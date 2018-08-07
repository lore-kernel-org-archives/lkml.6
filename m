Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4FCC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78382172A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78382172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbeHGVlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:41:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:19438 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbeHGVlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:41:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 12:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="70958792"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2018 12:25:17 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 7 Aug 2018 12:25:17 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.40]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.7]) with mapi id 14.03.0319.002;
 Tue, 7 Aug 2018 12:25:16 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "hehy1@lenovo.com" <hehy1@lenovo.com>
Subject: Re: [PATCH] ACPI: nfit: adjust annotation for why return 0 if fail
 to find NFIT at startup
Thread-Topic: [PATCH] ACPI: nfit: adjust annotation for why return 0 if fail
 to find NFIT at startup
Thread-Index: AQHULhYrQYzwv9pYgkScCOy3MN+HiaS1IecA
Date:   Tue, 7 Aug 2018 19:25:15 +0000
Message-ID: <1533669914.18175.28.camel@intel.com>
References: <1533622531-3617-1-git-send-email-oceanhehy@gmail.com>
In-Reply-To: <1533622531-3617-1-git-send-email-oceanhehy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <387B8D4E660F724E90D074645DD74C78@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIDIwMTgtMDgtMDcgYXQgMDI6MTUgLTA0MDAsIE9jZWFuIEhlIHdyb3RlOg0KPiBG
cm9tOiBPY2VhbiBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCg0KSnVzdCBzb21lIG1pbm9yIG5pdHMg
aW4gY29tbWl0IG1lc3NhZ2Ugd29yZGluZzoNCg0KPiANCj4gQWRkIGRldGFpbCBleHBsYW5hdGlv
biB3aHkgaXQncyBvayB0byByZXR1cm4gMCBpZiBmYWlsIHRvIGZpbmQgTkZJVCBhdA0KICAgICAg
ZGV0YWlsZWQgICAgICAgICAgXmZvciAgICAgICAgICAgICAgICAgICAgICAgXndlICAgICAgICAg
IF5hbg0KPiBzdGFydHVwLCByZWZlciB0byBjaGFwdGVyIDkuMjAuMiBOVkRJTU0gUm9vdCBEZXZp
Y2UgaW4gQUNQSSA2LjIgc3BlYy4NCiAgICAgICAgIC4gUmVmZXINCg0KUGVyaGFwcyBEYXZlIGNh
biBmaXh1cCB3aGlsZSBhcHBseWluZy4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPY2VhbiBIZSA8
aGVoeTFAbGVub3ZvLmNvbT4NCj4gLS0tDQo+IHYxOiBodHRwczovL2xpc3RzLjAxLm9yZy9waXBl
cm1haWwvbGludXgtbnZkaW1tLzIwMTgtQXVndXN0LzAxNzMxMS5odG1sIA0KPiB2MjogUGVyIFZp
c2hhbCdzIGNvbW1lbnRzIG9mIHYxLCBpdCB0dXJucyBvdXQgdGhhdCBpdCdzIHJpZ2h0IHRvIGtl
ZXAgDQo+ICJyZXR1cm4gMCIgaWYgTkZJVCBub3QgZm91bmQgYXQgYm9vdCB0aW1lLiBUaGlzIHYy
IGFkanVzdCBhbm5vdGF0aW9uDQo+IHRvIGF2b2lkIG1pc3VuZGVyc3RhbmRpbmcgb2YgInJldHVy
biAwIi4NCg0KTG9va3MgZ29vZCwgdGhhbmtzIGZvciB0aGUgdXBkYXRlLiBGZWVsIGZyZWUgdG8g
YWRkOg0KUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29t
Pg0KDQo+IA0KPiAgZHJpdmVycy9hY3BpL25maXQvY29yZS5jIHwgOCArKysrKysrLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUu
Yw0KPiBpbmRleCA3YzQ3OTAwLi4xYjk4MmZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2FjcGkv
bmZpdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+IEBAIC0zMzUz
LDcgKzMzNTMsMTMgQEAgc3RhdGljIGludCBhY3BpX25maXRfYWRkKHN0cnVjdCBhY3BpX2Rldmlj
ZSAqYWRldikNCj4gIA0KPiAgCXN0YXR1cyA9IGFjcGlfZ2V0X3RhYmxlKEFDUElfU0lHX05GSVQs
IDAsICZ0YmwpOw0KPiAgCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgew0KPiAtCQkvKiBUaGlz
IGlzIG9rLCB3ZSBjb3VsZCBoYXZlIGFuIG52ZGltbSBob3RwbHVnZ2VkIGxhdGVyICovDQo+ICsJ
CS8qIFRoZSBOVkRJTU0gcm9vdCBkZXZpY2UgYWxsb3dzIE9TIHRvIHRyaWdnZXIgZW51bWVyYXRp
b24gb2YNCj4gKwkJICogTlZESU1NcyB0aHJvdWdoIE5GSVQgYXQgYm9vdCB0aW1lIGFuZCByZS1l
bnVtZXJhdGlvbiBhdA0KPiArCQkgKiByb290IGxldmVsIHZpYSB0aGUgX0ZJVCBtZXRob2QgZHVy
aW5nIHJ1bnRpbWUuDQo+ICsJCSAqIFRoaXMgaXMgb2sgdG8gcmV0dXJuIDAgaGVyZSwgd2UgY291
bGQgaGF2ZSBhbiBudmRpbW0NCj4gKwkJICogaG90cGx1Z2dlZCBsYXRlciBhbmQgZXZhbHVhdGUg
X0ZJVCBtZXRob2Qgd2hpY2ggcmV0dXJucw0KPiArCQkgKiBkYXRhIGluIHRoZSBmb3JtYXQgb2Yg
YSBzZXJpZXMgb2YgTkZJVCBTdHJ1Y3R1cmVzLg0KPiArCQkgKi8NCj4gIAkJZGV2X2RiZyhkZXYs
ICJmYWlsZWQgdG8gZmluZCBORklUIGF0IHN0YXJ0dXBcbiIpOw0KPiAgCQlyZXR1cm4gMDsNCj4g
IAl9DQo=
