Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348AFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C628E248DC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C628E248DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeGCA7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:59:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5983 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752789AbeGCA67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:58:59 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 5C3BBCF5B33EF;
        Tue,  3 Jul 2018 08:58:56 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.80]) by
 DGGEMM402-HUB.china.huawei.com ([10.3.20.210]) with mapi id 14.03.0382.000;
 Tue, 3 Jul 2018 08:58:48 +0800
From:   "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBl?=
 =?gb2312?B?eHQ0OiBlMmZzcHJvZ3M6IGZpeCBpbm9kZSBiaXRtYXAgbnVtIG5vdCBpbnRl?=
 =?gb2312?Q?ger,incompatible_for_ancient_android_devices?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBleHQ0OiBl?=
 =?gb2312?B?MmZzcHJvZ3M6IGZpeCBpbm9kZSBiaXRtYXAgbnVtIG5vdCBpbnRlZ2VyLGlu?=
 =?gb2312?Q?compatible_for_ancient_android_devices?=
Thread-Index: AQHUDiB7bBM9P+9CgUmyd+rfiNQEzqR03/Qw//+NOgCAANrbsP///3QAgAE0cUCAAEv3AIABNeRAgABFnICAA2DhYP//tn0AACs/VrA=
Date:   Tue, 3 Jul 2018 00:58:48 +0000
Message-ID: <FDC91B229D965C458E3615E98C48ADDD0EC41DC4@dggemm511-mbx.china.huawei.com>
References: <20180627140937.GA3348@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
 <20180628022900.GA663@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
 <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
 <20180629142612.GE1231@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
 <20180630130429.GA26529@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41D5F@dggemm511-mbx.china.huawei.com>
 <20180702121654.GA15131@thunk.org>
In-Reply-To: <20180702121654.GA15131@thunk.org>
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

QW5kIGNhbiB5b3UgaGVscCBtZSB1bmRlcnN0YW5kICp3aHkqIHN1Y2ggYSBjaG9pY2Ugd2FzIG1h
ZGU/DQotLS0tLWlmIHRoZXJlIGlzIHN1Y2ggYSBwcm9ibGVtIGluIHlvdXIgZGV2aWNlcywgaG93
IHdpbGwgeW91IGRvPyBJcyB0aGVyZSBhbnkgb3RoZXIgY2hvaWNlPw0KLS0tLS0gb2YgY291cnNl
LCB5b3UgY2Fubm90IGZvcm1hdCB0aGUgcGFydGl0aW9uLg0KDQotLS0tLdPKvP7Urbz+LS0tLS0N
CreivP7IyzogVGhlb2RvcmUgWS4gVHMnbyBbbWFpbHRvOnR5dHNvQG1pdC5lZHVdIA0Kt6LLzcqx
vOQ6IDIwMTjE6jfUwjLI1SAyMDoxNw0KytW8/sjLOiBHYW9taW5nIChtaW5nLCBjb25zdW1lciBC
RykNCrOty806IGxpbnV4LWV4dDRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBMaXFpbmdjaGFvIChzb3JwKTsgU2hlbmNoZW4gKGhhcnJ5KTsgbWlhb3hpZSAo
QSk7IHlhbmdmZWkgKEQpOyBSZW5saXBlbmcgKE9TIGRyaXZlcikNCtb3zOI6IFJlOiC08Li0OiC0
8Li0OiC08Li0OiC08Li0OiC08Li0OiBbUEFUQ0hdIGV4dDQ6IGUyZnNwcm9nczogZml4IGlub2Rl
IGJpdG1hcCBudW0gbm90IGludGVnZXIsaW5jb21wYXRpYmxlIGZvciBhbmNpZW50IGFuZHJvaWQg
ZGV2aWNlcw0KDQpPbiBNb24sIEp1bCAwMiwgMjAxOCBhdCAwOTozNDoyOEFNICswMDAwLCBHYW9t
aW5nIChtaW5nLCBjb25zdW1lciBCRykgd3JvdGU6DQo+IEkgZ290IGl0LiBZb3UgaGF0ZSBtYWtl
X2V4dDRmcywgYW5kIG1lIHRvby4NCj4gWW91IGRvbid0IGxpa2UgdG8gbWVyZ2UgdGhpcyBwYXRj
aCBpbiB1cHN0cmVhbSBlMmZzcHJvZ3MgdG8gcmVzb2x2ZSB0aGUgYnVnIG9mIG1ha2VfZXh0NGZz
Lg0KPiANCj4gT2YgY291cnNlIHdlIHdpbGwgZml4IHRoZSBidWcgb24gb3VyIGFuY2llbnQgZGV2
aWNlcywgd2UgaGF2ZSB0byAuDQo+IElmIHRoaXMgcHJvYmxlbSBmaXhlZCBvciB0aGlzIHBhdGNo
IG1lcmdlcyBpbiBsYXRlc3QgZTJmc3Byb2dzLCB3ZSB3aWxsIGJhY2twb3J0IHRoZSBsYXRlc3Qg
ZTJmc3Byb2dzLg0KPiBJZiBub3QsIHdlIGhhdmUgbm8gbW90aXZhdGlvbiB0byBiYWNrcG9ydCBp
dC4NCj4gDQo+IEkgZG9uJ3Qga25vdyB3aGV0aGVyIG90aGVyIGFuZHJvaWQgZGV2aWNlcyBzdWZm
ZXIgdGhpcyBwcm9ibGVtLg0KDQpDYW4geW91IGJlIGV4cGxpY2l0IGFuZCB0ZWxsIG1lIGhvdyBt
YW55IEh1YXdlaSBkZXZpY2VzIHVzZXMgYSBibG9jaw0Kc2l6ZSBvZiAxMDI0PyAgQW5kIGNhbiB5
b3UgaGVscCBtZSB1bmRlcnN0YW5kICp3aHkqIHN1Y2ggYSBjaG9pY2Ugd2FzIG1hZGU/DQoNCiAg
ICAgCSAgICAgICAJICAgICAgIAkgICAJICAgCSAgICAgIC0gVGVkDQo=
