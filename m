Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AG47ELsH/f60BEMl+Qx1Wzes5sQbAunRrymcxczubM969gt6+cefZuMz2TgIIjFx3V1ah+5m/68F
ARC-Seal: i=1; a=rsa-sha256; t=1520967404; cv=none;
        d=google.com; s=arc-20160816;
        b=gM5yMyIXCqSNu+1Aqo1cXyhsVZu0RbUKXJYkw4n5wnwK0WZ4yUgXcxyj38lnhTEXVT
         3I+2P8QbmTJWRzqTd6OWiQWDZEuO4p+8vdJDQH/iHa/TVRpVo6iRk85LtGUCfZHhM/hg
         vVCuIwVZgRJ49wp53hziRbkjPRgezf14utf/eXHiox+3VSLJCBXUl3hH/2sgjyV1fk5k
         9vqb7lulxsPvJ5ROTXuY8r0jNGTHeAp4VpHizeeAiRtcckBubZ1dnlojfOgAOeXqJkn4
         EzY7mhhMXjVUmw1mes4BHNwdN9YvKKTsUllXrhywhjzfdbqavdQQquyrUUa0C4mX4I6V
         g56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=n7w4OIGfleR6IngzdFw8C0kLA3tOKjdoI1CuLQqeQIs=;
        b=os5VI9ClmALKSqYhnKF/Urka32W8uVb72aR6mpWWgfCRMMRE76HLQMwzKUPbC0wj3x
         CnKKsYh0BVaxoCM2/dL/01UrWWhxKbKzPYrrpKt0BTcUwrGDdgNflGzX+Ufq2HCi4PNy
         GRDk5DKP2w3XjKGZa0pDxg3yUCBRYx1fEYeYQDFxRlpCBBhYKzuw+9cmAPwdLnX1Ne3h
         9WShoTfLOGBFykWm0Yyt8xyxNOmcfWJC5la2v+N2IwYJUcXYxFMAtmlY/F6M7WL+NyzV
         UA/rLUXuWwhgJdG3HcMRJf5yIz8oThWIP7EwHAcwSKQnXcC7D59ywGZj/Qi8D0TObZQn
         kxgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=chefbJVV;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.34.76 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=chefbJVV;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.34.76 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Thread-Index: AQHTqoAmKKGb/CVRXk2mfd+L4ykECqO7enoAgAnz4+CAAONKgIAHBrvAgAC7MoCAAI3HUA==
Date: Tue, 13 Mar 2018 18:56:38 +0000
Message-ID: <DM2PR0201MB07676A546340135791F9F25EB8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
 <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
 <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
 <f6a416b7-542f-a3c3-538f-8549cf4e96c3@arm.com>
 <DM2PR0201MB07678A47B5380DC14E6F6126B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <755770ba-d110-8b2e-3c1f-9b65686dc51f@arm.com>
