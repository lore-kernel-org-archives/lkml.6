Return-Path: <Mario.Limonciello@dell.com>
X-Cyrus-Session-Id: sloti22d1t05-394842-1526483019-2-17528867518495185137
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_LOW -0.7, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='68.232.153.96', Host='esa7.dell-outbound.iphmx.com', Country='US',
  FromHeader='com', MailFrom='com', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Mario.Limonciello@dell.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526483018; b=R0GRnZwxIx/vyGOWbPsZbEacC3LpPk+ec6DedeNBXtjMRZmoZu
    N97gGkVyK7e+szBKLAfrAcxli1N79Wh7dj0avHBxBsLKuI6zq9EAOg+TXQlqiYeJ
    nW7gH9OSTeZBdD/AptOb3wgs9tTahBBmc7zsRAFUSZD8WH/BnZifTgcrbynB3VI+
    VgFleKGNN2iHO+1u39xhQNumZLYVYyH7mfRCOlW7AcZVfe7zokNKpbsgA7b7khWa
    JqVQG+rlR8+euXe1ga56Cyw3NWLQFLDx6jiFJUOPs3UYUg+WzZGaHOBMCA5Fnszx
    WJSjJ1zQrcNoxhXPYHVPbTD+bkTm8qZxtO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version; s=fm2; t=1526483018; bh=OxW2ps7fHW/PoZqnOse2Wuvf5
    k62wRqdMtJKFue6dj8=; b=eVWCf2W/H8OnhOl+Rnl8T2l2lJ4j8GsVoXOu6TMoK
    LOEP7XZe0+auDr9bgxlnyh2bYluIjOAchC9mQTEtZweuOpOqBHJgUjtvHfIb17Kl
    YQdIDRvy6B9jArxsXW8JFypwW44i0GFbRoXgeBBo+GBT1JEW6ZbwRlNyrOncUOq0
    SpI3v2+EplrRwmqFGA4UnTpu7YZ+16c7ftJ/u216VoagaWmaxgfweZxzY2N8o9sZ
    u+GXG45RMDbAyNzwio9JDdGOPZFEH3snlAG9Er+GEvBSR6UJAJzPmy7Mza9xiXpe
    MV7lrCBMJ5cPyiYi8yodMfI4Wq/ezxmmm9yYTazc5EaGA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com
    header.b=RferKztb x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=smtpout;
    dmarc=pass (p=none,d=none) header.from=dell.com;
    iprev=pass policy.iprev=68.232.153.96 (esa7.dell-outbound.iphmx.com);
    spf=pass smtp.mailfrom=Mario.Limonciello@dell.com
    smtp.helo=esa7.dell-outbound.iphmx.com;
    x-aligned-from=pass (Address match);
    x-cm=promotion score=0;
    x-ptr=pass x-ptr-helo=esa7.dell-outbound.iphmx.com
    x-ptr-lookup=esa7.dell-outbound.iphmx.com;
    x-return-mx=pass smtp.domain=dell.com smtp.result=pass
    smtp_is_org_domain=yes header.domain=dell.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com
      header.b=RferKztb x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=smtpout;
    dmarc=pass (p=none,d=none) header.from=dell.com;
    iprev=pass policy.iprev=68.232.153.96 (esa7.dell-outbound.iphmx.com);
    spf=pass smtp.mailfrom=Mario.Limonciello@dell.com
      smtp.helo=esa7.dell-outbound.iphmx.com;
    x-aligned-from=pass (Address match);
    x-cm=promotion score=0;
    x-ptr=pass x-ptr-helo=esa7.dell-outbound.iphmx.com
      x-ptr-lookup=esa7.dell-outbound.iphmx.com;
    x-return-mx=pass smtp.domain=dell.com smtp.result=pass
      smtp_is_org_domain=yes header.domain=dell.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKUsU3RLnnHr0dsdsYSkWE6M69UUanI6+MK3w/GsR9ZyJ3mhEMgxjf19FhMqGf/9+h7KBSkr+v1m8R064fp2YZwaQbPnOCq9533Ghic0JhMAfL4+CCWn
    EjDriOsrwmO2LY7Vf67EaBSo71eyNAEI4DSC2X7cFD3jv2pYF84kWsZLWDW/unVY8sczW6Bdw5gcvMd5Gbt0pvyJ0wtcEX76ovI=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 b=1 a=KnMD5mEbq5MDPFkSCEFksA==:117
    a=KnMD5mEbq5MDPFkSCEFksA==:17 a=wCHvqnb4SGkA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=iLNU1ar6AAAA:8 a=LdSbmKOsAAAA:8
    a=pqI2O50Xkh0B6iEWwBMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=HErAIEcT1t9lkSvq_S40:22 cc=prm
