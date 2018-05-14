Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AB8JxZqCCHBcY+vfLqCkMOoeX+/PfHmYum3ToGbm/9mNXrpvY3z/uE54dJBNqw1fI8bzl8vyMkUC
ARC-Seal: i=1; a=rsa-sha256; t=1526325122; cv=none;
        d=google.com; s=arc-20160816;
        b=mScXZKgQ3E0PtxSuJDeDECFRcmgTjPOyVE2D9i6j0IAlupCk1D86Ld1akRw6nlTySn
         QBeblYFtNQhQgqgsP6fLoWCHQkTbeXkqdJxfaXnLrtKQO9NqKTDa+t8ti+mQ+WW5JHST
         4zHwrsw/n1Xa79yTdYKoskUYBhFoN8PyX17MjuZG6gNm22lPsKKmD05WnMJxN5cLfDzs
         7Op76G2MlbTtJZAGV10BAhRRkWgd02J0yxmWfgXIcssCpAb1NeEtb3lamAXtpKYUxH+L
         w+CBp7Qe044UGdU0Che5q/NWNPOwzE15rz03gAjO1IEMUfw6o7VYmBBrgDLZ5hSyxevA
         4uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=PohofdT7TygUyKhizuZLyKttMbkFEM5adQPyXlFz9OE=;
        b=E+RXlXw19kWU+tGHGWHlaLDy13QP+onWPJK8Bokc55TSaRt2Ov3IlQJ8svpBfFnegu
         8CTbqpjX0ZDaL6onHOgLDog9yV+7hPTKJuWH2r0TkAjW20HMQCzgHH7vK1wgsTmQEuae
         snDrPoYYfow7E4YblntsfvtJl6pLzos51MtNFyG5e5+cbflqmOQk9HBxSIAW3lAJCtGA
         dhERV/xnADtqW5r7BzYXUIA5PjFrgWCiyVobbCfOKj5RciN3x0xgwlJ6OYK7bKdyAA19
         5Ov8gBhDjd5P55Qn+ffm/fFDM08pufkWraCGIX8J8PNNGUJ/t4orrrPme7JT9GPibKLw
         oaLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=SypU6PBY;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.41.51 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=SypU6PBY;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.41.51 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "ard.biesheuvel@linaro.org"
	<ard.biesheuvel@linaro.org>, "mingo@kernel.org" <mingo@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org"
	<sboyd@codeaurora.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
