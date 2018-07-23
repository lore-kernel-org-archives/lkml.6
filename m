Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C5FECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4572086A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4572086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbeGWDPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:15:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:57643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387743AbeGWDPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:15:43 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id D0A4DE8D770D4;
        Mon, 23 Jul 2018 10:16:49 +0800 (CST)
Received: from DGGEMM507-MBX.china.huawei.com ([169.254.1.75]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0382.000;
 Mon, 23 Jul 2018 10:16:50 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: RE: [PATCH] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Thread-Topic: [PATCH] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Thread-Index: AQHUIZ3jKVgf1gBCwEC5U/xKcWTyBKSbBbcAgAAF2ICAAAfDAIAAAf2AgAD8nQA=
Date:   Mon, 23 Jul 2018 02:16:49 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A710ACE@dggemm507-mbx.china.huawei.com>
References: <20180722085044.50701-1-nixiaoming@huawei.com>
         <2C39A9CD-4591-46C8-BB25-5FA2C85149CE@oracle.com>
         <a6be2d3bf2ff5ac43f82dcb7b29ba32faccbbdaf.camel@hammerspace.com>
         <8B9E4DFD-F651-4478-A82E-CDB759BB1A69@oracle.com>
 <e0ee80246f7bb7587beac3f8d90f94cc6b7e6aff.camel@hammerspace.com>
In-Reply-To: <e0ee80246f7bb7587beac3f8d90f94cc6b7e6aff.camel@hammerspace.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMjMsIDIwMTggYXQgMzowOCBBTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
Pk9uIFN1biwgMjAxOC0wNy0yMiBhdCAxNTowMSAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+
PiA+IE9uIEp1bCAyMiwgMjAxOCwgYXQgMjozMyBQTSwgVHJvbmQgTXlrbGVidXN0IDwNCj4+ID4g
dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4gPiANCj4+ID4gT24gU3VuLCAyMDE4
LTA3LTIyIGF0IDE0OjEyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+ID4gPiA+IE9uIEp1
bCAyMiwgMjAxOCwgYXQgNDo1MCBBTSwgbml4aWFvbWluZyA8bml4aWFvbWluZ0BodWF3ZWkuY29t
Pg0KPj4gPiA+ID4gd3JvdGU6DQo+PiA+ID4gPiANCj4+ID4gPiA+IGR1bW15ID0gYmUzMl90b19j
cHVwKHArKyk7DQo+PiA+ID4gPiBkdW1teSA9IGJlMzJfdG9fY3B1cChwKyspOw0KPj4gPiA+ID4g
QXNzaWduaW5nIHZhbHVlIHRvICJkdW1teSIgaGVyZSwgYnV0IHRoYXQgc3RvcmVkIHZhbHVlDQo+
PiA+ID4gPiBpcyBvdmVyd3JpdHRlbiBiZWZvcmUgaXQgY2FuIGJlIHVzZWQuDQo+PiA+ID4gPiAN
Cj4+ID4gPiA+IGRlbGV0ZSBpbnZhbGlkIGFzc2lnbm1lbnQgc3RhdGVtZW50cyBpbg0KPj4gPiA+
ID4gbmZzZDRfZGVjb2RlX2V4Y2hhbmdlX2lkDQo+PiA+ID4gPiANCj4+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IG4wMDIwMjc1NCA8bml4aWFvbWluZ0BodWF3ZWkuY29tPg0KPj4gPiA+ID4gLS0tDQo+
PiA+ID4gPiBmcy9uZnNkL25mczR4ZHIuYyB8IDQgKystLQ0KPj4gPiA+ID4gMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+ID4gPiA+IA0KPj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHhkci5jIGIvZnMvbmZzZC9uZnM0eGRyLmMNCj4+ID4g
PiA+IGluZGV4IGE5Njg0M2MuLjhlNzg1NDEgMTAwNjQ0DQo+PiA+ID4gPiAtLS0gYS9mcy9uZnNk
L25mczR4ZHIuYw0KPj4gPiA+ID4gKysrIGIvZnMvbmZzZC9uZnM0eGRyLmMNCj4+ID4gPiA+IEBA
IC0xMzkyLDggKzEzOTIsOCBAQCBuZnNkNF9kZWNvZGVfZXhjaGFuZ2VfaWQoc3RydWN0DQo+PiA+
ID4gPiBuZnNkNF9jb21wb3VuZGFyZ3MgKmFyZ3AsDQo+PiA+ID4gPiANCj4+ID4gPiA+IAkJLyog
c3NwX3dpbmRvdyBhbmQgc3NwX251bV9nc3NfaGFuZGxlcyAqLw0KPj4gPiA+ID4gCQlSRUFEX0JV
Rig4KTsNCj4+ID4gPiA+IC0JCWR1bW15ID0gYmUzMl90b19jcHVwKHArKyk7DQo+PiA+ID4gPiAt
CQlkdW1teSA9IGJlMzJfdG9fY3B1cChwKyspOw0KPj4gPiA+ID4gKwkJYmUzMl90b19jcHVwKHAr
Kyk7DQo+PiA+ID4gPiArCQliZTMyX3RvX2NwdXAocCsrKTsNCj4+ID4gPiANCj4+ID4gPiBJZiB0
aGVzZSB2YWx1ZXMgYXJlIG5vdCB1c2VkLCB3aGF0J3MgdGhlIHBvaW50IG9mIGJ5dGUgc3dhcHBp
bmcNCj4+ID4gPiB0aGVtPw0KPj4gPiA+IFN1cmVseSAicCArPSAyOyIgc2hvdWxkIGJlIGVub3Vn
aC4NCj4+ID4gPiANCj4+ID4gPiANCj4+ID4gPiA+IAkJYnJlYWs7DQo+PiA+ID4gPiAJZGVmYXVs
dDoNCj4+ID4gPiA+IAkJZ290byB4ZHJfZXJyb3I7DQo+PiA+IA0KPj4gPiBHaXZlbiB0aGF0IHRo
ZSB2YWx1ZSBvZiAncCcgaXNuJ3QgdXNlZCBlaXRoZXIsIHdoeSBub3QganVzdCBkZWxldGUNCj4+
ID4gdGhvc2UgdHdvIGxpbmVzIGFsdG9nZXRoZXI/DQo+PiANCj4+IFNvdW5kcyBPSywgUkVBRF9C
VUYgaXMgdHJhY2tpbmcgcHJvZ3Jlc3MgdGhyb3VnaCB0aGUgYnVmZmVyLA0KPj4gYW5kIGl0IGFs
cmVhZHkgdXBkYXRlcyAicCIgYXMgYSBzaWRlLWVmZmVjdC4NCj4+IA0KPj4gTWlnaHQgdGhlcmUg
YmUgc29tZSBuZWFyYnkgaW5zdGFuY2VzIG9mIG9wZW4tY29kZWQgInAiIHVwZGF0ZXMNCj4+IHRo
YXQgY291bGQgYWxzbyBiZSByZW1vdmVkLCBmb3Igc2ltaWxhciByZWFzb25zPw0KPj4gDQo+DQo+
UHJvYmFibHksIHllcy4gSSBiZWxpZXZlIHRoYXQgd2UndmUgc2FpZCBiZWZvcmUgKGFuZCBCcnVj
ZSBhZ3JlZWQgYXQNCj50aGUgdGltZSkgdGhhdCB3ZSBzaG91bGQgZ2V0IHJpZCBvZiBSRUFEX0JV
RigpIGluIGtuZnNkIGFzIGl0IHRlbmRzIHRvDQo+b2JmdXNjYXRlIHRoZXNlIGFzc2lnbm1lbnRz
IHRvICdwJy4gRG9lcyBhbnlvbmUgaGF2ZSBhbnkgZnJlZSBjeWNsZXMgdG8NCj53b3JrIG9uIHRo
YXQ/DQo+DQo+LS0gDQo+VHJvbmQgTXlrbGVidXN0DQo+TGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KPnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCj4NCj4N
Cg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldywgDQpJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBh
cyBzb29uIGFzIHBvc3NpYmxlIGJhc2VkIG9uIHlvdXIgY29tbWVudHMuDQoNClRoYW5rcw0KDQoN
Cg==
