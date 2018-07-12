Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59143C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107EA20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107EA20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeGLHAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:00:17 -0400
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:4855 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbeGLHAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:00:17 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 03:00:16 EDT
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,341,1526335200"; 
   d="scan'208";a="53275928"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] rtc: isl1219: add device tree docu
Thread-Topic: [PATCH v4 5/5] rtc: isl1219: add device tree docu
Thread-Index: AQHUGDKQQPZVuDcxn0uq52IAiz//4qSKAlKAgAECrYA=
Date:   Thu, 12 Jul 2018 06:42:11 +0000
Message-ID: <1531377731.5323.2.camel@diehl.com>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
         <20180710090710.9066-6-Denis.Osterland@diehl.com>
         <20180711151621.GA4084@rob-hp-laptop>
In-Reply-To: <20180711151621.GA4084@rob-hp-laptop>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPcwlxmpAr5VGvqgmQp0ooEWl+8IqDs4kwr6qZ9H9tKFWd
X-TNEFEvaluated: 1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <A88210DD43D1AA42AD46D177F4733DDB@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gTWl0dHdvY2gsIGRlbiAxMS4wNy4yMDE4LCAwOToxNiAtMDYwMCBzY2hyaWViIFJvYiBI
ZXJyaW5nOg0KPiBPbiBUdWUsIEp1bCAxMCwgMjAxOCBhdCAwOTo0NDoxNUFNICswMDAwLCBE
ZW5pcyBPU1RFUkxBTkQgd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogRGVuaXMgT3N0ZXJsYW5k
IDxEZW5pcy5Pc3RlcmxhbmRAZGllaGwuY29tPg0KPiA+IA0KPiA+IFRoZSBkZXZpY2V0cmVl
IGRvY3VtZW50YXRpb24gZm9yIHRoZSBJU0wxMjE5IGRldmljZSB0cmVlDQo+ID4gYmluZGlu
ZyBpcyBhZGRlZCB3aXRoIGFuIHNob3J0IGV4YW1wbGUuIEl0IGlzIG5vdCBhIHRyaXZpYWwN
Cj4gPiBkZXZpY2UsIGJlY2F1c2UgaXQgc3VwcG9ydHMgdHdvIGludGVycnVwdCBzb3VjZXMu
DQo+IHMvc291Y2VzL3NvdXJjZXMvDQpPSw0KPiANCj4gPiANCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBEZW5pcyBPc3RlcmxhbmQgPERlbmlzLk9zdGVybGFuZEBkaWVobC5jb20+DQo+
ID4gLS0tDQo+ID4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvaXNpbCxpc2wxMjE5
LnR4dMKgwqB8IDI5ICsrKysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAyOSBpbnNlcnRpb25zKCspDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9pc2lsLGlzbDEyMTkudHh0DQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMv
aXNpbCxpc2wxMjE5LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
dGMvaXNpbCxpc2wxMjE5LnR4dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5mMjZmMWU5ZDRiZGUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9pc2lsLGlzbDEy
MTkudHh0DQo+ID4gQEAgLTAsMCArMSwyOSBAQA0KPiA+ICtJbnRlcnNpbCBJU0wxMjE5IEky
QyBSVEMvQWxhcm0gY2hpcCB3aXRoIGV2ZW50IGluDQo+ID4gKw0KPiA+ICtJU0wxMjE5IGhh
cyBhZGRpdGlvbmFsIHBpbnMgRVZJTiBhbmQgI0VWREVUIGZvciB0YW1wZXIgZGV0ZWN0aW9u
Lg0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllcyBzdXBwb3J0ZWQgYnkgdGhlIGRl
dmljZToNCj4gPiArDQo+ID4gKyAtICJjb21wYXRpYmxlIjogbXVzdCBiZSAiaXNpbCxpc2wx
MjE5Ig0KPiA+ICsgLSAicmVnIjogSTJDIGJ1cyBhZGRyZXNzIG9mIHRoZSBkZXZpY2UNCj4g
PiArDQo+ID4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gKw0KPiA+ICsgLSAiaW50ZXJy
dXB0LW5hbWVzIjogbGlzdCB3aGljaCBtYXkgY29udGFpbnMgImlycSIgYW5kICJldmRldCIN
Cj4gPiArIC0gImludGVycnVwdC1wYXJlbnQiLCAiaW50ZXJydXB0cyIsICJpbnRlcnJ1cHRz
LWV4dGVuZGVkIjoNCj4gPiArwqDCoMKgZm9yIHBhc3NpbmcgdGhlIGludGVycnVwdCBsaW5l
IG9mIHRoZSBTb0MgY29ubmVjdGVkIHRvICNJUlEgcGluDQo+ID4gK8KgwqDCoGFuZCAjRVZE
RVQgcGluIG9mIHRoZSBSVEMgY2hpcC4NCj4gSnVzdCBsaXN0ICdpbnRlcnJ1cHRzJyBhbmQg
aG93IG1hbnkgdGhlcmUgYXJlLiBpbnRlcnJ1cHQtcGFyZW50IGlzwqANCj4gaW1wbGllZCBh
bmQgbWF5IGJlIGluIGEgcGFyZW50IG5vZGUuIGludGVycnVwdHMtZXh0ZW5kZWQgaXMgYWxz
b8KgDQo+IGltcGxpY2l0bHkgYWxsb3dlZCBhcyBuZWVkZWQuDQpXaWxsIGNoYW5nZSB0bzog
ImludGVycnVwdHMiOiBsaXN0IG9mIGludGVycnVwdHMgZm9yICJpcnEiIGFuZCAiZXZkZXQi
DQo+IA0KPiA+IA0KPiA+ICsgLSAiaXNpbCxldi1ldmllbmIiOiBpZiBwcmVzZW50IGJpdCBj
YW4gYmUgc2V0IHRvIGRpc2FibGUgZXZlbnQgaW5wdXQgcHVsbC11cA0KPiA+ICsNCj4gPiAr
DQo+ID4gK0V4YW1wbGUgaXNsMTIxOSBub2RlIHdpdGggI0lSUSBwaW4gY29ubmVjdGVkIHRv
IFNvQyBncGlvMSBwaW4xMg0KPiA+ICsgYW5kICNFVkRFVCBwaW4gY29ubmVjdGVkIHRvIFNv
QyBncGlvMiBwaW4gMjQ6DQo+ID4gKw0KPiA+ICsJaXNsMTIxOTogcnRjQDY4IHsNCj4gPiAr
CQljb21wYXRpYmxlID0gImlzaWwsaXNsMTIxOSI7DQo+ID4gKwkJcmVnID0gPDB4Njg+Ow0K
PiA+ICsJCWludGVycnVwdC1uYW1lcyA9ICJpcnEiLCAiZXZkZXQiOw0KPiA+ICsJCWludGVy
cnVwdHMtZXh0ZW5kZWQgPSA8JmdwaW8xIDEyIElSUV9UWVBFX0VER0VfRkFMTElORz4sDQo+
ID4gKwkJCTwmZ3BpbzIgMjQgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4gPiArCX07DQo+
ID4gKw0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gRGllaGwg
Q29ubmVjdGl2aXR5IFNvbHV0aW9ucyBHbWJIDQo+ID4gR2VzY2jDpGZ0c2bDvGhydW5nOiBI
b3JzdCBMZW9uYmVyZ2VyDQo+ID4gU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBOw7xybmJlcmcg
LSBSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0DQo+ID4gTsO8cm5iZXJnOiBIUkIgMzIz
MTUNCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gPiANCj4gPiBEZXIgSW5oYWx0IGRlciB2b3JzdGVoZW5kZW4gRS1NYWlsIGlzdCBuaWNo
dCByZWNodGxpY2ggYmluZGVuZC4gRGllc2UgRS1NYWlsIGVudGhhZWx0IHZlcnRyYXVsaWNo
ZSB1bmQvb2RlciByZWNodGxpY2ggZ2VzY2h1ZXR6dGUgSW5mb3JtYXRpb25lbi4NCj4gPiBJ
bmZvcm1pZXJlbiBTaWUgdW5zIGJpdHRlLCB3ZW5uIFNpZSBkaWVzZSBFLU1haWwgZmFlbHNj
aGxpY2hlcndlaXNlIGVyaGFsdGVuIGhhYmVuLiBCaXR0ZSBsb2VzY2hlbiBTaWUgaW4gZGll
c2VtIEZhbGwgZGllIE5hY2hyaWNodC4NCj4gPiBKZWRlIHVuZXJsYXVidGUgRm9ybSBkZXIg
UmVwcm9kdWt0aW9uLCBCZWthbm50Z2FiZSwgQWVuZGVydW5nLCBWZXJ0ZWlsdW5nIHVuZC9v
ZGVyIFB1Ymxpa2F0aW9uIGRpZXNlciBFLU1haWwgaXN0IHN0cmVuZ3N0ZW5zIHVudGVyc2Fn
dC4NCj4gPiBUaGUgY29udGVudHMgb2YgdGhlIGFib3ZlIG1lbnRpb25lZCBlLW1haWwgaXMg
bm90IGxlZ2FsbHkgYmluZGluZy4gVGhpcyBlLW1haWwgY29udGFpbnMgY29uZmlkZW50aWFs
IGFuZC9vciBsZWdhbGx5IHByb3RlY3RlZCBpbmZvcm1hdGlvbi4gUGxlYXNlIGluZm9ybSB1
cyBpZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBieQ0KPiA+IG1pc3Rha2UgYW5k
IGRlbGV0ZSBpdCBpbiBzdWNoIGEgY2FzZS4gRWFjaCB1bmF1dGhvcml6ZWQgcmVwcm9kdWN0
aW9uLCBkaXNjbG9zdXJlLCBhbHRlcmF0aW9uLCBkaXN0cmlidXRpb24gYW5kL29yIHB1Ymxp
Y2F0aW9uIG9mIHRoaXMgZS1tYWlsIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuDQoNCkRpZWhs
IENvbm5lY3Rpdml0eSBTb2x1dGlvbnMgR21iSA0KR2VzY2jDpGZ0c2bDvGhydW5nOiBIb3Jz
dCBMZW9uYmVyZ2VyDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IE7DvHJuYmVyZyAtIFJlZ2lz
dGVyZ2VyaWNodDogQW10c2dlcmljaHQNCk7DvHJuYmVyZzogSFJCIDMyMzE1DQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRGVyIEluaGFsdCBk
ZXIgdm9yc3RlaGVuZGVuIEUtTWFpbCBpc3QgbmljaHQgcmVjaHRsaWNoIGJpbmRlbmQuIERp
ZXNlIEUtTWFpbCBlbnRoYWVsdCB2ZXJ0cmF1bGljaGUgdW5kL29kZXIgcmVjaHRsaWNoIGdl
c2NodWV0enRlIEluZm9ybWF0aW9uZW4uDQpJbmZvcm1pZXJlbiBTaWUgdW5zIGJpdHRlLCB3
ZW5uIFNpZSBkaWVzZSBFLU1haWwgZmFlbHNjaGxpY2hlcndlaXNlIGVyaGFsdGVuIGhhYmVu
LiBCaXR0ZSBsb2VzY2hlbiBTaWUgaW4gZGllc2VtIEZhbGwgZGllIE5hY2hyaWNodC4NCkpl
ZGUgdW5lcmxhdWJ0ZSBGb3JtIGRlciBSZXByb2R1a3Rpb24sIEJla2FubnRnYWJlLCBBZW5k
ZXJ1bmcsIFZlcnRlaWx1bmcgdW5kL29kZXIgUHVibGlrYXRpb24gZGllc2VyIEUtTWFpbCBp
c3Qgc3RyZW5nc3RlbnMgdW50ZXJzYWd0Lg0KVGhlIGNvbnRlbnRzIG9mIHRoZSBhYm92ZSBt
ZW50aW9uZWQgZS1tYWlsIGlzIG5vdCBsZWdhbGx5IGJpbmRpbmcuIFRoaXMgZS1tYWlsIGNv
bnRhaW5zIGNvbmZpZGVudGlhbCBhbmQvb3IgbGVnYWxseSBwcm90ZWN0ZWQgaW5mb3JtYXRp
b24uIFBsZWFzZSBpbmZvcm0gdXMgaWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwg
YnkNCm1pc3Rha2UgYW5kIGRlbGV0ZSBpdCBpbiBzdWNoIGEgY2FzZS4gRWFjaCB1bmF1dGhv
cml6ZWQgcmVwcm9kdWN0aW9uLCBkaXNjbG9zdXJlLCBhbHRlcmF0aW9uLCBkaXN0cmlidXRp
b24gYW5kL29yIHB1YmxpY2F0aW9uIG9mIHRoaXMgZS1tYWlsIGlzIHN0cmljdGx5IHByb2hp
Yml0ZWQuIA0K
