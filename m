Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF1BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2E3208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2E3208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933510AbeGIArP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:47:15 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:56725 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933204AbeGIArO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:47:14 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w690l72J006601
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 Jul 2018 09:47:07 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w690l7PA027163;
        Mon, 9 Jul 2018 09:47:07 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w690l3ZZ003207;
        Mon, 9 Jul 2018 09:47:07 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-1809822; Mon, 9 Jul 2018 09:38:04 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Mon, 9
 Jul 2018 09:38:04 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     =?utf-8?B?6KOY56iA55+zKOeogOefsyk=?= 
        <xishi.qiuxishi@alibaba-inc.com>
CC:     linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6ZmI5LmJ5YWo?= <zy.zhengyi@alibaba-inc.com>
Subject: =?utf-8?B?UmU6IFJl77yaW1JGQ10gYSBxdWVzdGlvbiBhYm91dCByZXVzZSBod3BvaXNv?=
 =?utf-8?B?biBwYWdlIGluIHNvZnRfb2ZmbGluZV9wYWdlKCk=?=
Thread-Topic: =?utf-8?B?UmXvvJpbUkZDXSBhIHF1ZXN0aW9uIGFib3V0IHJldXNlIGh3cG9pc29uIHBh?=
 =?utf-8?B?Z2UgaW4gc29mdF9vZmZsaW5lX3BhZ2UoKQ==?=
