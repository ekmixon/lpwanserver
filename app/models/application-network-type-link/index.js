var httpError = require('http-errors')
const { list, listAll, load, removeMany, loadByQuery } = require('../model-lib')
const R = require('ramda')
const { getUpdates, validateSchema } = require('../../lib/utils')
const { prune } = require('dead-leaves')

//* *****************************************************************************
// Fragments for how the data should be returned from Prisma.
//* *****************************************************************************
const fragments = {
  basic: `fragment BasicApplicationNetworkTypeLink on ApplicationNetworkTypeLink {
    id
    networkSettings
    enabled
    application {
      id
    }
    networkType {
      id
    }
  }`
}

// ******************************************************************************
// Helpers
// ******************************************************************************
const validateNwkSettings = validateSchema(
  'ApplicationNetworkTypeLink.networkSettings failed validation',
  require('./nwk-settings-schema.json')
)

// ******************************************************************************
// Model Functions
// ******************************************************************************
async function enabledValidation (ctx, { application }) {
  // Ensure app has a ReportingProtocol
  const app = await ctx.$m.application.load({ where: application })
  if (!app.reportingProtocol) {
    throw httpError(400, 'ApplicationNetworkTypeLink cannot be enabled because Application has no ReportingProtocol.')
  }
}

async function create (ctx, { data, origin }) {
  data = { enabled: false, ...data, networkSettings: prune(data.networkSettings || {}) }
  validateNwkSettings(data.networkSettings)
  if (data.enabled) {
    await ctx.$self.enabledValidation({ application: data.application })
  }
  const rec = await ctx.db.create({ data })
  await ctx.$m.networkType.forAllNetworks({
    networkTypeId: rec.networkType.id,
    op: network => {
      const isOrigin = origin && origin.network.id === network.id
      const meta = { isOrigin, enabled: false }
      if (isOrigin) meta.remoteId = origin.remoteId
      return ctx.$m.networkDeployment.create({
        data: {
          status: 'CREATED',
          type: 'APPLICATION',
          meta,
          network: { id: network.id },
          application: rec.application
        }
      })
    }
  })
  return rec
}

async function update (ctx, { where, data }) {
  let rec
  if (data.neworkSettings) {
    data = { ...data, networkSettings: prune(data.networkSettings) }
    validateNwkSettings(data.networkSettings)
  }
  // No changing the application or the network.
  if (data.applicationId || data.networkTypeId) {
    throw httpError(403, 'Cannot change link targets')
  }
  if (data.enabled) {
    rec = await ctx.$self.load({ where })
    await ctx.$self.enabledValidation({ application: rec.application })
  }
  rec = await ctx.db.update({ where, data })
  await ctx.$self.push({ applicationNetworkTypeLink: rec })
  return rec
}

async function upsert (ctx, { data, ...args }) {
  try {
    let rec = await ctx.$self.loadByQuery({ where: R.pick(['networkType', 'application'], data) })
    data = getUpdates(rec, data)
    return R.empty(data) ? rec : ctx.$self.update({ ...args, where: { id: rec.id }, data })
  }
  catch (err) {
    if (err.statusCode === 404) return ctx.$self.create({ ...args, data })
    throw err
  }
}

async function remove (ctx, { id }) {
  var rec = await ctx.db.load({ where: { id } })

  // Delete DeviceNetworkTypeLinks
  for await (let devState of ctx.$m.device.listAll({ where: { application: rec.application } })) {
    let ids = devState.records.map(R.prop('id'))
    ctx.log.debug('ApplicationNetworkTypeLink:remove:deviceIds', { ids })
    for await (let state of ctx.$m.deviceNetworkTypeLink.removeMany({ where: { device: { id_in: ids } } })) {
    }
  }

  // Delete NetworkDeployments
  ctx.log.debug('ApplicationNetworkTypeLink:remove:Delete NetworkDeployments')
  await ctx.$m.networkType.forAllNetworks({
    networkTypeId: rec.networkType.id,
    op: async network => {
      let where = { network: { id: network.id }, application: rec.application }
      for await (let state of ctx.$m.networkDeployment.listAll({ where })) {
        await Promise.all(state.records.map(rec => ctx.$m.networkDeployment.remove(rec)))
      }
    }
  })

  await ctx.db.remove(id)
}

async function pushApplicationNetworkTypeLink (ctx, { id, applicationNetworkTypeLink: rec, pushDevices = false }) {
  if (!rec) {
    rec = await ctx.db.load({ where: { id } })
  }
  await ctx.$m.networkType.forAllNetworks({
    networkTypeId: rec.networkType.id,
    op: network => ctx.$m.networkProtocol.pushApplication({ network, applicationId: rec.application.id, pushDevices })
  })
}

async function pushApplicationDevices (ctx, { id, status }) {
  for await (let devState of ctx.$m.device.listAll({ where: { application: { id } } })) {
    let ids = devState.records.map(R.prop('id'))
    for await (let devNtlState of ctx.$m.deviceNetworkTypeLink.listAll({ where: { device: { id_in: ids } } })) {
      let ids = devNtlState.map(R.prop('id'))
      await Promise.all(ids.map(id => ctx.$m.deviceNetworkTypeLink.push({ id, status })))
    }
  }
}

// ******************************************************************************
// Model
// ******************************************************************************
module.exports = {
  role: 'applicationNetworkTypeLink',
  publicApi: {
    create,
    list,
    listAll,
    load,
    loadByQuery,
    update,
    upsert,
    remove,
    removeMany,
    push: pushApplicationNetworkTypeLink,
    pushDevices: pushApplicationDevices
  },
  privateApi: {
    enabledValidation
  },
  fragments
}
