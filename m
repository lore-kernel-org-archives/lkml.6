Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A83DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331172146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbfBSUdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:33:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:52173 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfBSUdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:33:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="117461631"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 19 Feb 2019 12:33:15 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Feb 2019 12:33:14 -0800
Received: from fmsmsx126.amr.corp.intel.com ([169.254.1.212]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.137]) with mapi id 14.03.0415.000;
 Tue, 19 Feb 2019 12:33:14 -0800
From:   "Brown, Len" <len.brown@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Len Brown <lenb@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [linux-drivers-review] [PATCH 02/11] topolgy: simplify
 cputopology.txt formatting and wording
Thread-Topic: [linux-drivers-review] [PATCH 02/11] topolgy: simplify
 cputopology.txt formatting and wording
Thread-Index: AQHUyAKhfXThj+8N40yfmQOFdkmbIaXoCi0A//+I4NA=
Date:   Tue, 19 Feb 2019 20:33:14 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9485C5B776A@FMSMSX126.amr.corp.intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <e13cb72d48bdaed80b681abf89bc77d58931db51.1550545163.git.len.brown@intel.com>
 <9108bd98-e9f4-fee3-80c7-72d540c48291@infradead.org>
In-Reply-To: <9108bd98-e9f4-fee3-80c7-72d540c48291@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjhiNzE2YTUtNDZjNS00MDAyLWI0ZDktZWMxMzAxNzViODdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibnhPSFRwSGFyaVdSZzZYdnpDRkFZb2l3cEM4R0FGd2JCZmxsc1V5cXBEK3NSVStRdFpHaDMrZ04zV3JSVzdXViJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gK2lmIENPTkZJR19TQ0hFRF9CT09LIGFuZCBDT05GSUdfU0NIRURfRFJBV0VSIGFyZSBzZWxl
Y3RlZCwgcmVzcGVjdGl2ZWx5Lg0KPj4gIA0KPj4gIENPTkZJR19TQ0hFRF9CT09LIGFuZCBDT05G
SUdfRFJBV0VSIGFyZSBjdXJyZW50bHkgb25seSB1c2VkIG9uIHMzOTAsIA0KPj4gd2hlcmUNCg0K
PmZ3aXc6ICAgICAgICAgICAgICAgICAgICBDT05GSUdfU0NIRURfRFJBV0VSDQoNCkhlaC4gIFNl
ZW1zIHRoYXQgZXZlcnkgbGluZSBvZiB1cGRhdGUgdG8gYSAudHh0IGZpbGVzIHVuY292ZXJzIHR3
byBsaW5lcyBvZiBleGlzdGluZyBidWdzLg0KDQpIb3BlZnVsbHkgd2UgYXJlIGJldHRlciBhdCB3
cml0aW5nIHNvZnR3YXJlLCB0aGFuIGRvY3VtZW50YXRpb24hDQoNCkluZGVlZCwgbWF5YmUgaWYg
d2UgaGFkIGEgY29tcGlsZXIgb3IgY2hlY2twYXRjaC5wbCBmaWxlIGZvciBkb2N1bWVudGF0aW9u
IGZpbGVzLA0KVGhleSB3b3VsZCBhcHByb2FjaCB0aGUgcXVhbGl0eSBvZiB0aGUgc291cmNlIGNv
ZGU/DQoNCkkgdXBkYXRlZCB0aGUgcGF0Y2ggdG8gZml4IHRoaXMgdG9vLg0KDQpUaGFua3MsDQot
TGVuDQoNCg0K
