Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3388C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7927A20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7927A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeLCSdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:33:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:60201 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeLCSdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:33:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 10:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="124688921"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 03 Dec 2018 10:33:41 -0800
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 3 Dec 2018 10:33:40 -0800
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.114]) by
 fmsmsx117.amr.corp.intel.com ([169.254.3.100]) with mapi id 14.03.0415.000;
 Mon, 3 Dec 2018 10:33:40 -0800
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH 1/2] tools/testing/nvdimm: Align test resources to 128M
Thread-Topic: [PATCH 1/2] tools/testing/nvdimm: Align test resources to 128M
Thread-Index: AQHUhCfStNsSgVgLSk+OsXHmGZhVPqVt6zYA
Date:   Mon, 3 Dec 2018 18:33:39 +0000
Message-ID: <f2969130eb0ba86b862787ebc8f7e8cc3dd5498a.camel@intel.com>
References: <154308521932.237140.13650270234597178173.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154308521932.237140.13650270234597178173.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.170]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D22631333429A147B78D62B09BB3A3A8@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBTYXQsIDIwMTgtMTEtMjQgYXQgMTA6NDYgLTA4MDAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gSW4gcHJlcGFyYXRpb24gZm9yIGxpYm52ZGltbSBncm93aW5nIG5ldyByZXN0cmljdGlvbnMg
dG8gZGV0ZWN0IHNlY3Rpb24NCj4gY29uZmxpY3RzIGJldHdlZW4gcGVyc2lzdGVudCBtZW1vcnkg
cmVnaW9ucywgZW5hYmxlIG5maXRfdGVzdCB0bw0KPiBhbGxvY2F0ZSBhbGlnbmVkIHJlc291cmNl
cy4gVXNlIGEgZ2VuX3Bvb2wgdG8gYWxsb2NhdGUgbmZpdF90ZXN0J3MgZmFrZQ0KPiByZXNvdXJj
ZXMgaW4gYSBzZXBhcmF0ZSBhZGRyZXNzIHNwYWNlIGZyb20gdGhlIHZpcnR1YWwgdHJhbnNsYXRp
b24gb2YNCj4gdGhlIHNhbWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRh
bi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQo+ICB0b29scy90ZXN0aW5nL252ZGltbS90
ZXN0L25maXQuYyB8ICAgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQoN
ClRoaXMgbG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbT4NCg0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9udmRp
bW0vdGVzdC9uZml0LmMgYi90b29scy90ZXN0aW5nL252ZGltbS90ZXN0L25maXQuYw0KPiBpbmRl
eCAwMWVjMDRiZjkxYjUuLmNhNGU2MWM4NjRkNSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGlu
Zy9udmRpbW0vdGVzdC9uZml0LmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9udmRpbW0vdGVzdC9u
Zml0LmMNCj4gQEAgLTE1LDYgKzE1LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGlu
Zy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L2xpYm52ZGltbS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2dlbmFsbG9jLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvdm1hbGxvYy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiBAQCAtMjE1LDYgKzIxNiw4IEBAIHN0cnVjdCBuZml0
X3Rlc3Qgew0KPiAgDQo+ICBzdGF0aWMgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKm5maXRfd3E7
DQo+ICANCj4gK3N0YXRpYyBzdHJ1Y3QgZ2VuX3Bvb2wgKm5maXRfcG9vbDsNCj4gKw0KPiAgc3Rh
dGljIHN0cnVjdCBuZml0X3Rlc3QgKnRvX25maXRfdGVzdChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ICB7DQo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2Rldmlj
ZShkZXYpOw0KPiBAQCAtMTEzMiw2ICsxMTM1LDkgQEAgc3RhdGljIHZvaWQgcmVsZWFzZV9uZml0
X3Jlcyh2b2lkICpkYXRhKQ0KPiAgCWxpc3RfZGVsKCZuZml0X3Jlcy0+bGlzdCk7DQo+ICAJc3Bp
bl91bmxvY2soJm5maXRfdGVzdF9sb2NrKTsNCj4gIA0KPiArCWlmIChyZXNvdXJjZV9zaXplKCZu
Zml0X3Jlcy0+cmVzKSA+PSBESU1NX1NJWkUpDQo+ICsJCWdlbl9wb29sX2ZyZWUobmZpdF9wb29s
LCBuZml0X3Jlcy0+cmVzLnN0YXJ0LA0KPiArCQkJCXJlc291cmNlX3NpemUoJm5maXRfcmVzLT5y
ZXMpKTsNCj4gIAl2ZnJlZShuZml0X3Jlcy0+YnVmKTsNCj4gIAlrZnJlZShuZml0X3Jlcyk7DQo+
ICB9DQo+IEBAIC0xMTQ0LDcgKzExNTAsNyBAQCBzdGF0aWMgdm9pZCAqX190ZXN0X2FsbG9jKHN0
cnVjdCBuZml0X3Rlc3QgKnQsIHNpemVfdCBzaXplLCBkbWFfYWRkcl90ICpkbWEsDQo+ICAJCQlH
RlBfS0VSTkVMKTsNCj4gIAlpbnQgcmM7DQo+ICANCj4gLQlpZiAoIWJ1ZiB8fCAhbmZpdF9yZXMp
DQo+ICsJaWYgKCFidWYgfHwgIW5maXRfcmVzIHx8ICEqZG1hKQ0KPiAgCQlnb3RvIGVycjsNCj4g
IAlyYyA9IGRldm1fYWRkX2FjdGlvbihkZXYsIHJlbGVhc2VfbmZpdF9yZXMsIG5maXRfcmVzKTsN
Cj4gIAlpZiAocmMpDQo+IEBAIC0xMTY0LDYgKzExNzAsOCBAQCBzdGF0aWMgdm9pZCAqX190ZXN0
X2FsbG9jKHN0cnVjdCBuZml0X3Rlc3QgKnQsIHNpemVfdCBzaXplLCBkbWFfYWRkcl90ICpkbWEs
DQo+ICANCj4gIAlyZXR1cm4gbmZpdF9yZXMtPmJ1ZjsNCj4gICBlcnI6DQo+ICsJaWYgKCpkbWEg
JiYgc2l6ZSA+PSBESU1NX1NJWkUpDQo+ICsJCWdlbl9wb29sX2ZyZWUobmZpdF9wb29sLCAqZG1h
LCBzaXplKTsNCj4gIAlpZiAoYnVmKQ0KPiAgCQl2ZnJlZShidWYpOw0KPiAgCWtmcmVlKG5maXRf
cmVzKTsNCj4gQEAgLTExNzIsOSArMTE4MCwxNiBAQCBzdGF0aWMgdm9pZCAqX190ZXN0X2FsbG9j
KHN0cnVjdCBuZml0X3Rlc3QgKnQsIHNpemVfdCBzaXplLCBkbWFfYWRkcl90ICpkbWEsDQo+ICAN
Cj4gIHN0YXRpYyB2b2lkICp0ZXN0X2FsbG9jKHN0cnVjdCBuZml0X3Rlc3QgKnQsIHNpemVfdCBz
aXplLCBkbWFfYWRkcl90ICpkbWEpDQo+ICB7DQo+ICsJc3RydWN0IGdlbnBvb2xfZGF0YV9hbGln
biBkYXRhID0gew0KPiArCQkuYWxpZ24gPSBTWl8xMjhNLA0KPiArCX07DQo+ICAJdm9pZCAqYnVm
ID0gdm1hbGxvYyhzaXplKTsNCj4gIA0KPiAtCSpkbWEgPSAodW5zaWduZWQgbG9uZykgYnVmOw0K
PiArCWlmIChzaXplID49IERJTU1fU0laRSkNCj4gKwkJKmRtYSA9IGdlbl9wb29sX2FsbG9jX2Fs
Z28obmZpdF9wb29sLCBzaXplLA0KPiArCQkJCWdlbl9wb29sX2ZpcnN0X2ZpdF9hbGlnbiwgJmRh
dGEpOw0KPiArCWVsc2UNCj4gKwkJKmRtYSA9ICh1bnNpZ25lZCBsb25nKSBidWY7DQo+ICAJcmV0
dXJuIF9fdGVzdF9hbGxvYyh0LCBzaXplLCBkbWEsIGJ1Zik7DQo+ICB9DQo+ICANCj4gQEAgLTI4
MzksNiArMjg1NCwxOCBAQCBzdGF0aWMgX19pbml0IGludCBuZml0X3Rlc3RfaW5pdCh2b2lkKQ0K
PiAgCQlnb3RvIGVycl9yZWdpc3RlcjsNCj4gIAl9DQo+ICANCj4gKwluZml0X3Bvb2wgPSBnZW5f
cG9vbF9jcmVhdGUoaWxvZzIoU1pfNE0pLCBOVU1BX05PX05PREUpOw0KPiArCWlmICghbmZpdF9w
b29sKSB7DQo+ICsJCXJjID0gLUVOT01FTTsNCj4gKwkJZ290byBlcnJfcmVnaXN0ZXI7DQo+ICsJ
fQ0KPiArDQo+ICsJaWYgKGdlbl9wb29sX2FkZChuZml0X3Bvb2wsIFZNQUxMT0NfU1RBUlQsDQo+
ICsJCQkJVk1BTExPQ19FTkQgKyAxIC0gVk1BTExPQ19TVEFSVCwgTlVNQV9OT19OT0RFKSkgew0K
PiArCQlyYyA9IC1FTk9NRU07DQo+ICsJCWdvdG8gZXJyX3JlZ2lzdGVyOw0KPiArCX0NCj4gKw0K
PiAgCWZvciAoaSA9IDA7IGkgPCBOVU1fTkZJVFM7IGkrKykgew0KPiAgCQlzdHJ1Y3QgbmZpdF90
ZXN0ICpuZml0X3Rlc3Q7DQo+ICAJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7DQo+IEBA
IC0yODk0LDYgKzI5MjEsOSBAQCBzdGF0aWMgX19pbml0IGludCBuZml0X3Rlc3RfaW5pdCh2b2lk
KQ0KPiAgCXJldHVybiAwOw0KPiAgDQo+ICAgZXJyX3JlZ2lzdGVyOg0KPiArCWlmIChuZml0X3Bv
b2wpDQo+ICsJCWdlbl9wb29sX2Rlc3Ryb3kobmZpdF9wb29sKTsNCj4gKw0KPiAgCWRlc3Ryb3lf
d29ya3F1ZXVlKG5maXRfd3EpOw0KPiAgCWZvciAoaSA9IDA7IGkgPCBOVU1fTkZJVFM7IGkrKykN
Cj4gIAkJaWYgKGluc3RhbmNlc1tpXSkNCj4gQEAgLTI5MTcsNiArMjk0Nyw4IEBAIHN0YXRpYyBf
X2V4aXQgdm9pZCBuZml0X3Rlc3RfZXhpdCh2b2lkKQ0KPiAgCXBsYXRmb3JtX2RyaXZlcl91bnJl
Z2lzdGVyKCZuZml0X3Rlc3RfZHJpdmVyKTsNCj4gIAluZml0X3Rlc3RfdGVhcmRvd24oKTsNCj4g
IA0KPiArCWdlbl9wb29sX2Rlc3Ryb3kobmZpdF9wb29sKTsNCj4gKw0KPiAgCWZvciAoaSA9IDA7
IGkgPCBOVU1fTkZJVFM7IGkrKykNCj4gIAkJcHV0X2RldmljZSgmaW5zdGFuY2VzW2ldLT5wZGV2
LmRldik7DQo+ICAJY2xhc3NfZGVzdHJveShuZml0X3Rlc3RfZGltbSk7DQo+IA0KDQo=
