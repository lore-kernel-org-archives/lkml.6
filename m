Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F6C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A465223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A465223E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeHKCRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 22:17:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:21517 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbeHKCRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 22:17:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 16:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,221,1531810800"; 
   d="scan'208";a="71895152"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2018 16:45:37 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 10 Aug 2018 16:45:37 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.40]) by
 fmsmsx118.amr.corp.intel.com ([169.254.1.229]) with mapi id 14.03.0319.002;
 Fri, 10 Aug 2018 16:45:36 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "hehy1@lenovo.com" <hehy1@lenovo.com>
Subject: Re: [PATCH v2] ACPI: nfit: remove redundant assignment if nfit_mem
 found
Thread-Topic: [PATCH v2] ACPI: nfit: remove redundant assignment if nfit_mem
 found
Thread-Index: AQHUKj0MXtI1OwvIIUypjIK37MuHIqS6KVQA
Date:   Fri, 10 Aug 2018 23:45:35 +0000
Message-ID: <1533944734.6054.38.camel@intel.com>
References: <1533199444-29607-1-git-send-email-oceanhehy@gmail.com>
In-Reply-To: <1533199444-29607-1-git-send-email-oceanhehy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCC5CA9523A00740AB44287C469ACDF3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMTgtMDgtMDIgYXQgMDQ6NDQgLTA0MDAsIG9jZWFuaGVoeUBnbWFpbC5jb20g
d3JvdGU6DQo+IEZyb206IE9jZWFuIEhlIDxoZWh5MUBsZW5vdm8uY29tPg0KPiANCj4gV2hlbiBu
Zml0X21lbSBpcyBmb3VuZCB2aWEgbGlzdF9mb3JfZWFjaF9lbnRyeSwgaXQgaGFzIGFscmVhZHkg
YmVlbg0KPiBhc3NpZ25lZCB2YWxpZCB2YWx1ZS4gVGhlcmUgaXMgbm8gbmVlZCB0byBhc3NpZ24g
aXQgYWdhaW4gaW4gdGhlDQo+IGZvbGxvd2luZw0KPiBjb2Rlcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE9jZWFuIEhlIDxoZWh5MUBsZW5vdm8uY29tPg0KPiAtLS0NCj4gdjE6IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA1NTMyNzcvDQo+IHYyOiBTb3JyeSBmb3Igbm9pc2Uu
IEkgZ290IGFuIGVtYWlsIHByb2JsZW0sIHNvIEkgaGF2ZSB0byByZXNlbmQgdG8NCj4gbG9vcCAN
Cj4gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZy4NCj4gDQo+ICBkcml2ZXJzL2FjcGkvbmZpdC9j
b3JlLmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMgYi9k
cml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gaW5kZXggN2M0NzkwMC4uODVkZGU1NCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9u
Zml0L2NvcmUuYw0KPiBAQCAtMTA0OCw5ICsxMDQ4LDcgQEAgc3RhdGljIGludCBfX25maXRfbWVt
X2luaXQoc3RydWN0DQo+IGFjcGlfbmZpdF9kZXNjICphY3BpX2Rlc2MsDQo+ICAJCQkJYnJlYWs7
DQo+ICAJCQl9DQo+ICANCj4gLQkJaWYgKGZvdW5kKQ0KPiAtCQkJbmZpdF9tZW0gPSBmb3VuZDsN
Cj4gLQkJZWxzZSB7DQo+ICsJCWlmICghZm91bmQpIHsNCg0KSGkgT2NlYW4sDQoNCldoaWxlIHRo
aXMgaXMgdGVjaG5pY2FsbHkgY29ycmVjdCwgdGhlIG9sZCB3YXkgd2FzIGVhc2llciB0byByZWFk
LiBXZQ0KbG9vcCB0aHJvdWdoIGFuZCBmaW5kIHRoZSBtYXRjaGluZyBoYW5kbGUuIElmIHdlIGZv
dW5kIG9uZSwgdGhlbg0KbmZpdF9tZW0gd2FzIHdoYXRldmVyIHdhcyBmb3VuZC4gSWYgbm90LCB3
ZSBhbGxvY2F0ZSBpdC4NCg0KV2l0aCB0aGlzIGNoYW5nZSwgb25lIGhhcyB0byBnbyBncm9rIHRo
ZSBsaXN0X2Zvcl8uLiBsb29wIHRvIGZpZ3VyZSBvdXQNCndoZXJlIG5maXRfbWVtIGlzIGNvbWlu
ZyBmcm9tLiBJJ2QgcGVyc29uYWxseSBwcmVmZXIgdG8ga2VlcCB0aGUNCmV4aXN0aW5nIHdheS4u
DQoNCj4gIAkJCW5maXRfbWVtID0gZGV2bV9remFsbG9jKGFjcGlfZGVzYy0+ZGV2LA0KPiAgCQkJ
CQlzaXplb2YoKm5maXRfbWVtKSwNCj4gR0ZQX0tFUk5FTCk7DQo+ICAJCQlpZiAoIW5maXRfbWVt
KQ0K
