" Vim syntax file
" Language:	CUDA (NVIDIA Compute Unified Device Architecture)
" Maintainer:	Timothy B. Terriberry <tterribe@users.sourceforge.net>
" Last Change:	2007 Oct 13

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  source <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
endif

" CUDA extentions
syn keyword cudaStorageClass	__device__ __global__ __host__
syn keyword cudaStorageClass	__constant__ __shared__
syn keyword cudaStorageClass	__inline__ __align__ __thread__
"syn keyword cudaStorageClass	__import__ __export__ __location__
syn keyword cudaStructure	template
syn keyword cudaType		char1 char2 char3 char4
syn keyword cudaType		uchar1 uchar2 uchar3 uchar4
syn keyword cudaType		short1 short2 short3 short4
syn keyword cudaType		ushort1 ushort2 ushort3 ushort4
syn keyword cudaType		int1 int2 int3 int4
syn keyword cudaType		uint1 uint2 uint3 uint4
syn keyword cudaType		long1 long2 long3 long4
syn keyword cudaType		ulong1 ulong2 ulong3 ulong4
syn keyword cudaType		float1 float2 float3 float4
syn keyword cudaType		ufloat1 ufloat2 ufloat3 ufloat4
syn keyword cudaType		dim3 texture textureReference
syn keyword cudaType		cudaError_t cudaDeviceProp cudaMemcpyKind
syn keyword cudaType		cudaArray cudaChannelFormatKind
syn keyword cudaType		cudaChannelFormatDesc cudaTextureAddressMode
syn keyword cudaType		cudaTextureFilterMode cudaTextureReadMode
syn keyword cudaVariable	gridDim blockIdx blockDim threadIdx
syn keyword cudaConstant	__DEVICE_EMULATION__
syn keyword cudaConstant	cudaSuccess
" Many more errors are defined, but only these are listed in the maunal
syn keyword cudaConstant	cudaErrorMemoryAllocation
syn keyword cudaConstant	cudaErrorInvalidDevicePointer
syn keyword cudaConstant	cudaErrorInvalidSymbol
syn keyword cudaConstant	cudaErrorMixedDeviceExecution
syn keyword cudaConstant	cudaMemcpyHostToHost
syn keyword cudaConstant	cudaMemcpyHostToDevice
syn keyword cudaConstant	cudaMemcpyDeviceToHost
syn keyword cudaConstant	cudaMemcpyDeviceToDevice
syn keyword cudaConstant	cudaReadModeElementType
syn keyword cudaConstant	cudaReadModeNormalizedFloat
syn keyword cudaConstant	cudaFilterModePoint
syn keyword cudaConstant	cudaFilterModeLinear
syn keyword cudaConstant	cudaAddressModeClamp
syn keyword cudaConstant	cudaAddressModeWrap
syn keyword cudaConstant	cudaChannelFormatKindSigned
syn keyword cudaConstant	cudaChannelFormatKindUnsigned
syn keyword cudaConstant	cudaChannelFormatKindFloat
" Optix functions.
syn keyword optixFn	rtDeclareVariable
syn keyword optixFn	rtPotentialIntersection
syn keyword optixFn	rtReportIntersection
syn keyword optixFn	rtTrace rtPrintf
syn keyword optixFn	rtPrintExceptionDetails
syn keyword optixFn	make_float make_float2 make_float3 make_float4
syn keyword optixFn	tex1D tex2D tex3D
syn keyword optixFn	normalize dot corss clamp
" macro
syn keyword optixMacro	M_1_PIf M_PIf
" Optix variable.
syn keyword optixVar	Ray namespace
syn keyword optixVar	size_t2 rtObject rtBuffer rtTextureSampler
" statements
syn keyword states	rtCurrentRay
syn keyword states	rtPayload
syn keyword states	rtLaunchIndex
syn keyword states	rtIntersectionDistance
syn keyword states	using optix
syn keyword states	RT_PROGRAM RT_CALLALBE_PROGRAM
" others
syn keyword others	attribute

hi def link cudaStorageClass	Function
hi def link cudaStructure	Structure
hi def link cudaType		Type
hi def link cudaVariable	Identifier
hi def link cudaConstant	Constant
hi def link optixFn	Function
hi def link optixVar	Type
hi def link states	Statement
hi def link optixMacro	Macro
hi def link others	pandocDefinitionBlock

let b:current_syntax = "cuda"

" vim: ts=8
