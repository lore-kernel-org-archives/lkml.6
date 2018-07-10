Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85CB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85CB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micron.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeGJLk4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:40:56 -0400
Received: from mailout.micron.com ([137.201.242.129]:22039 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeGJLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:40:55 -0400
Received: from mail.micron.com (bowex36c.micron.com [137.201.84.132])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id w6ABeFEV025431;
        Tue, 10 Jul 2018 05:40:16 -0600
Received: from SIWEX4B.sing.micron.com (10.160.29.66) by bowex36c.micron.com
 (137.201.84.132) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 10 Jul
 2018 05:40:15 -0600
Received: from SIWEX5A.sing.micron.com (10.160.29.59) by
 SIWEX4B.sing.micron.com (10.160.29.66) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Tue, 10 Jul 2018 19:40:08 +0800
Received: from SIWEX5A.sing.micron.com ([fe80::a9c5:8ccb:fd84:268d]) by
 SIWEX5A.sing.micron.com ([fe80::a9c5:8ccb:fd84:268d%25]) with mapi id
 15.00.1347.000; Tue, 10 Jul 2018 19:40:08 +0800
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Topic: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Index: AdQYQr3ufyYGN/FbRHqtIbELl93nLg==
Date:   Tue, 10 Jul 2018 11:40:08 +0000
Message-ID: <60a09008ea18424eb4005839554da858@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23958.005
X-TM-AS-Result: No--8.379900-0.000000-31
X-TM-AS-MatchedID: 150567-139010-710970-780022-702807-703454-700019-701837-7
        00838-705468-705461-708712-780052-702020-703747-703712-105700-700726-706564
        -701339-700042-706023-148004-148046-148133-148980-42000-42003-29961-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksICBCb3Jpcw0KPj4NCj4+IE9rYXksIEkgdGhpbmsgd2UgYWxyZWFkeSBoYWQgdGhpcyBkaXNj
dXNzaW9uLCBidXQgSSdtIGFza2luZyBpdCBhZ2Fpbi4NCj4+IFdoYXQgYXJlIHRoZSBwb3NzaWJs
ZSB2YWx1ZXMgZm9yIHRoYXQgZmllbGQgYW5kIHdoYXQgZG8gdGhleSBtZWFuPw0KPg0KPlN0aWxs
LCBpdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0ICJJbnRlcm5hbCBFQ0MgbGV2ZWwiIG1lYW5zLiBJ
dCBzZWVtcyB0aGF0IE5BTkQNCj5jaGlwcyBoYXZpbmcgb24tZGllIEVDQyBoYXZlIHRoaXMgZmll
bGQgc2V0IHRvIDEwYiAoMHgyKSwgMDBiIHNlZW1zIHRvIGJlDQo+cmVzZXJ2ZWQgZm9yICJubyBv
bi1kaWUgRUNDIiwgYnV0IHdoYXQgYXJlIDAxYiBhbmQgMTFiIHJlc2VydmVkIGZvcj8NCj4NCg0K
VGhhdCBwb3NpdGlvbiBpZGVudGlmaWVzIHRoZSBwYXJ0IGFzIGhhdmluZyBJbnRlcm5hbCBFQ0Mg
Y2FwYWJpbGl0eS4gIA0KVGhlIDAxYiBhbmQgMTFiIGFyZSByZXNlcnZlZCBmb3IgZnV0dXJlIGRl
ZmluaXRpb24uICBCaXQgNyBvZiBSRUFEIElEIEJ5dGUgNCBpZGVudGlmaWVzIHRoZQ0KZGV2aWNl
IGFzIGFuIEVDQyBPRkYgMHgwIG9yIEVDQyBPTiAweDEuDQoNCj4+IEFsc28sIGlzIGl0IGV2ZW4g
dXNlZCB0byBlbmNvZGUgdGhlIGZhY3QgdGhhdCB0aGUgTkFORCBoYXMgb24tZGllIEVDQw0KPj4g
b24gYWxsIHlvdXIgTkFORHM/IFdlIGFscmVhZHkgaGFkIHRoZSBwcm9ibGVtIG9mIGluY29tcGF0
aWJsZSBJRA0KPj4gc2NoZW1lcywgc28gSSB3b3VsZG4ndCBiZSBzdXJwcmlzZWQgaWYgdGhhdCB3
YXMgdGhlIGNhc2UgaGVyZSwgaGVuY2UNCj4+IG15IGluaXRpYWwgc3VnZ2VzdGlvbiB0byBiYXNl
IHRoZSBkZXRlY3Rpb24gb24gdGhlIG1vZGVsIG5hbWUuDQo+DQo+SSdkIHJlYWxseSBuZWVkIHRv
IGhhdmUgYW4gYW5zd2VyIG9uIHRoYXQgb25lIHRvIHRha2UgYSBkZWNpc2lvbi4gQWxzbywgSQ0K
PmNvdWxkbid0IGZpbmQgYSBkYXRhc2hlZXQgZm9yIGFuIElUICh3aXRob3V0IEUpIHZlcnNpb24g
b2YgdGhlDQo+TVQyOUYxRzA4QUJBRkFXUCBwYXJ0LiBEb2VzIGl0IGV4aXN0LCBvciBjYW4gd2Ug
YXNzdW1lDQo+TVQyOUYxRzA4QUJBRkFXUCBjaGlwcyBhbHdheXMgY29tZSB3aXRoIGZvcmNpYmx5
IGVuYWJsZWQgb24tZGllIEVDQz8NCg0KTVQyOUYxRzA4QUJBRkFXUCBjb21lcyBpbiBFQ0MgT04g
b25seS4gIFdlIGRpZG7igJl0IGRldmVsb3AgYQ0KTVQyOUYxRzA4QUJBRkFXUCBFQ0MgT0ZGIHZl
cnNpb24uICBCaXQgNyBvZiBSRUFEIElEIEJ5dGUgNCBpZGVudGlmaWVzIHRoZQ0KZGV2aWNlIGFz
IGFuIEVDQyBPRkYgMHgwIG9yIEVDQyBPTiAweDEuDQoNCg==
