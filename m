Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A320C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FF727D45
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FF727D45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934806AbeF3B0x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:26:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5945 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933949AbeF3B0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:26:51 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 39C382D89BF3C;
        Sat, 30 Jun 2018 09:26:49 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.80]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0382.000;
 Sat, 30 Jun 2018 09:26:44 +0800
From:   "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBleHQ0OiBlMmZzcHJv?=
 =?gb2312?B?Z3M6IGZpeCBpbm9kZSBiaXRtYXAgbnVtIG5vdCBpbnRlZ2VyLGluY29tcGF0?=
 =?gb2312?Q?ible_for_ancient_android_devices?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBleHQ0OiBlMmZzcHJvZ3M6IGZp?=
 =?gb2312?B?eCBpbm9kZSBiaXRtYXAgbnVtIG5vdCBpbnRlZ2VyLGluY29tcGF0aWJsZSBm?=
 =?gb2312?Q?or_ancient_android_devices?=
Thread-Index: AQHUDiB7bBM9P+9CgUmyd+rfiNQEzqR03/Qw//+NOgCAANrbsP///3QAgAE0cUCAAEv3AIABNeRA
Date:   Sat, 30 Jun 2018 01:26:43 +0000
Message-ID: <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
 <20180627140937.GA3348@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
 <20180628022900.GA663@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
 <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
 <20180629142612.GE1231@thunk.org>
