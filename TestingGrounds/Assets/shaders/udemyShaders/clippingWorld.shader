Shader "Custom/screenSpace" {
	Properties {
		_Color ("Color", 2D) = "white"{}
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		//_Glossiness ("Smoothness", Range(0,1)) = 0.5
		//_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _Color;
		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

	

	
		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
            clip (frac((IN.worldPos.y) * 1)-.1);

			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
		

		}
		ENDCG
	}
	FallBack "Diffuse"
}
