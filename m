Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0381DC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A274E216FB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A274E216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeHOEco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:32:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:21695 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeHOEco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:32:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 18:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,241,1531810800"; 
   d="scan'208";a="224716298"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2018 18:42:47 -0700
Received: from pgsmsx109.gar.corp.intel.com ([169.254.14.29]) by
 PGSMSX108.gar.corp.intel.com ([169.254.8.104]) with mapi id 14.03.0319.002;
 Wed, 15 Aug 2018 09:42:46 +0800
From:   "Ong, Hean Loong" <hean.loong.ong@intel.com>
To:     "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Vandervennet, Yves" <yves.vandervennet@intel.com>
Subject: Re: [PATCH10 0/3] Intel FPGA Video and Image Processing Suite
Thread-Topic: [PATCH10 0/3] Intel FPGA Video and Image Processing Suite
Thread-Index: AQHUM6zUc+wXHV2usUSi15kWFwPc4qS+3xGAgACl/4A=
Date:   Wed, 15 Aug 2018 01:42:45 +0000
Message-ID: <1534297365.3035.0.camel@intel.com>
References: <1534237029-2648-1-git-send-email-hean.loong.ong@intel.com>
         <3720ba74-947a-1b5d-5f5b-1ef03d5941aa@kernel.org>
In-Reply-To: <3720ba74-947a-1b5d-5f5b-1ef03d5941aa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.226.243.17]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A66F67514536543AD8D00F20A84CC41@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTE0IGF0IDEwOjQ4IC0wNTAwLCBEaW5oIE5ndXllbiB3cm90ZToNCj4g
DQo+IE9uIDA4LzE0LzIwMTggMDM6NTcgQU0sIEhlYW4tTG9vbmcsIE9uZyB3cm90ZToNCj4gPiAN
Cj4gPiBGcm9tOiBPbmcsIEhlYW4gTG9vbmcgPGhlYW4ubG9vbmcub25nQGludGVsLmNvbT4NCj4g
PiANCj4gPiBUaGUgRlBHQSBGcmFtZUJ1ZmZlciBTb2Z0IElQIGNvdWxkIGJlIHNlZW7CoMKgYXMg
dGhlIEdQVSBhbmQgdGhlIERSTQ0KPiA+IGRyaXZlciBwYXRjaMKgDQo+ID4gaGVyZSBpcyBhbGxv
Y2F0aW5nIG1lbW9yeSBmb3IgaW5mb3JtYXRpb24gdG8gYmUgc3RyZWFtZWQgZnJvbSB0aGUNCj4g
PiBBUk0vTGludXjCoA0KPiA+IHRvIHRoZSBkaXNwbGF5IHBvcnQuIEJhc2ljYWxseSB0aGUgZHJp
dmVyIGp1c3Qgd3JhcHMgdGhlDQo+ID4gaW5mb3JtYXRpb24gc3VjaCBhc8KgDQo+ID4gdGhlIHBp
eGVscyB0byBiZSBkcmF3biBieSB0aGUgRlBHQSBGcmFtZUJ1ZmZlciAyLg0KPiA+IA0KPiA+IFRo
ZSBwaWVjZSBvZiBoYXJkd2FyZSBpbiBkaXNjdXNzaW9uIGlzIHRoZSBTb0MgRlBHQSB3aGVyZSBM
aW51eA0KPiA+IHJ1bnMgb24gdGhlwqANCj4gPiBBUk0gY2hpcCBhbmQgdGhlIEZHUEEgaXMgZHJp
dmVuIGJ5IGl0cyBOSU9TIHNvZnQgY29yZSB3aXRoIGl0cyBvd24NCj4gPiBwcm9wcmlldGFyeSBm
aXJtd2FyZS4NCj4gVGhpcyBkcml2ZXIgZG9lc24ndCBoYXZlIHRvIEFSTSBzcGVjaWZpYyBkb2Vz
IGl0Pw0KPiANCj4gPiANCj4gPiANCj4gPiBGb3IgZXhhbXBsZSB0aGUgYXBwbGljYXRpb24gZnJv
bSB0aGUgQVJNIExpbnV4IHdvdWxkIGhhdmUgdG8gd3JpdGUNCj4gPiBpbmZvcm1hdGlvbsKgDQo+
ID4gb24gdGhlIC9kZXYvZmIwIHdpdGggdGhlIGluZm9ybWF0aW9uIHN0b3JlZCBpbiB0aGUgU0RS
QU0gdG8gYmUNCj4gPiBmZXRjaGVkIGJ5IHRoZcKgDQo+ID4gRlBHQSBmcmFtZWJ1ZmZlciBJUCBh
bmQgZGlzcGxheWVkIG9uIHRoZSBEaXNwbGF5IFBvcnQgTW9uaXRvci4NCj4gPiANCj4gPiANCj4g
PiBPbmcgSGVhbiBMb29uZyAoMik6DQo+ID4gwqAgQVJNOnNvY2ZwZ2EtZGVmY29uZmlnIEludGVs
IEZQR0EgVmlkZW8gYW5kIEltYWdlIFByb2Nlc3NpbmcgU3VpdGUNCj4gPiDCoCBBUk06ZHJtIGl2
aXAgSW50ZWwgRlBHQSBWaWRlbyBhbmQgSW1hZ2UgUHJvY2Vzc2luZyBTdWl0ZQ0KPiA+IA0KPiA+
IE9uZywgSGVhbiBMb29uZyAoMSk6DQo+ID4gwqAgQVJNOmR0LWJpbmRpbmdzOmRpc3BsYXkgSW50
ZWwgRlBHQSBWaWRlbyBhbmQgSW1hZ2UgUHJvY2Vzc2luZw0KPiA+IFN1aXRlDQo+ID4gDQo+ID4g
wqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2FsdHIsdmlwLWZiMi50eHTCoMKgwqB8
wqDCoMKgNjMgKysrKysrKw0KPiA+IMKgYXJjaC9hcm0vY29uZmlncy9zb2NmcGdhX2RlZmNvbmZp
Z8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgwqA1ICsNCj4gPiDCoGRy
aXZlcnMvZ3B1L2RybS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgwqAyICsNCj4gPiDCoGRyaXZlcnMvZ3B1L2RybS9N
YWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHzCoMKgwqDCoDEgKw0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL2l2aXAvS2NvbmZpZ8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgMTQgKysNCj4g
PiDCoGRyaXZlcnMvZ3B1L2RybS9pdmlwL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgwqA5ICsNCj4gPiDCoGRyaXZlcnMvZ3B1L2RybS9p
dmlwL2ludGVsX3ZpcF9jb25uLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqDCoDk1
DQo+ID4gKysrKysrKysrKw0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL2l2aXAvaW50ZWxfdmlwX2Nv
cmUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDE2MQ0KPiA+ICsrKysrKysrKysr
KysrKysNCj4gPiDCoGRyaXZlcnMvZ3B1L2RybS9pdmlwL2ludGVsX3ZpcF9kcnYuaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqA1MiArKysrKysNCj4gPiDCoGRyaXZlcnMvZ3B1
L2RybS9pdmlwL2ludGVsX3ZpcF9vZi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8
wqDCoDE5Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gwqAxMCBmaWxlcyBjaGFuZ2Vk
LCA1OTUgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCj4gPiDCoGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2FsdHIs
dmlwLWZiMi50eHQNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vaXZp
cC9LY29uZmlnDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2l2aXAv
TWFrZWZpbGUNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vaXZpcC9p
bnRlbF92aXBfY29ubi5jDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJt
L2l2aXAvaW50ZWxfdmlwX2NvcmUuYw0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
Z3B1L2RybS9pdmlwL2ludGVsX3ZpcF9kcnYuaA0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvZ3B1L2RybS9pdmlwL2ludGVsX3ZpcF9vZi5jDQo+ID4gDQo+IENhbiB5b3UgY2xhcmlm
eSB5b3VyIGNvbW1pdCBoZWFkZXI/IFdoYXQgaXMgIlBBVENIMTAiLCBpcyBpdCB2ZXJzaW9uDQo+
IDEwPw0KPiBJZiBzbywgaXQgc2hvdWxkIGJlICJQQVRDSHYxMCIuDQo+IA0KPiBZb3UncmUgYWxz
byBtaXNzaW5nIGEgZmV3IG90aGVyIG1haW50YWluZXJzIGluIHlvdXIgQ0MgbGlzdCwgdGhlICJE
Uk0NCj4gRFJJVkVSUyBBTkQgTUlTQyBHUFUgUEFUQ0hFUyIgcGVvcGxlLg0KPiANCk5vdGVkDQoN
Cj4gRGluaA==
