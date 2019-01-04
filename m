Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEB0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9DD20815
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfADDNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 22:13:55 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46507 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbfADDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 22:13:55 -0500
X-UUID: f435f572266e42f1bd2ba7a32e3a9ce1-20190104
X-UUID: f435f572266e42f1bd2ba7a32e3a9ce1-20190104
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 341720648; Fri, 04 Jan 2019 11:13:48 +0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Jan 2019 11:13:47 +0800
Received: from MTKMBS31N1.mediatek.inc ([fe80::e1b3:15a3:610e:3f13]) by
 MTKMBS31N1.mediatek.inc ([fe80::e1b3:15a3:610e:3f13%23]) with mapi id
 15.00.1395.000; Fri, 4 Jan 2019 11:13:47 +0800
From:   =?gb2312?B?WXVuZmVpIERvbmcgKLat1Ma3ySk=?= 
        <Yunfei.Dong@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     =?gb2312?B?VGlmZmFueSBMaW4gKMHWu9vJuik=?= 
        <tiffany.lin@mediatek.com>,
        =?gb2312?B?QW5kcmV3LUNUIENoZW4gKOqQ1se1zyk=?= 
        <Andrew-CT.Chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?gb2312?B?UWlhbnFpYW4gWWFuICjR1tm72bsp?= 
        <Qianqian.Yan@mediatek.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvM10gbWVkaWE6IGR0LWJpbmRpbmdzOiBtZWRpYTog?=
 =?gb2312?Q?Fix_MTK_document_for_vcodec?=
Thread-Topic: [PATCH 1/3] media: dt-bindings: media: Fix MTK document for
 vcodec
Thread-Index: AQHUnncyFA8AjmHgPE+jq9Dg8CBEGKWdseoAgADGdvA=
Date:   Fri, 4 Jan 2019 03:13:47 +0000
Message-ID: <6167c601b2c04e2a8b493a3cab35941e@MTKMBS31N1.mediatek.inc>
References: <1545978785-31375-1-git-send-email-yunfei.dong@mediatek.com>
 <20190103231722.GA22018@bogus>
