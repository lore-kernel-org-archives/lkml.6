Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA5C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EA02709C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EA02709C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934666AbeF1H6z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:58:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753661AbeF1H6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:58:52 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 40C75431875A;
        Thu, 28 Jun 2018 15:58:46 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.80]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0382.000;
 Thu, 28 Jun 2018 15:57:00 +0800
From:   "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIXSBleHQ0OiBlMmZzcHJvZ3M6IGZpeCBpbm9k?=
 =?gb2312?B?ZSBiaXRtYXAgbnVtIG5vdCBpbnRlZ2VyLGluY29tcGF0aWJsZSBmb3IgYW5j?=
 =?gb2312?Q?ient_android_devices?=
Thread-Topic: =?gb2312?B?tPC4tDogW1BBVENIXSBleHQ0OiBlMmZzcHJvZ3M6IGZpeCBpbm9kZSBiaXRt?=
 =?gb2312?B?YXAgbnVtIG5vdCBpbnRlZ2VyLGluY29tcGF0aWJsZSBmb3IgYW5jaWVudCBh?=
 =?gb2312?Q?ndroid_devices?=
Thread-Index: AQHUDiB7bBM9P+9CgUmyd+rfiNQEzqR03/Qw//+NOgCAANrbsA==
Date:   Thu, 28 Jun 2018 07:56:59 +0000
Message-ID: <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
 <20180627140937.GA3348@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
 <20180628022900.GA663@thunk.org>
In-Reply-To: <20180628022900.GA663@thunk.org>
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

