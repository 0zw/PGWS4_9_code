Shader "Example/WorldRefl Normalmap" 
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Bumpmap", 2D) = "bump" {}
		_Cube("Cubemap", CUBE) = "" {}
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert


		sampler2D _MainTex;
		sampler2D _BumpMap;
		samplerCUBE _Cube;
		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 worldRefl;
			INTERNAL_DATA
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb*0.5;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Emission = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb;
		}
		ENDCG
	}
		FallBack "Diffuse"
}