In-Reply-To: <20190103231722.GA22018@bogus>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.27.4.250]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLCBhbmQgSSBhbHJlYWR5IHNlbnQgdGhl
IHNlY29uZCBwYXRjaC4NCg0KQ2hhbmdlIG5vdGU6DQoxOiBtb2RpZnkgdGhlIHN1YmplY3QgZm9y
IDAwMDEqDQoyOiBtb2RpZnkgdGhlIGRlc2NyaXB0aW9uIGZvciAwMDAzKg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpZdW5mZWkgRG9uZyANCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IFJvYiBIZXJy
aW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3JnXSANCreiy83KsbzkOiAyMDE5xOox1MI0yNUgNzox
Nw0KytW8/sjLOiBZdW5mZWkgRG9uZyAotq3UxrfJKQ0Ks63LzTogVGlmZmFueSBMaW4gKMHWu9vJ
uik7IEFuZHJldy1DVCBDaGVuICjqkNbHtc8pOyBNYXVybyBDYXJ2YWxobyBDaGVoYWI7IE1hcmsg
UnV0bGFuZDsgTWF0dGhpYXMgQnJ1Z2dlcjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1tZWRpYXRla0BsaXN0
cy5pbmZyYWRlYWQub3JnOyBRaWFucWlhbiBZYW4gKNHW2bvZuykNCtb3zOI6IFJlOiBbUEFUQ0gg
MS8zXSBtZWRpYTogZHQtYmluZGluZ3M6IG1lZGlhOiBGaXggTVRLIGRvY3VtZW50IGZvciB2Y29k
ZWMNCg0KT24gRnJpLCBEZWMgMjgsIDIwMTggYXQgMDI6MzM6MDNQTSArMDgwMCwgWXVuZmVpIERv
bmcgd3JvdGU6DQo+IEZpeCBNVEsgYmluZGluZyBkb2N1bWVudCBmb3IgTVQ4MTczIGR0c2kgY2hh
bmdlZCBpbiBvcmRlciB0byB1c2UgDQo+IHN0YW5kYXJkIENDRiBpbnRlcmZhY2UuDQo+IE1UODE3
MyBTb0MgZnJvbSBNZWRpYXRlay4NCg0KQSBiZXR0ZXIgc3ViamVjdCB3b3VsZCBiZSAiYWRkICdh
c3NpZ25lZC1jbG9ja3MnIHRvIHZjb2RlYyBleGFtcGxlcyIuDQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFFpYW5xaWFuIFlhbiA8cWlhbnFpYW4ueWFuQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlay12Y29kZWMudHh0ICAgfCAxMyAr
KysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCANCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEv
bWVkaWF0ZWstdmNvZGVjLnR4dCANCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVkaWEvbWVkaWF0ZWstdmNvZGVjLnR4dA0KPiBpbmRleCAyYTYxNWQ4NGE2ODIuLmI2YjVk
ZGU2YWJkOCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lZGlhL21lZGlhdGVrLXZjb2RlYy50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLXZjb2RlYy50eHQNCj4gQEAgLTY2LDYgKzY2LDE1
IEBAIHZjb2RlY19kZWM6IHZjb2RlY0AxNjAwMDAwMCB7DQo+ICAgICAgICAgICAgICAgICAgICAi
dmVuY3BsbCIsDQo+ICAgICAgICAgICAgICAgICAgICAidmVuY19sdF9zZWwiLA0KPiAgICAgICAg
ICAgICAgICAgICAgInZkZWNfYnVzX2Nsa19zcmMiOw0KPiArICAgIGFzc2lnbmVkLWNsb2NrcyA9
IDwmdG9wY2tnZW4gQ0xLX1RPUF9WRU5DX0xUX1NFTD4sDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgPCZ0b3Bja2dlbiBDTEtfVE9QX0NDSTQwMF9TRUw+LA0KPiArICAgICAgICAgICAgICAgICAg
ICAgIDwmdG9wY2tnZW4gQ0xLX1RPUF9WREVDX1NFTD4sDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgPCZhcG1peGVkc3lzIENMS19BUE1JWEVEX1ZDT0RFQ1BMTD4sDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgPCZhcG1peGVkc3lzIENMS19BUE1JWEVEX1ZFTkNQTEw+Ow0KPiArICAgIGFzc2ln
bmVkLWNsb2NrLXBhcmVudHMgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkNPREVDUExMXzM3MFA1PiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiBDTEtfVE9QX1VOSVZQ
TExfRDI+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIENMS19U
T1BfVkNPREVDUExMPjsNCj4gKyAgICBhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwwPiwgPDA+LCA8
MD4sIDwxNDgyMDAwMDAwPiwgPDgwMDAwMDAwMD47DQo+ICAgIH07DQo+ICANCj4gICAgdmNvZGVj
X2VuYzogdmNvZGVjQDE4MDAyMDAwIHsNCj4gQEAgLTEwNSw0ICsxMTQsOCBAQCB2Y29kZWNfZGVj
OiB2Y29kZWNAMTYwMDAwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgInZlbmNfc2VsIiwNCj4g
ICAgICAgICAgICAgICAgICAgICJ2ZW5jX2x0X3NlbF9zcmMiLA0KPiAgICAgICAgICAgICAgICAg
ICAgInZlbmNfbHRfc2VsIjsNCj4gKyAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JnRvcGNrZ2VuIENM
S19UT1BfVkVOQ19TRUw+LA0KPiArICAgICAgICAgICAgICAgICAgICAgIDwmdG9wY2tnZW4gQ0xL
X1RPUF9WRU5DX0xUX1NFTD47DQo+ICsgICAgYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmdG9w
Y2tnZW4gQ0xLX1RPUF9WRU5DUExMX0QyPiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPCZ0b3Bja2dlbiBDTEtfVE9QX1VOSVZQTEwxX0QyPjsNCj4gICAgfTsNCj4gLS0NCj4gMi4x
OS4xDQo+IA0K
