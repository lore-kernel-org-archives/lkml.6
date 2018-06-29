Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1407C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3156B24D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3156B24D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967524AbeF2CGV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:06:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965776AbeF2CGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:06:20 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 61B235C3628CD;
        Fri, 29 Jun 2018 10:06:14 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.382.0; Fri, 29 Jun 2018 10:06:15 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.80]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0382.000;
 Fri, 29 Jun 2018 10:06:04 +0800
From:   "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBleHQ0OiBlMmZzcHJvZ3M6IGZp?=
 =?gb2312?B?eCBpbm9kZSBiaXRtYXAgbnVtIG5vdCBpbnRlZ2VyLGluY29tcGF0aWJsZSBm?=
 =?gb2312?Q?or_ancient_android_devices?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIXSBleHQ0OiBlMmZzcHJvZ3M6IGZpeCBpbm9k?=
 =?gb2312?B?ZSBiaXRtYXAgbnVtIG5vdCBpbnRlZ2VyLGluY29tcGF0aWJsZSBmb3IgYW5j?=
 =?gb2312?Q?ient_android_devices?=
Thread-Index: AQHUDiB7bBM9P+9CgUmyd+rfiNQEzqR03/Qw//+NOgCAANrbsP///3QAgAE0cUA=
Date:   Fri, 29 Jun 2018 02:06:03 +0000
Message-ID: <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
 <20180627140937.GA3348@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
 <20180628022900.GA663@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
 <20180628153022.GA8521@thunk.org>
In-Reply-To: <20180628153022.GA8521@thunk.org>
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

