Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA254C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A762084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfBUNrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:47:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:7777 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBUNrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:47:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 05:47:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="128209848"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2019 05:47:31 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 21 Feb 2019 05:47:30 -0800
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 21 Feb 2019 05:47:30 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.57]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.180]) with mapi id 14.03.0415.000;
 Thu, 21 Feb 2019 07:47:28 -0600
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH] IB/hfi1: Add missing break in switch statement
Thread-Topic: [PATCH] IB/hfi1: Add missing break in switch statement
Thread-Index: AQHUyYGSdGkcJixM00O7Of2i+gKbRaXqQmuw
Date:   Thu, 21 Feb 2019 13:47:28 +0000
Message-ID: <3F128C9216C9B84BB6ED23EF16290AFB750DB973@CRSMSX101.amr.corp.intel.com>
References: <20190221010233.GA29228@embeddedor>
In-Reply-To: <20190221010233.GA29228@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWNmNGQyMzMtMDE5Ni00OTdjLWEwY2MtMzA5ODVkNWI1ZjBhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaU1jN0V3ejV0dUFcL0NcL1I2bmkxajdpa0RmTFFDYTZnVllPSWdpR2E2WmxpYmNxUFZKWUNPdDlGMGE1VEpaVTZ1In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VzdGF2byBBLiBSLiBT
aWx2YSBbbWFpbHRvOmd1c3Rhdm9AZW1iZWRkZWRvci5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwg
RmVicnVhcnkgMjAsIDIwMTkgODowMyBQTQ0KPiBUbzogV2FuLCBLYWlrZSA8a2Fpa2Uud2FuQGlu
dGVsLmNvbT47IE1hcmNpbmlzenluLCBNaWtlDQo+IDxtaWtlLm1hcmNpbmlzenluQGludGVsLmNv
bT47IERhbGVzc2FuZHJvLCBEZW5uaXMNCj4gPGRlbm5pcy5kYWxlc3NhbmRyb0BpbnRlbC5jb20+
OyBEb3VnIExlZGZvcmQgPGRsZWRmb3JkQHJlZGhhdC5jb20+Ow0KPiBKYXNvbiBHdW50aG9ycGUg
PGpnZ0B6aWVwZS5jYT4NCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHdXN0YXZvIEEuIFIuDQo+IFNpbHZhIDxndXN0YXZvQGVt
YmVkZGVkb3IuY29tPjsgS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gSUIvaGZpMTogQWRkIG1pc3NpbmcgYnJlYWsgaW4gc3dpdGNoIHN0YXRlbWVu
dA0KPiANCj4gRml4IHRoZSBmb2xsb3dpbmcgd2FybmluZyBieSBhZGRpbmcgYSBtaXNzaW5nIGJy
ZWFrOg0KPiANCj4gZHJpdmVycy9pbmZpbmliYW5kL2h3L2hmaTEvdGlkX3JkbWEuYzogSW4gZnVu
Y3Rpb24NCj4g4oCYaGZpMV90aWRfcmRtYV93cWVfaW50ZXJsb2Nr4oCZOg0KPiBkcml2ZXJzL2lu
ZmluaWJhbmQvaHcvaGZpMS90aWRfcmRtYS5jOjMyNTE6Mzogd2FybmluZzogdGhpcyBzdGF0ZW1l
bnQgbWF5DQo+IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+ICAgIHN3
aXRjaCAocHJldi0+d3Iub3Bjb2RlKSB7DQo+ICAgIF5+fn5+fg0KPiBkcml2ZXJzL2luZmluaWJh
bmQvaHcvaGZpMS90aWRfcmRtYS5jOjMyNTk6Mjogbm90ZTogaGVyZQ0KPiAgIGNhc2UgSUJfV1Jf
UkRNQV9SRUFEOg0KPiAgIF5+fn4NCj4gDQo+IFdhcm5pbmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdp
bXBsaWNpdC1mYWxsdGhyb3VnaD0zDQo+IA0KPiBUaGlzIHBhdGNoIGlzIHBhcnQgb2YgdGhlIG9u
Z29pbmcgZWZmb3J0cyB0byBlbmFibGUgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4NCj4gDQo+IEZp
eGVzOiBjNmMyMzExNzVjY2QgKCJJQi9oZmkxOiBBZGQgaW50ZXJsb2NrIGJldHdlZW4gVElEIFJE
TUEgV1JJVEUgYW5kDQo+IG90aGVyIHJlcXVlc3RzIikNCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2
byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2luZmluaWJhbmQvaHcvaGZpMS90aWRfcmRtYS5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcv
aGZpMS90aWRfcmRtYS5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2hmaTEvdGlkX3JkbWEu
Yw0KPiBpbmRleCBiYzJmZjgzMDI2ZjcuLmZkZGEzM2FjYTc3ZiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9pbmZpbmliYW5kL2h3L2hmaTEvdGlkX3JkbWEuYw0KPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvaHcvaGZpMS90aWRfcmRtYS5jDQo+IEBAIC0zMjU2LDYgKzMyNTYsNyBAQCBib29sIGhm
aTFfdGlkX3JkbWFfd3FlX2ludGVybG9jayhzdHJ1Y3QgcnZ0X3FwDQo+ICpxcCwgc3RydWN0IHJ2
dF9zd3FlICp3cWUpDQo+ICAJCWRlZmF1bHQ6DQo+ICAJCQlicmVhazsNCj4gIAkJfQ0KPiArCQli
cmVhazsNCj4gIAljYXNlIElCX1dSX1JETUFfUkVBRDoNCj4gIAkJaWYgKHByZXYtPndyLm9wY29k
ZSAhPSBJQl9XUl9USURfUkRNQV9XUklURSkNCj4gIAkJCWJyZWFrOw0KPiAtLQ0KDQpSZXZpZXdl
ZC1ieTogS2Fpa2UgV2FuIDxLYWlrZS53YW5AaW50ZWwuY29tPg0KDQo+IDIuMjAuMQ0KDQo=
