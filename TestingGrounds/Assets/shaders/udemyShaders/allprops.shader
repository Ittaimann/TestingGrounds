Shader "udemy/AllProps" {
	Properties{
		_myColor("example color",color)=(1,1,1,1)
		_myRange("Examples range",Range(0,5))=1
		_myTex("example texture",2D)="white"{}
		_myCube("Example Cube",CUBE)=""{}
		_myFloat("example float",float)=0.5
		_myVector("Example Vector",Vector)=(.5,1,1,1)

	}
	SubShader{
		CGPROGRAM 
		#pragma surface surf Lambert

		fixed4 _myColor;
		half _myRange;
		sampler2D _myTex;
		samplerCUBE _myCube;
		float _myFloat;
		float4 _myVector;

		struct Input{
			float2 uv_myTex;
			float3 worldRefl;
		};

		
		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo= (tex2D(_myTex,IN.uv_myTex)*_myRange).rgb;
			o.Emission= texCUBE(_myCube,IN.worldRefl).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
