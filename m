Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A7C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A174820C0F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A174820C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbeGDByj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:54:39 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50372 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932624AbeGDByh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:54:37 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id C464FE9758192;
        Wed,  4 Jul 2018 09:54:33 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.80]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0382.000;
 Wed, 4 Jul 2018 09:54:14 +0800
From:   "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPA=?=
 =?gb2312?B?uLQ6IFtQQVRDSF0gZXh0NDogZTJmc3Byb2dzOiBmaXggaW5vZGUgYml0bWFw?=
 =?gb2312?B?IG51bSBub3QgaW50ZWdlcixpbmNvbXBhdGlibGUgZm9yIGFuY2llbnQgYW5k?=
 =?gb2312?Q?roid_devices?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BB?=
 =?gb2312?B?VENIXSBleHQ0OiBlMmZzcHJvZ3M6IGZpeCBpbm9kZSBiaXRtYXAgbnVtIG5v?=
 =?gb2312?B?dCBpbnRlZ2VyLGluY29tcGF0aWJsZSBmb3IgYW5jaWVudCBhbmRyb2lkIGRl?=
 =?gb2312?Q?vices?=
Thread-Index: AQHUDiB7bBM9P+9CgUmyd+rfiNQEzqR03/Qw//+NOgCAANrbsP///3QAgAE0cUCAAEv3AIABNeRAgABFnICAA2DhYP//tn0AACs/VrAAA4S8gAAR8cZg///L04D//uBw0A==
Date:   Wed, 4 Jul 2018 01:54:12 +0000
Message-ID: <FDC91B229D965C458E3615E98C48ADDD0EC41F6D@dggemm511-mbx.china.huawei.com>
References: <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
 <20180629142612.GE1231@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
 <20180630130429.GA26529@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41D5F@dggemm511-mbx.china.huawei.com>
 <20180702121654.GA15131@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41DC4@dggemm511-mbx.china.huawei.com>
 <20180703103557.GA27426@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41F40@dggemm511-mbx.china.huawei.com>
 <20180703160301.GB4384@thunk.org>
In-Reply-To: <20180703160301.GB4384@thunk.org>
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

