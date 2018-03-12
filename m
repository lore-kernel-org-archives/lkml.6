Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AG47ELsUdQB9yLlMAbkF+G4kIMexbohAg0Yt9FSsD0WtQvwFlkE/vCaAdCtQmSuU3SxrYrQbwj6W
ARC-Seal: i=1; a=rsa-sha256; t=1520896082; cv=none;
        d=google.com; s=arc-20160816;
        b=ZfX9BPa2WFa6tirMimDLP3ocTxnT5SN53KResykfBM7/FR/0pdc7/pxrR6pb6hM92I
         FKA6bC3EOoVdXZl6nFdwAw5UyB3e9k4kbTZrazHPz7cLkAa+QcRwIskIuaGrUU4WgVn+
         IZHfzJ4vAJr9YWHnS+4SWcHPJIGWMhzpuszjmky9vO6FfyV2tcVVpho8sBQTQ4LXUswv
         7dt1Lne4/nURW8GmeP07BxVdZuymy29SGdUiXWmRjN65X2l6s++8t/ScKYq6LGeBTY1f
         SOck7jQ6mK1+1Clnc4bZyMmI3Q4KhGBkDN0YV/TkeAUYPiL9Z+utU9yC7gtXG5pQ7Vsh
         j3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=ycUUKM/E6afaUXB3Xp+cBb7HiB/ErY/KMvXhZK4ohtQ=;
        b=V9uehlYXv60EfFrePWS25s/+fWeoPx+jcx7tcuguW/WRTVnQpI5eiakZYxgkBNm6Hm
         CrsGUMcBDESET4EnrChHGXwLpxFggp5Q+LEExufThk1VJnipUFfrCHwSpjv5hL0byQbV
         R1t/SFoKMOijy1dWOwiU9QDWGU3tw4JGpQnaaqPnRpWH5aOGsKMB8dAxmdhIKKAloOGj
         /I+12oMtH5QHZiYpjEv245sHP5wqSsC1+LXn19m+VTee9s2dQT+FRbMwpAyLtk8rqd3l
         +PK/sPhrc7wOc++qGvwjTLo41aXgYARdeN9DAreq2WKza2dtL796jmALGTH415ZdrELy
         SuHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=i0Wge3eU;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.38.70 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=i0Wge3eU;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.38.70 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "ard.biesheuvel@linaro.org"
	<ard.biesheuvel@linaro.org>, "mingo@kernel.org" <mingo@kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, Rajan Vaja <RAJANV@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Thread-Topic: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Thread-Index: AQHTqoAmKKGb/CVRXk2mfd+L4ykECqO7enoAgAnz4+CAAONKgIAHBrvA
Date: Mon, 12 Mar 2018 23:07:56 +0000
Message-ID: <DM2PR0201MB07678A47B5380DC14E6F6126B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
 <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
 <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
 <f6a416b7-542f-a3c3-538f-8549cf4e96c3@arm.com>