V2UgdXNlIHVzdWFsIGlub2RlIHNpemUsIGl0IGlzIDI1NiBieXRlcy4NCg0KWWVzLCB0aGlzIGNv
bW1pdCBpcyBpbiBteSByZXBvc2l0b3J5Lg0KQnV0IHRoZXJlIGlzIGEgYnVnIGluIHRoaXMgcGF0
Y2guDQoNCkxldCBtZSBzaG93IHlvdSwNCkhlcmUgaXMgdGhlIGJ1ZzogIiByZXR1cm4gQUxJR04o
aW5vZGVzLCAoaW5mby5ibG9ja19zaXplIC8gaW5mby5pbm9kZV9zaXplKSk7Ig0KDQpJbiBteSBy
ZXByb2R1Y2UsDQppbmZvLmJsb2NrX3NpemUgPSAxMDI0LCAoaXQgaXMgbGVnYWwpDQppbmZvLmlu
b2RlX3NpemUgPTI1NiwNCg0KdGhlIGNvZGUgb25seSBBTElHTiBCWSA0Lg0KDQpCdXQgaW4gcmVh
bCBzY2VuYXJpbywgd2Ugc2hvdWxkIGFsaWduIGJ5IDgsKCA4IGJpdCBwZXIgYnl0ZXMgaW4gaW5v
ZGUgbWFwKS4NCg0KU28gd2UgZ290IElub2RlcyBwZXIgZ3JvdXA6IDE3MDggLCB3aGljaCBpcyBp
bGxlZ2FsLg0KDQpMaWtlIGJlbG93LA0KDQouL2hvc3QvbGludXgteDg2L2Jpbi9tYWtlX2V4dDRm
cyAgLXMgLWwgMjBNIC1iIDEwMjQgZ2FvbWluZy5pbWcgDQpDcmVhdGluZyBmaWxlc3lzdGVtIHdp
dGggcGFyYW1ldGVyczoNCiAgICBTaXplOiAyMDk3MTUyMA0KICAgIEJsb2NrIHNpemU6IDEwMjQN
CiAgICBCbG9ja3MgcGVyIGdyb3VwOiA4MTkyDQogICAgSW5vZGVzIHBlciBncm91cDogMTcwOA0K
ICAgIElub2RlIHNpemU6IDI1Ng0KICAgIEpvdXJuYWwgYmxvY2tzOiAxMDI0DQogICAgTGFiZWw6
DQogICAgQmxvY2tzOiAyMDQ4MA0KICAgIEJsb2NrIGdyb3VwczogMw0KICAgIFJlc2VydmVkIGJs
b2NrIGdyb3VwIHNpemU6IDk1DQpDcmVhdGVkIGZpbGVzeXN0ZW0gd2l0aCAxMS81MTI0IGlub2Rl
cyBhbmQgMjUwOS8yMDQ4MCBibG9ja3MNCg0KVGhpcyBidWcgZXhpc3RzIHZlcnkgdmVyeSBsb25n
IHRpbWUgdGlsbCBub3cuDQoNCg0KUmVnYXJkcywNCk1pbmcNCg0KLS0tLS3Tyrz+1K28/i0tLS0t
DQq3orz+yMs6IFRoZW9kb3JlIFkuIFRzJ28gW21haWx0bzp0eXRzb0BtaXQuZWR1XSANCreiy83K
sbzkOiAyMDE4xOo21MIyOMjVIDIzOjMwDQrK1bz+yMs6IEdhb21pbmcgKG1pbmcsIGNvbnN1bWVy
IEJHKQ0Ks63LzTogbGludXgtZXh0NEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IExpcWluZ2NoYW8gKHNvcnApOyBTaGVuY2hlbiAoaGFycnkpOyBtaWFveGll
IChBKTsgeWFuZ2ZlaSAoRCk7IFJlbmxpcGVuZyAoT1MgZHJpdmVyKQ0K1vfM4jogUmU6ILTwuLQ6
ILTwuLQ6IFtQQVRDSF0gZXh0NDogZTJmc3Byb2dzOiBmaXggaW5vZGUgYml0bWFwIG51bSBub3Qg
aW50ZWdlcixpbmNvbXBhdGlibGUgZm9yIGFuY2llbnQgYW5kcm9pZCBkZXZpY2VzDQoNCk9uIFRo
dSwgSnVuIDI4LCAyMDE4IGF0IDA3OjU2OjU5QU0gKzAwMDAsIEdhb21pbmcgKG1pbmcsIGNvbnN1
bWVyIEJHKSB3cm90ZToNCj4gWW91IHNlZSwgSW5vZGVzIHBlciBncm91cCBpcyAxNzA4LHdoaWNo
IGlzIGlsbGVnYWwgYXMgeW91IHNhaWQuDQo+IA0KPiBTbywgdGhlIHByb2JsZW0gZXhpc3RzIGEg
bG9uZyB0aW1lIHVudGlsIEp1biAyMXRoIDIwMTguDQo+IA0KPiBZb3UgY29tcGxhaW5lZCB0aGUg
cHJvYmxlbSBpbiAyMDExLCB0aGV5IGRvIG5vdCBmaXggaXQgdGlsbCAyMDE4Lg0KPiBKdXN0IGFz
DQo+IEkgY29tcGxhaW5lZCwgZml4IGl0LCAgYW5kIHlvdSBkbyBub3QgYWNjZXB0IGl0LiBeX14N
Cg0KSGVyZSdzIHRoZSBjb21taXQuICAoTm90ZSB0aGUgZGF0ZS4pICAgRG8geW91IHNlZSBpdCBp
biB5b3VyIHJlcG9zaXRvcnk/DQoNCk9yIGFyZSB5b3UgdXNpbmcgYW4gdW51c3VhbCBpbm9kZSBz
aXplPyAgKGUuZy4sIG5vdCAyNTYgYnl0ZXMsIG9yIDE2DQppbm9kZXMgcGVyIGJsb2NrKS4NCg0K
DQogICAgICAgCSAgIAkgICAgICAgCSAgICAgICAJICAgICAJICAtIFRlZA0KDQpjb21taXQgMDZj
MzVmOTM1YTdhZGFkY2ViOWVlMzI2YjMyMzFmOTUyZjZhZDIwMw0KTWVyZ2U6IDQ4MGEzYjEgOTZj
YzU0YQ0KQXV0aG9yOiBDb2xpbiBDcm9zcyA8Y2Nyb3NzQGFuZHJvaWQuY29tPg0KRGF0ZTogICBT
YXQgQXByIDMwIDE5OjA4OjA5IDIwMTEgLTA3MDANCg0KICAgIE1lcmdlICJNYWtlIGlub2RlcyBw
ZXIgZ3JvdXAgYSBtdWx0aXBsZSBvZiBpbm9kZXMgcGVyIGJsb2NrIg0KDQpkaWZmIC0tY2MgZXh0
NF91dGlscy9tYWtlX2V4dDRmcy5jDQppbmRleCBjOWZkOTkyLGUzN2Q2MTcuLjIyYzk0MjQNCi0t
LSBhL2V4dDRfdXRpbHMvbWFrZV9leHQ0ZnMuYw0KKysrIGIvZXh0NF91dGlscy9tYWtlX2V4dDRm
cy5jDQpAQEAgLTIxNCwyNiAtMjE1LDEwICsyMTQsMjcgQEBAIHN0YXRpYyB1MzIgY29tcHV0ZV9p
bm9kZXNfcGVyX2dyb3VwKA0KICB7DQogIAl1MzIgYmxvY2tzID0gRElWX1JPVU5EX1VQKGluZm8u
bGVuLCBpbmZvLmJsb2NrX3NpemUpOw0KICAJdTMyIGJsb2NrX2dyb3VwcyA9IERJVl9ST1VORF9V
UChibG9ja3MsIGluZm8uYmxvY2tzX3Blcl9ncm91cCk7DQotIAlyZXR1cm4gRElWX1JPVU5EX1VQ
KGluZm8uaW5vZGVzLCBibG9ja19ncm91cHMpOw0KKyAJdTMyIGlub2RlcyA9IERJVl9ST1VORF9V
UChpbmZvLmlub2RlcywgYmxvY2tfZ3JvdXBzKTsNCisgCXJldHVybiBBTElHTihpbm9kZXMsIChp
bmZvLmJsb2NrX3NpemUgLyBpbmZvLmlub2RlX3NpemUpKTsNCiAgfQ0KICANCiArc3RhdGljIHUz
MiBjb21wdXRlX2JnX2Rlc2NfcmVzZXJ2ZV9ibG9ja3MoKQ0KICt7DQogKwl1MzIgYmxvY2tzID0g
RElWX1JPVU5EX1VQKGluZm8ubGVuLCBpbmZvLmJsb2NrX3NpemUpOw0KICsJdTMyIGJsb2NrX2dy
b3VwcyA9IERJVl9ST1VORF9VUChibG9ja3MsIGluZm8uYmxvY2tzX3Blcl9ncm91cCk7DQogKwl1
MzIgYmdfZGVzY19ibG9ja3MgPSBESVZfUk9VTkRfVVAoYmxvY2tfZ3JvdXBzICogc2l6ZW9mKHN0
cnVjdCBleHQyX2dyb3VwX2Rlc2MpLA0KICsJCQlpbmZvLmJsb2NrX3NpemUpOw0KICsNCiArCXUz
MiBiZ19kZXNjX3Jlc2VydmVfYmxvY2tzID0NCiArCQkJRElWX1JPVU5EX1VQKGJsb2NrX2dyb3Vw
cyAqIDEwMjQgKiBzaXplb2Yoc3RydWN0IGV4dDJfZ3JvdXBfZGVzYyksDQogKwkJCQkJaW5mby5i
bG9ja19zaXplKSAtIGJnX2Rlc2NfYmxvY2tzOw0KICsNCiArCWlmIChiZ19kZXNjX3Jlc2VydmVf
YmxvY2tzID4gaW5mby5ibG9ja19zaXplIC8gc2l6ZW9mKHUzMikpDQogKwkJYmdfZGVzY19yZXNl
cnZlX2Jsb2NrcyA9IGluZm8uYmxvY2tfc2l6ZSAvIHNpemVvZih1MzIpOw0KICsNCiArCXJldHVy
biBiZ19kZXNjX3Jlc2VydmVfYmxvY2tzOw0KICt9DQogKw0KICB2b2lkIHJlc2V0X2V4dDRmc19p
bmZvKCkgew0KICAgICAgLy8gUmVzZXQgYWxsIHRoZSBnbG9iYWwgZGF0YSBzdHJ1Y3R1cmVzIHVz
ZWQgYnkgbWFrZV9leHQ0ZnMgc28gaXQNCiAgICAgIC8vIGNhbiBiZSBjYWxsZWQgYWdhaW4uDQo=
