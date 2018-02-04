Return-Path: <prvs=566751c09=Stanislav.Nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x224NAJNaKCKfaqB9pBPOpl37U81qJyIE/88Dw3NMJRiHNszZpDpjn3SFZaxky9DSwHlFcwh8
ARC-Seal: i=1; a=rsa-sha256; t=1517735011; cv=none;
        d=google.com; s=arc-20160816;
        b=S3g8PPRUzN5gOJg6OV/mxdUB08Y2kOXqfKaNsUZnXP/uspF78dWy5H3GOz07vhTTRI
         mSyzRfSizM1NNtYgWx/htwrMaIUvk5cQSzToZA2j+s6vbygtdjfZ2nz9lmGW+bljnX1J
         xxYIFO7vm4f3vqKyTDDqOWPOUPD+W2XlOnSaQhguzI/d3m7JVaCCEtgtajfYUWwcSMxg
         LGofBmBo3NMjJdLEFIi7hXn1MaxjEqERGa981HJBpnrlHHeRuhV7aPvER30SovStZ0TO
         1Hi1JmiW0Zf59F3Kyq7DylxcS6GU9yvfAEKfyUAf75yZLSGgmqPg6vLwo4qLkjE448l6
         0/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:wdcipoutbound:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=R72KjH/itnnjnmoQdYX6HJBmXJB4qagf2rTx9s0MNw8=;
        b=T5kD08VKPSopKpbvD6y44hFq3EQXGo1F31y1/9nhgT5bdd4MhkI0OI0F7Tp3sp6ISA
         R68+Q6fktPFyNCoIpsJFP5hTSWPo/u3KjC/9K9LMhfGV3q0mKuQbIqCrBp0W1/w56zBa
         Ll6ZdcNCQOf7LH4uRWNf2LbAahuVHg9KdPrZ0sKQEU1hyihwQIrNy9rlDeo3HOilCEQZ
         nO4NyxW6HzrOZt8dHOpgsmVBNnZNxhpkN4TZBfoeLOsuTom/42rI0lRzd93X7vA+zfez
         Mi+6DAKNK5oJVrMg7ZaKCn67FKGGquUeM5v60MChwcrEDvvWqwcuIawWMZZZodVHWyrB
         FDQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=MwtGUvVc;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=UJRp5U8g;
       spf=pass (google.com: domain of prvs=566751c09=stanislav.nijnikov@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=566751c09=Stanislav.Nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=MwtGUvVc;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=UJRp5U8g;
       spf=pass (google.com: domain of prvs=566751c09=stanislav.nijnikov@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=566751c09=Stanislav.Nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,458,1511798400";
   d="scan'208";a="70637681"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: RE: [PATCH v4 02/10] ufs: sysfs: device descriptor
Thread-Topic: [PATCH v4 02/10] ufs: sysfs: device descriptor
Thread-Index: AQHTm3fxziri2a02vkOpvE8m6VQTJqOQQcwAgABzD4CAAJrnAIACpKJA
Date: Sun, 4 Feb 2018 09:03:25 +0000
Message-ID: <DM2PR0401MB0975F2D6C2E2CF3E0A3AB6209AFF0@DM2PR0401MB0975.namprd04.prod.outlook.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
	 <1517501746-19075-3-git-send-email-stanislav.nijnikov@wdc.com>
	 <1517531145.2746.26.camel@wdc.com> <20180202071735.GC9314@kroah.com>
 <1517589119.2675.19.camel@wdc.com>
In-Reply-To: <1517589119.2675.19.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0401MB1261;7:P0XU97+6b08NLXCQzbIp+i7rkZAOyuvSmRVhxKlstlcG6mao4t8Cp6f28DUf59dWTLEP4vTjtnlU/STbU0ANWvMpo4kYyAiUTSu6/Q5UWPVfz+zznqtIfCG0XJK25tXCIRIEnabBB804WQpw97gtE4Bxqn1Up0quFKwz3YD8NQXJpQxwL8K2sd7h7F0tDhigSip7wFa8JcwEG5V1NGypxQwXmRKvni8G4a1ebl8v0TcJdLN5eZjjwwOpqHAEAezB;20:1XaadOR3vonsrzXYOU/46fHxpoMrRyUkHnTaac2VdKY1dCLOpkq3FzE5fd61BUooHZKcRBu2wrQeHXSOg4MgnwfNMbp5lcl+mGuu69gQAhVTmyxhhk0mSSNDUUWMk+zW2cGehoSjDf3WmfXrHkN4rjLbGfplQTo7ddA6WnhzdL8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d95fca5-4421-4d43-e5ed-08d56bae2699
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM2PR0401MB1261;
x-ms-traffictypediagnostic: DM2PR0401MB1261:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM2PR0401MB1261F3DEFD33F1FA93001E8F9AFF0@DM2PR0401MB1261.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR0401MB1261;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0401MB1261;
x-forefront-prvs: 05739BA1B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(39860400002)(366004)(396003)(377424004)(199004)(189003)(13464003)(72206003)(6246003)(8676002)(59450400001)(105586002)(3660700001)(3280700002)(81166006)(81156014)(55016002)(76176011)(102836004)(54906003)(316002)(6436002)(26005)(110136005)(229853002)(4326008)(53936002)(68736007)(8936002)(9686003)(7696005)(53546011)(6506007)(99286004)(106356001)(7520500002)(6116002)(3846002)(2906002)(5660300001)(93886005)(86362001)(305945005)(2950100002)(5250100002)(2501003)(97736004)(14454004)(478600001)(74316002)(33656002)(7736002)(66066001)(25786009)(2900100001)(561944003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR0401MB1261;H:DM2PR0401MB0975.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ixpXHGojqk2cRtlxqGtfXKMPew33U7ruNwwwHXnh2BWb4pNiNu1lw2BhBislxzgu8gJNpM055MckrhnhNqEqSg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d95fca5-4421-4d43-e5ed-08d56bae2699
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2018 09:03:25.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0401MB1261
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215920431432185?=
X-GMAIL-MSGID: =?utf-8?q?1591460506750435390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUNCj4g
U2VudDogRnJpZGF5LCBGZWJydWFyeSAyLCAyMDE4IDY6MzIgUE0NCj4gVG86IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnDQo+IENjOiBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gamFlZ2V1a0BrZXJuZWwub3JnOyBBbGV4IExlbWJl
cmcgPEFsZXguTGVtYmVyZ0B3ZGMuY29tPjsgU3RhbmlzbGF2DQo+IE5pam5pa292IDxTdGFuaXNs
YXYuTmlqbmlrb3ZAd2RjLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMi8xMF0gdWZz
OiBzeXNmczogZGV2aWNlIGRlc2NyaXB0b3INCj4gDQo+IE9uIEZyaSwgMjAxOC0wMi0wMiBhdCAw
ODoxNyArMDEwMCwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+ID4gT24gRnJp
LCBGZWIgMDIsIDIwMTggYXQgMTI6MjU6NDZBTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdyb3Rl
Og0KPiA+ID4gT24gVGh1LCAyMDE4LTAyLTAxIGF0IDE4OjE1ICswMjAwLCBTdGFuaXNsYXYgTmlq
bmlrb3Ygd3JvdGU6DQo+ID4gPiA+ICtlbnVtIHVmc19kZXNjX3BhcmFtX3NpemUgew0KPiA+ID4g
PiArCVVGU19QQVJBTV9CWVRFX1NJWkUJPSAxLA0KPiA+ID4gPiArCVVGU19QQVJBTV9XT1JEX1NJ
WkUJPSAyLA0KPiA+ID4gPiArCVVGU19QQVJBTV9EV09SRF9TSVpFCT0gNCwNCj4gPiA+ID4gKwlV
RlNfUEFSQU1fUVdPUkRfU0laRQk9IDgsDQo+ID4gPiA+ICt9Ow0KPiA+ID4NCj4gPiA+IFBsZWFz
ZSBkbyBub3QgY29weSBiYWQgbmFtaW5nIGNob2ljZXMgZnJvbSB0aGUgV2luZG93cyBrZXJuZWwg
aW50bw0KPiA+ID4gdGhlIExpbnV4IGtlcm5lbC4gVXNpbmcgbmFtZXMgbGlrZSBXT1JEIC8gRFdP
UkQgLyBRV09SRCBpcyBtdWNoIGxlc3MNCj4gPiA+IHJlYWRhYmxlIHRoYW4gdXNpbmcgdGhlIG51
bWVyaWMgY29uc3RhbnRzIDIsIDQsIDguIEhlbmNlIG15IHByb3Bvc2FsDQo+ID4gPiB0byBsZWF2
ZSBvdXQgdGhlIGFib3ZlIGVudW0gY29tcGxldGVseS4NCj4gPg0KPiA+IEFyZSB5b3Ugc3VyZSB0
aG9zZSBkbyBub3QgY29tZSBmcm9tIHRoZSBzcGVjIGl0c2VsZj8gIEl0J3MgYmVlbiBhDQo+ID4g
d2hpbGUgc2luY2UgSSBsYXN0IHJlYWQgaXQsIGJ1dCBmb3Igc29tZSByZWFzb24gSSByZW1lbWJl
ciB0aG9zZSB0eXBlcw0KPiA+IG9mIG5hbWVzIGJlaW5nIGluIHRoZXJlLiAgQnV0IEkgbWlnaHQg
YmUgY29uZnVzaW5nIHNwZWNzIGhlcmUuDQo+IA0KPiBIZWxsbyBHcmVnLA0KPiANCj4gVGhhdCdz
IGEgZ29vZCBxdWVzdGlvbi4gSG93ZXZlciwgYSBxdWljayBzZWFyY2ggb24gdGhlIEludGVybmV0
IGZvciB0aGUNCj4gc2VhcmNoIHBocmFzZSAiVW5pdmVyc2FsIEZsYXNoIFN0b3JhZ2UiICJxd29y
ZCIgZGlkIG5vdCB5aWVsZCBhbnkgcmVzdWx0cw0KPiBhYm91dCBVRlMgaW4gdGhlIGZpcnN0IHRl
biBzZWFyY2ggaGl0cy4gQW5kIEkgaGF2ZW4ndCBmb3VuZCBhbnkgcmVmZXJlbmNlcyB0bw0KPiB0
aGUgRFdPUkQgLyBRV09SRCB0ZXJtaW5vbG9neSBpbiB0aGUgIlVOSVZFUlNBTCBGTEFTSCBTVE9S
QUdFIEhPU1QNCj4gQ09OVFJPTExFUiBJTlRFUkZBQ0UgKFVGU0hDSSksIFVOSUZJRUQgTUVNT1JZ
IEVYVEVOU0lPTiwgVmVyc2lvbg0KPiAxLjEiIGRvY3VtZW50IGVpdGhlci4gTWF5YmUgdGhhdCBt
ZWFucyB0aGF0IEkgd2FzIGxvb2tpbmcgYXQgdGhlIHdyb25nDQo+IGRvY3VtZW50Pw0KPiANCj4g
VGhhbmtzLA0KPiANCj4gQmFydC4NCj4gDQo+IA0KVGhlIFVGUyBzcGVjIDIuMSBzcGVjaWZpZXMg
c2l6ZSBhcyBmaXJzdCBsZXR0ZXIgaW4gbmFtZXMgb2YgdGhlIGRlc2NyaXB0b3IgcGFyYW1ldGVy
cyBhbmQgYXR0cmlidXRlcyAoZS5nLiBiRGV2aWNlQ2xhc3MsIHdTcGVjVmVyc2lvbiwgZFBTQU1h
eERhdGFTaXplLCBxVG90YWxSYXdEZXZpY2VDYXBhY2l0eSwgLi4uKS4gQnV0IHVzYWdlIG9mIHRo
ZSBlbnVtIGNvdWxkIGJlIGVhc2lseSByZW1vdmVkLg0KDQpSZWdhcmRzDQpTdGFuaXNsYXYNCg0K
