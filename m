Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD30ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A195214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A195214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeIRCHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:07:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:54925 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeIRCHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:07:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 13:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="264314567"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga006.fm.intel.com with ESMTP; 17 Sep 2018 13:38:17 -0700
Received: from orsmsx151.amr.corp.intel.com ([169.254.7.211]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.237]) with mapi id 14.03.0319.002;
 Mon, 17 Sep 2018 13:38:16 -0700
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
To:     "Howell, Seth" <seth.howell@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Topic: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Index: AQHUNB7X7okyqfuXp0e3kpEuk2f+WqTB4cuAgAAKaQCAATczAIAGhGQAgCvyAwA=
Date:   Mon, 17 Sep 2018 20:38:16 +0000
Message-ID: <11f85f780435a5ded567bc8559d7c770d3bc4464.camel@intel.com>
References: <20180814223303.83556-1-seth.howell@intel.com>
         <20180815225021.GB31799@ziepe.ca>
         <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
         <20180816180126.GB10507@ziepe.ca>
         <EA913ED399BBA34AA4EAC2EDC24CDD0086118B12@FMSMSX105.amr.corp.intel.com>
In-Reply-To: <EA913ED399BBA34AA4EAC2EDC24CDD0086118B12@FMSMSX105.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.18.124.203]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EB06C1CD1EA7E4AABC32B88DFC0AD6E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA4LTIwIGF0IDE0OjMyIC0wNzAwLCBIb3dlbGwsIFNldGggd3JvdGU6DQo+
IEhpIEphc29uLA0KPiANCj4gSSBhcG9sb2dpemUgZm9yIHRoZSBmZXcgZGF5cyBvZiByYWRpbyBz
aWxlbmNlIG9uIHRoaXMgb25lLiBJIHdhcyBhYmxlIHRvIGFwcGx5DQo+IHlvdXIgcGF0Y2ggb24g
bXkgbG9jYWwgY29uZmlndXJhdGlvbiBhbmQgY2FuIGNvbmZpcm0gdGhhdCBpdCBmaXhlcyB0aGUg
aXNzdWUNCj4gb2Ygc2VuZCB3aXRoIGludmFsaWRhdGUgYmVpbmcgaW1wcm9wZXJseSBtYXBwZWQg
YmV0d2VlbiBhIHVzZXItc3BhY2UgcHJvY2Vzcw0KPiBhbmQgdGhlIGtlcm5lbCByeGUgZHJpdmVy
Lg0KPiANCj4gVGhhbmtzIGFnYWluIGZvciB5b3VyIHRpbWUgYW5kIGhlbHAuDQo+IA0KPiBTZXRo
IEhvd2VsbA0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgt
cmRtYS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzoNCj4gbGludXgtcmRtYS1vd25lckB2
Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBKYXNvbiBHdW50aG9ycGUNCj4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAxNiwgMjAxOCAxMTowMSBBTQ0KPiBUbzogSG93ZWxsLCBTZXRoIDxzZXRo
Lmhvd2VsbEBpbnRlbC5jb20+DQo+IENjOiBXYWxrZXIsIEJlbmphbWluIDxiZW5qYW1pbi53YWxr
ZXJAaW50ZWwuY29tPjsgRG91ZyBMZWRmb3JkIDwNCj4gZGxlZGZvcmRAcmVkaGF0LmNvbT47IGxp
bnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IDsgTW9uaSBTaG91YSA8bW9uaXNAbWVsbGFub3guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSByZG1hOiBtb3ZlIHRoZSBpYl93cl9vcGNvZGUgZW51bSB0byBpbmNsdWRlL3VhcGkNCj4gDQo+
IE9uIFdlZCwgQXVnIDE1LCAyMDE4IGF0IDExOjI3OjM2UE0gKzAwMDAsIEhvd2VsbCwgU2V0aCB3
cm90ZToNCj4gDQo+ID4gVGhhbmsgeW91IGZvciB0YWtpbmcgdGhlIHRpbWUgdG8gcmV2aWV3IHRo
aXMgaXNzdWUuIFRoZSBwYXRjaCB5b3UgDQo+ID4gc3VibWl0dGVkIHdpbGwgZGVmaW5pdGVseSBm
aXggdGhlIHByb2JsZW0gSSB3YXMgZmFjaW5nLg0KPiANCj4gQ2FuIHlvdSB0ZXN0IGl0IHRvIGJl
IGNlcnRhaW4/DQo+IA0KPiBUaGFua3MsDQo+IEphc29uDQoNCldlJ3ZlIHJlY2VudGx5IHJ1biBp
bnRvIHRoaXMgc2FtZSBpc3N1ZSBvbiBpNDBpdywgd2hpY2ggYXBwZWFycyB0byBtYWtlIHRoZSBz
YW1lDQptaXN0YWtlIG9mIHVzaW5nIHRoZSBrZXJuZWwgdmVyc2lvbiBvZiB0aGUgZW51bSBpbnN0
ZWFkIG9mIHRoZSB1c2Vyc3BhY2UNCnZlcnNpb24uIFRoaXMgcHJvcG9zZWQgcGF0Y2ggd2lsbCBh
ZGRyZXNzIGl0IHRoZXJlIHRvby4gV2hhdCdzIHRoZSBjdXJyZW50DQpzdGF0dXMgaGVyZT8gQ2Fu
IGl0IGJlIG1lcmdlZD8gSSBqdXN0IGNoZWNrZWQgYW5kIGRvIG5vdCBzZWUgaXQgbWVyZ2VkIHRv
IExpbnV4DQptYXN0ZXIuDQoNClJ1bm5pbmcgYSB1c2VyLXNwYWNlIE5WTWUtb0YgdGFyZ2V0IHdp
dGggUkRNQSBhbmQgYSByZWNlbnQgTGludXgga2VybmVsDQppbml0aWF0b3IgaXMgbm90IGN1cnJl
bnRseSBwb3NzaWJsZSBvbiByeGUgb3IgaTQwaXcgYmVjYXVzZSBpdCByZXF1aXJlcyBzZW5kDQp3
aXRoIGludmFsaWRhdGUgc3VwcG9ydC4NCg0KVGhhbmtzLA0KQmVuDQoNCg==
