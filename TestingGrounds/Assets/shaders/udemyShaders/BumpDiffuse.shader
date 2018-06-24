Shader "udemy/BumpDiffuse" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalMap("normal map ",2D)= "bump"{}
		_mySlider("bump amount",Range(0,10))=1.0
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
		sampler2D _NormalMap;
		half _mySlider;
		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalMap;

		};

	
		fixed4 _Color;

		

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
		    o.Normal=UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
			o.Normal*=float3(_mySlider,_mySlider,1);
			// Metallic and smoothness come from slider variables
			
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