Thread-Index: AQHUFRAF+OBtREWF40yAWtv54Jfzu6SFeS8A
Date:   Mon, 9 Jul 2018 00:38:02 +0000
Message-ID: <20180709003802.GA11404@hori1.linux.bs1.fc.nec.co.jp>
References: <ac6e703d-b0df-40d2-8918-63a63f3c5d68.xishi.qiuxishi@alibaba-inc.com>
In-Reply-To: <ac6e703d-b0df-40d2-8918-63a63f3c5d68.xishi.qiuxishi@alibaba-inc.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.84]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3D83C10B11C104C899866172B5F4122@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdWwgMDYsIDIwMTggYXQgMDU6NTk6MTVQTSArMDgwMCwg6KOY56iA55+zKOeogOef
sykgd3JvdGU6DQo+IA0KPiBIaSBOYW95YSwNCj4gDQo+IEhvdyBhYm91dCB0aGlzIGNhc2UsIHdl
IG9ubHkgdHJpZ2dlciBzb2Z0IG9mZmxpbmUgcGFnZSwgYnV0IHNvbWVvbmUga2lsbGVkDQo+IGxh
dGVyLg0KPiBBcyB0aGUgcmFjZSBJIHNhaWQgYmVmb3JlLCB0aGVuIHNvbWVvbmUgbWF5IHVzZSB0
aGUgaHdwb2lzb25lZCBodWdldGxiIHBhZ2UNCj4gYWdhaW4uDQo+IFBsZWFzZSBzZWUgdGhlIGZv
bGxvd2luZy4NCj4gDQo+IHNvZnQgb2ZmbGluZTogDQo+ICAgICBnZXRfYW55X3BhZ2UgLSBmaW5k
IHRoZSBodWdldGxiIGlzIGZyZWUNCj4gcHJvY2VzcyBBOg0KPiAgICAgZG9fcGFnZV9mYXVsdCAt
IGhhbmRsZV9tbV9mYXVsdCAtIGh1Z2V0bGJfZmF1bHQgLSBodWdldGxiX25vX3BhZ2UNCj4gLSBh
bGxvY19odWdlX3BhZ2UNCj4gc29mdCBvZmZsaW5lOg0KPiAgICAgc29mdF9vZmZsaW5lX2ZyZWVf
cGFnZSAtIHNldCBod3BvaXNvbiBmbGFnDQo+IHByb2Nlc3MgQjoNCj4gICAgIG1tYXAgdGhlIGh1
Z2V0bGIgZmlsZSBmcm9tIEEsIGh1Z2V0bGJfZmF1bHQgLSBodWdldGxiX25vX3BhZ2UNCj4gLSBm
aW5kX2xvY2tfcGFnZQ0KPiAgICAgaXQgZmluZCBod3BvaXNvbiBmbGFnIGlzIGFscmVhZHkgc2V0
LCBzbyByZXQgPSBWTV9GQVVMVF9IV1BPSVNPTg0KPiAgICAgdGhlbiBtbV9mYXVsdF9lcnJvciAt
IGRvX3NpZ2J1cyAtIG1jZSBraWxsDQo+IHByb2Nlc3MgQiB3YXMga2lsbGVkIGJ5IHNvZnQgb2Zm
bGluZSwgcmlnaHQ/DQoNClJpZ2h0LCB0aGlzIGFuZCB5b3VyIGFub3RoZXIgZW1haWwgc2hvd3Mg
aG93IHRoaW5ncyBnbyBiYWQuDQpTb2Z0IG9mZmxpbmUgaGFuZGxlciBpcyBzaW1wbHkgcmFjeSBu
b3csIHNvIHdlIGhhZCBiZXR0ZXIgY2FuY2VsIGl0IGlmDQp0aGUgdGFyZ2V0IHBhZ2Ugd2FzIGFs
bG9jYXRlZCBkdXJpbmcgc29mdCBvZmZsaW5lIGhhbmRsaW5nIGJ5IGRvdWJsZQ0KY2hlY2tpbmcg
YXMgSSBtZW50aW9uZWQuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQoNCj4gDQo+IFRo
YW5rcywNCj4gWGlzaGkgUWl1IA0KPiANCj4gICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgICAg5Y+R5Lu25Lq6
77yaTmFveWEgSG9yaWd1Y2hpIDxuLWhvcmlndWNoaUBhaC5qcC5uZWMuY29tPg0KPiAgICAg5Y+R
6YCB5pe26Ze077yaMjAxOOW5tDfmnIg25pelKOaYn+acn+S6lCkgMTY6MTkNCj4gICAgIOaUtuS7
tuS6uu+8muijmOeogOefsyjnqIDnn7MpIDx4aXNoaS5xaXV4aXNoaUBhbGliYWJhLWluYy5jb20+
DQo+ICAgICDmioTjgIDpgIHvvJpsaW51eC1tbSA8bGludXgtbW1Aa3ZhY2sub3JnPjsgbGludXgt
a2VybmVsDQo+ICAgICA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IOmZiOS5ieWFqCA8
enkuemhlbmd5aUBhbGliYWJhLWluYy5jb20+DQo+ICAgICDkuLvjgIDpopjvvJpSZTogW1JGQ10g
YSBxdWVzdGlvbiBhYm91dCByZXVzZSBod3BvaXNvbiBwYWdlIGluIHNvZnRfb2ZmbGluZV9wYWdl
DQo+ICAgICAoKQ0KPiANCj4gICAgIE9uIEZyaSwgSnVsIDA2LCAyMDE4IGF0IDExOjM3OjQxQU0g
KzA4MDAsIOijmOeogOefsyjnqIDnn7MpIHdyb3RlOg0KPiAgICAgPiBUaGlzIHBhdGNoIGFkZDA1
Y2VjDQo+ICAgICA+IChtbTogc29mdC1vZmZsaW5lOiBkb24ndCBmcmVlIHRhcmdldCBwYWdlIGlu
IHN1Y2Nlc3NmdWwgcGFnZSBtaWdyYXRpb24pDQo+ICAgICAgcmVtb3Zlcw0KPiAgICAgPiBzZXRf
bWlncmF0ZXR5cGVfaXNvbGF0ZSgpIGFuZCB1bnNldF9taWdyYXRldHlwZV9pc29sYXRlKCkNCj4g
ICAgICBpbiBzb2Z0X29mZmxpbmVfcGFnZQ0KPiAgICAgPiAoKS4NCj4gICAgID4gDQo+ICAgICA+
IEFuZCB0aGlzIHBhdGNoIDI0M2FiZDViDQo+ICAgICA+IChtbTogaHVnZXRsYjogcHJldmVudCBy
ZXVzZSBvZiBod3BvaXNvbmVkIGZyZWUgaHVnZXBhZ2VzKSBjaGFuZ2VzDQo+ICAgICA+IGlmICgh
aXNfbWlncmF0ZV9pc29sYXRlX3BhZ2UocGFnZSkpIHRvIGlmICghUGFnZUhXUG9pc29uDQo+ICAg
ICAocGFnZSkpLCBzbyBpdCBjb3VsZA0KPiAgICAgPiBwcmV2ZW50IHNvbWVvbmUNCj4gICAgID4g
cmV1c2UgdGhlIGZyZWUgaHVnZXRsYiBhZ2FpbiBhZnRlciBzZXQgdGhlIGh3cG9pc29uIGZsYWcN
Cj4gICAgID4gaW4gc29mdF9vZmZsaW5lX2ZyZWVfcGFnZSgpDQo+ICAgICA+IA0KPiAgICAgPiBN
eSBxdWVzdGlvbiBpcyB0aGF0IGlmIHNvbWVvbmUgcmV1c2UgdGhlIGZyZWUgaHVnZXRsYiBhZ2Fp
biBiZWZvcmUgDQo+ICAgICA+IHNvZnRfb2ZmbGluZV9mcmVlX3BhZ2UoKSBhbmQNCj4gICAgID4g
YWZ0ZXIgZ2V0X2FueV9wYWdlDQo+ICAgICAoKSwgdGhlbiBpdCB1c2VzIHRoZSBob3BvaXNvbiBw
YWdlLCBhbmQgdGhpcyBtYXkgdHJpZ2dlciBtY2UNCj4gICAgID4ga2lsbCBsYXRlciwgcmlnaHQ/
DQo+IA0KPiAgICAgSGkgWGlzaGksDQo+IA0KPiAgICAgVGhhbmsgeW91IGZvciBwb2ludGluZyBv
dXQgdGhlIGlzc3VlLiBUaGF0J3MgbmljZSBjYXRjaC4NCj4gDQo+ICAgICBJIHRoaW5rIHRoYXQg
dGhlIHJhY2UgY29uZGl0aW9uIGl0c2VsZiBjb3VsZCBoYXBwZW4sIGJ1dCBpdCBkb2Vzbid0IGxl
YWQNCj4gICAgIHRvIE1DRSBraWxsIGJlY2F1c2UgUGFnZUhXUG9pc29uIGlzIG5vdCB2aXNpYmxl
IHRvIEhXIHdoaWNoIHRyaWdnZXJzIE1DRS4NCj4gICAgIFBhZ2VIV1BvaXNvbiBmbGFnIGlzIGp1
c3QgYSBmbGFnIGluIHN0cnVjdCBwYWdlIHRvIHJlcG9ydCB0aGUgbWVtb3J5IGVycm9yDQo+ICAg
ICBmcm9tIGtlcm5lbCB0byB1c2Vyc3BhY2UuIFNvIGV2ZW4gaWYgYSBDUFUgaXMgYWNjZXNzaW5n
IHRvIHRoZSBwYWdlIHdob3NlDQo+ICAgICBzdHJ1Y3QgcGFnZSBoYXMgUGFnZUhXUG9pc29uIHNl
dCwgdGhhdCBkb2Vzbid0IGNhdXNlIGEgTUNFIHVubGVzcyB0aGUgcGFnZQ0KPiAgICAgaXMgcGh5
c2ljYWxseSBicm9rZW4uDQo+ICAgICBUaGUgdHlwZSBvZiBtZW1vcnkgZXJyb3IgdGhhdCBzb2Z0
IG9mZmxpbmUgdHJpZXMgdG8gaGFuZGxlIGlzIGNvcnJlY3RlZA0KPiAgICAgb25lIHdoaWNoIGlz
IG5vdCBhIGZhaWx1cmUgeWV0IGFsdGhvdWdoIGl0J3Mgc3RhcnRpbmcgdG8gd2Vhci4NCj4gICAg
IFNvIHN1Y2ggUGFnZUhXUG9pc29uIHBhZ2UgY2FuIGJlIHJldXNlZCwgYnV0IHRoYXQncyBub3Qg
Y3JpdGljYWwgYmVjYXVzZQ0KPiAgICAgdGhlIHBhZ2UgaXMgZnJlZWQgYXQgc29tZSBwb2ludCBh
ZnRlcndvcmQgYW5kIGVycm9yIGNvbnRhaW5tZW50IGNvbXBsZXRlcy4NCj4gDQo+ICAgICBIb3dl
dmVyLCBJIG5vdGljZWQgdGhhdCB0aGVyZSdzIGEgc21hbGwgcGFpbiBpbiBmcmVlIGh1Z2V0bGIg
Y2FzZS4NCj4gICAgIFdlIGNhbGwgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2UoKSBpbiBzb2Z0X29m
ZmxpbmVfZnJlZV9wYWdlKCkgd2hpY2ggbW92ZXMNCj4gICAgIHRoZSBQYWdlSFdQb2lzb24gZmxh
ZyBmcm9tIHRoZSBoZWFkIHBhZ2UgdG8gdGhlIHJhdyBlcnJvciBwYWdlLg0KPiAgICAgSWYgdGhl
IHJlcG9ydGVkIHJhY2UgaGFwcGVucywgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2UoKSBqdXN0IHJl
dHVybiB3aXRob3V0DQo+ICAgICBkb2luZyBhbnkgZGlzc29sdmUgd29yayBiZWNhdXNlICJpZiAo
UGFnZUh1Z2UocGFnZSkgJiYgIXBhZ2VfY291bnQocGFnZSkpIg0KPiAgICAgYmxvY2sgaXMgc2tp
cHBlZC4NCj4gICAgIFRoZSBodWdlcGFnZSBpcyBhbGxvY2F0ZWQgYW5kIHVzZWQgYXMgdXN1YWws
IGJ1dCB0aGUgY29udGFpbWVudCBkb2Vzbid0DQo+ICAgICBjb21wbGV0ZSBhcyBleHBlY3RlZCBp
biB0aGUgbm9ybWFsIHBhZ2UsIGJlY2F1c2UgZnJlZV9odWdlX3BhZ2VzKCkgZG9lc24ndA0KPiAg
ICAgY2FsbCBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZSgpIGZvciBod3BvaXNvbiBodWdlcGFnZS4g
VGhpcyBpcyBub3QgY3JpdGljYWwNCj4gICAgIGJlY2F1c2Ugc3VjaCBlcnJvciBodWdlcGFnZSBq
dXN0IHJlc2lkZSBpbiBmcmVlIGh1Z2VwYWdlIGxpc3QuIEJ1dCB0aGlzDQo+ICAgICBtaWdodCBs
b29rcyBsaWtlIGEga2luZCBvZiBtZW1vcnkgbGVhay4gQW5kIGV2ZW4gd29yc2Ugd2hlbiBodWdl
cGFnZSBwb29sDQo+ICAgICBpcyBzaHJpbmtlZCBhbmQgdGhlIGh3cG9pc29uIGh1Z2VwYWdlIGlz
IGZyZWVkLCB0aGUgUGFnZUhXUG9pc29uIGZsYWcgaXMNCj4gICAgIHN0aWxsIG9uIHRoZSBoZWFk
IHBhZ2Ugd2hpY2ggaXMgdW5saWtlbHkgdG8gYmUgYW4gYWN0dWFsIGVycm9yIHBhZ2UuDQo+IA0K
PiAgICAgU28gSSB0aGluayB3ZSBuZWVkIGltcHJvdmVtZW50IGhlcmUsIGhvdyBhYm91dCB0aGUg
Zml4IGxpa2UgYmVsb3c/DQo+IA0KPiAgICAgICAobm90IHRlc3RlZCB5ZXQsIHNvcnJ5KQ0KPiAN
Cj4gICAgICAgZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFp
bHVyZS5jDQo+ICAgICAgIC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gICAgICAgKysrIGIv
bW0vbWVtb3J5LWZhaWx1cmUuYw0KPiAgICAgICBAQCAtMTg4Myw2ICsxODgzLDExIEBAIHN0YXRp
YyB2b2lkIHNvZnRfb2ZmbGluZV9mcmVlX3BhZ2UNCj4gICAgIChzdHJ1Y3QgcGFnZSAqcGFnZSkN
Cj4gICAgICAgICAgICAgICBzdHJ1Y3QgcGFnZSAqaGVhZCA9IGNvbXBvdW5kX2hlYWQocGFnZSk7
DQo+ICAgICAgIA0KPiAgICAgICAgICAgICAgIGlmICghVGVzdFNldFBhZ2VIV1BvaXNvbihoZWFk
KSkgew0KPiAgICAgICArICAgICAgICAgICAgICAgaWYgKHBhZ2VfY291bnQoaGVhZCkpIHsNCj4g
ICAgICAgKyAgICAgICAgICAgICAgICAgICAgICAgQ2xlYXJQYWdlSFdQb2lzb24oaGVhZCk7DQo+
ICAgICAgICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gICAgICAgKyAgICAgICAg
ICAgICAgIH0NCj4gICAgICAgKw0KPiAgICAgICAgICAgICAgICAgICAgICAgbnVtX3BvaXNvbmVk
X3BhZ2VzX2luYygpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgaWYgKFBhZ2VIdWdlKGhlYWQp
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFn
ZShwYWdlKTsNCj4gDQo+ICAgICBUaGFua3MsDQo+ICAgICBOYW95YSBIb3JpZ3VjaGkNCj4g