SGksDQoNCkkgaGF2ZSBjbG9uZWQgdGhlIHJlcG8gL3N5c3RlbS9leHRyYXMgb24gbWFzdGVyIGJy
YW5jaC4NCmdpdCBjbG9uZSBodHRwczovL2FuZHJvaWQuZ29vZ2xlc291cmNlLmNvbS9wbGF0Zm9y
bS9zeXN0ZW0vZXh0cmFzICYmIChjZCBleHRyYXMgJiYgY3VybCAtTG8gYGdpdCByZXYtcGFyc2Ug
LS1naXQtZGlyYC9ob29rcy9jb21taXQtbXNnIGh0dHBzOi8vZ2Vycml0LXJldmlldy5nb29nbGVz
b3VyY2UuY29tL3Rvb2xzL2hvb2tzL2NvbW1pdC1tc2cgOyBjaG1vZCAreCBgZ2l0IHJldi1wYXJz
ZSAtLWdpdC1kaXJgL2hvb2tzL2NvbW1pdC1tc2cpDQphbmQgDQpnaXQgY2hlY2tvdXQgZ2l0IGNo
ZWNrb3V0IDljMjc5NzBkMTQyZGMxNGIxZTgyYjFkNmY5ZmE4MjdmOTk0NjA5YjYgLWIgdG1wDQov
L3RoaXMgbWVhbnMgcm9sbGJhY2sgdG8gdGhlIHZlcnNpb24gYmVmb3JlIG1ha2VfZXh0NGZzIGNv
ZGUgd2FzIGRlbGV0ZWQgb24gSnVuIDIxdGggMjAxOC4NCg0KQW5kIGNvcHkgdGhlIGNvZGVzIHRv
IGFuZHJvaWQgcHJvamVjdCwgdGhlbiBjb21waWxlLCBhbmQgcHJvZHVjZSB0aGUgaW1hZ2UuIExp
a2UgYmVsb3csDQoNCi4vaG9zdC9saW51eC14ODYvYmluL21ha2VfZXh0NGZzICAtcyAtbCAyME0g
LWIgMTAyNCBnYW9taW5nLmltZw0KQ3JlYXRpbmcgZmlsZXN5c3RlbSB3aXRoIHBhcmFtZXRlcnM6
DQogICAgU2l6ZTogMjA5NzE1MjANCiAgICBCbG9jayBzaXplOiAxMDI0DQogICAgQmxvY2tzIHBl
ciBncm91cDogODE5Mg0KICAgIElub2RlcyBwZXIgZ3JvdXA6IDE3MDgNCiAgICBJbm9kZSBzaXpl
OiAyNTYNCiAgICBKb3VybmFsIGJsb2NrczogMTAyNA0KICAgIExhYmVsOg0KICAgIEJsb2Nrczog
MjA0ODANCiAgICBCbG9jayBncm91cHM6IDMNCiAgICBSZXNlcnZlZCBibG9jayBncm91cCBzaXpl
OiA5NQ0KQ3JlYXRlZCBmaWxlc3lzdGVtIHdpdGggMTEvNTEyNCBpbm9kZXMgYW5kIDI1MDkvMjA0
ODAgYmxvY2tzDQoNCllvdSBzZWUsIElub2RlcyBwZXIgZ3JvdXAgaXMgMTcwOCx3aGljaCBpcyBp
bGxlZ2FsIGFzIHlvdSBzYWlkLg0KDQpTbywgdGhlIHByb2JsZW0gZXhpc3RzIGEgbG9uZyB0aW1l
IHVudGlsIEp1biAyMXRoIDIwMTguDQoNCllvdSBjb21wbGFpbmVkIHRoZSBwcm9ibGVtIGluIDIw
MTEsIHRoZXkgZG8gbm90IGZpeCBpdCB0aWxsIDIwMTguDQpKdXN0IGFzDQpJIGNvbXBsYWluZWQs
IGZpeCBpdCwgIGFuZCB5b3UgZG8gbm90IGFjY2VwdCBpdC4gXl9eDQoNCg0KUmVnYXJkcywNCk1p
bmcNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IFRoZW9kb3JlIFkuIFRzJ28gW21haWx0
bzp0eXRzb0BtaXQuZWR1XSANCreiy83KsbzkOiAyMDE4xOo21MIyOMjVIDEwOjI5DQrK1bz+yMs6
IEdhb21pbmcgKG1pbmcsIGNvbnN1bWVyIEJHKQ0Ks63LzTogbGludXgtZXh0NEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpcWluZ2NoYW8gKHNvcnApOyBT
aGVuY2hlbiAoaGFycnkpOyBtaWFveGllIChBKTsgeWFuZ2ZlaSAoRCkNCtb3zOI6IFJlOiC08Li0
OiBbUEFUQ0hdIGV4dDQ6IGUyZnNwcm9nczogZml4IGlub2RlIGJpdG1hcCBudW0gbm90IGludGVn
ZXIsaW5jb21wYXRpYmxlIGZvciBhbmNpZW50IGFuZHJvaWQgZGV2aWNlcw0KDQpPbiBUaHUsIEp1
biAyOCwgMjAxOCBhdCAwMTo0MDozMEFNICswMDAwLCBHYW9taW5nIChtaW5nLCBjb25zdW1lciBC
Rykgd3JvdGU6DQo+IEhpIHR5dHNvLA0KPiANCj4gSSBoYXZlIGNoZWNrZWQgdGhhdCBtYWtlX2V4
dDRmcyBjb2RlIHdhcyBkZWxldGVkIG8gSnVuIDIxdGggMjAxOCBvbiBtYXN0ZXIgYnJhbmNoIG9m
IC9zeXN0ZW0vZXh0cmFzIHJlcG9zaXRvcnkuDQo+IGUuZy4gDQo+IGh0dHBzOi8vYW5kcm9pZC1y
ZXZpZXcuZ29vZ2xlc291cmNlLmNvbS9jL3BsYXRmb3JtL3N5c3RlbS9leHRyYXMvKy83MDgwMDMN
Cg0KTWFrZV9leHQ0ZnMgd2FzIGZpeGVkIG5vdCBjcmVhdGUgaW52YWxpZCBmaWxlIHN5c3RlbXMg
YSAqbG9uZyogdGltZQ0KYWdvLiAgV2hhdCBJJ20gbm90IHN1cmUgYWJvdXQgaXMgd2h5IHRoZSBw
YXRjaCBoYXNuJ3QgZ290dGVuIG91dCB0bw0KbW9yZSBBbmRyb2lkIG1hbnVmYWN0ZXJzIHNvb25l
ci4NCg0KSXQgc2hvdWxkIGhhdmUgYmVlbiBmaXhlZCBieSBzb21ldGltZSBpbiAyMDEyIC0tLSBJ
IGNvbXBsYWluZWQgdG8gdGhlDQpBbmRyb2lkIHRlYW0gaW4gZWFybHkgMjAxMS4gIFdoYXQgSSBk
b24ndCB1bmRlcnN0YW5kIGlzIHdoeSBwZW9wbGUgYXJlDQpjb21pbmcgb3V0IG9mIHRoZSB3b29k
d29yayAqbm93Ki4NCg0KCQkJCQktIFRlZA0K
