Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AG47ELt0fAtT/1fvQHnLj53oNfB79WyYw7GwzBr0pEFsddHcegemNcKS3V+aA+FDdhIdJw+R/M7l
ARC-Seal: i=1; a=rsa-sha256; t=1520460238; cv=none;
        d=google.com; s=arc-20160816;
        b=FLRe0fAhTE/WHCAZZ4t3UmgfkCUCxLYQapg79ArS7+fAs6+4VWRxJXIvmX0b5vBrTV
         jy0CB65QsbfRB/ROezwo7Uy3dVxzdBmukBYLiKTiav8wxTC3V1a4uMAT+A2jtsIVquok
         tzc3q8cgYWPMv3DaIkQkM86seGl2lW4POo7yIFk90R/uAzFKu2l67ZCB2e15fslGnQqv
         OtFlxIX1gZ/5K/I6OaD60egwMJOx3r9OjEWGq0YlLl2hWtJBPOi7VA1+w+wXJIxfpIjV
         dZMlJDfPfieLpBRmxOWbUefpfwIeaGhkyY4jvrHg9kY8lPQO1iobMI2wbTdmrGfmfmbY
         vl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=wgFv+v0m3yFAereNxwX5EZLdr6G+gEW4EznGGlv/lm0=;
        b=sa6Flz9ju1/VUo7B/zO9ddUrb3t6j46uQeeH9UJWorjGfdbxIDsiy4xqQ5A6h68fWf
         XrOHReyvexuVetCjSSHJX1e6z0GDeQne5ebvJUT0Z5h5fn9rzAyuB46L0UwF6zjKRvmP
         RDV1QIIAkclryDLHT3oc3rf2sgbk9yyBa0Whd1zDPIRxgocttFzp8MLI3jXnXuCUfI60
         R3qJITFbZbK0eBbBIh4eAE1tGo9KQXhL+mDWWvRA8DOZ8B/lcgc0jHh56krELggK0tr0
         oGm8x8DZ+GoMC2eb7Tn6WtpwGgh088GCYLoy1a0NmG4TH9YxY2EYyHXW+oaLuL8704yc
         XbEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=uiZiPDoX;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.73 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=uiZiPDoX;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.73 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"mingo@kernel.org" <mingo@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "matt@codeblueprint.co.uk"
	<matt@codeblueprint.co.uk>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "michal.simek@xilinx.com"
	<michal.simek@xilinx.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, Rajan Vaja
	<RAJANV@xilinx.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
Thread-Topic: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
Thread-Index: AQHTqoAjKTcTPssCQUKUhEOwggajX6O7goWAgAnhnqA=
Date: Wed, 7 Mar 2018 22:03:54 +0000
Message-ID: <CY1PR0201MB0764DDE30E3DFF713FAF0F7BB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-4-git-send-email-jollys@xilinx.com>
 <573acd04-85c4-829d-a0d6-36b3958ac1ec@arm.com>
