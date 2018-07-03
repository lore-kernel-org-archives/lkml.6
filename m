Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DF7C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105E221A6E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105E221A6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeGCLPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:15:44 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:54892 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752552AbeGCLPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:15:39 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id BE75270082733;
        Tue,  3 Jul 2018 19:15:36 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.80]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0382.000;
 Tue, 3 Jul 2018 19:15:21 +0800
From:   "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BB?=
 =?gb2312?B?VENIXSBleHQ0OiBlMmZzcHJvZ3M6IGZpeCBpbm9kZSBiaXRtYXAgbnVtIG5v?=
 =?gb2312?B?dCBpbnRlZ2VyLGluY29tcGF0aWJsZSBmb3IgYW5jaWVudCBhbmRyb2lkIGRl?=
 =?gb2312?Q?vices?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBl?=
 =?gb2312?B?eHQ0OiBlMmZzcHJvZ3M6IGZpeCBpbm9kZSBiaXRtYXAgbnVtIG5vdCBpbnRl?=
 =?gb2312?Q?ger,incompatible_for_ancient_android_devices?=
Thread-Index: AQHUDiB7bBM9P+9CgUmyd+rfiNQEzqR03/Qw//+NOgCAANrbsP///3QAgAE0cUCAAEv3AIABNeRAgABFnICAA2DhYP//tn0AACs/VrAAA4S8gAAR8cZg
Date:   Tue, 3 Jul 2018 11:15:21 +0000
Message-ID: <FDC91B229D965C458E3615E98C48ADDD0EC41F40@dggemm511-mbx.china.huawei.com>
References: <20180628022900.GA663@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
 <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
 <20180629142612.GE1231@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
 <20180630130429.GA26529@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41D5F@dggemm511-mbx.china.huawei.com>
 <20180702121654.GA15131@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41DC4@dggemm511-mbx.china.huawei.com>
 <20180703103557.GA27426@thunk.org>
In-Reply-To: <20180703103557.GA27426@thunk.org>
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

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBUaGVvZG9yZSBZLiBUcydvIFttYWlsdG86
dHl0c29AbWl0LmVkdV0gDQq3osvNyrG85DogMjAxOMTqN9TCM8jVIDE4OjM2DQrK1bz+yMs6IEdh
b21pbmcgKG1pbmcsIGNvbnN1bWVyIEJHKQ0Ks63LzTogbGludXgtZXh0NEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpcWluZ2NoYW8gKHNvcnApOyBTaGVu
Y2hlbiAoaGFycnkpOyBtaWFveGllIChBKTsgeWFuZ2ZlaSAoRCk7IFJlbmxpcGVuZyAoT1MgZHJp
dmVyKQ0K1vfM4jogUmU6ILTwuLQ6ILTwuLQ6ILTwuLQ6ILTwuLQ6ILTwuLQ6ILTwuLQ6IFtQQVRD
SF0gZXh0NDogZTJmc3Byb2dzOiBmaXggaW5vZGUgYml0bWFwIG51bSBub3QgaW50ZWdlcixpbmNv
bXBhdGlibGUgZm9yIGFuY2llbnQgYW5kcm9pZCBkZXZpY2VzDQoNCk9uIFR1ZSwgSnVsIDAzLCAy
MDE4IGF0IDEyOjU4OjQ4QU0gKzAwMDAsIEdhb21pbmcgKG1pbmcsIGNvbnN1bWVyIEJHKSB3cm90
ZToNCj4gQW5kIGNhbiB5b3UgaGVscCBtZSB1bmRlcnN0YW5kICp3aHkqIHN1Y2ggYSBjaG9pY2Ug
d2FzIG1hZGU/DQo+IC0tLS0taWYgdGhlcmUgaXMgc3VjaCBhIHByb2JsZW0gaW4geW91ciBkZXZp
Y2VzLCBob3cgd2lsbCB5b3UgZG8/IElzIHRoZXJlIGFueSBvdGhlciBjaG9pY2U/DQo+IC0tLS0t
IG9mIGNvdXJzZSwgeW91IGNhbm5vdCBmb3JtYXQgdGhlIHBhcnRpdGlvbi4NCg0KWW91IG1pc3Vu
ZGVyc3RhbmQgbXkgcXVlc3Rpb24uICBXaHkgd2FzIHRoZSBjaG9pY2Ugb2YgYSBibG9ja3NpemUg
b2YNCjEwMjQgbWFkZT8NCg0KLS0tLS1zb21lIG9uZSBjaG9vc2UsIG5vdCBtZSAuIEkgZ3Vlc3Mg
dGhleSB3YW50IGdldCBtb3JlIGlub2RlcyBpbiAyME0gZmlsZXN5c3RlbS4NCg0KSSdtIHRyeWlu
ZyB0byB1bmRlcnN0YW5kIGhvdyBtYW55IGRldmljZXMsIGFuZCB3aHkgYW55IG90aGVyDQptYW51
ZmFjdHVyZSB3b3VsZCBtYWtlLCB3aGF0IHNlZW1zIHRvIG1lLCB0byBiZSBhIGNvbXBsZXRlbHkg
aW5zYW5lDQpjaG9pY2UuDQoNCkhvdyBsb25nIGhhcyBIdWF3ZWkgYmVlbiB1c2luZyBhIDEwMjQg
Ynl0ZSBibG9ja3NpemU/ICBBbmQgd2h5PyAgQW5kDQpmb3IgaG93IG1hbnkgZGV2aWNlcz8gIEVz
c2VudGlhbGx5LCBJJ20gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaWYgdGhpcw0Kd2FzIGEgSHVhd2Vp
LXNwZWNpZmljIG1pc3Rha2UuDQotLS0tLSBJIGNhbm5vdCBhbnN3ZXIgdGhpcyBxdWVzdGlvbi4N
Cg0KCQkJCQktIFRlZA0K