In-Reply-To: <f6a416b7-542f-a3c3-538f-8549cf4e96c3@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB1006;7:4RW7PBixydhLZQ8x8xT6Se8GldWcVlbKZghqQDZIEFCX7nHNeaM+1tYB8mJtCENK+qjNLJHh12OUqvkoCH4B9HGpb59ALD+LxmIy9nY78C9q+HVEdJINNU51Ojrh7Yj7c59QNl9Ev8K4D+y0vXcozcx68vzWtIQdnPyPFJV2xRImoKMO+1FCjddrMQef5UrrvmzW/PVc9dCjtc2FSxX4eMm9Qrz6pt3ku3WccNr1atnlV4Yg2gxm9tNuABT32yky
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(396003)(376002)(366004)(13464003)(189003)(199004)(6246003)(316002)(3660700001)(102836004)(8936002)(6506007)(7696005)(4326008)(25786009)(229853002)(81166006)(81156014)(8676002)(53546011)(76176011)(3280700002)(478600001)(39060400002)(26005)(186003)(72206003)(9686003)(6436002)(14454004)(93886005)(54906003)(53936002)(68736007)(55016002)(99286004)(74316002)(66066001)(86362001)(7416002)(6116002)(106356001)(5660300001)(7736002)(3846002)(305945005)(2900100001)(5250100002)(33656002)(97736004)(6916009)(105586002)(2950100002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB1006;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 556b34e9-583f-421e-9592-08d5886e176a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB1006;
x-ms-traffictypediagnostic: DM2PR0201MB1006:
x-microsoft-antispam-prvs: <DM2PR0201MB100678D0485DE6F24DD35711B8D30@DM2PR0201MB1006.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR0201MB1006;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB1006;
x-forefront-prvs: 06098A2863
x-microsoft-antispam-message-info: RnEFk7sGzdMk8hInIX4Rid85AJWlPSmdeYiQnDgAV1Q2y8usi8rhYj8KMM8DKYAPqUmK7QwE+iIXVO/xIN8l0rEm8fX8I94n/yLjbCvUtu9AtGADrm4bQoCwvv4edtDlCTIdoKx90vaAf2mEa+r2b66wNjNnqn/5U09FoYHJV8wYrcZxCguXXEWtQLbW7obg050g0yM3SDKsGUYgpxbVBgx18jIq8mNTeMJzq0RErrehm7aUeJ4LgPsvs+2xcX3IhIr/27aH44PaQngHnTZ0Ygb4p3OH1mSM365gTjRB0UXhN34Mh7IM2jjKT6547Q9f9DvST4BP92MDgIjpZcYWuw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556b34e9-583f-421e-9592-08d5886e176a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 23:07:56.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB1006
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948931841332945?=
X-GMAIL-MSGID: =?utf-8?q?1594775130872412983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgU3VkZWVwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVl
cCBIb2xsYSBbbWFpbHRvOnN1ZGVlcC5ob2xsYUBhcm0uY29tXQ0KPiBTZW50OiBUaHVyc2RheSwg
TWFyY2ggMDgsIDIwMTggMzo0OCBBTQ0KPiBUbzogSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5j
b20+DQo+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbWF0dEBjb2RlYmx1ZXByaW50
LmNvLnVrOw0KPiBoa2FsbHdlaXQxQGdtYWlsLmNvbTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207
IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IFN1ZGVlcCBIb2xs
YSA8c3VkZWVwLmhvbGxhQGFybS5jb20+Ow0KPiBhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnOyBt
aW5nb0BrZXJuZWwub3JnOyBrZWVzY29va0BjaHJvbWl1bS5vcmc7DQo+IGRtaXRyeS50b3Jva2hv
dkBnbWFpbC5jb207IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgtYXJtLQ0K
PiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NSAxLzRdIGR0LWJpbmRpbmdzOiBmaXJtd2FyZTogQWRkIGJpbmRpbmdzIGZvciBaeW5xTVANCj4g
ZmlybXdhcmUNCj4gDQo+IA0KPiANCj4gT24gMDcvMDMvMTggMjI6MjUsIEpvbGx5IFNoYWggd3Jv
dGU6DQo+ID4gSGkgU3VkZWVwLA0KPiA+DQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4+ICtFeGFtcGxl
czoNCj4gPj4+ICsJZmlybXdhcmUgew0KPiA+Pj4gKwkJenlucW1wX2Zpcm13YXJlOiB6eW5xbXAt
ZmlybXdhcmUgew0KPiA+Pj4gKwkJCWNvbXBhdGlibGUgPSAieGxueCx6eW5xbXAtZmlybXdhcmUi
Ow0KPiA+Pj4gKwkJCW1ldGhvZCA9ICJzbWMiOw0KPiA+Pj4gKwkJfTsNCj4gPj4+ICsJfTsNCj4g
Pj4+DQo+ID4+DQo+ID4+IERvIHlvdSBmb3Jlc2VlIHVzaW5nIFNNQy9IVkMgZm9yIHRoaXMgZmly
bXdhcmUgZXZlbiBvbiBmdXR1cmUgcGxhdGZvcm1zPw0KPiA+PiBJZiBub3QsIEkgc3VnZ2VzdCB0
byBrZWVwIHRoZSBwcm90b2NvbCBwYXJ0IHNlcGFyYXRlIGZyb20gdGhlIHRyYW5zcG9ydCBpLmUu
DQo+ID4+IHNtYy9odmMgdmlhIEFURi4gSXQgY291bGQgYmUgcmVwbGFjZWQgd2l0aCBtYWlsYm94
IG9yIHNvbWUgaC93DQo+ID4+IG1lY2hhbmlzbSBpbiBmdXR1cmUgPw0KPiA+Pg0KPiA+DQo+ID4g
V2UgaGF2ZSBQU0NJIGFuZCBFRU1JIGludGVyZmFjZXMgZXhwb3NlZCB0byBsaW51eCBmcm9tIEFU
Ri4gUFNDSSBpcyBhbg0KPiA+IEVFTUkgY2xpZW50LiBXZSBkbyBub3QgaGF2ZSBjdXJyZW50IHBs
YW5zIHRvIHN3aXRjaCB0byBtYWlsYm94IGFzIGl0DQo+ID4gd2lsbCByZXF1aXJlIDIgY29tbXVu
aWNhdGlvbiBjaGFubmVscyB0byBQTVUgYXMgUFNDSSBpcyB0aHJvdWdoIEFURi4NCj4gPg0KPiAN
Cj4gT0ssIGJ1dCBJIGp1c3Qgc2F3IHNvbWUgYmluZGluZ3MgdGhhdCBoYXMgbWFpbGJveCBpbnRl
cmZhY2UsIGhvbmVzdGx5IGl0J3MgZ2V0dGluZw0KPiB0b28gY29uZnVzaW5nIHdpdGggbXVsdGlw
bGUgc2VyaWVzIG9uIHRoZSBzYW1lIHRoaW5nIGZsb2F0aW5nIGFuZCBoZW5jZSBJDQo+IHJlcXVl
c3RlZCB0byBwdXQgaXQgdG9nZXRoZXIgYXMgb25lIHNlcmllcy4NCg0KTWFpbGJveCBiaW5kaW5n
IGlzIHVzZWQgZm9yIHBvd2VyIG1hbmFnZW1lbnQgZHJpdmVyLiBNYWlsYm94IGlzIG9ubHkgdXNl
ZCBmb3IgUE1VLT5BUFUgY29tbXVuaWNhdGlvbi4NCkFQVS0+UE1VIGNvbW11bmljYXRpb24gaXMg
YWx3YXlzIHRocm91Z2ggRUVNSSBmaXJtd2FyZSBpbnRlcmZhY2Ugd2hpY2ggaXMgdXNpbmcgU01D
L0hWQy4NCg0KDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0K
