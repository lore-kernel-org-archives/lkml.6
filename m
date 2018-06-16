Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B42C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B022087E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B022087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbeFPJI3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:08:29 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:53073 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932204AbeFPJI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:08:27 -0400
Received: from DGGEMA404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 28189D9361BAA;
        Sat, 16 Jun 2018 17:08:24 +0800 (CST)
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.111]) by
 DGGEMA404-HUB.china.huawei.com ([10.3.20.45]) with mapi id 14.03.0382.000;
 Sat, 16 Jun 2018 17:08:23 +0800
From:   gengdongjiu <gengdongjiu@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSB1c2I6IHhoY2k6IHJlbW92ZSB0aGUgY29kZSBi?=
 =?gb2312?Q?uild_warning?=
Thread-Topic: [PATCH v2] usb: xhci: remove the code build warning
Thread-Index: AQHT/aPv1nuhYmQTHUO8ri6ZrJ2nNaRgqQwAgAH9yYA=
Date:   Sat, 16 Jun 2018 09:08:23 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201CE2843@DGGEMA503-MBX.china.huawei.com>
References: <20180606143659.1476-1-gengdongjiu@huawei.com>
 <20180615104004.GA2993@kroah.com>
In-Reply-To: <20180615104004.GA2993@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.56.137]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEp1biAwNiwgMjAxOCBhdCAxMDozNjo1OVBNICswODAwLCBEb25naml1IEdlbmcg
d3JvdGU6DQo+ID4gSW5pdGlhbGl6ZSB0aGUgJ2VycicgdmFyaWF0ZSB0byByZW1vdmUgdGhlIGJ1
aWxkIHdhcm5pbmcsIHRoZSB3YXJuaW5nDQo+ID4gaXMgc2hvd24gYXMgYmVsb3c6DQo+ID4NCj4g
PiBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEuYzogSW4gZnVuY3Rpb24gJ3RlZ3JhX3h1c2Jf
bWJveF90aHJlYWQnOg0KPiA+IGRyaXZlcnMvdXNiL2hvc3QveGhjaS10ZWdyYS5jOjU1Mjo2OiB3
YXJuaW5nOiAnZXJyJyBtYXkgYmUgdXNlZA0KPiA+IHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5j
dGlvbiBbLVd1bmluaXRpYWxpemVkXQ0KPiA+IGRyaXZlcnMvdXNiL2hvc3QveGhjaS10ZWdyYS5j
OjQ4Mjo2OiBub3RlOiAnZXJyJyB3YXMgZGVjbGFyZWQgaGVyZQ0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogRG9uZ2ppdSBHZW5nIDxnZW5nZG9uZ2ppdUBodWF3ZWkuY29tPg0KPiA+IEFja2VkLWJ5
OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+IEhvdyB0
byByZXByb2R1Y2U6DQo+ID4gMS4gbWFrZSBkZWZjb25maWcgQVJDSD1hcm0NCj4gPiAyLiBtYWtl
IC1qMTAwIENST1NTX0NPTVBJTEU9YXJtLWxpbnV4LWdudWVhYmktIEFSQ0g9YXJtDQo+ID4NCj4g
PiBUaGVuIHlvdSBjYW4gc2VlIGJlbG93IHdhcm5pbmdzOg0KPiA+IGRyaXZlcnMvdXNiL2hvc3Qv
eGhjaS10ZWdyYS5jOiBJbiBmdW5jdGlvbiAndGVncmFfeHVzYl9tYm94X3RocmVhZCc6DQo+ID4g
ZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmM6NTUyOjY6IHdhcm5pbmc6ICdlcnInIG1heSBi
ZSB1c2VkDQo+ID4gdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV3VuaW5pdGlhbGl6
ZWRdDQo+ID4gZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmM6NDgyOjY6IG5vdGU6ICdlcnIn
IHdhcyBkZWNsYXJlZCBoZXJlDQo+IA0KPiBXaGF0IGNoYW5nZWQgZnJvbSB2MT8gIEFsd2F5cyBw
dXQgdGhhdCBiZWxvdyB0aGUgLS0tIGxpbmUuDQo+IA0KPiBQbGVhc2UgZml4IHVwIGFuZCByZXNl
bmQgYSB2My4NCg0KDQpUaGFua3MsIEkganVzdGx5IGFkZCAiQWNrZWQtYnk6IFRoaWVycnkgUmVk
aW5nIDx0cmVkaW5nQG52aWRpYS5jb20+IiBpbiB0aGUgVjIgY29tcGFyZWQgd2l0aCB2MQ0KQW55
d2F5IEkgd2lsbCBwdXQgdGhhdCBiZWxvdyBhbmQgcmVzZW5kIGEgdjMuDQoNCj4gDQo+IHRoYW5r
cywNCj4gDQo+IGdyZWcgay1oDQo=
