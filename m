Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AB8JxZqdQzuFjA+nd1bp1ZYeWbrvbTzM+bnZUzTG3fK6yZrE85+MymovvgT2Ve7z6ewx0rVo0DMu
ARC-Seal: i=1; a=rsa-sha256; t=1526324792; cv=none;
        d=google.com; s=arc-20160816;
        b=K3UL4IoMtK6q7AL33vuz+nvo7ddEeI0HYHh+yQLB7YRoJ1vCNxd/5NlEN8D20rDYqm
         RN2nfRQPB3JW9wq40Ak6rHg//Vqrvp1/HKyXzZS5cMFQeX6WpUL3kwSzpxBgof7ER9Tv
         YpyGXOK0nwLlNqhF6VMpEx6BmajoY7TMFPK/g0Dm2sePcrqTeiJX21Pr84a7kJOwjwPI
         spjhgPq5dxyqu0QC6Bc+gMtnNpyPxU9nrZAg0x+GrR0JaMjKeEiiNJA7AL1mpcajE211
         guiKyD3osapGSGr5J4/PVHhZrcDRdBjQqdmEeez9naFJzgds24DUq5KiKZiXFTwNOyUJ
         xKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Rn4cK1EBS1CwgR8Do0e0TCB4Gfh8LUHnMVs1Jqd0hvA=;
        b=uqBUTydixHEvWLb/jYiSkIOSZun/l3cjQ4iizajdrd5Ne2qXWGtaTLodjf6yXexYJ4
         +hAMK88G3FkSlMby84c7I1AQz1TWg6z18kRm3zqI4NdyfxiVzigH34ujr4JIAsGMNxS9
         mFYb5VpOPP+eJnVpTh4yZja9dEU0fKlvU0AkADKuMNGFrVpyo7LxEp3ODcIDGJO0wAa6
         FsE7E9j7Tw7oklkkyYn17rSrsvuhlvnVvEdXX1VqYvXS6NyQrXGgVNiQ/Eys2tqf2ztI
         8LUnirakCJefqsJMfq7GU/P9M30lNiHRx+KWPvil8qQ0lJto5WP5rUY8/2A/nxqn/S7W
         O5mA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=JK2LnGn+;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.36.44 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=JK2LnGn+;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.36.44 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Subject: RE: [PATCH v6 02/11] firmware: xilinx: Add Zynqmp firmware driver
Thread-Topic: [PATCH v6 02/11] firmware: xilinx: Add Zynqmp firmware driver
Thread-Index: AQHT0QOtEGItBQiG9kK/kjlu757RZ6QpLawAgAadZqA=
Date: Mon, 14 May 2018 19:06:19 +0000
Message-ID: <SN1PR02MB37580153B7BD4C229AA0AAEFB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-3-git-send-email-jollys@xilinx.com>
 <9cbfb3cd-daa3-f145-c6f2-f15f61d1bea0@arm.com>