In-Reply-To: <573acd04-85c4-829d-a0d6-36b3958ac1ec@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0201MB1834;7:kjN0MDuk74HLGFe4kdtm52UK2u8yPNvWql//+Rqr/k7TpQcjOUqJ/llhG5jrTIa2RpVN1fQE70YhopH5IiweIXcWV07qjPlXRDae9Avx+tuzso+tkS2Voakmtf7Jo8jkrJOqGlVE1WU7TayVXTkxXqjqXgEddUf+zb0qgUHzzGrav7+ycc8gOkv0xOf9uSbcDMakHddB6vfICZki30CvKmrSdJ2C9gHS3RI1qSJi2UirAk71MqXp2Vz6oWF0VJLe
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(366004)(39860400002)(346002)(13464003)(199004)(189003)(50944005)(39060400002)(68736007)(106356001)(72206003)(53936002)(6246003)(105586002)(6436002)(9686003)(97736004)(7696005)(99286004)(25786009)(2950100002)(478600001)(6916009)(3280700002)(76176011)(2900100001)(74316002)(7416002)(316002)(26005)(53546011)(5660300001)(14454004)(66066001)(8936002)(102836004)(3660700001)(8676002)(229853002)(186003)(305945005)(77096007)(3846002)(6116002)(7736002)(59450400001)(33656002)(6506007)(2906002)(4326008)(55016002)(86362001)(54906003)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1834;H:CY1PR0201MB0764.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01886bee-f7ec-4759-75a4-08d584775179
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0201MB1834;
x-ms-traffictypediagnostic: CY1PR0201MB1834:
x-microsoft-antispam-prvs: <CY1PR0201MB18344540A787550EC87C8A06B8D80@CY1PR0201MB1834.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR0201MB1834;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1834;
x-forefront-prvs: 0604AFA86B
x-microsoft-antispam-message-info: 6k8l8XSc3sC8KoP/Oi4er2K54cHQXGu7ooc0hVMYA5WXhslqQMd2Gxid2Gn4nlLUYiEkYi0ob7DvohoJDwje0Nynd8MKj79HyJ4Td8kT/UAbRubqKClvBBzhFDrILdt1vnP2xnneiHiS/+thwa5+ulPWCk3V12ikptSGXpDVXSjuOO6NL3gYgM95+qsBuAb5U4EKz9lQOYYEkILOOhM/xBwS75gmlwN3x7zH13YGgO08nM6yFd+1+nGvrGQghDxi+5O/gi2WK8B4DqG34FVthhyFtrp61xXyQT3v1/MVabUYQ1GTdqBD8HEHOE0YCqri5eG407727rZZlIZlES0L1Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01886bee-f7ec-4759-75a4-08d584775179
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 22:03:54.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1834
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948932748631222?=
X-GMAIL-MSGID: =?utf-8?q?1594318115678340036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgU3VkZWVwLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3Vk
ZWVwIEhvbGxhIFttYWlsdG86c3VkZWVwLmhvbGxhQGFybS5jb21dDQo+IFNlbnQ6IFRodXJzZGF5
LCBNYXJjaCAwMSwgMjAxOCA2OjQ0IEFNDQo+IFRvOiBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54
LmNvbT4NCj4gQ2M6IGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc7IG1pbmdvQGtlcm5lbC5vcmc7
DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBtYXR0QGNvZGVibHVlcHJpbnQuY28udWs7
DQo+IGhrYWxsd2VpdDFAZ21haWwuY29tOyBrZWVzY29va0BjaHJvbWl1bS5vcmc7DQo+IGRtaXRy
eS50b3Jva2hvdkBnbWFpbC5jb207IG1pY2hhbC5zaW1la0B4aWxpbnguY29tOyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5o
b2xsYUBhcm0uY29tPjsgUmFqYW4gVmFqYQ0KPiA8UkFKQU5WQHhpbGlueC5jb20+OyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSm9sbHkgU2hhaA0KPiA8Sk9MTFlT
QHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy80XSBkcml2ZXJzOiBmaXJt
d2FyZTogeGlsaW54OiBBZGQgc3lzZnMgaW50ZXJmYWNlDQo+IA0KPiANCj4gDQo+IE9uIDIwLzAy
LzE4IDE5OjIxLCBKb2xseSBTaGFoIHdyb3RlOg0KPiA+IEFkZCBGaXJtd2FyZS1nZ3Mgc3lzZnMg
aW50ZXJmYWNlIHdoaWNoIHByb3ZpZGVzIHJlYWQvd3JpdGUgaW50ZXJmYWNlDQo+ID4gdG8gZ2xv
YmFsIHN0b3JhZ2UgcmVnaXN0ZXJzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9sbHkgU2hh
aCA8am9sbHlzQHhpbGlueC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFqYW4gVmFqYSA8cmFq
YW52QHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9BQkkvc3RhYmxlL3N5c2ZzLWRyaXZl
ci16eW5xbXAtZmlybXdhcmUgICAgICAgIHwgIDUwICsrKysNCj4gPiAgZHJpdmVycy9maXJtd2Fy
ZS94aWxpbngvenlucW1wL01ha2VmaWxlICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgZHJpdmVy
cy9maXJtd2FyZS94aWxpbngvenlucW1wL2Zpcm13YXJlLWdncy5jICAgICAgfCAyOTcNCj4gKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC9m
aXJtd2FyZS5jICAgICAgICAgIHwgIDEzICsNCj4gPiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS94
aWxpbngvenlucW1wL2Zpcm13YXJlLmggICAgfCAgIDIgKw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQs
IDM2MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
PiBEb2N1bWVudGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZHJpdmVyLXp5bnFtcC1maXJtd2FyZQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wL2Zp
cm13YXJlLWdncy5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvc3Rh
YmxlL3N5c2ZzLWRyaXZlci16eW5xbXAtZmlybXdhcmUNCj4gPiBiL0RvY3VtZW50YXRpb24vQUJJ
L3N0YWJsZS9zeXNmcy1kcml2ZXItenlucW1wLWZpcm13YXJlDQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5iMDQ3MjdhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1kcml2ZXItenlucW1wLWZpcm13
YXJlDQo+ID4gQEAgLTAsMCArMSw1MCBAQA0KPiA+ICtXaGF0OgkJL3N5cy9kZXZpY2VzL3BsYXRm
b3JtL3p5bnFtcC1maXJtd2FyZS9nZ3M+ICtEYXRlOg0KPiAJCUphbnVhcnkgMjAxOA0KPiA+ICtL
ZXJuZWxWZXJzaW9uOgk0LjE1LjANCj4gPiArQ29udGFjdDoJIkpvbGx5IFNoYWgiIDxqb2xseXNA
eGlsaW54LmNvbT4NCj4gPiArRGVzY3JpcHRpb246DQo+ID4gKwkJUmVhZC9Xcml0ZSBQTVUgZ2xv
YmFsIGdlbmVyYWwgc3RvcmFnZSByZWdpc3RlciB2YWx1ZSwNCj4gPiArCQlHTE9CQUxfR0VOX1NU
T1JBR0V7MDozfS4NCj4gPiArCQlHbG9iYWwgZ2VuZXJhbCBzdG9yYWdlIHJlZ2lzdGVyIHRoYXQg
Y2FuIGJlIHVzZWQNCj4gPiArCQlieSBzeXN0ZW0gdG8gcGFzcyBpbmZvcm1hdGlvbiBiZXR3ZWVu
IG1hc3RlcnMuDQo+ID4gKw0KPiANCj4gV2hhdCBraW5kIG9mIGluZm9ybWF0aW9uID8gSXMgdGhl
cmUgYW55IHNlbWFudGljcyBmb3IgdGhhdCA/DQo+IFdoeSBkb2VzIEVFTUkgbGFjayBBUElzIGZv
ciB0aGF0IGlmIGl0J3MgY3JpdGljYWwsIGdpdmluZyBhY2Nlc3MgdG8gc3VjaCBpbmZvcm1hdGlv
bg0KPiB0byB1c2Vyc3BhY2UgbWF5IG5vdCBiZSBnb29kIGlkZWEuDQo+IAkNCg0KVGhlc2UgYXJl
IGZvciBnZW5lcmFsIHVzZS4gSW5mb3JtYXRpb24gYmVpbmcgcGFzc2VkIGNhbiBiZSBhcHBsaWNh
dGlvbiBzcGVjaWZpYy4NClN5c2ZzIGNhbGwgdW5kZXJuZWF0aCBtYXBzIHRvIEVFTUkgaW9jdGwg
Y2FsbCB0byByZWFkL3dyaXRlIHRoZXNlIHJlZ2lzdGVycy4NCg0KPiA+ICsJCVRoZSByZWdpc3Rl
ciBpcyByZXNldCBkdXJpbmcgc3lzdGVtIG9yIHBvd2VyLW9uDQo+ID4gKwkJcmVzZXRzLiBUaHJl
ZSByZWdpc3RlcnMgYXJlIHVzZWQgYnkgdGhlIEZTQkwgYW5kDQo+ID4gKwkJb3RoZXIgWGlsaW54
IHNvZnR3YXJlIHByb2R1Y3RzOiBHTE9CQUxfR0VOX1NUT1JBR0V7NDo2fS4NCj4gPiArDQo+IA0K
PiBGU0JMID8NCj4gDQo+IEZvciB3aGF0IGlzIGl0IHVzZWQgPw0KDQpUaGVyZSBhcmUgdG90YWwg
OCBzdWNoIHJlZ2lzdGVycy4gNCBhcmUgcmVzZXJ2ZWQgZm9yIGN1c3RvbWVyIGFwcGxpY2F0aW9u
LiBPdGhlciA0IGFyZSBiZWluZyB1c2VkIGJ5IFhpbGlueCBzdyBwcm9kdWN0cyBsaWtlIEZTQkwu
DQpGU0JMIGlzIHVzaW5nIGl0IHRvIHBhc3MgaGFuZG9mZiBpbmZvcm1hdGlvbiB0byBvdGhlciBt
YXN0ZXIuDQoNCj4gDQo+ID4gKwkJVXNhZ2U6DQo+ID4gKwkJIyBjYXQgL3N5cy8uLi4venlucW1w
LWZpcm13YXJlL2dnczANCj4gPiArCQkjIGVjaG8gPG1hc2s+IDx2YWx1ZT4gPiAvc3lzLy4uLi96
eW5xbXAtZmlybXdhcmUvZ2dzMA0KPiA+ICsNCj4gPiArCQlFeGFtcGxlOg0KPiA+ICsJCSMgY2F0
IC9zeXMvLi4uL3p5bnFtcC1maXJtd2FyZS9nZ3MwDQo+ID4gKwkJIyBlY2hvIDB4RkZGRkZGRkYg
MHgxMjM0QUJDRCA+IC9zeXMvLi4uL3p5bnFtcC0NCj4gZmlybXdhcmUvZ2dzMA0KPiA+ICsNCj4g
PiArVXNlcnM6CQlYaWxpbngNCj4gPiArDQo+ID4gK1doYXQ6CQkvc3lzL2RldmljZXMvcGxhdGZv
cm0venlucW1wLWZpcm13YXJlL3BnZ3MqDQo+ID4gK0RhdGU6CQlKYW51YXJ5IDIwMTgNCj4gPiAr
S2VybmVsVmVyc2lvbjoJNC4xNS4wDQo+ID4gK0NvbnRhY3Q6CSJKb2xseSBTaGFoIiA8am9sbHlz
QHhpbGlueC5jb20+DQo+ID4gK0Rlc2NyaXB0aW9uOg0KPiA+ICsJCVJlYWQvV3JpdGUgUE1VIHBl
cnNpc3RlbnQgZ2xvYmFsIGdlbmVyYWwgc3RvcmFnZSByZWdpc3Rlcg0KPiA+ICsJCXZhbHVlLCBQ
RVJTX0dMT0JfR0VOX1NUT1JBR0V7MDozfS4NCj4gPiArCQlQZXJzaXN0ZW50IGdsb2JhbCBnZW5l
cmFsIHN0b3JhZ2UgcmVnaXN0ZXIgdGhhdA0KPiA+ICsJCWNhbiBiZSB1c2VkIGJ5IHN5c3RlbSB0
byBwYXNzIGluZm9ybWF0aW9uIGJldHdlZW4NCj4gPiArCQltYXN0ZXJzLg0KPiA+ICsNCj4gDQo+
IERpdHRvDQo+IA0KPiA+ICsJCVRoaXMgcmVnaXN0ZXIgaXMgb25seSByZXNldCBieSB0aGUgcG93
ZXItb24gcmVzZXQNCj4gPiArCQlhbmQgbWFpbnRhaW5zIGl0cyB2YWx1ZSB0aHJvdWdoIGEgc3lz
dGVtIHJlc2V0Lg0KPiA+ICsJCUZvdXIgcmVnaXN0ZXJzIGFyZSB1c2VkIGJ5IHRoZSBGU0JMIGFu
ZCBvdGhlciBYaWxpbngNCj4gPiArCQlzb2Z0d2FyZSBwcm9kdWN0czogUEVSU19HTE9CX0dFTl9T
VE9SQUdFezQ6N30uDQo+ID4gKwkJUmVnaXN0ZXIgaXMgcmVzZXQgb25seSBieSBhIFBPUiByZXNl
dC4NCj4gPiArDQo+IA0KPiBEaXR0bw0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gU3VkZWVwDQo=
