Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12425C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B192124192
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B192124192
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbeGBJeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:34:44 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5567 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753343AbeGBJem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:34:42 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 02A95A00D3B41;
        Mon,  2 Jul 2018 17:34:36 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.382.0; Mon, 2 Jul 2018 17:34:36 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.80]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0382.000;
 Mon, 2 Jul 2018 17:34:29 +0800
From:   "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBleHQ0OiBl?=
 =?gb2312?B?MmZzcHJvZ3M6IGZpeCBpbm9kZSBiaXRtYXAgbnVtIG5vdCBpbnRlZ2VyLGlu?=
 =?gb2312?Q?compatible_for_ancient_android_devices?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBleHQ0OiBlMmZzcHJv?=
 =?gb2312?B?Z3M6IGZpeCBpbm9kZSBiaXRtYXAgbnVtIG5vdCBpbnRlZ2VyLGluY29tcGF0?=
 =?gb2312?Q?ible_for_ancient_android_devices?=
Thread-Index: AQHUDiB7bBM9P+9CgUmyd+rfiNQEzqR03/Qw//+NOgCAANrbsP///3QAgAE0cUCAAEv3AIABNeRAgABFnICAA2DhYA==
Date:   Mon, 2 Jul 2018 09:34:28 +0000
Message-ID: <FDC91B229D965C458E3615E98C48ADDD0EC41D5F@dggemm511-mbx.china.huawei.com>
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
 <20180627140937.GA3348@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
 <20180628022900.GA663@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
 <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
 <20180629142612.GE1231@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
 <20180630130429.GA26529@thunk.org>
In-Reply-To: <20180630130429.GA26529@thunk.org>
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

