Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D0EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A862084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A862084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeJAPjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:39:04 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52901 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:39:03 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w9191lQN003695, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id w9191lQN003695
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 1 Oct 2018 17:01:47 +0800
Received: from RTITMBSVM01.realtek.com.tw ([fe80::f4ca:82cf:5a3:5d7a]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Mon, 1 Oct
 2018 17:01:46 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "joe@perches.com" <joe@perches.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rickveens92@gmail.com" <rickveens92@gmail.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: rtlwifi: Removed unused define and code efuse_re_pg* from wifi.h
Thread-Topic: [PATCH] staging: rtlwifi: Removed unused define and code
 efuse_re_pg* from wifi.h
Thread-Index: AQHUWT1rP1cTRHGZG0aeYjGy34CbQaUJkhyA
Date:   Mon, 1 Oct 2018 09:01:46 +0000
Message-ID: <1538384493.3117.1.camel@realtek.com>
References: <20180930182919.GA19383@localhost.localdomain>
         <7c4f645219bb69f31777367d5edc0830c32467db.camel@perches.com>
         <87in2ml2ts.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87in2ml2ts.fsf@kamboji.qca.qualcomm.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A82CDED060A0347A5BE8B4AADD93953@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTEwLTAxIGF0IDA3OjE1ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBK
b2UgUGVyY2hlcyA8am9lQHBlcmNoZXMuY29tPiB3cml0ZXM6DQo+IA0KPiA+IE9uIFN1biwgMjAx
OC0wOS0zMCBhdCAyMDoyOSArMDIwMCwgUmljayBWZWVucyB3cm90ZToNCj4gPj4gVGhlIGZvbGxv
d2luZzoNCj4gPj7CoMKgYm9vbCBlZnVzZV9yZV9wZ19zZWMxZmxhZzsNCj4gPj7CoMKgdTggZWZ1
c2VfcmVfcGdfZGF0YVs4XTsNCj4gPj4gYXJlIG5vdCByZWZlcmVuY2VkIGFueXdoZXJlIGluIHRo
ZSBydGx3aWZpIGNvZGUuDQo+ID4+wqANCj4gPj4gU2lnbmVkLW9mZi1ieTogUmljayBWZWVucyA8
cmlja3ZlZW5zOTJAZ21haWwuY29tPg0KPiA+PiAtLS0NCj4gPj7CoMKgZHJpdmVycy9zdGFnaW5n
L3J0bHdpZmkvd2lmaS5oIHwgNCAtLS0tDQo+ID4NCj4gPiBQcmVzdW1hYmx5IHRoZSBlcXVpdmFs
ZW50IHVzZXMgaW4NCj4gPsKgCWRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS93
aWZpLmgNCj4gPiBzaG91bGQgYmUgcmVtb3ZlZCBhcyB3ZWxsLg0KPiANCj4gQnV0IGlmIGl0J3Mg
bmVlZGVkLCBqdXN0IGRvIGl0IGluIHNlcGFyYXRlIHBhdGNoIGFzIHRoZSBwYXRjaGVzIGdvIHZp
YQ0KPiBkaWZmZXJlbnQgdHJlZXMuDQo+IA0KDQpJIGNhbiBzZW5kIHRoaXMgcGF0Y2guDQoNCi0t
DQpQSw0K
