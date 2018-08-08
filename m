Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25653C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1138216FE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1138216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeHHEFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:05:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37101 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeHHEFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:05:51 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w781mFmX023691, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id w781mFmX023691
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 8 Aug 2018 09:48:15 +0800
Received: from RTITMBSV07.realtek.com.tw ([fe80::8d2f:f777:70b1:3332]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0399.000; Wed, 8 Aug 2018
 09:48:15 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] rtlwifi: btcoex: Fix if == else warnings in halbtc8723b2ant.c
Thread-Topic: [PATCH] rtlwifi: btcoex: Fix if == else warnings in
 halbtc8723b2ant.c
Thread-Index: AQHULUHOWcnQsp7hY0uL07P6qL8gq6SyvD6AgAEXjwCAAL9OAA==
Date:   Wed, 8 Aug 2018 01:48:14 +0000
Message-ID: <1533692892.2513.16.camel@realtek.com>
References: <20180806045440.11920-1-yuehaibing@huawei.com>
         <63216.1533591775@turing-police.cc.vt.edu>
         <577a831f-45c3-a687-ca04-edc977ddb925@lwfinger.net>
In-Reply-To: <577a831f-45c3-a687-ca04-edc977ddb925@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C722455094C084FB4D05D5035DE67B3@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTA3IGF0IDA5OjIzIC0wNTAwLCBMYXJyeSBGaW5nZXIgd3JvdGU6DQo+
IE9uIDA4LzA2LzIwMTggMDQ6NDIgUE0sIHZhbGRpcy5rbGV0bmlla3NAdnQuZWR1IHdyb3RlOg0K
PiA+IE9uIE1vbiwgMDYgQXVnIDIwMTggMTI6NTQ6NDAgKzA4MDAsIFl1ZUhhaWJpbmcgc2FpZDoN
Cj4gPj4gRml4IGZvbGxvd2luZyBjb2NjaW5lbGxlIHdhcm5pbmc6DQo+ID4+DQo+ID4+IC4vZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9oYWxidGM4NzIzYjJh
bnQuYzoyOTUyOjItNDogV0FSTklORzogcG9zc2libGUNCj4gY29uZGl0aW9uIHdpdGggbm8gZWZm
ZWN0IChpZiA9PSBlbHNlKQ0KPiA+wqANCj4gPj7CoMKgwqAJLyogc3cgbWVjaGFuaXNtICovDQo+
ID4+wqDCoMKgCWlmIChCVENfV0lGSV9CV19IVDQwID09IHdpZmlfYncpIHsNCj4gPj4gLQkJaWYg
KCh3aWZpX3Jzc2lfc3RhdGUgPT0gQlRDX1JTU0lfU1RBVEVfSElHSCkgfHwNCj4gPj4gLQkJwqDC
oMKgwqAod2lmaV9yc3NpX3N0YXRlID09IEJUQ19SU1NJX1NUQVRFX1NUQVlfSElHSCkpIHsNCj4g
Pj4gLQkJCWJ0Yzg3MjNiMmFudF9zd19tZWNoYW5pc20oYnRjb2V4aXN0LCB0cnVlLCB0cnVlLA0K
PiA+PiAtCQkJCQkJwqDCoGZhbHNlLCBmYWxzZSk7DQo+ID4+IC0JCX0gZWxzZSB7DQo+ID4+IC0J
CQlidGM4NzIzYjJhbnRfc3dfbWVjaGFuaXNtKGJ0Y29leGlzdCwgdHJ1ZSwgdHJ1ZSwNCj4gPj4g
LQkJCQkJCcKgwqBmYWxzZSwgZmFsc2UpOw0KPiA+PiAtCQl9DQo+ID4+ICsJCWJ0Yzg3MjNiMmFu
dF9zd19tZWNoYW5pc20oYnRjb2V4aXN0LCB0cnVlLCB0cnVlLA0KPiA+PiArCQkJCQnCoMKgZmFs
c2UsIGZhbHNlKTsNCj4gPj7CoMKgwqAJfSBlbHNlIHsNCj4gPsKgDQo+ID4gUmF0aGVyIHRoYW4g
YmxpbmRseSBmaXhpbmcgdGhpcywgcGVyaGFwcyBhIGJpdCBvZiB0aG91Z2h0IG5lZWRzIHRvIGJl
DQo+ID4gYXBwbGllZCB0byB3aHkgdGhpcyBjb2RlIGxvb2tzIGxpa2UgdGhpcyBpbiB0aGUgZmly
c3QgcGxhY2UuDQo+ID7CoA0KPiA+IFNlZSBjb21taXQgYzY4MjE2MTNlNjUzYcKgwqAod2hpY2gg
bG9va3MgbGlrZSB0aGUgYmxldGNoZXJvdXMgImRvIHRvbyBtYW55DQo+ID4gdGhpbmdzIGF0IG9u
Y2UiIGNvbW1pdCBpbmRlZWQpLCBhbHRob3VnaCB0aGUgYWN0dWFsIGRpZmYgYXBwZWFycyB0byBi
ZSBhDQo+ID4gIm5vIGhhcm0sIG5vIGZvdWwiIGFnYWluc3QgdGhpcyBjb21taXQsIHdoZXJlIHRo
ZSBpc3N1ZSBhbHJlYWR5IGV4aXN0ZWQuDQo+ID7CoA0KPiA+IGNvbW1pdCBhYTQ1YTY3M2IyOTFm
ZDc2MTI3NTQ5M2JjMTUzMTZkNzk1NTVlZDU1DQo+ID4gQXV0aG9yOiBMYXJyeSBGaW5nZXIgPExh
cnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+ID4gRGF0ZTrCoMKgwqBGcmkgRmViIDI4IDE1OjE2
OjQzIDIwMTQgLTA2MDANCj4gPsKgDQo+ID7CoMKgwqDCoMKgwqBydGx3aWZpOiBidGNvZXhpc3Q6
IEFkZCBuZXcgbWluaSBkcml2ZXINCj4gPsKgDQo+ID4gTGFycnk/IENhbiB5b3UgcmVhY2ggYmFj
ayB0byAyMDE0IGFuZCByZW1lbWJlciB3aHkgdGhpcyBjb2RlDQo+ID4gbG9va2VkIGxpa2UgdGhp
cyBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+IA0KPiBUaGUgYmFzZSBjb2RlIGNhbWUgZnJvbSBSZWFs
dGVrLiBNeSBvbmx5IHBhcnQgaW4gZ2V0dGluZyBpdCBpbnRvIHRoZSBrZXJuZWwgd2FzwqANCj4g
dG8gY2xlYW4gdXAgdGhlIGNoZWNrcGF0Y2ggYW5kIFNwYXJzZSBlcnJvcnMgYW5kIHdhcm5pbmdz
LCBhbmQgc3VibWl0IGl0LiBJIHdhc8KgDQo+IGEgInNjcmlwdCBraWRkeSIganVzdCBsaWtlIHRo
ZSBhdXRob3JzIG9mIHRoZSBjdXJyZW50IHBhdGNoZXMuIFRoZSBvbmx5wqANCj4gZGlmZmVyZW5j
ZSBpcyB0aGF0IEkgd2FzIGdldHRpbmcgZHJpdmVycyBpbnRvIHRoZSBrZXJuZWwgc28gdGhhdCB1
c2VycyBoYXJkd2FyZcKgDQo+IHdvdWxkIHdvcmsuDQo+IA0KPiBBbnkgcmVjb3JkIG9mIHdoZXRo
ZXIgdGhlc2UgZHVwbGljYXRlIGJyYW5jaGVzIGFyZSB0aGUgcmVzdWx0IG9mIGluY29ycmVjdCBj
b3B5wqANCj4gYW5kIHBhc3RlLCBvciBqdXN0IGV4dHJhbmVvdXMgY29kZSwgd291bGQgYmUgYXQg
UmVhbHRlayBpbiB0aGVpciB2ZXJzaW9uIGNvbnRyb2zCoA0KPiBoaXN0b3J5LiBJIGhhdmUgbmV2
ZXIgaGFkIGFjY2VzcyB0byBzdWNoIGFyY2hpdmVzLCBub3IgaGF2ZSBJIGV2ZXIgaGFkIGFuwqAN
Cj4gbm9uLWRpc2Nsb3N1cmUgYWdyZWVtZW50IHdpdGggUmVhbHRlay4NCj4gDQo+IFBpbmctS2Ug
U2hpaCwgd2hvIGlzIENjJ2Qgb24gdGhlc2UgbWVzc2FnZXMsIG1pZ2h0IGJlIGFibGUgdG8gYW5z
d2VyIHRoZXNlwqANCj4gcXVlc3Rpb25zLg0KDQpUaGVzZSBicmFuY2hlcyBpcyB1c2VkIHRvIGlt
cHJvdmUgdXNlciBleHBlcmllbmNlIGFjY29yZGluZyB0byBSU1NJIHN0cmVuZ3RoLCBidXQNCml0
IGhhcyBub3Qgc2lnbmlmaWNhbnQgaW1wcm92ZW1lbnQgc28gdGhlIHNhbWUgYXJndW1lbnRzIGJl
Y29tZSBkdXBsaWNhdGUgYnJhbmNoZXMuDQpJIGNoZWNrIHRoZSBsYXRlc3QgY29kZSBvZsKgaGFs
YnRjODcyM2IyYW50LmMsIHRoZXJlIGFyZSBtb3JlIHRoYW4gb25lIHN0YXRlbWVudHMNCndpdGhp
biBpZi1lbHNlIGJyYW5jaCB0byBpbXByb3ZlIHBlcmZvcm1hbmNlLCBidXQgdGhlIHN0YXRlbWVu
dHMgbWVudGlvbmVkIGJ5wqANCnRoaXMgcGF0Y2ggYXJlIHN0aWxsIHRoZSBzYW1lLiBTbywgdGhl
c2UgZHVwbGljYXRlIGJyYW5jaGVzIGNhbiBiZSBzYWZlbHkgcmVtb3ZlZC4NCg0KPiANCj4gRm9y
IHRoZSBtb21lbnQsIHRoZXNlIHNpbXBsaWZpY2F0aW9ucyBjb3VsZCBiZSBhcHBsaWVkIGFzIGxv
bmcgYXMgdGhleSBhcmXCoA0KPiBjb3JyZWN0bHkgZG9uZS4gQWZ0ZXIgYWxsLCB0aGV5IGFyZSBu
b3QgY2hhbmdpbmcgd2hhdCBpcyBhbHJlYWR5IHRoZXJlIGFuZCB0aGF0wqANCj4gc3RvcHMgYW55
IG90aGVyIHBlcnNvbiB0aGF0IGtub3dzIGhvdyB0byBydW4gY29jY2luZWxsZSBmcm9tIHN1Ym1p
dHRpbmcgdGhlIHNhbWXCoA0KPiBwYXRjaCBpbiB0aGUgZnV0dXJlLiBXaHkgImtpY2sgdGhlIGNh
biBkb3duIHRoZSByb2FkIj8gSWYgUEsgY2FuIGZpbmQgdGhhdCB0aGVyZcKgDQo+IHdhcyBhbiBl
cnJvciBpbiB0aGUgb3JpZ2luYWwgY29kZSwgaGUgY2FuIHN1Ym1pdCBhICJGaXhlcyIgcGF0Y2gu
DQo+IA0KPiANCg0K