X-ME-CMScore: 0
X-ME-CMCategory: promotion
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F6AABrWvZah8qZ6ERbGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQWDnsoCoNoiASMcIF5gQ9gklUUgSk7CyUJgQKDPAIagnAhNBg?=
 =?us-ascii?q?BAgEBAQEBAQIBAQIQAQEBCgsJCCgjDII1Ig0ESykDLwEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARUCDSYjAhgBAQEDASMRRQUHBAIBCBEEAQEBAgIjAwICAkQBCAgCBAE?=
 =?us-ascii?q?NBQiDGwKBdwgPqzyCHIhXgieBCYccghOBD4MLgUGBUAEBAhiBBQkcCCuCaYJUA?=
 =?us-ascii?q?ocXGSyFWYp9BwKFZ26HdIE+g2SHUSuCAINIgVWCCoQSAYJ4gSUcggtwgxMJghc?=
 =?us-ascii?q?OCYNFhRSFPm+ON4EtgRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2F6AABrWvZah8qZ6ERbGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?WDnsoCoNoiASMcIF5gQ9gklUUgSk7CyUJgQKDPAIagnAhNBgBAgEBAQEBAQIBA?=
 =?us-ascii?q?QIQAQEBCgsJCCgjDII1Ig0ESykDLwEBAQEBAQEBAQEBAQEBAQEBAQEBARUCDSY?=
 =?us-ascii?q?jAhgBAQEDASMRRQUHBAIBCBEEAQEBAgIjAwICAkQBCAgCBAENBQiDGwKBdwgPq?=
 =?us-ascii?q?zyCHIhXgieBCYccghOBD4MLgUGBUAEBAhiBBQkcCCuCaYJUAocXGSyFWYp9BwK?=
 =?us-ascii?q?FZ26HdIE+g2SHUSuCAINIgVWCCoQSAYJ4gSUcggtwgxMJghcOCYNFhRSFPm+ON?=
 =?us-ascii?q?4EtgRgBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.189
X-IronPort-AV: E=Sophos;i="5.49,390,1520917200";
   d="scan'208";a="1153340490"
X-DLP: DLP_GlobalPCIDSS
To: <pmenzel+linux-usb@molgen.mpg.de>, <heikki.krogerus@linux.intel.com>
CC: <greg@kroah.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Thread-Topic: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Thread-Index: AQHT7FnacruSscNvFUKixxVl6UQN9aQxRuSAgAANFYCAAP+ZAIAAQeIAgAAKfwD//9M78A==
Date: Wed, 16 May 2018 15:03:29 +0000
Message-ID: <942026fe8caf4b46b8114b497b5f9f15@ausx13mpc120.AMER.DELL.COM>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com> <20180516115814.GB11469@kuha.fi.intel.com>
 <73e6e77b-36e0-017a-18fb-36e45b0a17a1@molgen.mpg.de>