SSBnb3QgaXQuIFlvdSBoYXRlIG1ha2VfZXh0NGZzLCBhbmQgbWUgdG9vLg0KWW91IGRvbid0IGxp
a2UgdG8gbWVyZ2UgdGhpcyBwYXRjaCBpbiB1cHN0cmVhbSBlMmZzcHJvZ3MgdG8gcmVzb2x2ZSB0
aGUgYnVnIG9mIG1ha2VfZXh0NGZzLg0KDQpPZiBjb3Vyc2Ugd2Ugd2lsbCBmaXggdGhlIGJ1ZyBv
biBvdXIgYW5jaWVudCBkZXZpY2VzLCB3ZSBoYXZlIHRvIC4NCklmIHRoaXMgcHJvYmxlbSBmaXhl
ZCBvciB0aGlzIHBhdGNoIG1lcmdlcyBpbiBsYXRlc3QgZTJmc3Byb2dzLCB3ZSB3aWxsIGJhY2tw
b3J0IHRoZSBsYXRlc3QgZTJmc3Byb2dzLg0KSWYgbm90LCB3ZSBoYXZlIG5vIG1vdGl2YXRpb24g
dG8gYmFja3BvcnQgaXQuDQoNCkkgZG9uJ3Qga25vdyB3aGV0aGVyIG90aGVyIGFuZHJvaWQgZGV2
aWNlcyBzdWZmZXIgdGhpcyBwcm9ibGVtLg0KDQpJZiBzb21lb25lIGVsc2UgY29tZSB0byBjb21w
bGFpbiB0aGlzIHByb2JsZW0sIHlvdSBzaG91bGQgY29uc2lkZXIgdG8gZml4IGl0Lg0KDQpCZXN0
IHdpc2hlcy4NCg0KTWluZw0KDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBUaGVvZG9y
ZSBZLiBUcydvIFttYWlsdG86dHl0c29AbWl0LmVkdV0gDQq3osvNyrG85DogMjAxOMTqNtTCMzDI
1SAyMTowNA0KytW8/sjLOiBHYW9taW5nIChtaW5nLCBjb25zdW1lciBCRykNCrOty806IGxpbnV4
LWV4dDRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaXFp
bmdjaGFvIChzb3JwKTsgU2hlbmNoZW4gKGhhcnJ5KTsgbWlhb3hpZSAoQSk7IHlhbmdmZWkgKEQp
OyBSZW5saXBlbmcgKE9TIGRyaXZlcikNCtb3zOI6IFJlOiC08Li0OiC08Li0OiC08Li0OiC08Li0
OiBbUEFUQ0hdIGV4dDQ6IGUyZnNwcm9nczogZml4IGlub2RlIGJpdG1hcCBudW0gbm90IGludGVn
ZXIsaW5jb21wYXRpYmxlIGZvciBhbmNpZW50IGFuZHJvaWQgZGV2aWNlcw0KDQpPbiBTYXQsIEp1
biAzMCwgMjAxOCBhdCAwMToyNjo0M0FNICswMDAwLCBHYW9taW5nIChtaW5nLCBjb25zdW1lciBC
Rykgd3JvdGU6DQo+IFllcywgaXQgaXMgY2F1c2VkIGJ5IHVzaW5nIDEwMjQgYmxvY2tzaXplLg0K
PiBJdCBpcyBoaXN0b3JpY2FsIHByb2JsZW0sIGFuZCBJIGhhdmUgdG8gYWRtaXQgdGhhdCdzIG5v
dCBnb29kIGlkZWEuICBJIGRvbid0IGtub3cgd2h5IHNvbWVib2R5IGNob29zZSBpdCBzb21lIHll
YXJzIGJlZm9yZS4gDQo+IEl0IGhhcyBiZWVuIGNvcnJlY3RlZCB0d28geWVhcnMgYmVmb3JlIG9y
IG1vcmUgZWFybHkuIEJ1dCBzb21lIGFuY2llbnQgZGV2aWNlcyBleGlzdC4gDQo+IEl0IGlzIG5v
dCB1c2VyIGRhdGEsIG5vIG5lZWQgdG8gZG8gZmlsZS1iYXNlZCBlbmNyeXB0aW9uLiBJdCBpcyBh
IHNtYWxsIHBhcnRpdGlvbiBmb3Igc29tZSB1c2UuDQo+IA0KPiBIb3dldmVyLCAxMDI0IGlzIGxl
Z2FsIHRob3VnaCBub3QgZ29vZCwgc29tZWJvZHkgbWF5IHVzZSBpdC4gDQo+IEFuZCB3ZSBzaG91
bGQgZml4IGl0Lg0KDQpTbyB5b3UgdW5kZXJzdGFuZCBteSBwb3NpdGlvbiAtLS0gdGhlIHJlYXNv
biB3aHkgSSd2ZSBiZWVuIHB1c2hpbmcgc28NCmhhcmQgaXMgSSdtIHRyeWluZyB0byBmaWd1cmUg
b3V0IGhvdyBiaWcgb2YgYSBwcm9ibGVtIHRoaXMgaXMuDQpTcGVjaWZpY2FsbHkgc3BlYWtpbmcs
IGlzIHRoaXMgYSBIdWF3ZWktc3BlY2lmaWMgcHJvYmxlbSwgb3Igc29tZXRoaW5nDQphY3Jvc3Mg
dGhlIGVudGlyZSBBbmRyb2lkIGVjb3N5c3RlbS4gIEkgKnRob3VnaHQqIEkgaGFkIGZpeGVkIG1v
c3Qgb2YNCnRoZSBkaXNhc3RlciBiYWNrIGluIDIwMTEuICBUaGVyZSBoYXZlIHBlcmlvZGljIGhl
YWRhY2hlcyB3aGVyZQ0KdGVzdGVycyB3b3VsZCBkaXNjb3ZlciBwcm9ibGVtcyB3aGVyZSBhbmRy
b2lkIGhhbmRzZXRzIGdldCBicmlja2VkDQphZnRlciBkb2luZyBhIGZhY3RvcnkgcmVzZXQgdGhh
dCBJIGhhZCB0cmFja2VkIGRvd24gdG8gbWFrZV9leHQ0ZnMsDQphbmQgdGhlIGV4aXN0ZW5jZSBv
ZiBtYWtlX2V4dDRmcyBpcyBub3Qgc29tZXRoaW5nIEkgYWdyZWVkIHRvLCBhbmQNCmhhdmUgYmVl
biBmaWdodGluZyBmb3IgeWVhcnMuICBTbyBJJ3ZlIGJlZW4gY2xlYW5pbmcgdXAgYWZ0ZXINCm1h
a2VfZXh0NGZzIGZvciBhIHdoaWxlLCBldmVuIHRob3VnaCBpdCdzIG5vdCBteSByZXNwb25zaWJs
aXR5LiAgKEZvcg0Kb25lIHRoaW5nIG15IHdvcmsgcmVzcG9uc2liaWxpdGllcyBhcmUgZm9yIGRh
dGEgY2VudGVyIHNlcnZlcnMgYXQNCkdvb2dsZSwgKm5vdCogQW5kcm9pZDsgZm9yIGFub3RoZXIs
IG5vIG9uZSBhc2tlZCAqbWUqIGJlZm9yZSB0aGV5IGNhbWUNCnVwIHdpdGggdGhlIGFib21pbmF0
aW9uIHdoaWNoIGlzIG1ha2VfZXh0NGZzLikNCg0KU28gSSBkb24ndCBmZWVsIHBhcnRpY3VsYXJs
eSwgb3IgcGVyc29uYWxseSwgcmVzcG9uc2libGUgZm9yIGJ1Z3MNCmNhdXNlZCBieSBtYWtlX2V4
dDRmcywgYmVjYXVzZSBpZiBpdCBoYWQgYmVlbiB1cCB0byBtZSwgaXQgd291bGQgaGF2ZQ0KbmV2
ZXIgZXhpc3RlZCBpbiB0aGUgZmlyc3QgcGxhY2UuDQoNCklmIGl0J3Mgb25seSBpbiBhbmNpZW50
IEh1YXdlaSBkZXZpY2VzLCBJIGRvbid0IHNlZSBhIHN0cm9uZyByZWFzb24gdG8NCnN1cHBvcnQg
aGlzIGluIHVwc3RyZWFtIGUyZnNwcm9ncy4gIEFyZSB5b3UgcmVhbGx5IGdvaW5nIHRvIGJlDQpi
YWNrcG9ydGluZyB0aGUgbGF0ZXN0IGUyZnNwcm9ncyBpbnRvIHRoZXNlIGFuY2llbnQgSHVhd2Vp
IGRldmljZXM/DQpJbiBteSBleHBlcmllbmNlLCB0aGUgQW5kcm9pZCB0ZWFtIGhhcyBhIGhhcmQg
ZW5vdWdoIHRpbWUgZ2V0dGluZw0KdGhlaXIgQW5kcm9pZCBwYXJ0bmVycyB0byBiYWNrcG9ydCBr
ZXJuZWwgZml4ZXMgZm9yIHNldmVyZSBzZWN1cml0eQ0KYnVncyBpbnRvIG9sZCBBbmRyb2lkIGRl
dmljZXMgLS0tIG5ldmVyIG1pbmQgdmVyc2lvbnMgb2YgZTJmc3Byb2dzLg0KDQpJZiBub3QsIHdo
YXQncyB0aGUgcG9pbnQ/DQoNClJlZ2FyZHMsDQoNCgkJCQkJCS0gVGVkDQo=
