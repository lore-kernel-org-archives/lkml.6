Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA6C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B3C2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B3C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeJMIrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:47:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:19938 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJMIrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:47:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 18:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,374,1534834800"; 
   d="scan'208";a="240955291"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2018 18:12:40 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 12 Oct 2018 18:12:40 -0700
Received: from fmsmsx122.amr.corp.intel.com ([169.254.5.127]) by
 fmsmsx111.amr.corp.intel.com ([169.254.12.10]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 18:12:40 -0700
From:   "Bridgers, Vince" <vince.bridgers@intel.com>
To:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "atull@kernel.org" <atull@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "james.hartley@sondrel.com" <james.hartley@sondrel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vandervennet, Yves" <yves.vandervennet@intel.com>
Subject: RE: [PATCH] MAINTAINERS: Replace Vince Bridgers as Altera TSE
 maintainer
Thread-Topic: [PATCH] MAINTAINERS: Replace Vince Bridgers as Altera TSE
 maintainer
Thread-Index: AQHUYmyy5H5xnPGhlECadlvvu/QLUKUcXnug
Date:   Sat, 13 Oct 2018 01:12:39 +0000
Message-ID: <15E5F4404EBD914E8BCA1FCC37E0A56A189C429C@fmsmsx122.amr.corp.intel.com>
References: <1539363052-6143-1-git-send-email-thor.thayer@linux.intel.com>
 <20181012165741.GA12446@kroah.com>
 <295a966d-5f48-9313-7dc6-47ea49d05a27@linux.intel.com>
In-Reply-To: <295a966d-5f48-9313-7dc6-47ea49d05a27@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODMyNWEzN2EtYzJiMi00Y2YwLTk1NTAtY2JlOTEwNjIyZDQ2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTzZ0amhUSUxVa1paRGJYVGtJTkdQZDM2S29iWjYxSUtFT3d4Sm5OVTV6cGpkNFNYdUsrRDRkRWJSY01zdFR3ZiJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUaG9yIFRoYXllciA8dGhvci50
aGF5ZXJAbGludXguaW50ZWwuY29tPiANClNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMiwgMjAxOCAz
OjQ5IFBNDQpUbzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQpDYzogZ2Vl
cnQrcmVuZXNhc0BnbGlkZXIuYmU7IGpob2dhbkBrZXJuZWwub3JnOyBhdHVsbEBrZXJuZWwub3Jn
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBqYW1lcy5oYXJ0bGV5QHNvbmRyZWwuY29tOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBCcmlkZ2VycywgVmluY2UgPHZpbmNlLmJyaWRnZXJzQGlu
dGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIE1BSU5UQUlORVJTOiBSZXBsYWNlIFZpbmNl
IEJyaWRnZXJzIGFzIEFsdGVyYSBUU0UgbWFpbnRhaW5lcg0KDQpPbiAxMC8xMi8yMDE4IDExOjU3
IEFNLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBGcmksIE9jdCAxMiwgMjAxOCBhdCAxMTo1MDo1MkFN
IC0wNTAwLCB0aG9yLnRoYXllckBsaW51eC5pbnRlbC5jb20gd3JvdGU6DQo+PiBGcm9tOiBUaG9y
IFRoYXllciA8dGhvci50aGF5ZXJAbGludXguaW50ZWwuY29tPg0KPj4NCj4+IFZpbmNlIGhhcyBt
b3ZlZCB0byBhIGRpZmZlcmVudCByb2xlLiBSZXBsYWNlIGhpbSBhcyBBbHRlcmEgVFNFIA0KPj4g
bWFpbnRhaW5lci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9yIFRoYXllciA8dGhvci50aGF5
ZXJAbGludXguaW50ZWwuY29tPg0KPiANCj4gV291bGQgYmUgbmljZSBpZiBWaW5jZSBjYW4gYWNr
IHRoaXMuLi4NCj4gDQorIFZpbmNlIChhdCBhIG5ldyBlbWFpbCBhZGRyZXNzKQ0KDQpUaGFua3Mg
VGhvciwgDQoNCkFja2VkLWJ5OiBWaW5jZSBCcmlkZ2VycyA8dmluY2UuYnJpZGdlcnNAaW50ZWwu
Y29tPiANCg==
