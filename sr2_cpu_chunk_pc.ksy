meta:
  id: sr2_cpu_chunk_pc
  file-extension: chunk_pc
  encoding: utf-8
  endian: le
seq:
  # Header
  - id: magic
    contents: [0x12, 0xca, 0xca, 0xbb]
  - id: version
    contents: [0x79, 0x0, 0x0, 0x0] # Version 121
  - id: header_0x8
    type: u4
  - id: header_0xc
    type: u4
  - id: header_0x10
    type: u4
  - id: header_0x14
    size: 128
  - id: cityobject_count
    type: u4
  - id: header_0x98
    type: u4
  - id: header_0x9c
    type: u4
  - id: header_0xa0
    type: u4
  - id: header_0xa4
    size: 16
  - id: header_0xb4
    type: u4
  - id: header_0xb8
    type: u4
  - id: header_0xbc
    type: u4
  - id: header_0xc0
    type: u4
  - id: header_0xc4
    type: u4
  - id: header_0xc8
    type: u4
  - id: header_0xcc
    type: u4
  - id: header_0xd0
    type: u4
  - id: header_worldpos0_x
    type: f4
  - id: header_worldpos0_y
    type: f4
  - id: header_worldpos0_z
    type: f4
  - id: header_0xe0
    type: f4
  - id: header_0xe4
    type: f4
  - id: header_0xe8
    type: f4
  - id: header_0xec
    type: f4
  - id: header_0xf0
    type: u4
  - id: header_0xf4
    size: 12

    # Textures
  - id: texture_count
    type: u4
  - id: texture_padding
    size: texture_count * 4
  - id: texture_names
    type: strz
    repeat: expr
    repeat-expr: texture_count

    # Byte alignment workaround.
    # https://github.com/kaitai-io/kaitai_struct/issues/12
  - id: align
    size: (16 - _io.pos) % 16

    # Model info
  - id: rendermodel_count
    type: u4
  - id: cityobject_part_count
    type: u4
  - id: model_count
    type: u4
  - id: unknown3_count
    type: u4
  - id: unknown4_count
    type: u4

  - id: align1
    size: (16 - _io.pos) % 16

  - id: rendermodel_unk0s
    type: rendermodel_unk0
    repeat: expr
    repeat-expr: rendermodel_count

  - id: align2
    size: (16 - _io.pos) % 16

  - id: cityobject_parts
    type: cityobject_part
    repeat: expr
    repeat-expr: cityobject_part_count

  - id: align3
    size: (16 - _io.pos) % 16

  - id: unknown3s
    type: unknown3
    repeat: expr
    repeat-expr: unknown3_count

  - id: align4
    size: (16 - _io.pos) % 16

  - id: unknown4s
    type: unknown4
    repeat: expr
    repeat-expr: unknown4_count

  - id: align5
    size: (16 - _io.pos) % 16

  - id: unk_worldpos_count
    type: u4

    # Assumption: The data from here to mopp is some
    # complicated Havok collision model.
  - id: unk_worldpositions # is this vertices of a baked model?
    type: vec3
    repeat: expr
    repeat-expr: unk_worldpos_count
  - id: unknown6_count # seems incomprehensible.
    type: u4
  - id: unknown6s
    size: 3
    repeat: expr
    repeat-expr: unknown6_count
  - id: unknown7_count
    type: u4
  - id: unknown7s
    type: u4
    repeat: expr
    repeat-expr: unknown7_count
  - id: unknown8_count
    type: u4
  - id: unknown8s
    size: 12
    repeat: expr
    repeat-expr: unknown8_count
  - id: align6
    size: (16 - _io.pos) % 16
    # https://niftools.sourceforge.net/wiki/Nif_Format/Mopp
  - id: havok_mopp_size
    type: u4
  - id: align7
    size: (16 - _io.pos) % 16
  - id: havok_mopp
    size: havok_mopp_size
  - id: align8
    size: (4 - _io.pos) % 4
    # is this a bounding box?
  - id: unknown10min
    type: vec3
  - id: unknown10max
    type: vec3

  - id: align9
    size: (16 - _io.pos) % 16

    # Model header
  - id: model_headers
    type: model_header(_index)
    repeat: expr
    repeat-expr: model_count
  - id: vert_headers
    type: vert_header
    #repeat

types:
  vec3:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
  rendermodel_unk0:
    seq:
      - id: unk0
        type: u4
      - id: padding
        size: 12
      - id: unk1
        type: u4
      - id: unk2
        type: u4
  cityobject_part:
    seq:
      - id: pos_x
        type: f4
      - id: pos_y
        type: f4
      - id: pos_z
        type: f4
      - id: rest_of_the_transform
        size: 72
      - id: unk0
        type: u4
      - id: rendermodel_id
        type: u4
      - id: unk1
        type: u4
  unknown3:
    seq:
      - id: float0
        type: f4
      - id: float1
        type: f4
      - id: float2
        type: f4
      - id: float3
        type: f4
      - id: float4
        type: f4
      - id: float5
        type: f4
      - id: float6
        type: f4
      - id: float7
        type: f4
      - id: float8
        type: f4
      - id: float9
        type: f4
      - id: floata
        type: f4
      - id: floatb
        type: f4
      - id: floatc
        type: f4
      - id: floatd
        type: f4
      - id: floate
        type: f4
      - id: floatf
        type: f4
      - id: float10
        type: f4
      - id: float11
        type: f4
      - id: float12
        type: f4
      - id: float13
        type: f4
      - id: float14
        type: f4
      - id: float15
        type: f4
      - id: float16
        type: f4
      - id: float17
        type: f4
      - id: float18
        type: f4
  unknown4:
    seq:
      - id: float0
        type: f4
      - id: float1
        type: f4
      - id: float2
        type: f4
      - id: float3
        type: f4
      - id: float4
        type: f4
      - id: float5
        type: f4
      - id: float6
        type: f4
      - id: float7
        type: f4
      - id: float8
        type: f4
      - id: float9
        type: f4
      - id: floata
        type: f4
      - id: floatb
        type: f4
      - id: floatc
        type: f4

  model_header:
    params:
      - id: i
        type: s4
    seq: # 20B
      - id: type # Either 7 or 0? 7 is physmodel, 0 rendermodel.
        type: u2
      - id: vert_header_count # here
        type: u2
      - id: index_count
        type: u4
      - id: unk
        size: 12

  vert_header_cont:
    seq:
      - id: header
        type: vert_header
        #repeat: expr
        #repeat-expr: model_headers[0].vert_header_count

  vert_header:
    seq: # 16B
      - id: temp
        size: 16