SGksDQoNCkkgZG8gbm90IHRoaW5rIEh1YXdlaSBoYXMgaGFja2VkIG1ha2VfZXh0NGZzLg0KRm9y
IGl0IGNvdWxkIGJlIHJlcHJvZHVjZWQgaW4gbWFrZV9leHQ0ZnMgbWFzdGVyIGJyYWNoIGJlZm9y
ZSBKdW4gMjF0aCAyMDE4LiBMaWtlIGJlbG93LA0KSSB0aGluayB3ZSBqdXN0IGNob29zZSBub3Qg
cmVjb21tZW5kZWQgcGFyYW1ldGVyICItYiAxMDI0IiBmb3Igc21hbGwgcGFydGl0aW9uIGxpa2Ug
YmVsb3csIGJ1dCBpdCdzIGxlZ2FsIHRob3VnaCBub3QgZ29vZC4gDQoNCi4vaG9zdC9saW51eC14
ODYvYmluL21ha2VfZXh0NGZzICAtcyAtbCAyME0gLWIgMTAyNCBnYW9taW5nLmltZyANCkNyZWF0
aW5nIGZpbGVzeXN0ZW0gd2l0aCBwYXJhbWV0ZXJzOg0KICAgIFNpemU6IDIwOTcxNTIwDQogICAg
QmxvY2sgc2l6ZTogMTAyNA0KICAgIEJsb2NrcyBwZXIgZ3JvdXA6IDgxOTINCiAgICBJbm9kZXMg
cGVyIGdyb3VwOiAxNzA4DQogICAgSW5vZGUgc2l6ZTogMjU2DQogICAgSm91cm5hbCBibG9ja3M6
IDEwMjQNCiAgICBMYWJlbDoNCiAgICBCbG9ja3M6IDIwNDgwDQogICAgQmxvY2sgZ3JvdXBzOiAz
DQogICAgUmVzZXJ2ZWQgYmxvY2sgZ3JvdXAgc2l6ZTogOTUNCkNyZWF0ZWQgZmlsZXN5c3RlbSB3
aXRoIDExLzUxMjQgaW5vZGVzIGFuZCAyNTA5LzIwNDgwIGJsb2Nrcw0KDQpPdGhlciB2ZW5kb3Jz
IG1heSBjaG9vc2UgdGhpcyBwYXJhLCBvciBub3QsIHdlIGRvbid0IGtub3cuIG1heWJlIHRoZXkg
YXJlIGx1Y2t5IG9yIHdpc2Ugbm90IGNob29zaW5nIDEwMjQuDQoNCk9mIGNvdXJzZSB3ZSB3aWxs
IGNob29zZSA0MDk2LCBvciBta2UyZnMgZnJvbSBub3cgb24uDQoNCldlIGp1c3Qgd2FudCB0byBm
aXggaGlzdG9yaWNhbCBwcm9ibGVtLiBXZSB3aWxsIGZpeCBpdCBieSBvdXJzZWx2ZXMuDQpJIGZ1
bGx5IHVuZGVyc3RhbmQgeW91ciBhdHRpdHVkZS4NClRoYW5rcyBhIGxvdC4NCg0KUmVnYXJkcywN
Ck1pbmcNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IFRoZW9kb3JlIFkuIFRzJ28gW21h
aWx0bzp0eXRzb0BtaXQuZWR1XSANCreiy83KsbzkOiAyMDE4xOo31MI0yNUgMDowMw0KytW8/sjL
OiBHYW9taW5nIChtaW5nLCBjb25zdW1lciBCRykNCrOty806IGxpbnV4LWV4dDRAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaXFpbmdjaGFvIChzb3JwKTsg
U2hlbmNoZW4gKGhhcnJ5KTsgbWlhb3hpZSAoQSk7IHlhbmdmZWkgKEQpOyBSZW5saXBlbmcgKE9T
IGRyaXZlcikNCtb3zOI6IFJlOiC08Li0OiC08Li0OiC08Li0OiC08Li0OiC08Li0OiC08Li0OiC0
8Li0OiBbUEFUQ0hdIGV4dDQ6IGUyZnNwcm9nczogZml4IGlub2RlIGJpdG1hcCBudW0gbm90IGlu
dGVnZXIsaW5jb21wYXRpYmxlIGZvciBhbmNpZW50IGFuZHJvaWQgZGV2aWNlcw0KDQpPbiBUdWUs
IEp1bCAwMywgMjAxOCBhdCAxMToxNToyMUFNICswMDAwLCBHYW9taW5nIChtaW5nLCBjb25zdW1l
ciBCRykgd3JvdGU6DQo+IA0KPiBZb3UgbWlzdW5kZXJzdGFuZCBteSBxdWVzdGlvbi4gIFdoeSB3
YXMgdGhlIGNob2ljZSBvZiBhIGJsb2Nrc2l6ZSBvZg0KPiAxMDI0IG1hZGU/DQo+IA0KPiAtLS0t
LXNvbWUgb25lIGNob29zZSwgbm90IG1lIC4gSSBndWVzcyB0aGV5IHdhbnQgZ2V0IG1vcmUgaW5v
ZGVzIGluIDIwTSBmaWxlc3lzdGVtLg0KDQpUaGF0IGNhbid0IGJlIHRoZSBleHBsYW5hdGlvbi4N
Cg0KSSBqdXN0IGNoZWNrZWQgdGhlIHNvdXJjZXMgZm9yIG1ha2VfZXh0NGZzOyB0aGUgYmxvY2tz
aXplIHdhcw0KaGFyZC1jb2RlZCwgYXMgd2FzIHRoZSBudW1iZXIgb2YgaW5vZGVzLiAgU28gaW4g
b3JkZXIgdG8gdXNlIGENCmJsb2NrX3NpemUgb2YgMTAyNCBieXRlcywgc29tZW9uZSBtdXN0IGhh
dmUgaGFja2VkIHRoZSBzb3VyY2VzDQpkaXJlY3RseSBhbmQgbW9kaWZpZWQgY29tcHV0ZV9ibG9j
a19zaXplKCkuICBBbmQgaW4gZmFjdCwgaXQgd291bGQNCmhhdmUgYmVlbiAqZWFzaWVyKiB0byBz
aW1wbHkgaGFjayBjb21wdXRlX2lub2RlcygpIHdoaWNoIGlzIGp1c3QgYSBmZXcNCmxpbmVzIGJl
bG93IGluIG1ha2VfZXh0NGZzLmM6DQoNCnN0YXRpYyB1MzIgY29tcHV0ZV9ibG9ja19zaXplKCkN
CnsNCglyZXR1cm4gNDA5NjsNCn0NCg0Kc3RhdGljIHUzMiBjb21wdXRlX2lub2RlcygpDQp7DQoJ
cmV0dXJuIERJVl9ST1VORF9VUChpbmZvLmxlbiwgaW5mby5ibG9ja19zaXplKSAvIDQ7DQp9DQoN
Cg0KVGhpcyBhbHNvIG1lYW5zIGNvbW1pdCAwNmMzNWY5MzVhN2Egd2hpY2ggZml4ZWQgbWFrZV9l
eHQ0ZnMuYyB3YXNuJ3QNCmJ1Z2d5OyBpdCB3YXMgYSB2YWxpZCBmaXggZ2l2ZW4gdGhlIGNvbXBs
ZXRlLW5vbi1hZGp1c3RhYmlsaXR5IG9mIHRoZQ0KYmxvY2tzaXplIGluIG1ha2VfZXh0NGZzLiAg
WWVzLCBpdCdzIG5vdCBhIGdyZWF0IGZpeCwgc2luY2UgaXQgd2FzDQpmcmFnaWxlIC0tLSBidXQg
dGhhdCdzIGhhcmRseSB0aGUgc21hbGxlc3QgcHJvYmxlbSBpbiBtYWtlX2V4dDRmcywNCnRoZXJl
IHdhcyBwbGVudHkgb2Ygb3RoZXIgc3VwZXItZnJhZ2lsZSBiaXRzIGluIG1ha2VfZXh0NGZzLiAg
VGhlcmUncw0KYSAqcmVhc29uKiBJIHdhcyBwdXNoaW5nIGhhcmQgdG8gbWFrZSBtYWtlX2V4dDRm
cyBnbyBhd2F5Lg0KDQpUaGF0IGJlaW5nIHNhaWQsIGdpdmVuIHRoZSBibG9jayBzaXplIG9mIG1h
a2VfZXh0NGZzIHdhcyBoYXJkLWNvZGVkIHRvDQo0MDk2LCBpdCBtYWtlcyBpdCBjbGVhciB0aGF0
IHRoZSBjaGFuZ2UgdG8gbWFrZSBpdCBjcmVhdGUgYSBibG9ja3NpemUNCm9mIDEwMjQgbXVzdCBo
YXZlIGJlZWVuIGEgSHVhd2VpLWxvY2FsIGNoYW5nZSwgYW5kIGl0IHdhcyBuZXZlciBzZW50DQpi
YWNrIHRvIHRoZSB0aGUgY29tbW9uIEFPU1AgdHJlZS4gIChJZiBpdCBoYWQsIEkgd291bGQgaGF2
ZSBnb3R0ZW4gYW4NCmUtbWFpbCwgYW5kIEkgd291bGQgaGF2ZSBleHBsYWluZWQgdG8gd2hvZXZl
ciBoYWQgbWFkZSB0aGlzDQpIdWF3ZWktbG9jYWwgaGFjayB3aHkgaXQgd2FzIHN1Y2ggYSBpbmNy
ZWRpYmx5IGJhZCBpZGVhLikNCg0KDQpJbiBhbnkgY2FzZSwgd2hhdCBJIHdvdWxkIHJlY29tbWVu
ZCBhdCB0aGlzIHBvaW50IGlmIHlvdSBuZWVkIHRvDQpzdXBwb3J0IEh1YXdlaSBkZXZpY2VzIHRo
YXQgZG8gdGhpcywgaXMgdGhhdCB5b3Uga2VlcCB5b3VyIGUyZnNwcm9ncw0KYXMgYSBIdWF3ZWkt
c3BlY2lmaWMgZTJmc3Byb2dzIHJlcG8uDQoNCj4gSG93IGxvbmcgaGFzIEh1YXdlaSBiZWVuIHVz
aW5nIGEgMTAyNCBieXRlIGJsb2Nrc2l6ZT8gIEFuZCB3aHk/ICBBbmQNCj4gZm9yIGhvdyBtYW55
IGRldmljZXM/ICBFc3NlbnRpYWxseSwgSSdtIHRyeWluZyB0byBmaWd1cmUgb3V0IGlmIHRoaXMN
Cj4gd2FzIGEgSHVhd2VpLXNwZWNpZmljIG1pc3Rha2UuDQo+IC0tLS0tIEkgY2Fubm90IGFuc3dl
ciB0aGlzIHF1ZXN0aW9uLg0KDQpXZWxsLCBhY3R1YWxseSwgaXQgc2hvdWxkIGJlIHZlcnkgZWFz
eSBmb3IgeW91IHRvIGRldHJlbWluZSB0aGUgYW5zd2VyDQp0aGlzIHF1ZXN0aW9uIC0tLSBpdCBz
aG91bGQganVzdCBiZSBhIG1hdHRlciBvZiBjaGVja2luZyBnaXQgc291cmNlDQpjb250cm9sIGhp
c3RvcnkgYW5kIHNlZSB3aGljaCBwcm9kdWN0IHRyZWVzIGhhcyB0aGUgY2hhbmdlIHRvDQpwbGF0
Zm9ybXMvc3lzdGVtL2V4dHJhcy9leHQ0X3V0aWxzL21ha2VfZXh0NGZzLmMgLS0tIGFuZCB5b3Ug
bXVzdCBoYXZlDQpwbGF0Zm9ybS1zcGVjaWZpYyBzb3VyY2UgdHJlZXMgaW4gb3JkZXIgdG8gYmUg
Y29tcGxpYW50IHdpdGggdGhlIEdOVQ0KUHVibGljIExpY2Vuc2UgKEdQTCkuDQoNCkV2ZW4gaWYg
eW91IGRpZG4ndCwgaXQgd291bGQganVzdCBiZSBhIG1hdHRlciB1c2luZyBkdW1wZTJmcyBvcg0K
ZGVidWdmcyAodGhleSBhcmVuJ3QgYnVpbHQgYnkgZGVmYXVsdCBpbiBlMmZzcHJvZ3MgYnkgdGhl
IEFPU1AgYnVpbGQNCnRyZWVzLCBidXQgdGhleSBzaG91bGQgYmUgYnVpbGRhYmxlKSB0byB0aG9z
ZSBIdWF3ZWkgZGV2aWNlcyB0aGF0IHlvdQ0Kc3RpbGwgc3VwcG9ydCwgYW5kIHRoZW4gcnVuIGVp
dGhlciBkdW1wZTJmcyBvciBkZWJ1Z2ZzIHZpYSBhZGIgc2hlbGwNCmFuZCBzZWUgd2hhdCBibG9j
ayBzaXplIGlzIHJlcG9ydGVkLg0KDQpFdmVuIGlmIHlvdSBhcmVuJ3QgYWxsb3dlZCB0byBhbnN3
ZXIgdGhpcyBxdWVzdGlvbiBwdWJsaWNhbGx5LCBJJ2QNCnN0cm9uZ2x5IHJlY29tbWVuZCB5b3Ug
ZmlndXJlIGl0IG91dCwgc28geW91IGtub3cgd2hlbiB5b3VyIGxvY2FsDQpjaGFuZ2UgdG8gZTJm
c3Byb2dzIGNhbiBiZSBkcm9wcGVkLiAgSSdkIGZ1cnRoZXIgcmVjb21tZW5kIHRoYXQgeW91DQpt
YWtlIHN1cmUgYWxsIG5ldyBIdWF3ZWkgZGV2aWNlcyB1c2UgYSBibG9jayBzaXplIG9mIDQwOTYs
IHByZWZlcmFibHkNCnVzaW5nIG1rZTJmcyBhbmQgZTJmc2Ryb2lkLCBhcyBpcyBjdXJyZW50bHkg
ZG9uZSBpbiBBT1NQLiAgRmFpbGluZw0KdGhhdCwgYXQgbGVhc3QgcGxlYXNlIHVzZSB0aGUgc3Rv
Y2sgbWFrZV9leHQ0ZnMgd2hpY2ggZG9lc24ndCBoYXZlIHRoZQ0KSHVhd2VpLXNwZWNpZmljIGhh
Y2sgdG8gc3VwcG9ydCAxMDI0IGJ5dGUgYmxvY2sgc2l6ZXMsIG9yIGhhdmUgdGhhdA0KSHVhd2Vp
LXNwZWNpZmljIGhhY2sgcmV2ZXJ0ZWQuDQoNClJlZ2FyZHMsDQoNCgkJCQkJCS0gVGVkDQo=
