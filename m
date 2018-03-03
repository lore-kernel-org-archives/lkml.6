Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsxTQlBt1uZWF7cFyAVpp8TellmGHi0c2AdWe4MIz9K4aV9ShqgjeSIG+5BD/giFWl2XjpL
ARC-Seal: i=1; a=rsa-sha256; t=1520115884; cv=none;
        d=google.com; s=arc-20160816;
        b=jbMNJQZ85xO6xXz6ciXLKrysACpAx7EIey2YMoAP3h7LUJ8TLMHsNC0umLPpCJy1sv
         jzWayEhkaueNAAoMm5KqysXb1liQgHrYHP2C8eitDxT19RBVSJC4oZR7o6sRkPVBiDF/
         AsT9xPly9BZU2hum6JAAUjVCMT++6O/J+lGIaiRT/NdKp5ArUJSFDdr4VAKaLI1cgH95
         6SD3AxAoesCsOtTUcNH0oVM+pUAaUszu7EMCpNPeWqCmHlOFnVlChhfqbVf+UjRtiebD
         BSoUQjCqvdzkWxp/CPFmXTeIjel1C4gYgs1DCN843b+kxum5kqlXCZbxAf/0GUTCxPWV
         /pVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9btTS7CaOcFulWDd2fzSWossHGnF1Czn1Wf//UbQUbg=;
        b=vEgAzfOwv0iIaDYS4XlTNRn7QDh1duApe7JsONaV/b4rOf+hbftxgypGFHniN7eOsf
         ahokh3Dm+wdDsLvkcAqdEBktC/VOL0tLecc+AYZzDzguqr/OLS/Fn+SLwFYNQJ8CS2Mo
         S2fI2MSFih9v0k1haVqSSNpeTIwmoTqsuReBNuVvukQ9abdxSyfXNP25kO/WzlEAdIvr
         f30MVRRElsnmjDrm15z47QCojilPlbLIxnIUrsmqIna8URCvaQFjo750oOlx1zEv8r6l
         t9FtDkz5YAt0NPFQHZjoh9syW+heK7LFiUaJwhNfopJZuSk8++l6oHnigVnxNd6s3IR1
         vcCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=RwafZgnO;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=RwafZgnO;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Mark Jackson <mpfj@newflow.co.uk>,
	=?utf-8?B?TWljaGHFgiBPbGVzemN6eWs=?= <oleszczyk.m@gmail.com>, Rafael Gago
 Castano <rgc@hms.se>, Sascha Hauer <s.hauer@pengutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 018/102] dt-bindings: serial: Add common
 rs485 binding for RTS polarity
Thread-Topic: [PATCH AUTOSEL for 4.15 018/102] dt-bindings: serial: Add common
 rs485 binding for RTS polarity