In-Reply-To: <755770ba-d110-8b2e-3c1f-9b65686dc51f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB1005;7:P0v60icNdMZmMCQ0jsZkz5wbse1GTOPmVc4wO5pEnorbfMFX+XWNBEDt9gTSy1vJXhWQP4+YBW3LofEXWPCHoRkDgsX+fF6RHLMn+5jP8/FkQasi6vkeqJX2sxZqly5/OFRJ4JUviuDOnDmhRYa5yETb77z1UJqiD1k8ytkMtCDl84Xi/jv+RRIWsaIpmQqdsfU+9Sj4KBTl0CVj+3mWODiA/Jycl3cWeO/57bvmg+ocEaUu5zyqEI1mmQglDLzL
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39380400002)(39860400002)(376002)(199004)(189003)(13464003)(26005)(6436002)(9686003)(97736004)(102836004)(2950100002)(6116002)(3846002)(106356001)(39060400002)(99286004)(53546011)(4326008)(186003)(478600001)(2900100001)(68736007)(3660700001)(93886005)(229853002)(53936002)(25786009)(55016002)(6506007)(6916009)(7696005)(54906003)(81166006)(8936002)(5250100002)(7736002)(66066001)(81156014)(76176011)(86362001)(8676002)(14454004)(7416002)(316002)(2906002)(6246003)(33656002)(74316002)(105586002)(305945005)(3280700002)(72206003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB1005;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26498b00-df5d-400b-09bb-08d5891426eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB1005;
x-ms-traffictypediagnostic: DM2PR0201MB1005:
x-microsoft-antispam-prvs: <DM2PR0201MB1005C5A04FC2E8135428D09CB8D20@DM2PR0201MB1005.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR0201MB1005;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB1005;
x-forefront-prvs: 0610D16BBE
x-microsoft-antispam-message-info: 4SMBUWFk0RCPzX6f6ov8twWqxdC4RiAvaf4voVY6IkK+gKdQmha5trA4/AW2+UrqeJLidz57AAipKGzpLmDWzuBpkbevdA6UmQvPzCo0m/TIEadCjl1r2c9a+ymDWF57wWtShK0R5sHiuCkAiMHNN+y/ricWUy0bCecWw12ExoDD2g30eNt9p1ZZj/iL9WVYDUHyhehQFOfVkZIx3ptb6D7lXLQx+agDsUNSYayc0eol+8fv7BjRknYkbgdobQdlLqZXpNaTSnjhcjwKCs49Q4gyPfprLpJyvlx0q/As+9euFiPDHaJmqAERX7NCe10F2/yaH5TJ5EnVGzXILfOjug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26498b00-df5d-400b-09bb-08d5891426eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 18:56:38.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB1005
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948931841332945?=
X-GMAIL-MSGID: =?utf-8?q?1594849917058030889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VkZWVwIEhvbGxhIFtt
YWlsdG86c3VkZWVwLmhvbGxhQGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEzLCAy
MDE4IDM6MTYgQU0NCj4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29tPg0KPiBDYzog
U3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOw0KPiBtYXR0QGNvZGVibHVlcHJpbnQuY28udWs7IGhrYWxsd2VpdDFAZ21haWwuY29t
OyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgYXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZzsNCj4gbWluZ29Aa2VybmVs
Lm9yZzsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tOw0K
PiBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS80XSBkdC1iaW5k
aW5nczogZmlybXdhcmU6IEFkZCBiaW5kaW5ncyBmb3IgWnlucU1QDQo+IGZpcm13YXJlDQo+IA0K
PiANCj4gDQo+IE9uIDEyLzAzLzE4IDIzOjA3LCBKb2xseSBTaGFoIHdyb3RlOg0KPiA+IEhpIFN1
ZGVlcCwNCj4gDQo+ID4+Pj4gRG8geW91IGZvcmVzZWUgdXNpbmcgU01DL0hWQyBmb3IgdGhpcyBm
aXJtd2FyZSBldmVuIG9uIGZ1dHVyZQ0KPiBwbGF0Zm9ybXM/DQo+ID4+Pj4gSWYgbm90LCBJIHN1
Z2dlc3QgdG8ga2VlcCB0aGUgcHJvdG9jb2wgcGFydCBzZXBhcmF0ZSBmcm9tIHRoZSB0cmFuc3Bv
cnQgaS5lLg0KPiA+Pj4+IHNtYy9odmMgdmlhIEFURi4gSXQgY291bGQgYmUgcmVwbGFjZWQgd2l0
aCBtYWlsYm94IG9yIHNvbWUgaC93DQo+ID4+Pj4gbWVjaGFuaXNtIGluIGZ1dHVyZSA/DQo+ID4+
Pj4NCj4gPj4+DQo+ID4+PiBXZSBoYXZlIFBTQ0kgYW5kIEVFTUkgaW50ZXJmYWNlcyBleHBvc2Vk
IHRvIGxpbnV4IGZyb20gQVRGLiBQU0NJIGlzDQo+ID4+PiBhbiBFRU1JIGNsaWVudC4gV2UgZG8g
bm90IGhhdmUgY3VycmVudCBwbGFucyB0byBzd2l0Y2ggdG8gbWFpbGJveCBhcw0KPiA+Pj4gaXQg
d2lsbCByZXF1aXJlIDIgY29tbXVuaWNhdGlvbiBjaGFubmVscyB0byBQTVUgYXMgUFNDSSBpcyB0
aHJvdWdoIEFURi4NCj4gPj4+DQo+ID4+DQo+ID4+IE9LLCBidXQgSSBqdXN0IHNhdyBzb21lIGJp
bmRpbmdzIHRoYXQgaGFzIG1haWxib3ggaW50ZXJmYWNlLCBob25lc3RseQ0KPiA+PiBpdCdzIGdl
dHRpbmcgdG9vIGNvbmZ1c2luZyB3aXRoIG11bHRpcGxlIHNlcmllcyBvbiB0aGUgc2FtZSB0aGlu
Zw0KPiA+PiBmbG9hdGluZyBhbmQgaGVuY2UgSSByZXF1ZXN0ZWQgdG8gcHV0IGl0IHRvZ2V0aGVy
IGFzIG9uZSBzZXJpZXMuDQo+ID4NCj4gPiBNYWlsYm94IGJpbmRpbmcgaXMgdXNlZCBmb3IgcG93
ZXIgbWFuYWdlbWVudCBkcml2ZXIuIE1haWxib3ggaXMgb25seQ0KPiA+IHVzZWQgZm9yIFBNVS0+
QVBVIGNvbW11bmljYXRpb24uIEFQVS0+UE1VIGNvbW11bmljYXRpb24gaXMgYWx3YXlzDQo+ID4g
dGhyb3VnaCBFRU1JIGZpcm13YXJlIGludGVyZmFjZSB3aGljaCBpcyB1c2luZyBTTUMvSFZDLg0K
PiA+DQo+IA0KPiBBaCBPSywgaXMgaXQgYmVjYXVzZSB0aGVyZSdzIG5vIG5vbi1zZWN1cmUgbWFp
bGJveCBvciB0byBhdm9pZCByYWNlcywgYWxsIG5vbi0NCj4gc2VjdXJlIEVFTUkgaXMgY2hhbm5l
bGVkIHRocm91Z2ggU01DID8NCj4gDQoNCjIgcmVhc29uczoNCjE+IEF2b2lkIG11bHRpcGxlIEVF
TUkgY29tbXVuaWNhdGlvbiBjaGFubmVscyBhcyBQU0NJIGlzIHRocm91Z2ggQVRGLg0KMj4gV2Ug
aGF2ZSBzb21lIHNlY3VyZSBvcGVyYXRpb25zIGhhbmRsZWQgaW4gQVRGIGJlY2F1c2Ugb2YgbWVt
b3J5IGNvbnN0cmFpbnRzIG9uIFBNVQ0KDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0K
