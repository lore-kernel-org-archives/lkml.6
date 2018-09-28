Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6640C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED492064D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED492064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbeI1VPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:15:39 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:63234 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeI1VPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:15:38 -0400
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="17955849"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Sep 2018 07:51:30 -0700
Received: from CHN-SV-EXMX02.mchp-main.com ([fe80::7dfe:3761:863e:3963]) by
 CHN-SV-EXCH07.mchp-main.com ([::1]) with mapi id 14.03.0352.000; Fri, 28 Sep
 2018 07:51:30 -0700
From:   <Yuiko.Oshino@microchip.com>
To:     <f.fainelli@gmail.com>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <m.felsch@pengutronix.de>, <Markus.Niebel@tqs.de>,
        <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 net-next 0/2] Add support for Microchip Technology
 KSZ9131 10/100/1000 Ethernet PHY
Thread-Topic: [PATCH v2 net-next 0/2] Add support for Microchip Technology
 KSZ9131 10/100/1000 Ethernet PHY
Thread-Index: AQHUVphya4zNLsRTRkuap5x4toOLSqUFx67w
Date:   Fri, 28 Sep 2018 14:51:29 +0000
Message-ID: <6AF1B4F019F8804DB17BB6F30B56F026DCBCBD@CHN-SV-EXMX02.mchp-main.com>
References: <1538079344-6152-1-git-send-email-yuiko.oshino@microchip.com>
 <7c84dfed-6864-7b25-38d1-9bed1cfea0bc@gmail.com>
In-Reply-To: <7c84dfed-6864-7b25-38d1-9bed1cfea0bc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDA5LzI3LzIwMTggMDE6MTUgUE0sIFl1aWtvIE9zaGlubyB3cm90ZToNCj4+IFRoaXMgaXMg
dGhlIGluaXRpYWwgZHJpdmVyIGZvciBNaWNyb2NoaXAgS1NaOTEzMSAxMC8xMDAvMTAwMCBFdGhl
cm5ldA0KPj4gUEhZDQo+Pg0KPj4gdjI6DQo+PiAtIENyZWF0aW5nIGEgc2VyaWVzIGZyb20gdHdv
IHJlbGF0ZWQgcGF0Y2hlcy4NCj4NCj5XaGVuIHBlb3BsZSBnaXZlIHlvdSBBY2tlZC1ieSBvciBS
ZXZpZXdlZC1ieSB0YWdzIGluIHByaW9yIHZlcnNpb25zLCBpdCBpcyB1c3VhbGx5DQo+YSBnb29k
ICBwcmFjdGljZSB0byBhZGQgdGhlbSB0byB5b3VyIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2gg
c3VibWlzc2lvbi4gQWxzbywNCj55b3VyIHBhdGNoZXMgMSBhbmQgMiBkaWQgbm90IHNob3cgdXAg
YXMgYXMgcmVwbHkgdG8gdGhpcyBjb3ZlciBsZXR0ZXIsIHdoaWxlIHRoZXkNCj5zaG91bGQsIHBs
ZWFzZSBmaXggdGhpcyBpZiB5b3UgZXZlciBuZWVkIHRvIHN1Ym1pdCBuZXcgcGF0Y2hlcyBpbiB0
aGUgZnV0dXJlLg0KPg0KPlRoYW5rIHlvdSENCg0KRmxvcmlhbiwNClRoYW5rIHlvdSBmb3IgeW91
ciByZXZpZXdzLiBTb3JyeSBJIGZvcmdvdCB0byBhZGQgQWNrZWQtYnkuDQpJcyBzZWVtcyBsaWtl
IEkgYW0gbW9kaWZ5aW5nIHRoZSBkdC1iaW5kaW5nIGRvYywgc28gSSB3aWxsIHN1Ym1pdCB2My4N
ClRoYW5rIHlvdSENCg0KPg0KPi0tDQo+Rmxvcmlhbg0KDQpZdWlrbw0K