Thread-Index: AQHTsz5fM1ufYv9oLkmPH01Q8bMc3A==
Date: Sat, 3 Mar 2018 22:24:19 +0000
Message-ID: <20180303222318.26006-18-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:ahW/0nHjoqO93QVS1UijcTOs+LL9VjCWStS++l6hFUMr+IL2thlthEDVi1a+IH/qVBJn7RnUy5fZ6sLxbjPuI6+6nO2xzvdk296Q/A9C/3Rir/UM5rw6rgXT6xcqSPjIggQrWECVU71WWzuDR213KHqKLkUUeZlrggAMophgSAjkv1pA2g4cRJhwSa1rOI/2P+Pn+ZFwzQWWf0rUApz0LEzNyOP+7UeKiCj5LvUMENCeqFfZYb3qf+zbOe6l7fzF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c3a7231-7a46-4bb4-e0b3-08d581559052
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB089073B97CF48876E298E8A6FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(85827821059158)(106291317490208)(108721460000369);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(575784001)(86362001)(105586002)(1076002)(6306002)(14454004)(8936002)(6436002)(66066001)(59450400001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(39060400002)(4326008)(86612001)(186003)(5890100001)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(966005)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: RQ3x+NvZ4ROVK7aJj2N6dCPCeYUK7iarku0X9r8iamWiE9Vji5Ze+mDlBsRV7Rs/ewbUePwiOXOg4hJ+Rcr7IxzXGEaqvpkjQChzOr6Y+6zxtoLAPawBy9xLDpCa/myzA012dBwS7+bSu//HLPP/XEBpy+xhC1Lce/3KTu1RbtI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A74B44F31A02049B8C63DA221D77EBA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3a7231-7a46-4bb4-e0b3-08d581559052
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:19.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957034238877964?=
X-GMAIL-MSGID: =?utf-8?q?1593957034238877964?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+DQoNClsgVXBzdHJlYW0gY29tbWl0
IDZhYmU5ZWE4YTVhNTkwNGQ5MzViOGE0ODIxMTdhN2ZkOWIyNWYwOWUgXQ0KDQpyczQ4NSBhbGxv
d3MgZm9yIHJvYnVzdCBoYWxmLWR1cGxleCBzZXJpYWwgY29tbXVuaWNhdGlvbi4gIEl0IGlzIG9m
dGVuDQppbXBsZW1lbnRlZCBieSBhdHRhY2hpbmcgYW4gcnM0ODUgdHJhbnNjZWl2ZXIgdG8gYSBV
QVJULiAgVGhlIFVBUlQncw0KUlRTIGxpbmUgaXMgd2lyZWQgdG8gdGhlIHRyYW5zY2VpdmVyJ3Mg
VHJhbnNtaXQgRW5hYmxlIHBpbiBhbmQNCmRldGVybWluZXMgd2hldGhlciB0aGUgdHJhbnNjZWl2
ZXIgaXMgc2VuZGluZyBvciByZWNlaXZpbmcuDQoNCkV4YW1wbGVzIGZvciBzdWNoIHRyYW5zY2Vp
dmVycyBhcmUgTWF4aW0gTUFYMTM0NTFFIGFuZCBUSSBTTjY1SFZEMTc4MUE6DQpodHRwczovL2Rh
dGFzaGVldHMubWF4aW1pbnRlZ3JhdGVkLmNvbS9lbi9kcy9NQVgxMzQ1MEUtTUFYMTM0NTFFLnBk
Zg0KaHR0cDovL3d3dy50aS5jb20vbGl0L2RzL3N5bWxpbmsvc242NWh2ZDE3ODFhLXExLnBkZg0K
DQpJbiB0aGUgZGV2aWNldHJlZSwgdGhlIHRyYW5zY2VpdmVyIGl0c2VsZiBpcyBub3QgcmVwcmVz
ZW50ZWQsIG9ubHkgdGhlDQpVQVJUIGlzLiAgQSBmZXcgcnM0ODUtc3BlY2lmaWMgZHQtYmluZGlu
Z3MgYWxyZWFkeSBleGlzdCBhbmQgdGhlc2UgZ28NCmludG8gdGhlIFVBUlQncyBkZXZpY2Ugbm9k
ZS4NCg0KVGhpcyBjb21taXQgYWRkcyBhIGJpbmRpbmcgdG8gc2V0IHRoZSBSVFMgcG9sYXJpdHku
ICBNb3N0IChpZiBub3QgYWxsKQ0KdHJhbnNjZWl2ZXJzIHJlcXVpcmUgdGhlIFRyYW5zbWl0IEVu
YWJsZSBwaW4gYmUgZHJpdmVuIGhpZ2ggZm9yIHNlbmRpbmcsDQpidXQgaW4gc29tZSBjYXNlcyBi
b2FyZHMgbWF5IG5lZ2F0ZSB0aGUgcGluIGFuZCBSVFMgbXVzdCB0aGVuIGJlIGRyaXZlbg0KbG93
LiAgQ29uc2VxdWVudGx5IHRoZSBwb2xhcml0eSBkZWZhdWx0cyB0byBhY3RpdmUgaGlnaCBidXQg
Y2FuIGJlDQppbnZlcnRlZCB3aXRoIHRoZSBuZXdseSBhZGRlZCAicnM0ODUtcnRzLWFjdGl2ZS1s
b3ciIGJpbmRpbmcuDQoNCkRvY3VtZW50IHRoaXMgYmluZGluZyBpbiByczQ4NS50eHQgYW5kIGlu
IHRoZSB0d28gZHJpdmVycyBmc2wtaW14LXVhcnQNCmFuZCBmc2wtbHB1YXJ0IHRoYXQgYXJlIGFi
b3V0IHRvIGJlIGFtZW5kZWQgd2l0aCBzdXBwb3J0IGZvciBpdC4NCg0KQ3VyaW91c2x5LCB0aGUg
b21hcF9zZXJpYWwgZHJpdmVyIGRlZmF1bHRzIHRvIGFjdGl2ZSBsb3cgYW5kIGFscmVhZHkNCnN1
cHBvcnRzIGFuICJyczQ4NS1ydHMtYWN0aXZlLWhpZ2giIGJpbmRpbmcgdG8gaW52ZXJ0IHRoZSBw
b2xhcml0eS4NClRoaXMgaXMgbGVmdCB1bmNoYW5nZWQgdG8gcmV0YWluIGNvbXBhdGliaWxpdHks
IGJ1dCB0aGUgYmluZGluZyBpcw0KaGVyZXdpdGggZG9jdW1lbnRlZC4NCg0KQ2M6IE1hcmsgSmFj
a3NvbiA8bXBmakBuZXdmbG93LmNvLnVrPg0KQ2M6IE1pY2hhxYIgT2xlc3pjenlrIDxvbGVzemN6
eWsubUBnbWFpbC5jb20+DQpDYzogUmFmYWVsIEdhZ28gQ2FzdGFubyA8cmdjQGhtcy5zZT4NCkNj
OiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQpBY2tlZC1ieTogUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IEx1a2FzIFd1bm5lciA8bHVr
YXNAd3VubmVyLmRlPg0KQWNrZWQtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2Vu
aWdAcGVuZ3V0cm9uaXguZGU+DQpTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFs
ZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NlcmlhbC9mc2wtaW14LXVhcnQudHh0IHwgMyArKy0NCiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2ZzbC1scHVhcnQudHh0ICAgfCAzICsrLQ0K
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvb21hcF9zZXJpYWwudHh0
ICB8IDEgKw0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcnM0ODUu
dHh0ICAgICAgICB8IDEgKw0KIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NlcmlhbC9mc2wtaW14LXVhcnQudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NlcmlhbC9mc2wtaW14LXVhcnQudHh0DQppbmRleCA4NjBhOTU1OTgzOWEuLjg5Yjky
YzEzMTRjZiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
ZXJpYWwvZnNsLWlteC11YXJ0LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NlcmlhbC9mc2wtaW14LXVhcnQudHh0DQpAQCAtOSw3ICs5LDggQEAgT3B0aW9uYWwg
cHJvcGVydGllczoNCiAtIGZzbCxpcmRhLW1vZGUgOiBJbmRpY2F0ZSB0aGUgdWFydCBzdXBwb3J0
cyBpcmRhIG1vZGUNCiAtIGZzbCxkdGUtbW9kZSA6IEluZGljYXRlIHRoZSB1YXJ0IHdvcmtzIGlu
IERURSBtb2RlLiBUaGUgdWFydCB3b3Jrcw0KICAgICAgICAgICAgICAgICAgIGluIERDRSBtb2Rl
IGJ5IGRlZmF1bHQuDQotLSByczQ4NS1ydHMtZGVsYXksIHJzNDg1LXJ4LWR1cmluZy10eCwgbGlu
dXgscnM0ODUtZW5hYmxlZC1hdC1ib290LXRpbWU6IHNlZSByczQ4NS50eHQNCistIHJzNDg1LXJ0
cy1kZWxheSwgcnM0ODUtcnRzLWFjdGl2ZS1sb3csIHJzNDg1LXJ4LWR1cmluZy10eCwNCisgIGxp
bnV4LHJzNDg1LWVuYWJsZWQtYXQtYm9vdC10aW1lOiBzZWUgcnM0ODUudHh0DQogDQogUGxlYXNl
IGNoZWNrIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvc2VyaWFsLnR4
dA0KIGZvciB0aGUgY29tcGxldGUgbGlzdCBvZiBnZW5lcmljIHByb3BlcnRpZXMuDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9mc2wtbHB1YXJ0
LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvZnNsLWxwdWFy
dC50eHQNCmluZGV4IDU5NTY3YjUxY2YwOS4uNmJkM2YyZTkzZDYxIDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9mc2wtbHB1YXJ0LnR4dA0KKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9mc2wtbHB1YXJ0LnR4
dA0KQEAgLTE2LDcgKzE2LDggQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiBPcHRpb25hbCBwcm9w
ZXJ0aWVzOg0KIC0gZG1hczogQSBsaXN0IG9mIHR3byBkbWEgc3BlY2lmaWVycywgb25lIGZvciBl
YWNoIGVudHJ5IGluIGRtYS1uYW1lcy4NCiAtIGRtYS1uYW1lczogc2hvdWxkIGNvbnRhaW4gInR4
IiBhbmQgInJ4Ii4NCi0tIHJzNDg1LXJ0cy1kZWxheSwgcnM0ODUtcngtZHVyaW5nLXR4LCBsaW51
eCxyczQ4NS1lbmFibGVkLWF0LWJvb3QtdGltZTogc2VlIHJzNDg1LnR4dA0KKy0gcnM0ODUtcnRz
LWRlbGF5LCByczQ4NS1ydHMtYWN0aXZlLWxvdywgcnM0ODUtcngtZHVyaW5nLXR4LA0KKyAgbGlu
dXgscnM0ODUtZW5hYmxlZC1hdC1ib290LXRpbWU6IHNlZSByczQ4NS50eHQNCiANCiBOb3RlOiBP
cHRpb25hbCBwcm9wZXJ0aWVzIGZvciBETUEgc3VwcG9ydC4gV3JpdGUgdGhlbSBib3RoIG9yIGJv
dGggbm90Lg0KIA0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zZXJpYWwvb21hcF9zZXJpYWwudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NlcmlhbC9vbWFwX3NlcmlhbC50eHQNCmluZGV4IDQzZWFjNjc1ZjIxZi4uNGIwZjA1YWRi
MjI4IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nlcmlh
bC9vbWFwX3NlcmlhbC50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zZXJpYWwvb21hcF9zZXJpYWwudHh0DQpAQCAtMjAsNiArMjAsNyBAQCBPcHRpb25hbCBwcm9w
ZXJ0aWVzOg0KICAgICAgICAgIG5vZGUgYW5kIGEgRE1BIGNoYW5uZWwgbnVtYmVyLg0KIC0gZG1h
LW5hbWVzIDogInJ4IiBmb3IgcmVjZWl2ZSBjaGFubmVsLCAidHgiIGZvciB0cmFuc21pdCBjaGFu
bmVsLg0KIC0gcnM0ODUtcnRzLWRlbGF5LCByczQ4NS1yeC1kdXJpbmctdHgsIGxpbnV4LHJzNDg1
LWVuYWJsZWQtYXQtYm9vdC10aW1lOiBzZWUgcnM0ODUudHh0DQorLSByczQ4NS1ydHMtYWN0aXZl
LWhpZ2g6IGRyaXZlIFJUUyBoaWdoIHdoZW4gc2VuZGluZyAoZGVmYXVsdCBpcyBsb3cpLg0KIA0K
IEV4YW1wbGU6DQogDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NlcmlhbC9yczQ4NS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c2VyaWFsL3JzNDg1LnR4dA0KaW5kZXggYjg0MTU5MzZkZmRiLi5iN2MyOWY3NGViYjIgMTAwNjQ0
DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3JzNDg1LnR4
dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yczQ4NS50
eHQNCkBAIC0xMiw2ICsxMiw3IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQogICAqIGIgaXMgdGhl
IGRlbGF5IGJldHdlZW4gZW5kIG9mIGRhdGEgc2VudCBhbmQgcnRzIHNpZ25hbCBpbiBtaWxsaXNl
Y29uZHMNCiAgICAgICBpdCBjb3JyZXNwb25kcyB0byB0aGUgZGVsYXkgYWZ0ZXIgc2VuZGluZyBk
YXRhIGFuZCBhY3R1YWwgcmVsZWFzZSBvZiB0aGUgbGluZS4NCiAgIElmIHRoaXMgcHJvcGVydHkg
aXMgbm90IHNwZWNpZmllZCwgPDAgMD4gaXMgYXNzdW1lZC4NCistIHJzNDg1LXJ0cy1hY3RpdmUt
bG93OiBkcml2ZSBSVFMgbG93IHdoZW4gc2VuZGluZyAoZGVmYXVsdCBpcyBoaWdoKS4NCiAtIGxp
bnV4LHJzNDg1LWVuYWJsZWQtYXQtYm9vdC10aW1lOiBlbXB0eSBwcm9wZXJ0eSB0ZWxsaW5nIHRv
IGVuYWJsZSB0aGUgcnM0ODUNCiAgIGZlYXR1cmUgYXQgYm9vdCB0aW1lLiBJdCBjYW4gYmUgZGlz
YWJsZWQgbGF0ZXIgd2l0aCBwcm9wZXIgaW9jdGwuDQogLSByczQ4NS1yeC1kdXJpbmctdHg6IGVt
cHR5IHByb3BlcnR5IHRoYXQgZW5hYmxlcyB0aGUgcmVjZWl2aW5nIG9mIGRhdGEgZXZlbg0KLS0g
DQoyLjE0LjENCg==
