Shader "udemy/bumpedEnvironmeny" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MyBump ("bump texture",2D)="bump"{}
		_mySlider("bump slider",Range(0,10))=1
		_myBright("brightness",Range(0,10))=1
		_myCube("cube Map",CUBE)="white"{}
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
		sampler2D _MyBump;
		samplerCUBE _myCube;
		half _mySlider;
		half _myBright;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MyBump;
			float3 worldRefl; INTERNAL_DATA

		};


		fixed4 _Color;
		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Normal= UnpackNormal(tex2D(_MyBump,IN.uv_MyBump))*_myBright;
			o.Normal*= float3(_mySlider,_mySlider,1);
			o.Albedo= c.rgb;
			o.Albedo= texCUBE(_myCube,WorldReflectionVector(IN,o.Normal)).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
