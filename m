Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59E620870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59E620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeKTMs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:48:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:6431 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbeKTMs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:48:26 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 9062C73A399AD;
        Tue, 20 Nov 2018 10:21:39 +0800 (CST)
Received: from DGGEMM521-MBS.china.huawei.com ([169.254.3.218]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0415.000;
 Tue, 20 Nov 2018 10:21:32 +0800
From:   xuechaojing <xuechaojing@huawei.com>
To:     David Miller <davem@davemloft.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "wulike (A)" <wulike1@huawei.com>, chiqijun <chiqijun@huawei.com>,
        Wangfengying <fy.wang@huawei.com>,
        "Quhuichun (Tony)" <tony.qu@huawei.com>,
        "Luoshaokai (luoshaokai)" <luoshaokai@huawei.com>,
        xuechaojing <xuechaojing@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvNF0gbmV0LW5leHQvaGluaWM6cmVwbGFjZSBtdWx0?=
 =?gb2312?Q?iply_and_division_operators?=
Thread-Topic: [PATCH 1/4] net-next/hinic:replace multiply and division
 operators
Thread-Index: AQHUgBEQjbteD0dBtEKHoQuGQ+FC+qVXMW0AgAC2L8A=
Date:   Tue, 20 Nov 2018 02:21:31 +0000
Message-ID: <DACA750462785649825D7529120E85A808A65AFC@dggemm521-mbs.china.huawei.com>
References: <20181119061234.12839-1-xuechaojing@huawei.com>
 <20181119.150142.777293649598457239.davem@davemloft.net>
In-Reply-To: <20181119.150142.777293649598457239.davem@davemloft.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.30.175]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGk6DQoNClRoaXMgd3FlYmIgc2l6ZSBpcyAzMiBpbiByeCBhbmQgaW4gdHggaXMgNjQsIHNvIHRo
ZSB2YWx1ZSBpcyBhIHBvd2VyIG9mIHR3by4NCg0KVGhhbmsgeW91DQoNCi0tLS0t08q8/tStvP4t
LS0tLQ0Kt6K8/sjLOiBEYXZpZCBNaWxsZXIgW21haWx0bzpkYXZlbUBkYXZlbWxvZnQubmV0XSAN
Creiy83KsbzkOiAyMDE4xOoxMdTCMjDI1SA3OjAyDQrK1bz+yMs6IHh1ZWNoYW9qaW5nIDx4dWVj
aGFvamluZ0BodWF3ZWkuY29tPg0Ks63LzTogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgd3VsaWtlIChBKSA8d3VsaWtlMUBodWF3ZWkuY29tPjsg
Y2hpcWlqdW4gPGNoaXFpanVuQGh1YXdlaS5jb20+OyBXYW5nZmVuZ3lpbmcgPGZ5LndhbmdAaHVh
d2VpLmNvbT47IFF1aHVpY2h1biAoVG9ueSkgPHRvbnkucXVAaHVhd2VpLmNvbT47IEx1b3NoYW9r
YWkgKGx1b3NoYW9rYWkpIDxsdW9zaGFva2FpQGh1YXdlaS5jb20+DQrW98ziOiBSZTogW1BBVENI
IDEvNF0gbmV0LW5leHQvaGluaWM6cmVwbGFjZSBtdWx0aXBseSBhbmQgZGl2aXNpb24gb3BlcmF0
b3JzDQoNCkZyb206IFh1ZSBDaGFvamluZyA8eHVlY2hhb2ppbmdAaHVhd2VpLmNvbT4NCkRhdGU6
IE1vbiwgMTkgTm92IDIwMTggMDY6MTI6MzEgKzAwMDANCg0KPiBAQCAtNTMwLDcgKzUzNiw5IEBA
IGludCBoaW5pY193cV9hbGxvY2F0ZShzdHJ1Y3QgaGluaWNfd3FzICp3cXMsIHN0cnVjdCBoaW5p
Y193cSAqd3EsDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gIA0KPiAtCW51bV93cWVi
YnNfcGVyX3BhZ2UgPSBBTElHTih3cV9wYWdlX3NpemUsIHdxZWJiX3NpemUpIC8gd3FlYmJfc2l6
ZTsNCj4gKwl3cWViYl9zaXplX3NoaWZ0ID0gaWxvZzIod3FlYmJfc2l6ZSk7DQoNCllvdSBub3cg
aGF2ZSBpbnRyb2R1Y2VkIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlc2UgdmFyaW91cyBzaXplcyBh
cmUgYSBwb3dlciBvZiB0d28uDQoNCllvdSBzaG91bGQgY2hlY2sgZm9yIHRoaXMsIGVpdGhlciBh
dCBjb21waWxlIHRpbWUgb3IgYXQgcnVuIHRpbWUsIGluIG9yZGVyIHRvIGF2b2lkIHN1cnByaXNl
cyBhbmQgaGFyZCB0byBkZWJ1ZyBpc3N1ZXMgaW4gdGhlIGZ1dHVyZS4NCg0KVGhhbmsgeW91Lg0K