In-Reply-To: <20180629142612.GE1231@thunk.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.189.158.207]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCBpdCBpcyBjYXVzZWQgYnkgdXNpbmcgMTAyNCBibG9ja3NpemUuDQpJdCBpcyBoaXN0b3Jp
Y2FsIHByb2JsZW0sIGFuZCBJIGhhdmUgdG8gYWRtaXQgdGhhdCdzIG5vdCBnb29kIGlkZWEuICBJ
IGRvbid0IGtub3cgd2h5IHNvbWVib2R5IGNob29zZSBpdCBzb21lIHllYXJzIGJlZm9yZS4gDQpJ
dCBoYXMgYmVlbiBjb3JyZWN0ZWQgdHdvIHllYXJzIGJlZm9yZSBvciBtb3JlIGVhcmx5LiBCdXQg
c29tZSBhbmNpZW50IGRldmljZXMgZXhpc3QuIA0KSXQgaXMgbm90IHVzZXIgZGF0YSwgbm8gbmVl
ZCB0byBkbyBmaWxlLWJhc2VkIGVuY3J5cHRpb24uIEl0IGlzIGEgc21hbGwgcGFydGl0aW9uIGZv
ciBzb21lIHVzZS4NCg0KSG93ZXZlciwgMTAyNCBpcyBsZWdhbCB0aG91Z2ggbm90IGdvb2QsIHNv
bWVib2R5IG1heSB1c2UgaXQuIA0KQW5kIHdlIHNob3VsZCBmaXggaXQuDQoNCg0KUmVnYXJkcywN
Ck1pbmcNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IFRoZW9kb3JlIFkuIFRzJ28gW21h
aWx0bzp0eXRzb0BtaXQuZWR1XSANCreiy83KsbzkOiAyMDE4xOo21MIyOcjVIDIyOjI2DQrK1bz+
yMs6IEdhb21pbmcgKG1pbmcsIGNvbnN1bWVyIEJHKQ0Ks63LzTogbGludXgtZXh0NEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpcWluZ2NoYW8gKHNvcnAp
OyBTaGVuY2hlbiAoaGFycnkpOyBtaWFveGllIChBKTsgeWFuZ2ZlaSAoRCk7IFJlbmxpcGVuZyAo
T1MgZHJpdmVyKQ0K1vfM4jogUmU6ILTwuLQ6ILTwuLQ6ILTwuLQ6IFtQQVRDSF0gZXh0NDogZTJm
c3Byb2dzOiBmaXggaW5vZGUgYml0bWFwIG51bSBub3QgaW50ZWdlcixpbmNvbXBhdGlibGUgZm9y
IGFuY2llbnQgYW5kcm9pZCBkZXZpY2VzDQoNCk9uIEZyaSwgSnVuIDI5LCAyMDE4IGF0IDAyOjA2
OjAzQU0gKzAwMDAsIEdhb21pbmcgKG1pbmcsIGNvbnN1bWVyIEJHKSB3cm90ZToNCj4gV2UgdXNl
IHVzdWFsIGlub2RlIHNpemUsIGl0IGlzIDI1NiBieXRlcy4NCj4gDQo+IFllcywgdGhpcyBjb21t
aXQgaXMgaW4gbXkgcmVwb3NpdG9yeS4NCj4gQnV0IHRoZXJlIGlzIGEgYnVnIGluIHRoaXMgcGF0
Y2guDQo+IA0KPiBMZXQgbWUgc2hvdyB5b3UsDQo+IEhlcmUgaXMgdGhlIGJ1ZzogIiByZXR1cm4g
QUxJR04oaW5vZGVzLCAoaW5mby5ibG9ja19zaXplIC8gaW5mby5pbm9kZV9zaXplKSk7Ig0KPiAN
Cj4gSW4gbXkgcmVwcm9kdWNlLA0KPiBpbmZvLmJsb2NrX3NpemUgPSAxMDI0LCAoaXQgaXMgbGVn
YWwpDQo+IGluZm8uaW5vZGVfc2l6ZSA9MjU2LA0KDQpCdXQgd2h5IGFyZSB5b3UgdXNpbmcgYSBi
bG9jayBzaXplIG9mIDEwMjQ/ICBJdCdzIGxlZ2FsLCBidXQgaW4NCmdlbmVyYWwsIGl0J3MgYSBi
YWQgaWRlYSAob2Z0ZW4gd2lsbCBodXJ0IHBlcmZvcm1hbmNlLCB3aWxsIGltcG9zZQ0KYWRkaXRp
b25hbCBzY2FsYWJpbGl0eSBsaW1pdGF0aW9ucywgZXRjLikuLi4uICBJdCdzIGNlcnRhaW5seSBu
b3QNCnRoZSBkZWZhdWx0Lg0KDQpBIGJsb2NrIHNpemUgb2YgMTAyNCBpcyBhbHNvIGluY29tcGF0
aWJsZSB3aXRoIGZpbGUtYmFzZWQgZW5jcnlwdGlvbg0KKEZCRSksIHdoaWNoIGlzIHJlcXVpcmVk
IGZvciBhIG51bWJlciBvZiBBbmRyb2lkIGZlYXR1cmVzLiAgU3VwcG9ydA0KZm9yIEZCRSBpcyBz
dHJvbmdseSByZXF1aXJlZCwgYW5kIGl0IHdvdWxkbid0IHN1cnByaXNlIG1lIGlmIGl0DQpiZWNv
bWVzIGFuIG1hbmRhdG9yeSByZXF1aXJlbWVudCBhdCBzb21lIHBvaW50IGluIHRoZSBmdXR1cmUu
DQoNCkhvdyBsb25nIGhhdmUgeW91IGJlZW4gdXNpbmcgYSBibG9jayBzaXplIG9mIDEwMjQsIGFu
ZCB3aHk/DQoNCj4gQnV0IGluIHJlYWwgc2NlbmFyaW8sIHdlIHNob3VsZCBhbGlnbiBieSA4LCgg
OCBiaXQgcGVyIGJ5dGVzIGluIGlub2RlIG1hcCkuDQoNClllcywgYW5kIHRoYXQncyB3aHkgbWtl
MmZzIGRvZXMuICBtYWtlX2V4dDRmcyB3YXMgYW4gQW5kcm9pZCBzcGVjaWZpYw0KYWJvbWluYXRp
b24sIHRoYXQgSSd2ZSBiZWVuIHB1c2hpbmcgaGFyZCBmb3IgQW5kcm9pZCB0byByaWQgaXRzZWxm
IG9mLg0KVGhpcyBpcyBub3QgdGhlIG9ubHkgdGhpbmcgaXQncyBnb3R0ZW4gd3JvbmcgaW4gdGhl
IHBhc3QsIGFuZCBJJ3ZlIGhhZA0KdG8gaGVscCBBbmRyb2lkIGRldmVsb3BlcnMgZGVhbCB3aXRo
IGRhdGEgY29ycnVwdGluZyBidWdzIGNhdXNlZCBieQ0KdGhlIGZhY3QgdGhhdCB3YXkgYmFjayB3
aGVuLCBBbmRyb2lkIGhhZCBhIEdQTC1pbi11c2Vyc3BhY2UgYWxsZXJneS4NCg0KCQkJCQkJLSBU
ZWQNCg==