In-Reply-To: <9cbfb3cd-daa3-f145-c6f2-f15f61d1bea0@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3677;7:tWS4O1NSjCglQ1WeSgcCFUHzStKHmBiIgUbpKO2wKqApc+WZKEfua4FnKNtnM0KvkuZm075ztbOIrXrsyhRSoeSQq6w61WeXh+BrAa0wrab3FyL0jx4bjkLAemraP48dIIxyJ2iCbCJZMiotQh/bJhHP+JcZM45lJavPqAD5XAxjTFRyOEqwjWyzLMi6yPJc5iSEx3CMxteKWCSGVkYLQDSc1igKXkjbee3dwLIql+Vh8BTsF9FuQEQB1U7LsXU4
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(13464003)(189003)(199004)(8676002)(81156014)(7696005)(86362001)(478600001)(2201001)(25786009)(102836004)(76176011)(74316002)(68736007)(53546011)(6506007)(3280700002)(81166006)(305945005)(2906002)(316002)(14454004)(3660700001)(966005)(110136005)(66066001)(54906003)(72206003)(486006)(6246003)(11346002)(33656002)(8936002)(446003)(39060400002)(2900100001)(53936002)(106356001)(4326008)(7416002)(5660300001)(6306002)(476003)(55016002)(26005)(3846002)(6116002)(229853002)(6436002)(5250100002)(97736004)(186003)(99286004)(105586002)(2501003)(7736002)(9686003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3677;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3677;
x-ms-traffictypediagnostic: SN1PR02MB3677:
x-microsoft-antispam-prvs: <SN1PR02MB3677E452FFA308475F91B414B89C0@SN1PR02MB3677.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR02MB3677;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3677;
x-forefront-prvs: 067270ECAF
x-microsoft-antispam-message-info: Lwadaf0YHhDMFRCgXnLOMfzYnMnpAxQZbMDSMcKqrN4HTq0p2ZCBIdM2d6R/h/eYhmFduVQ2olsd4YLbkesZS5xRoXXfA+ZPJxHA2Njljv/ywTG1YLbF2SIlKBn4hu5awLwxKWUDIybuEmKEi1vUg0qsoM2ndcaHK9P/NVwSvK8fH055kvsOoApEaoKOl47B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 420a6996-9291-41d9-0e66-08d5b9cdc673
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420a6996-9291-41d9-0e66-08d5b9cdc673
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 19:06:19.0562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3677
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389331213451831?=
X-GMAIL-MSGID: =?utf-8?q?1600467545931997807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgU3VkZWVwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVl
cCBIb2xsYSBbbWFpbHRvOnN1ZGVlcC5ob2xsYUBhcm0uY29tXQ0KPiBTZW50OiBUaHVyc2RheSwg
TWF5IDEwLCAyMDE4IDc6MDUgQU0NCj4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29t
PjsgYXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZzsNCj4gbWluZ29Aa2VybmVsLm9yZzsgZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc7IG1hdHRAY29kZWJsdWVwcmludC5jby51azsNCj4gaGthbGx3
ZWl0MUBnbWFpbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gZG1pdHJ5LnRvcm9raG92
QGdtYWlsLmNvbTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lkQGNvZGVhdXJvcmEu
b3JnOyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU3VkZWVw
IEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbngu
Y29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSm9sbHkg
U2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDIvMTFd
IGZpcm13YXJlOiB4aWxpbng6IEFkZCBaeW5xbXAgZmlybXdhcmUgZHJpdmVyDQo+IA0KPiANCj4g
DQo+IE9uIDEwLzA0LzE4IDIwOjM4LCBKb2xseSBTaGFoIHdyb3RlOg0KPiA+IEZyb206IFJhamFu
IFZhamEgPHJhamFudkB4aWxpbnguY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyBhZGRpbmcg
Y29tbXVuaWNhdGlvbiBsYXllciB3aXRoIGZpcm13YXJlLg0KPiA+IEZpcm13YXJlIGRyaXZlciBw
cm92aWRlcyBhbiBpbnRlcmZhY2UgdG8gZmlybXdhcmUgQVBJcy4NCj4gPiBJbnRlcmZhY2UgQVBJ
cyBjYW4gYmUgdXNlZCBieSBhbnkgZHJpdmVyIHRvIGNvbW11bmljYXRlIHRvDQo+ID4gUE1VRlco
UGxhdGZvcm0gTWFuYWdlbWVudCBVbml0KS4gQWxsIHJlcXVlc3RzIGdvIHRocm91Z2ggQVRGLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFqYW4gVmFqYSA8cmFqYW52QHhpbGlueC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogSm9sbHkgU2hhaCA8am9sbHlzQHhpbGlueC5jb20+DQo+ID4gLS0t
DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBnZXRfc2V0X2NvbmR1
aXRfbWV0aG9kKCkgLSBDaG9vc2UgU01DIG9yIEhWQyBiYXNlZCBjb21tdW5pY2F0aW9uDQo+ID4g
KyAqIEBucDoJCVBvaW50ZXIgdG8gdGhlIGRldmljZV9ub2RlIHN0cnVjdHVyZQ0KPiA+ICsgKg0K
PiA+ICsgKiBVc2UgU01DIG9yIEhWQy1iYXNlZCBmdW5jdGlvbnMgdG8gY29tbXVuaWNhdGUgd2l0
aCBFTDIvRUwzLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IFJldHVybnMgMCBvbiBzdWNjZXNz
IG9yIGVycm9yIGNvZGUgICovIHN0YXRpYyBpbnQNCj4gPiArZ2V0X3NldF9jb25kdWl0X21ldGhv
ZChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKSB7DQo+ID4gKwljb25zdCBjaGFyICptZXRob2Q7DQo+
ID4gKw0KPiA+ICsJaWYgKG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKG5wLCAibWV0aG9kIiwgJm1l
dGhvZCkpIHsNCj4gPiArCQlwcl93YXJuKCIlcyBtaXNzaW5nIFwibWV0aG9kXCIgcHJvcGVydHlc
biIsIF9fZnVuY19fKTsNCj4gPiArCQlyZXR1cm4gLUVOWElPOw0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiArCWlmICghc3RyY21wKCJodmMiLCBtZXRob2QpKSB7DQo+ID4gKwkJZG9fZndfY2FsbCA9IGRv
X2Z3X2NhbGxfaHZjOw0KPiA+ICsJfSBlbHNlIGlmICghc3RyY21wKCJzbWMiLCBtZXRob2QpKSB7
DQo+ID4gKwkJZG9fZndfY2FsbCA9IGRvX2Z3X2NhbGxfc21jOw0KPiA+ICsJfSBlbHNlIHsNCj4g
PiArCQlwcl93YXJuKCIlcyBJbnZhbGlkIFwibWV0aG9kXCIgcHJvcGVydHk6ICVzXG4iLA0KPiA+
ICsJCQlfX2Z1bmNfXywgbWV0aG9kKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0N
Cj4gPiArDQo+IA0KPiBNYXJrIFIgZGlkIHNvbWUgY2xlYW51cCBhcm91bmQgU01DQ0MgY29uZHVp
dHNbMV0uIEl0IG1ha2VzIHNlbnNlIHRvIGJhc2UgdGhpcw0KPiBvbiB0b3AgdGhhdC4gQnV0IGlm
IHlvdSBtYW5hZ2UgdG8gcHVzaCB0aGlzIGZvciB2NC4xOCwgdGhlbiB5b3UgbWF5IG5lZWQgdG8g
d2FpdA0KPiBmb3IgdGhhdCB0byBiZSBtZXJnZWQgYW5kIGNsZWFuIGl0IHVwIGFmdGVyIHY0LjE4
DQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBTdWRlZXANCg0KTWFyayBSIGRpZCBjaGFuZ2UgZm9y
IFNNQ0NDIGVudW1zIGFuZCB3ZSBhcmUgbm90IHVzaW5nIGFueSBTTUNDQyBlbnVtcyBzbyB3ZSBk
b24ndCBoYXZlIGFueSBkZXBlbmRlbmN5IG9uIHRoYXQuDQoNClRoYW5rcywNCkpvbGx5IFNoYWgN
Cg0KPiANCj4gWzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2FybS1rZXJuZWwvbXNn
NjUwMzA1Lmh0bWwNCg==
