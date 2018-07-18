Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1347ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0D32075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0D32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeGRIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:31:53 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:2765 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbeGRIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:31:53 -0400
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,369,1526335200"; 
   d="scan'208";a="34274852"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] rtc: isl1219: add device tree docu
Thread-Topic: [PATCH v4 5/5] rtc: isl1219: add device tree docu
Thread-Index: AQHUGDKQQPZVuDcxn0uq52IAiz//4qSUgtAAgAAEjYA=
Date:   Wed, 18 Jul 2018 07:55:07 +0000
Message-ID: <1531900507.6017.13.camel@diehl.com>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
         <20180710090710.9066-6-Denis.Osterland@diehl.com>
         <20180718073850.GH3211@piout.net>
In-Reply-To: <20180718073850.GH3211@piout.net>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc9TAVn8G8ROyCylt5SD7VterozKSx7vTphlUwlLDc535
X-TNEFEvaluated: 1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <2FB2BD06D7033B4FA682EF07C890C280@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkFtIE1pdHR3b2NoLCBkZW4gMTguMDcuMjAxOCwgMDk6MzggKzAyMDAgc2No
cmllYiBBbGV4YW5kcmUgQmVsbG9uaToNCj4gSGksDQo+IA0KPiBPbiAxMC8wNy8yMDE4IDA5
OjQ0OjE1KzAwMDAsIERlbmlzIE9TVEVSTEFORCB3cm90ZToNCj4gPsKgDQo+ID4gKw0KPiA+
ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICsNCj4gPiArIC0gImludGVycnVwdC1uYW1l
cyI6IGxpc3Qgd2hpY2ggbWF5IGNvbnRhaW5zICJpcnEiIGFuZCAiZXZkZXQiDQo+ID4gKyAt
ICJpbnRlcnJ1cHQtcGFyZW50IiwgImludGVycnVwdHMiLCAiaW50ZXJydXB0cy1leHRlbmRl
ZCI6DQo+ID4gK8KgwqDCoGZvciBwYXNzaW5nIHRoZSBpbnRlcnJ1cHQgbGluZSBvZiB0aGUg
U29DIGNvbm5lY3RlZCB0byAjSVJRIHBpbg0KPiA+ICvCoMKgwqBhbmQgI0VWREVUIHBpbiBv
ZiB0aGUgUlRDIGNoaXAuDQo+ID4gKyAtICJpc2lsLGV2LWV2aWVuYiI6IGlmIHByZXNlbnQg
Yml0IGNhbiBiZSBzZXQgdG8gZGlzYWJsZSBldmVudCBpbnB1dCBwdWxsLXVwDQo+IEkgd291
bGQgdXNlIGEgY2xlYXJlciBuYW1lIGZvciB0aGF0IHByb3BlcnR5IGxpa2UgaXNpbCxldi1w
dWxsLXVwLWVuYWJsZWQuDQo+IA0KPiBBbHNvIG1ha2UgaXQgYW4gaW50IHNvIDAgaXMgZGlz
YWJsaW5nIHRoZSBwdWxsLXVwIChFVklFTkIgc2V0IHRvIDEpIDEgaXMNCj4gZW5hYmxpbmcg
dGhlIHB1bGwtdXAgKEVWSUVOQiBzZXQgdG8gMCkgYW5kIGRvIG5vdGhpbmcgd2hlbiB0aGUg
cHJvcGVydHkNCj4gaXMgbm90IHByZXNlbnQuDQpJdCBpcyBkZXNpZ25lZCBsaWtlwqBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2lzaWwsaXNsMTIwMjYudHh0LA0K
d2hpY2ggdXNlcyB0aGUgYml0IG5hbWUgZnJvbSBEb2N1bWVudGF0aW9uIGFzIHdlbGwuDQpJ
IHdpbGwgY2hhbmdlIHRvIGludGVnZXIgdHlwZS4NCj4gDQo+IA0KUmVnYXJkcyBEZW5pcw0K
DQpEaWVobCBDb25uZWN0aXZpdHkgU29sdXRpb25zIEdtYkgNCkdlc2Now6RmdHNmw7xocnVu
ZzogSG9yc3QgTGVvbmJlcmdlcg0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBOw7xybmJlcmcg
LSBSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0DQpOw7xybmJlcmc6IEhSQiAzMjMxNQ0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCkRlciBJ
bmhhbHQgZGVyIHZvcnN0ZWhlbmRlbiBFLU1haWwgaXN0IG5pY2h0IHJlY2h0bGljaCBiaW5k
ZW5kLiBEaWVzZSBFLU1haWwgZW50aGFlbHQgdmVydHJhdWxpY2hlIHVuZC9vZGVyIHJlY2h0
bGljaCBnZXNjaHVldHp0ZSBJbmZvcm1hdGlvbmVuLg0KSW5mb3JtaWVyZW4gU2llIHVucyBi
aXR0ZSwgd2VubiBTaWUgZGllc2UgRS1NYWlsIGZhZWxzY2hsaWNoZXJ3ZWlzZSBlcmhhbHRl
biBoYWJlbi4gQml0dGUgbG9lc2NoZW4gU2llIGluIGRpZXNlbSBGYWxsIGRpZSBOYWNocmlj
aHQuDQpKZWRlIHVuZXJsYXVidGUgRm9ybSBkZXIgUmVwcm9kdWt0aW9uLCBCZWthbm50Z2Fi
ZSwgQWVuZGVydW5nLCBWZXJ0ZWlsdW5nIHVuZC9vZGVyIFB1Ymxpa2F0aW9uIGRpZXNlciBF
LU1haWwgaXN0IHN0cmVuZ3N0ZW5zIHVudGVyc2FndC4NClRoZSBjb250ZW50cyBvZiB0aGUg
YWJvdmUgbWVudGlvbmVkIGUtbWFpbCBpcyBub3QgbGVnYWxseSBiaW5kaW5nLiBUaGlzIGUt
bWFpbCBjb250YWlucyBjb25maWRlbnRpYWwgYW5kL29yIGxlZ2FsbHkgcHJvdGVjdGVkIGlu
Zm9ybWF0aW9uLiBQbGVhc2UgaW5mb3JtIHVzIGlmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMg
ZS1tYWlsIGJ5DQptaXN0YWtlIGFuZCBkZWxldGUgaXQgaW4gc3VjaCBhIGNhc2UuIEVhY2gg
dW5hdXRob3JpemVkIHJlcHJvZHVjdGlvbiwgZGlzY2xvc3VyZSwgYWx0ZXJhdGlvbiwgZGlz
dHJpYnV0aW9uIGFuZC9vciBwdWJsaWNhdGlvbiBvZiB0aGlzIGUtbWFpbCBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkLiANCg==
