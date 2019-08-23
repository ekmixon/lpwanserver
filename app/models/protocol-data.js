const { prisma, formatRelationshipsIn } = require('../lib/prisma')
const httpError = require('http-errors')
const { create, update, remove } = require('./model-lib')
const CacheFirstStrategy = require('../lib/prisma-cache/src/cache-first-strategy')
const redis = require('../lib/redis')

// ******************************************************************************
// Fragments for how the data should be returned from Prisma.
// ******************************************************************************
const fragments = {
  basic: `fragment BasicProtocolData on ProtocolData {
    id
    dataIdentifier
    dataValue
    network {
      id
    }
    networkProtocol {
      id
    }
  }`
}

// ******************************************************************************
// Model Functions
// ******************************************************************************
async function load (ctx, args) {
  const [ records ] = await ctx.db.list(args)
  if (!records.length) throw httpError.NotFound()
  return records[0]
}

async function loadValue (ctx, [network, dataIdentifier]) {
  const rec = await ctx.$self.load({ where: {
    networkId: network.id,
    networkProtocolId: network.networkProtocol.id,
    dataIdentifier
  } })
  return rec.dataValue
}

async function upsert (ctx, [network, dataIdentifier, dataValue]) {
  const where = {
    networkId: network.id,
    networkProtocolId: network.networkProtocol.id,
    dataIdentifier
  }
  try {
    const rec = await ctx.$self.load({ where })
    return ctx.$self.update({ where: { id: rec.id }, data: { dataValue } })
  }
  catch (err) {
    return ctx.$self.create({ data: { ...where, dataValue } })
  }
}

function clearProtocolData (ctx, [networkId, networkProtocolId, keyStartsWith]) {
  const where = formatRelationshipsIn({
    networkId,
    networkProtocolId,
    dataIdentifier_contains: keyStartsWith
  })
  return prisma.deleteManyProtocolDatas(where)
}

function reverseLookupProtocolData (ctx, [networkId, keyLike, dataValue]) {
  const where = formatRelationshipsIn({
    networkId,
    dataIdentifier_contains: keyLike,
    dataValue
  })
  return prisma.protocolDatas({ where })
}

// ******************************************************************************
// Model
// ProtocolData exports it's own db client because it needs to specify "protocolDatas" to Prisma.
// If it were created by the main model file, it would pass "protocolData" to Prisma.
// But the main file uses "protocolData" because that's a nicer service name
// ******************************************************************************
module.exports = {
  context: {
    db: new CacheFirstStrategy({
      defaultFragmentKey: 'basic',
      prisma,
      redis: redis.keyval,
      fragments,
      name: 'protocolData',
      // This is to match a name generated by Prisma.
      pluralName: 'protocolDatas'
    })
  },
  api: {
    load,
    loadValue,
    create,
    upsert,
    update,
    remove,
    clearProtocolData,
    reverseLookupProtocolData
  }
}