CC: Rajan Vaja <RAJANV@xilinx.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Topic: [PATCH v6 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Index: AQHT0QOuPMmidPMypEa4aBd7J7FN0qQpLukAgAacZwA=
Date: Mon, 14 May 2018 19:11:56 +0000
Message-ID: <SN1PR02MB3758F635BA420721B0EB8A2FB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-4-git-send-email-jollys@xilinx.com>
 <c351b9a3-5f26-7202-7171-0dcc7adef7c0@arm.com>
In-Reply-To: <c351b9a3-5f26-7202-7171-0dcc7adef7c0@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB2128;7:Qml7Likh78sy83L3hrY5A1pFWv93mj03yjc7mgv+Hz1eYLso+jU35ZiSMRmOeLv93zSHh1DAjl06XttFh83JUdrLf64rlrxqnZb2rp5gernnx8n89qpcMBgFVjdwpB4knsxa9Vr8WcLoUXEG/+vsIeoNKXOszCbdJtowQh+TNVAcQF1NTkeTg7FADASmM7u9flPum7x4PDM0u2T0egz7XZlkLNVENafn9T4j7UprCEgQE+nLWOPvz37oEHeWMg9Z
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(13464003)(86362001)(74316002)(81156014)(26005)(305945005)(7736002)(8676002)(3280700002)(5660300001)(3660700001)(2201001)(8936002)(66066001)(9686003)(68736007)(316002)(97736004)(186003)(7416002)(102836004)(39060400002)(55016002)(2906002)(81166006)(25786009)(5250100002)(2501003)(4326008)(106356001)(105586002)(476003)(53546011)(11346002)(6506007)(2900100001)(53936002)(486006)(76176011)(33656002)(54906003)(229853002)(14454004)(446003)(110136005)(7696005)(6116002)(72206003)(6246003)(478600001)(6436002)(3846002)(99286004)(921003)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2128;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB2128;
x-ms-traffictypediagnostic: SN1PR02MB2128:
x-microsoft-antispam-prvs: <SN1PR02MB212878FBEDD976CCCDCCA12AB89C0@SN1PR02MB2128.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR02MB2128;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB2128;
x-forefront-prvs: 067270ECAF
x-microsoft-antispam-message-info: SvZxvb1O0OfmFTt3Dyahc1dvJBFXPsqcMe84bE1aCIZQz/CCFX66XrYF+zZhDlNGdkGEGuDIRl/ssYN/oCFVf6QIPwcByOVKFG7wT26bRT8Xmc3Cw/c7D6+volDI+3z1nBakXJXKm53DlpNHCC0k7ysRvXKLRxdI6YBUaxzf3Nt4Ba29lHNUy9Yrm72s/IKf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fe061386-7ff1-400d-5149-08d5b9ce8f63
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe061386-7ff1-400d-5149-08d5b9ce8f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 19:11:56.1439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2128
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389330509199100?=
X-GMAIL-MSGID: =?utf-8?q?1600467891634703586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgU3VkZWVwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVl
cCBIb2xsYSBbbWFpbHRvOnN1ZGVlcC5ob2xsYUBhcm0uY29tXQ0KPiBTZW50OiBUaHVyc2RheSwg
TWF5IDEwLCAyMDE4IDc6MDkgQU0NCj4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29t
PjsgYXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZzsNCj4gbWluZ29Aa2VybmVsLm9yZzsgZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc7IG1hdHRAY29kZWJsdWVwcmludC5jby51azsNCj4gaGthbGx3
ZWl0MUBnbWFpbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gZG1pdHJ5LnRvcm9raG92
QGdtYWlsLmNvbTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lkQGNvZGVhdXJvcmEu
b3JnOyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU3VkZWVw
IEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbngu
Y29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSm9sbHkg
U2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDMvMTFd
IGZpcm13YXJlOiB4aWxpbng6IEFkZCB6eW5xbXAgSU9DVEwgQVBJIGZvciBkZXZpY2UNCj4gY29u
dHJvbA0KPiANCj4gDQo+IA0KPiBPbiAxMC8wNC8xOCAyMDozOCwgSm9sbHkgU2hhaCB3cm90ZToN
Cj4gPiBGcm9tOiBSYWphbiBWYWphIDxyYWphbnZAeGlsaW54LmNvbT4NCj4gPg0KPiA+IEFkZCBa
eW5xTVAgZmlybXdhcmUgSU9DVEwgQVBJIHRvIGNvbnRyb2wgYW5kIGNvbmZpZ3VyZSBkZXZpY2Vz
IGxpa2UNCj4gPiBQTExzLCBTRCwgR2VtLCBldGMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBS
YWphbiBWYWphIDxyYWphbnZAeGlsaW54LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2xseSBT
aGFoIDxqb2xseXNAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9maXJtd2FyZS94
aWxpbngvenlucW1wLmMgICAgIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVk
ZS9saW51eC9maXJtd2FyZS94bG54LXp5bnFtcC5oIHwgIDIgKysNCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAyMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJt
d2FyZS94aWxpbngvenlucW1wLmMNCj4gPiBiL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFt
cC5jDQo+ID4gaW5kZXggNDkwNTYxYS4uNDRiNDNmYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUveGls
aW54L3p5bnFtcC5jDQo+ID4gQEAgLTIzOSw4ICsyMzksMjggQEAgc3RhdGljIGludCBnZXRfc2V0
X2NvbmR1aXRfbWV0aG9kKHN0cnVjdA0KPiBkZXZpY2Vfbm9kZSAqbnApDQo+ID4gIAlyZXR1cm4g
MDsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiB6eW5xbXBfcG1faW9jdGwoKSAtIFBN
IElPQ1RMIEFQSSBmb3IgZGV2aWNlIGNvbnRyb2wgYW5kIGNvbmZpZ3MNCj4gPiArICogQG5vZGVf
aWQ6CU5vZGUgSUQgb2YgdGhlIGRldmljZQ0KPiA+ICsgKiBAaW9jdGxfaWQ6CUlEIG9mIHRoZSBy
ZXF1ZXN0ZWQgSU9DVEwNCj4gPiArICogQGFyZzE6CUFyZ3VtZW50IDEgdG8gcmVxdWVzdGVkIElP
Q1RMIGNhbGwNCj4gPiArICogQGFyZzI6CUFyZ3VtZW50IDIgdG8gcmVxdWVzdGVkIElPQ1RMIGNh
bGwNCj4gPiArICogQG91dDoJUmV0dXJuZWQgb3V0cHV0IHZhbHVlDQo+ID4gKyAqDQo+ID4gKyAq
IFRoaXMgZnVuY3Rpb24gY2FsbHMgSU9DVEwgdG8gZmlybXdhcmUgZm9yIGRldmljZSBjb250cm9s
IGFuZCBjb25maWd1cmF0aW9uLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IFJldHVybnMgc3Rh
dHVzLCBlaXRoZXIgc3VjY2VzcyBvciBlcnJvcityZWFzb24gICovIHN0YXRpYw0KPiA+ICtpbnQg
enlucW1wX3BtX2lvY3RsKHUzMiBub2RlX2lkLCB1MzIgaW9jdGxfaWQsIHUzMiBhcmcxLCB1MzIg
YXJnMiwNCj4gPiArCQkJICAgdTMyICpvdXQpDQo+ID4gK3sNCj4gPiArCXJldHVybiB6eW5xbXBf
cG1faW52b2tlX2ZuKFBNX0lPQ1RMLCBub2RlX2lkLCBpb2N0bF9pZCwNCj4gPiArCQkJCSAgIGFy
ZzEsIGFyZzIsIG91dCk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
enlucW1wX2VlbWlfb3BzIGVlbWlfb3BzID0gew0KPiA+ICAJLmdldF9hcGlfdmVyc2lvbiA9IHp5
bnFtcF9wbV9nZXRfYXBpX3ZlcnNpb24sDQo+ID4gKwkuaW9jdGwgPSB6eW5xbXBfcG1faW9jdGws
DQo+ID4gIH07DQo+ID4NCj4gPiAgLyoqDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
ZmlybXdhcmUveGxueC16eW5xbXAuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS94bG54
LXp5bnFtcC5oDQo+ID4gaW5kZXggY2I2M2JlZC4uMmVlYzZlNyAxMDA2NDQNCj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmgNCj4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmgNCj4gPiBAQCAtMzQsNiArMzQsNyBAQA0KPiA+DQo+
ID4gIGVudW0gcG1fYXBpX2lkIHsNCj4gPiAgCVBNX0dFVF9BUElfVkVSU0lPTiA9IDEsDQo+ID4g
KwlQTV9JT0NUTCA9IDM0LA0KPiANCj4gSSBhbSBub3QgZm9yIHRoaXMgQVBJLiBJSVVDIHRoZXJl
IGFyZSBtb3JlIGZpbmVkIGdyYWluZWQgd2VsbCBkZWZpbmVkIEFQSXMoaWYgSSBhbQ0KPiBub3Qg
d3JvbmcgZnJvbSBlbnVtIDIgdXB0byAzMykuIFRoaXMgaXMgb3BlbiBlbmRlZCBBUEkgd2hpY2gg
YWxsb3dzIHVzZXIgdG8gZG8NCj4gd2hhdGV2ZXIgc2V0dGluZyBpdCBuZWVkcy4gQW5kIHRoYXQg
ZGVmZWF0cyB0aGUgcHVycG9zZSBvZiBvdGhlciBBUElzLg0KPiANCj4gSSB3aWxsIGxvb2sgdGhy
b3VnaCB0aGUgc2VyaWVzIGZvciB0aGUgdXNhZ2Ugb2YgdGhpcyB0byB1bmRlcnN0YW5kIHRoaXMg
YmV0dGVyLCBidXQgSQ0KPiBhbSBndWVzc2luZyBob3cgaXQgY2FuIGJlIChhYil1c2VkLg0KPiAN
Cj4gLS0NCj4gUmVnYXJkcywNCj4gU3VkZWVwDQoNClRoZXJlIGFyZSB3ZWxsIGRlZmluZWQgQVBJ
cyBmb3IgZ2VuZXJhbCBjbG9jayBjb250cm9scy4gSW9jdGwgaXMgZm9yIHNvbWUgc3BlY2lmaWMg
b3BlcmF0aW9ucyB3aGljaCBtYXkgbm90IGFwcGx5IHRvIGFsbCBwbGF0Zm9ybXMuDQpGb3IgY2xv
Y2sgZHJpdmVyLCBpb2N0bCBpcyB1c2VkIHRvIGdldC9zZXQgUGxsIGZyYWN0aW9uL2ludGVnZXIg
bW9kZSBhbmQgZGF0YS4gDQoNClRoYW5rcywNCkpvbGx5IFNoYWgNCg==
