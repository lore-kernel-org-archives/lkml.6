Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605D0C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0566F219D2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0566F219D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHFIVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:21:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37641 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHFIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:21:42 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w766Dn0n030790, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id w766Dn0n030790
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 6 Aug 2018 14:13:49 +0800
Received: from RTITMBSV07.realtek.com.tw ([fe80::8d2f:f777:70b1:3332]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0399.000; Mon, 6 Aug 2018
 14:13:49 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "colin.king@canonical.com" <colin.king@canonical.com>
Subject: Re: [PATCH] rtlwifi: btcoex: Fix if == else warnings in halbtc8723b2ant.c
Thread-Topic: [PATCH] rtlwifi: btcoex: Fix if == else warnings in
 halbtc8723b2ant.c
Thread-Index: AQHULUHOWcnQsp7hY0uL07P6qL8gq6SyPr+A
Date:   Mon, 6 Aug 2018 06:13:47 +0000
Message-ID: <1533564825.4334.1.camel@realtek.com>
References: <20180806045440.11920-1-yuehaibing@huawei.com>
In-Reply-To: <20180806045440.11920-1-yuehaibing@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C92778AA91302B4DA7A83437C4EAD5A8@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA4LTA2IGF0IDEyOjU0ICswODAwLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBG
aXggZm9sbG93aW5nIGNvY2NpbmVsbGUgd2FybmluZzoNCj4gDQo+IC4vZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9oYWxidGM4NzIzYjJhbnQuYzoyOTUyOjIt
NDogV0FSTklORzogcG9zc2libGUNCj4gY29uZGl0aW9uIHdpdGggbm8gZWZmZWN0IChpZiA9PSBl
bHNlKQ0KPiAuL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9idGNvZXhpc3Qv
aGFsYnRjODcyM2IyYW50LmM6Mjk2MToyLTQ6IFdBUk5JTkc6IHBvc3NpYmxlDQo+IGNvbmRpdGlv
biB3aXRoIG5vIGVmZmVjdCAoaWYgPT0gZWxzZSkNCj4gLi9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bHdpZmkvYnRjb2V4aXN0L2hhbGJ0Yzg3MjNiMmFudC5jOjMwMTE6Mi00OiBXQVJO
SU5HOiBwb3NzaWJsZQ0KPiBjb25kaXRpb24gd2l0aCBubyBlZmZlY3QgKGlmID09IGVsc2UpDQo+
IC4vZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9oYWxidGM4
NzIzYjJhbnQuYzozMDIwOjItNDogV0FSTklORzogcG9zc2libGUNCj4gY29uZGl0aW9uIHdpdGgg
bm8gZWZmZWN0IChpZiA9PSBlbHNlKQ0KPiAuL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsd2lmaS9idGNvZXhpc3QvaGFsYnRjODcyM2IyYW50LmM6MzQzOToyLTQ6IFdBUk5JTkc6IHBv
c3NpYmxlDQo+IGNvbmRpdGlvbiB3aXRoIG5vIGVmZmVjdCAoaWYgPT0gZWxzZSkNCj4gLi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvYnRjb2V4aXN0L2hhbGJ0Yzg3MjNiMmFu
dC5jOjM0NDg6Mi00OiBXQVJOSU5HOiBwb3NzaWJsZQ0KPiBjb25kaXRpb24gd2l0aCBubyBlZmZl
Y3QgKGlmID09IGVsc2UpDQo+IC4vZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZp
L2J0Y29leGlzdC9oYWxidGM4NzIzYjJhbnQuYzozMzM5OjItNDogV0FSTklORzogcG9zc2libGUN
Cj4gY29uZGl0aW9uIHdpdGggbm8gZWZmZWN0IChpZiA9PSBlbHNlKQ0KPiAuL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFsYnRjODcyM2IyYW50LmM6MzM0
ODoyLTQ6IFdBUk5JTkc6IHBvc3NpYmxlDQo+IGNvbmRpdGlvbiB3aXRoIG5vIGVmZmVjdCAoaWYg
PT0gZWxzZSkNCj4gLi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvYnRjb2V4
aXN0L2hhbGJ0Yzg3MjNiMmFudC5jOjMwNzQ6Mi00OiBXQVJOSU5HOiBwb3NzaWJsZQ0KPiBjb25k
aXRpb24gd2l0aCBubyBlZmZlY3QgKGlmID09IGVsc2UpDQo+IC4vZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9oYWxidGM4NzIzYjJhbnQuYzozMDgzOjItNDog
V0FSTklORzogcG9zc2libGUNCj4gY29uZGl0aW9uIHdpdGggbm8gZWZmZWN0IChpZiA9PSBlbHNl
KQ0KPiAuL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFs
YnRjODcyM2IyYW50LmM6MzE5MjoyLTQ6IFdBUk5JTkc6IHBvc3NpYmxlDQo+IGNvbmRpdGlvbiB3
aXRoIG5vIGVmZmVjdCAoaWYgPT0gZWxzZSkNCj4gLi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0bHdpZmkvYnRjb2V4aXN0L2hhbGJ0Yzg3MjNiMmFudC5jOjMyMDE6Mi00OiBXQVJOSU5H
OiBwb3NzaWJsZQ0KPiBjb25kaXRpb24gd2l0aCBubyBlZmZlY3QgKGlmID09IGVsc2UpDQo+IC4v
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9oYWxidGM4NzIz
YjJhbnQuYzozMjY3OjItNDogV0FSTklORzogcG9zc2libGUNCj4gY29uZGl0aW9uIHdpdGggbm8g
ZWZmZWN0IChpZiA9PSBlbHNlKQ0KPiAuL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
d2lmaS9idGNvZXhpc3QvaGFsYnRjODcyM2IyYW50LmM6MzI3NjoyLTQ6IFdBUk5JTkc6IHBvc3Np
YmxlDQo+IGNvbmRpdGlvbiB3aXRoIG5vIGVmZmVjdCAoaWYgPT0gZWxzZSkNCj4gLi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvYnRjb2V4aXN0L2hhbGJ0Yzg3MjNiMmFudC5j
OjMxMjQ6Mi00OiBXQVJOSU5HOiBwb3NzaWJsZQ0KPiBjb25kaXRpb24gd2l0aCBubyBlZmZlY3Qg
KGlmID09IGVsc2UpDQo+IC4vZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0
Y29leGlzdC9oYWxidGM4NzIzYjJhbnQuYzozMTMzOjItNDogV0FSTklORzogcG9zc2libGUNCj4g
Y29uZGl0aW9uIHdpdGggbm8gZWZmZWN0IChpZiA9PSBlbHNlKQ0KPiAuL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFsYnRjODcyM2IyYW50LmM6MjgyMToy
LTQ6IFdBUk5JTkc6IHBvc3NpYmxlDQo+IGNvbmRpdGlvbiB3aXRoIG5vIGVmZmVjdCAoaWYgPT0g
ZWxzZSkNCj4gLi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvYnRjb2V4aXN0
L2hhbGJ0Yzg3MjNiMmFudC5jOjI4MzA6Mi00OiBXQVJOSU5HOiBwb3NzaWJsZQ0KPiBjb25kaXRp
b24gd2l0aCBubyBlZmZlY3QgKGlmID09IGVsc2UpDQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8
eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCg==
