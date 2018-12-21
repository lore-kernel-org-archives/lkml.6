Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C443D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390862AbeLUWnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:43:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:11325 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbeLUWnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:43:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 14:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,383,1539673200"; 
   d="scan'208";a="109243744"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga007.fm.intel.com with ESMTP; 21 Dec 2018 14:43:11 -0800
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 21 Dec 2018 14:43:10 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.147]) with mapi id 14.03.0415.000;
 Fri, 21 Dec 2018 14:43:10 -0800
From:   "Greensky, James J" <james.j.greensky@intel.com>
To:     Jinpu Wang <jinpuwang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Subject: RE: Fix "perf tools: Synthesize GROUP_DESC feature in pipe mode" in
 the LT 4.14 branch
Thread-Topic: Fix "perf tools: Synthesize GROUP_DESC feature in pipe mode"
 in the LT 4.14 branch
Thread-Index: AdSYqhOOjTeuqArwRNuweSLcVqXhpQAtQAGAAAfIgUA=
Date:   Fri, 21 Dec 2018 22:43:09 +0000
Message-ID: <05BD5679F4A9234798A0693ABF94E75ADFF7FA54@ORSMSX101.amr.corp.intel.com>
References: <05BD5679F4A9234798A0693ABF94E75ADFF7F3A5@ORSMSX101.amr.corp.intel.com>
 <CAD9gYJKvcn5kzMKhHU2UO=99Vdus_v=5D-fZb6-+Fy=gDokZFA@mail.gmail.com>
In-Reply-To: <CAD9gYJKvcn5kzMKhHU2UO=99Vdus_v=5D-fZb6-+Fy=gDokZFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTNiMTFkZjctNGUwMi00YjBlLWI0ZDEtOTVmMmFkZTA3ODMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTUE2NzJpUUk5VGtPN2c1cnRaREExeFwva0k0YVphTlZYRXBnYU5iRXZQcHFxR1JMTnVmTTZmSUpJNWdmOUlFYlUifQ==
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBjb21taXQgZG9lcyBub3QgYXBwbHkgY2xlYW5seSBkdWUgdG8gb3RoZXIgY2hhbmdlcy4g
SXMgdGhlcmUgc29tZXRoaW5nIEkgY2FuIGRvIHRvIG1ha2UgaXQgZWFzaWVyLg0KDQpUaGlzIGxp
bmU6DQoJSWYgKGRhdGEtPmlzX3BpcGUpICB7DQpNdXN0IGJlIGNoYW5nZWQgdG86DQoJSWYgKGZp
bGUtPmlzX3BpcGUpIHsNCg0KTGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYSBtb3JlIHN0YW5kYXJk
IHdheSBvZiBjb21tdW5pY2F0aW5nIGNoZXJyeS1waWNrZWQgY2hhbmdlcyBmb3IgaW5jbHVzaW9u
Lg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmlucHUgV2FuZyBbbWFpbHRv
OmppbnB1d2FuZ0BnbWFpbC5jb21dIA0KU2VudDogRnJpZGF5LCBEZWNlbWJlciAyMSwgMjAxOCAy
OjU4IEFNDQpUbzogR3JlZW5za3ksIEphbWVzIEogPGphbWVzLmouZ3JlZW5za3lAaW50ZWwuY29t
PjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCkNjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB2My4xNCssIG9ubHkgdGhlIHJhaWQxMCBwYXJ0
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IEZpeCAicGVyZiB0b29sczog
U3ludGhlc2l6ZSBHUk9VUF9ERVNDIGZlYXR1cmUgaW4gcGlwZSBtb2RlIiBpbiB0aGUgTFQgNC4x
NCBicmFuY2gNCg0KK2NjIEdyZWcsIHN0YWJsZQ0KDQpHcmVlbnNreSwgSmFtZXMgSiA8amFtZXMu
ai5ncmVlbnNreUBpbnRlbC5jb20+IOS6jjIwMTjlubQxMuaciDIx5pel5ZGo5LqUIOS4iuWNiDEx
OjQ45YaZ6YGT77yaDQo+DQo+IENvbW1pdCBkMzhkMjcyNTkyNzM3ZWE4OGEyMCAoInBlcmYgdG9v
bHM6IFN5bnRoZXNpemUgR1JPVVBfREVTQyBmZWF0dXJlIGluIHBpcGUgbW9kZSIpIGJyb2tlIHRo
ZSBMVCA0LjE0IGJyYW5jaCB3aGVuIHVzaW5nIGV2ZW50IGdyb3VwcyBpbiBwaXBlLW1vZGUuDQo+
DQo+ICAgIyBwZXJmIHJlY29yZCAtZSAne2N5Y2xlcyxpbnN0cnVjdGlvbnMsYnJhbmNoZXN9JyAt
LSBzbGVlcCA0IHwgcGVyZiByZXBvcnQNCj4gICAjIFRvIGRpc3BsYXkgdGhlIHBlcmYuZGF0YSBo
ZWFkZXIgaW5mbywgcGxlYXNlIHVzZSAtLWhlYWRlci8tLWhlYWRlci1vbmx5IG9wdGlvbnMNCj4g
ICAjDQo+ICAgT3hkN2MgWzB4NjBdOiBmYWlsZWQgdG8gcHJvY2VzcyB0eXBlOiA4MA0KPiAgIEVy
cm9yOg0KPiAgIEZhaWxlZCB0byBwcm9jZXNzIHNhbXBsZQ0KPg0KPiBDb21taXQgYTIwMTU1MTZj
NWMwYmU5MzJhNjkgKCJwZXJmIHJlY29yZDogU3ludGhlc2l6ZSBmZWF0dXJlcyBiZWZvcmUgZXZl
bnRzIGluIHBpcGUgbW9kZSIpIGlzIHRoZSBmaXguIENhbiB3ZSBnZXQgdGhpcyBjaGVycnktcGlj
a2VkIGFuZCBhcHBsaWVkPw0KPg0K
