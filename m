Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2F620883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2F620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micron.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeGJMZR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:25:17 -0400
Received: from mailout.micron.com ([137.201.242.129]:14080 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGJMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:25:16 -0400
Received: from mail.micron.com (bowex17a.micron.com [137.201.21.209])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id w6ACObkw014727;
        Tue, 10 Jul 2018 06:24:37 -0600
Received: from SIWEX4H.sing.micron.com (10.160.29.19) by bowex17a.micron.com
 (137.201.21.209) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 10 Jul
 2018 06:24:35 -0600
Received: from SIWEX5A.sing.micron.com (10.160.29.59) by
 SIWEX4H.sing.micron.com (10.160.29.19) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Tue, 10 Jul 2018 20:24:28 +0800
Received: from SIWEX5A.sing.micron.com ([fe80::a9c5:8ccb:fd84:268d]) by
 SIWEX5A.sing.micron.com ([fe80::a9c5:8ccb:fd84:268d%25]) with mapi id
 15.00.1347.000; Tue, 10 Jul 2018 20:24:28 +0800
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
Thread-Index: AdQYSO8EIJ6yqPwQTR61MGVlKfRbjg==
Date:   Tue, 10 Jul 2018 12:24:28 +0000
Message-ID: <1df9a5d95c44408ab42b34948f956351@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23958.005
X-TM-AS-Result: No--7.222800-0.000000-31
X-TM-AS-MatchedID: 150567-139010-184200-187067-700038-703788-780014-700648-7
        80030-703747-702020-106660-703267-702161-700476-700839-703029-106230-706817
        -139704-700047-701702-148004-148046-148133-148980-20020-41000-42000-42003-2
        9961-63
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

SGksIEJvcmlzDQo+Pg0KPg0KPk9rYXkuIENhbiB5b3UgaGF2ZSBhIGxvb2sgYXQgdGhlIHBhdGNo
ZXMgSSBzZW50IGFuIGxldCBtZSBrbm93IGlmIEkgZG8gdGhlDQo+cmlnaHQgdGhpbmc/DQoNCkkg
YW0gZG9pbmcgdG9kYXkuIEFuZCB3aWxsIGJhY2sgdG8geW91IEkgY291bGQgZ2l2ZSBzb21lIGFk
dmljZS4NCg0KDQpJIGVuY291bnRlciBvbmUgcXVlc3Rpb24gYXMgYmVsb3cgd2hlbiBJIHJlcGx5
IHRoZSBlbWFpbCBvZiBsaW51eC1tdGQsIGJ1dCBJZiBJIHJlcGx5IG90aGVyIG1haWwgbGlzdCAN
ClN1Y2ggYXMgc2NzaSBtYWlsIGxpc3QsIG1tYyBtYWlsIGxpc3QsIG5vIGFueSBwcm9ibGVtLiBE
byB5b3Uga25vdyB3aHk/IA0KDQoNCllvdXIgbWFpbCB0byAnbGludXgtbXRkJyB3aXRoIHRoZSBz
dWJqZWN0DQoNCiAgICBSZTogW1BBVENIIHY2IDAvNl0gbXRkOiByYXduYW5kOiBzdXBwb3J0IE1U
MjlGMUcwOEFCQUZBV1AtSVRFOkYNCg0KSXMgYmVpbmcgaGVsZCB1bnRpbCB0aGUgbGlzdCBtb2Rl
cmF0b3IgY2FuIHJldmlldyBpdCBmb3IgYXBwcm92YWwuDQoNClRoZSByZWFzb24gaXQgaXMgYmVp
bmcgaGVsZDoNCg0KICAgIE1lc3NhZ2UgaGFzIGEgc3VzcGljaW91cyBoZWFkZXINCg0KRWl0aGVy
IHRoZSBtZXNzYWdlIHdpbGwgZ2V0IHBvc3RlZCB0byB0aGUgbGlzdCwgb3IgeW91IHdpbGwgcmVj
ZWl2ZSBub3RpZmljYXRpb24gb2YgdGhlIG1vZGVyYXRvcidzIGRlY2lzaW9uLiAgSWYgeW91IHdv
dWxkIGxpa2UgdG8gY2FuY2VsIHRoaXMgcG9zdGluZywgcGxlYXNlIHZpc2l0IHRoZSBmb2xsb3dp
bmcgVVJMOg0KDQogICAgaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9jb25maXJt
L2xpbnV4LW10ZC8xYTI4ZjlhNDA2OWEwYmJjYWRmYjZiMmExNzBjMDFkZDhiOTYyZDBhDQoNCg0K
Ly9iZWFuaHVvDQo=
