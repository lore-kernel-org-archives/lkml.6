Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E40C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11EA2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11EA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeKSWnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:43:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:56961 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:43:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 04:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="105820593"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2018 04:20:09 -0800
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 19 Nov 2018 04:20:08 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 19 Nov 2018 04:20:08 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.102]) with mapi id 14.03.0415.000;
 Mon, 19 Nov 2018 20:20:05 +0800
From:   "Xu, Terrence" <terrence.xu@intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "'igvt-g@lists.01.org'" <igvt-g@lists.01.org>,
        "'intel-gfx@lists.freedesktop.org'" <intel-gfx@lists.freedesktop.org>,
        "'kvm@vger.kernel.org'" <kvm@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC:     "Li, Susie" <susie.li@intel.com>,
        "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
        "Cowperthwaite, David J" <david.j.cowperthwaite@intel.com>,
        "Reddy, Raghuveer" <raghuveer.reddy@intel.com>,
        "Dong, Eddie" <eddie.dong@intel.com>,
        "Yuan, Hang" <hang.yuan@intel.com>,
        "Lv, Zhiyuan" <zhiyuan.lv@intel.com>,
        "Jin, Gordon" <gordon.jin@intel.com>,
        "Downs, Mike" <mike.downs@intel.com>,
        "Wang, Hongbo" <hongbo.wang@intel.com>
Subject: RE: [Intel-gfx] [GVT-g] [ANNOUNCE] 2018-Q3 release of KVMGT (Intel
 GVT-g for KVM)
Thread-Topic: [Intel-gfx] [GVT-g] [ANNOUNCE] 2018-Q3 release of KVMGT (Intel
 GVT-g for KVM)
Thread-Index: AdRnec44ZTP5BR3PSFuqetWa2tGSuwV/IGgAAKLgs/A=
Date:   Mon, 19 Nov 2018 12:20:05 +0000
Message-ID: <EE92950F97EE42469CA4F508D4691F5E3CD9B1C4@SHSMSX104.ccr.corp.intel.com>
References: <EE92950F97EE42469CA4F508D4691F5E3CD21CFA@SHSMSX104.ccr.corp.intel.com>
 <154237881992.14497.12677363726001385709@jlahtine-desk.ger.corp.intel.com>
In-Reply-To: <154237881992.14497.12677363726001385709@jlahtine-desk.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCBpZiB5b3UgZmluZCBhbmQgcHJvYmxlbSBvbiB3ZSBtZW50aW9uZWQgcGxhdGZvcm0sIHlv
dSBjYW4gZmlsZSBhIGJ1ZyBvbiBmZC4gKGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvKSAg
d2l0aCBjb21wb25lbnQgIkRSTS9pR1ZULWciLg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj5Gcm9tOiBKb29uYXMgTGFodGluZW4gW21haWx0bzpqb29uYXMubGFodGluZW5AbGludXgu
aW50ZWwuY29tXQ0KPlNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTYsIDIwMTggMTA6MzQgUE0NCj5U
bzogJ2lndnQtZ0BsaXN0cy4wMS5vcmcnIDxpZ3Z0LWdAbGlzdHMuMDEub3JnPjsgJ2ludGVsLQ0K
PmdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcnIDxpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPjsNCj4na3ZtQHZnZXIua2VybmVsLm9yZycgPGt2bUB2Z2VyLmtlcm5lbC5vcmc+OyAnbGlu
dXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZycgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBYdSwgVGVycmVuY2UNCj48dGVycmVuY2UueHVAaW50ZWwuY29tPg0KPkNjOiBMaSwgU3Vz
aWUgPHN1c2llLmxpQGludGVsLmNvbT47IFdhbmcsIFpoZW55dSBaDQo+PHpoZW55dS56LndhbmdA
aW50ZWwuY29tPjsgQ293cGVydGh3YWl0ZSwgRGF2aWQgSg0KPjxkYXZpZC5qLmNvd3BlcnRod2Fp
dGVAaW50ZWwuY29tPjsgUmVkZHksIFJhZ2h1dmVlcg0KPjxyYWdodXZlZXIucmVkZHlAaW50ZWwu
Y29tPjsgRG9uZywgRWRkaWUgPGVkZGllLmRvbmdAaW50ZWwuY29tPjsgWXVhbiwNCj5IYW5nIDxo
YW5nLnl1YW5AaW50ZWwuY29tPjsgTHYsIFpoaXl1YW4gPHpoaXl1YW4ubHZAaW50ZWwuY29tPjsg
SmluLA0KPkdvcmRvbiA8Z29yZG9uLmppbkBpbnRlbC5jb20+OyBEb3ducywgTWlrZSA8bWlrZS5k
b3duc0BpbnRlbC5jb20+Ow0KPldhbmcsIEhvbmdibyA8aG9uZ2JvLndhbmdAaW50ZWwuY29tPg0K
PlN1YmplY3Q6IFJlOiBbSW50ZWwtZ2Z4XSBbR1ZULWddIFtBTk5PVU5DRV0gMjAxOC1RMyByZWxl
YXNlIG9mIEtWTUdUDQo+KEludGVsIEdWVC1nIGZvciBLVk0pDQo+DQo+UXVvdGluZyBYdSwgVGVy
cmVuY2UgKDIwMTgtMTAtMTkgMTA6MDQ6NDcpDQo+PiBQbGF0Zm9ybSBTdXBwb3J0Og0KPj4NCj4+
IC0gICAgU2VydmVyIHBsYXRmb3JtczogSW50ZWwocikgWGVvbihyKSBFM192NCwgRTNfdjUgYW5k
IEUzX3Y2IHdpdGggSW50ZWwNCj4+IEdyYXBoaWNzIHByb2Nlc3Nvcg0KPj4NCj4+IC0gICAgQ2xp
ZW50IHBsYXRmb3JtczogSW50ZWwocikgQ29yZSh0bSkgNXRoIGdlbmVyYXRpb24gKGNvZGUgbmFt
ZToNCj5Ccm9hZHdlbGwpLA0KPj4gNnRoIGdlbmVyYXRpb24gKGNvZGUgbmFtZTogU2t5bGFrZSks
IDd0aCBnZW5lcmF0aW9uIChjb2RlIG5hbWU6DQo+PiBLYWJ5bGFrZSkgYW5kIDd0aCBTb0MgZ2Vu
ZXJhdGlvbiAoY29kZSBuYW1lOiBCcm94dG9uKSwgdGhlIEJyb3h0b24gaXMNCj4+IG5ldyBzdXBw
b3J0ZWQgcGxhdGZvcm0NCj4NCj5Eb2VzIHRoaXMgbWVhbiB0aGF0IGFsbCBTS1VzIGZyb20gdGhv
c2UgcGxhdGZvcm1zIGFyZSBzdXBwb3J0ZWQgc28gdGhhdA0KPndoZW4gdXNlcnMgcmVwb3J0IGJ1
Z3MsIHRoZXkgd2lsbCBiZSB3b3JrZWQgb24/DQo+DQo+UmVnYXJkcywgSm9vbmFzDQo=