In-Reply-To: <73e6e77b-36e0-017a-18fb-36e45b0a17a1@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgW21h
aWx0bzpwbWVuemVsK2xpbnV4LXVzYkBtb2xnZW4ubXBnLmRlXQ0KPiBTZW50OiBXZWRuZXNkYXks
IE1heSAxNiwgMjAxOCA3OjM2IEFNDQo+IFRvOiBIZWlra2kgS3JvZ2VydXMNCj4gQ2M6IEdyZWcg
S0g7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IExpbW9uY2llbGxvLA0KPiBNYXJpbw0KPiBTdWJqZWN0OiBSZTogYHVjc2lfYWNwaTogcHJv
YmUgb2YgVVNCQzAwMDowMCBmYWlsZWQgd2l0aCBlcnJvciAtMTJgIG9uIERlbGwgWFBTIDEzDQo+
IDkzNzANCj4gDQo+IERlYXIgSGVpa2tpLA0KPiANCj4gDQo+IE9uIDA1LzE2LzE4IDEzOjU4LCBI
ZWlra2kgS3JvZ2VydXMgd3JvdGU6DQo+IA0KPiA+IE9uIFdlZCwgTWF5IDE2LCAyMDE4IGF0IDEw
OjAyOjI2QU0gKzAyMDAsIEdyZWcgS0ggd3JvdGU6DQo+ID4+IE9uIFR1ZSwgTWF5IDE1LCAyMDE4
IGF0IDA2OjQ3OjM3UE0gKzAyMDAsIFBhdWwgTWVuemVsIHdyb3RlOg0KPiANCj4gPj4+IE9uIDA1
LzE1LzE4IDE4OjAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+Pj4+IE9uIFR1ZSwgTWF5IDE1LCAyMDE4
IGF0IDA0OjM0OjAzUE0gKzAyMDAsIFBhdWwgTWVuemVsIHdyb3RlOg0KPiA+Pj4NCj4gPj4+Pj4g
TGludXggNC4xNy1yYzUgc2hvd3MgdGhlIGVycm9yIGJlbG93IG9uIHRoZSBEZWxsIFhQUyAxMyA5
MzcwIHdpdGggRGViaWFuDQo+ID4+Pj4+IFNpZC91bnN0YWJsZS4NCj4gPj4+Pj4NCj4gPj4+Pj4g
YGBgDQo+ID4+Pj4+IFs/Pz9dDQo+ID4+Pj4+IFsgICAgMC40NDAyNDBdIHVzYjogcG9ydCBwb3dl
ciBtYW5hZ2VtZW50IG1heSBiZSB1bnJlbGlhYmxlDQo+ID4+Pj4+IFsgICAgMC40NDEzNThdIHVz
YmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiLXN0b3JhZ2UNCj4gPj4+
Pj4gWyAgICAwLjQ0MTM2N10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZl
ciB1c2JzZXJpYWxfZ2VuZXJpYw0KPiA+Pj4+PiBbICAgIDAuNDQxMzY5XSB1c2JzZXJpYWw6IFVT
QiBTZXJpYWwgc3VwcG9ydCByZWdpc3RlcmVkIGZvciBnZW5lcmljDQo+ID4+Pj4+IFsgICAgMC40
NDEzODNdIGlvcmVtYXAgZXJyb3IgZm9yIDB4M2Y3OTkwMDAtMHgzZjc5YTAwMCwgcmVxdWVzdGVk
IDB4MiwgZ290DQo+ID4+Pj4+IDB4MA0KPiA+Pj4+PiBbICAgIDAuNDQxNTE4XSB1Y3NpX2FjcGk6
IHByb2JlIG9mIFVTQkMwMDA6MDAgZmFpbGVkIHdpdGggZXJyb3IgLTEyDQo+ID4+Pj4+IFs/Pz9d
DQo+ID4+Pj4+IGBgYA0KPiA+Pj4+Pg0KPiA+Pj4+PiAxLiAgQXJlIHRoZSBpb3JlbWFwIGFuZCB1
Y3NpX2FjcGkgZXJyb3IgcmVsYXRlZCBvciBpcyBhIHNlcGFyYXRlIHJlcG9ydA0KPiA+Pj4+PiBu
ZWVkZWQ/DQo+ID4+Pj4NCj4gPj4+PiBUaGUgaW9yZW1hcCBlcnJvciBpcyB3aGF0IGNhdXNlcyB1
Y3NpX2FjcGkgdG8gZmFpbCB0aGUgcHJvYmUgY2FsbCAoLTEyDQo+ID4+Pj4gaXMgIm91dCBvZiBt
ZW1vcnkiLikNCj4gPj4+Pg0KPiA+Pj4+PiAyLiAgRG8geW91IGtub3cgdGhlIHJlYXNvbiBmb3Ig
dGhlIHVjc2lfYWNwaSBlcnJvcj8NCj4gPj4+Pg0KPiA+Pj4+IHRoZSBjYWxsIHRvIGlvcmVtYXAg
ZmFpbGVkLg0KPiA+Pj4+DQo+ID4+Pj4gRG9lcyB0aGlzIGRldmljZSByZWFsbHkgaGF2ZSBhIHdv
cmtpbmcgdHlwZWMgY29ubmVjdG9yPw0KPiA+Pj4NCj4gPj4+IEp1c3QgdG8gYXZvaWQgbWlzdW5k
ZXJzdGFuZGluZ3MsIG5vIGRldmljZSB3YXMgY29ubmVjdGVkIHRvIHRoZSBsYXB0b3ANCj4gPj4+
IGR1cmluZyBteSB0ZXN0Lg0KPiA+Pj4NCj4gPj4+IEJ1dCwgZnJvbSBvdGhlciBib290cywgdGhl
IERlbGwgZG9ja2luZyBzdGF0aW9uIFRCMTYga2luZCBvZiB3b3JrcyB3aXRoIGl0LA0KPiA+Pj4g
c28gST8/P2Qgc2F5IHRoZSBVU0IgVHlwZS1DIGNvbm5lY3RvciBpcyB3b3JraW5nLg0KPiA+Pg0K
PiA+PiBPaywgZ29vZCwgdGhpcyBtaWdodCBqdXN0IGJlIHRoZSBhY3BpIHRhYmxlcyBub3Qgc2V0
IHVwIHByb3Blcmx5IGZvcg0KPiA+PiB0aGlzIHR5cGUgb2YgY29ubmVjdGlvbi4gIE9kZCB0aGF0
IHRoZSB0YWJsZXMgc2hvdyBpdCBzaG91bGQgd29yaywNCj4gPj4gSGVpa2tpIHNob3VsZCBrbm93
IG1vcmUgYWJvdXQgdGhpcy4NCj4gPg0KPiA+IFRoZSBmaXJtd2FyZSBwcm9iYWJsZSBoYXMgbm90
IGltcGxlbWVudGVkIFVDU0kgb24gdGhpcyBib2FyZC4gSSB0aGluaw0KPiA+IERlbGwgYWx3YXlz
IHN1cHBsaWVzIHRoZSBBQ1BJIGRldmljZSBub2RlIGZvciBVQ1NJIGluIHRoZWlyIGFjcGkNCj4g
PiB0YWJsZXMuIFRoZSBfU1RBIG1ldGhvZCBpbiB0aGF0IGRldmljZSBub2RlIGlzIHRoZW4gdXNl
ZCB0byBpbmZvcm0gdGhlDQo+ID4gT1MgaWYgdGhlIGludGVyZmFjZSBleGlzdHMgb3Igbm90LiBU
aGUgcmV0dXJuIHZhbHVlIGZvciBfU1RBIGNvbWVzDQo+ID4gcHJvYmFibGUgZnJvbSBCSU9TLCBz
byB0aGlzIGlzIG1vc3QgbGlrZWx5IGEgQklPUyBwcm9ibGVtLg0KPiA+DQo+ID4gUGxlYXNlIG5v
dGUgdGhhdCBVQ1NJIHdpbGwgb25seSBzdXBwbHkgc3RhdHVzIGluZm9ybWF0aW9uIHRvIHRoZQ0K
PiA+IG9wZXJhdGluZyBzeXN0ZW0sIHNvIHRoZSBVU0IgVHlwZS1DIHBvcnRzIHdpbGwgZnVuY3Rp
b24gbm9ybWFsbHkgZXZlbg0KPiA+IHdpdGhvdXQgaXQuIFRoZSBwb3J0cyBhcmUgaGFuZGxlZCBp
biBmaXJtd2FyZSBvbiB0aGVzZSBwbGF0Zm9ybXMuDQo+ID4NCj4gPiBQYXVsLCBkbyB5b3UgaGF2
ZSB0aGUgbGF0ZXN0IEJJT1M/DQo+IA0KPiBJIGhhZCB0aGUgbGF0ZXN0IGZpcm13YXJlDQo+IA0K
PiAgPiBETUk6IERlbGwgSW5jLiBYUFMgMTMgOTM3MC8wRjZQM1YsIEJJT1MgMS4yLjEgMDIvMjEv
MjAxOA0KPiANCj4gdW50aWwgdG9kYXksIHdoZW4gMS4zLjIgd2l0aCB0aGUgY2hhbmdlcyBiZWxv
dyB3YXMgcmVsZWFzZWQgWzFdLg0KPiANCj4gTWFyaW8sIGl04oCZZCBiZSBncmVhdCwgaWYgdGhl
IERlbGwgZmlybXdhcmUgdGVhbSBjb3VsZCBzdGFydCB0ZXN0aW5nIHdpdGgNCj4gTGludXggcmVs
ZWFzZXMgdG9vIHRvIGZpbmQgc3VjaCBpc3N1ZXMuIA0KDQpQYXVsLA0KDQpUaGUgdGVhbSB0aGF0
IHN1c3RhaW5zIHBsYXRmb3JtcyBkb2VzIHBlcmZvcm0gTGludXggdGVzdGluZywgYnV0IGl0J3Mg
bm90IA0KY2VudGVyZWQgYXJvdW5kIGxhdGVzdCB1cHN0cmVhbSBrZXJuZWwgYW5kIGl0J3MgYWxz
byBmdW5jdGlvbmFsbHkgYmFzZWQgKG5vdA0KcmV2aWV3aW5nIGRtZXNnIGZvciBuZXcga2VybmVs
IGVycm9ycykgc28gdGhlcmUgYXJlIGNoYW5nZXMgaW4gDQpleHBlY3RhdGlvbnMgKHZpZXdlZCBh
cyByZWdyZXNzaW9ucykgYXMgeW91IGZpbmQgZnJvbSB0aW1lIHRvIHRpbWUuDQoNCj4gTWFyaW8s
IGNvdWxkIHlvdSBwbGVhc2UgYWxzbw0KPiBjaGVjayBpbnRlcm5hbGx5IGlmIHRoZSBEZWxsIGZp
cm13YXJlIHRlYW0gaXMgYXdhcmUgb2YgdGhlIGlzc3VlcyBhbmQNCj4gY2FuIGluY29ycG9yYXRl
IGEgZml4LiANCg0KU3VyZSBJJ2xsIGlucXVpcmUgaW50ZXJuYWxseS4NCg0KPiA+IEZpeGVzICYg
RW5oYW5jZW1lbnRzDQo+ID4gRml4ZXM6DQo+ID4gLSBCYXR0ZXJ5IGNhbid0IGNoYXJnZSBvdmVy
IDU1JQ0KPiA+IC0gSW5jb3JyZWN0IEN0cmwrQWx0K0RlbCBsb2cgb24gbWVzc2FnZSB3aXRoIEhJ
RCBFdmVudCBmaWx0ZXIgZHJpdmVyDQo+ID4gLSBQbGF0Zm9ybSBjYW4ndCBib290IHRvIHRoZSBQ
WEUgYm9vdCBlbnZpcm9ubWVudCBpbiBMZWdhY3kgbW9kZSB2aWEgREEzMDANCj4gPiAtIENvcnJl
Y3QgdGhlIGZsYXNoIHV0aWxpdHkgc3RyaW5nIHR5cG8NCj4gPiAtIFBDSUUgQ2FyZCBlcnJvciBz
aG93cyBpbiBTdXBwb3J0IEFzc2lzdCBUb29sDQo+ID4gLSBGYWlsICdQQ1IxIGNoYW5nZWQnIG1z
ZyBwcm9tcHQgaW4gQ01EIGR1cmluZyBydW5uaW5nIFRQTSBQQ1IgY3ljbGVzIGluIE9TDQo+ID4g
LSBUaGUgUENJLXRvLVBDSSBCcmlkZ2Ugd2lsbCBsb3N0IHdoaWxlIGNvbm5lY3RpbmcgdG8gRGVs
bCBUaHVuZGVyYm9sdCBEb2NrIFRCMTgNCj4gPiAtIEFkanVzdCBmYW4gc3BlZWQNCj4gPiAtIFNr
aXBzIGtleXMgd2hlbiB0eXBpbmcgZmFzdA0KPiA+DQo+ID4gRW5oYW5jZW1lbnRzOg0KPiA+IC0g
Tm9uZQ0KPiANCj4gSXTigJlsbCB0YWtlIG1lIHVwIHRvIHNvbWUgZGF5cyB0byBnZXQgbXkgaGFu
ZHMgb24gdGhlIGRldmljZSBhZ2Fpbi4gQnV0DQo+IHRoZSB1cGRhdGUgc2hvdWxkIGJlIGVhc3kg
ZW5vdWdoIHRoYW5rcyB0byBEZWxsIHN1cHBvcnRpbmcgZnd1cGQgd2l0aA0KPiBVRUZJIENhcHN1
bGUgYW5kIHVwbG9hZGluZyB0aGVpciB1cGRhdGVzIHRvIHRoZSBMaW51eCBWZW5kb3IgRmlybXdh
cmUNCj4gU2VydmljZSBbMl0uDQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0K
PiANCj4gDQo+IFsxXQ0KPiBodHRwOi8vd3d3LmRlbGwuY29tL3N1cHBvcnQvaG9tZS91cy9lbi8w
NC9kcml2ZXJzL2RyaXZlcnNkZXRhaWxzP2RyaXZlcklkPVZGMjNQDQo+IFsyXSBodHRwczovL2Z3
dXBkLm9yZy8NCg0K
