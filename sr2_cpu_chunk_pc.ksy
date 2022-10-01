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
    type: vert_header_cont(model_headers[_index].vert_header_count)
    repeat: expr
    repeat-expr: model_count
  - id: align10
    size: (16 - _io.pos) % 16
  - id: phys_models
    type: phys_model_buffer(
      model_headers[_index].type == 7,
      model_headers[_index].index_count,
      vert_headers[_index].vert_header[0].vert_count)
    repeat: expr
    repeat-expr: model_count

    # Materials
  - id: material_count
    type: u4
  - id: align11
    size: (16 - _io.pos) % 16
  - id: mat_shader_param_count
    type: u4
  - id: pad_mat
    size: 8
  - id: mat_unknown3_count
    type: u4
  - id: mat_unknown1
    type: u4
  - id: materials
    type: material
    repeat: expr
    repeat-expr: material_count

  - id: mat_bitflags
    type: mat_bitflag(materials[_index].bitflag_count)
    repeat: expr
    repeat-expr: material_count

    # Messing with these break shaders.
  - id: mat_unknown2
    size: 16
    repeat: expr
    repeat-expr: material_count
  - id: align12
    size: (16 - _io.pos) % 16

    # Mostly colors, sometimes affects scrolling textures.
  - id: mat_shader_params
    type: f4
    repeat: expr
    repeat-expr: mat_shader_param_count

  - id: mat_textures
    type: mat_tex_cont
    repeat: expr
    repeat-expr: material_count

  - id: mat_unknown3s
    type: mat_unknown3
    repeat: expr
    repeat-expr: mat_unknown3_count

    # uints up to thousands?
  - id: mat_unknown3_unk2
    size: mat_unknown3s[_index].unk2_count * 4
    repeat: expr
    repeat-expr: mat_unknown3_count

  - id: rendermodels
    type: rendermodel
    repeat: expr
    repeat-expr: rendermodel_count

  - id: cityobjects
    type: cityobject
    repeat: expr
    repeat-expr: cityobject_count

  - id: cityobject_names
    type: strz
    repeat: expr
    repeat-expr: cityobject_count

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
    doc: |
      A model header will talk about one of these two of things:

      - A physmodel (type 7)
        Each physmodel has a separate buffer and therefore each has its own
        model_header. The buffers are stored in this file right after vert
        headers.

      - Rendermodels (type 0)
        All buffers used for rendermodels are under this header. There is
        exactly one rendermodel header per chunk (or none?).
        Contains multiple vert_headers: one for each rendermodel vert buffer.
        Buffers are stored in g_chunk file.
        This does not tell how to get individual rendermodels. See rendermodel
        type for that.
        
      TODO: organize vert_headers in here somehow and get rid of vert_header_cont.
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
    doc: |
      TODO: See todo in model_header.

    params:
      - id: vert_header_count
        type: u2
    seq:
      - id: vert_header
        type: vert_header
        repeat: expr
        repeat-expr: vert_header_count
  vert_header:
    doc: |
      Describes a vertex buffer.

      unk2b_count:
        Probs vertex normals or something
        Each adds 2B to vert_size.
        
      uv_count:
        How many uv sets are used.
        Each UV set adds 4B to vert_size
        
      vert_size:
        Size is 12B + above.
        Physmodels don't use the above so size is always 12B.
        
      unk: 
        There's probably some meaning to this but it's 
        _always_ the same. 0xffffffff00000000

    seq: # 16B
      - id: unk2b_count
        type: u1
      - id: uv_count
        type: u1
      - id: vert_size
        type: u2
      - id: vert_count
        type: u4
      - id: pad
        contents: [255, 255, 255, 255, 0, 0, 0, 0]

  phys_model_buffer:
    params:
      - id: is_physmodel
        type: bool
      - id: index_count
        type: u4
      - id: vert_count
        type: u4
    seq:
      - id: vbuf
        type: vec3
        repeat: expr
        repeat-expr: vert_count
        if: is_physmodel
      - id: align
        size: (16 - _io.pos) % 16
      - id: ibuf
        type: u2
        repeat: expr
        repeat-expr: index_count
        if: is_physmodel
      - id: align1
        size: (16 - _io.pos) % 16

  material:
    doc: |
      TODO: Move mat_textures, mat_bitflags, etc. inside material.
    seq:
      - id: unk
        size: 12
      - id: bitflag_count
        type: u2
      - id: tex_count
        type: u2
      - id: pad1
        size: 2
      - id: unk2
        type: u2
      - id: pad3
        size: 4
  mat_bitflag:
    params:
      - id: size
        type: u2
    seq:
      - id: data
        size: size * 6
      - id: align
        size: (4 - size * 6) % 4
  mat_tex_cont:
    seq:
      - id: tex_data
        type: mat_tex
        repeat: expr
        repeat-expr: 16
  mat_tex:
    seq:
      - id: tex_id
        type: u2
      - id: tex_flag
        type: u2
  mat_unknown3:
    seq:
      - id: unk
        size: 8
      - id: unk2_count
        type: u2
      - id: unk3
        type: u2
      - id: pad
        contents: [255, 255, 255, 255]

  rendermodel:
    doc: |
      Describes vertex/index offsets and counts in buffers.
      Rendermodels are divided to submeshes per material.
      Some models use what I named submesh2. This format is unknown
      and in such cases the normal submeshes are garbage too.

      To be confirmed: bbox is a bounding box with min and max vert coords.
      Bbox usage is unknown.
    seq:
      - id: bbox_min
        type: vec3
      - id: bbox_max
        type: vec3
      - id: unk0
        type: u4
      - id: unk1
        type: u4
      - id: check_submeshes
        type: u4
      - id: check_submesh2
        type: u4
      - id: align
        size: (16 - _io.pos) % 16

      - id: submesh_unk0
        type: u2
        if: check_submeshes != 0
      - id: submesh_count
        type: u2
        if: check_submeshes != 0
      - id: submesh_pad0
        contents: [255, 255, 255, 255]
        if: check_submeshes != 0
      - id: submesh_unk2
        type: u4
        if: check_submeshes != 0
      - id: submesh_pad1
        contents: [0, 0, 0, 0]
        if: check_submeshes != 0

      - id: submesh2_unk0
        type: u2
        if: check_submesh2 != 0
      - id: submesh2_count
        type: u2
        if: check_submesh2 != 0
      - id: submesh2_pad0
        contents: [255, 255, 255, 255]
        if: check_submesh2 != 0
      - id: submesh2_unk2
        type: u4
        if: check_submesh2 != 0
      - id: submesh2_pad1
        contents: [0, 0, 0, 0]
        if: check_submesh2 != 0

      - id: submeshes
        type: submesh
        repeat: expr
        repeat-expr: submesh_count

      - id: submesh2s
        type: submesh2
        repeat: expr
        repeat-expr: submesh2_count
    types:
      submesh:
        seq:
          - id: vert_buffer_id
            type: u4
          - id: index_offset
            type: u4
          - id: vert_offset
            type: u4
          - id: index_count
            type: u2
          - id: material_id
            type: u2
      submesh2:
        seq:
          - id: unused
            contents: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
          - id: index_count # is it index count?
            type: u2
          - id: material_id
            type: u2

  cityobject:
    doc: |
      bbox is used for culling.
    seq:
      - id: bbox_min
        type: vec3
      - id: pad
        contents: [0, 0, 0, 0]
      - id: bbox_max
        type: vec3
      - id: cull_distance

        type: f4
      - id: pad1
        contents: [0, 0, 0, 0]
      - id: unk0
        size: 4
      - id: pad2
        contents: [0, 0, 0, 0]
      - id: unk1
        type: u2
      - id: pad3
        contents: [0, 0]
      - id: flags
        size: 4
      - id: unk3
        size: 4
      - id: pad4
        contents: [0, 0, 0, 0]
      - id: unk4
        size: 4
      - id: cityobject_part_id
        type: u4
      - id: unk5
        type: u4
      - id: unk6
        size: 4
      - id: unk7
        size: 4
