Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E51C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB1020663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfANISy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:18:54 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:45058 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:18:53 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 9CCC167A7DD;
        Mon, 14 Jan 2019 09:18:49 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 14 Jan
 2019 09:18:49 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 14 Jan 2019 09:18:49 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/7] ARM: dts: ls1021a: Remove fsl,qspi-has-second-chip
 as it is not used
Thread-Topic: [PATCH v8 5/7] ARM: dts: ls1021a: Remove
 fsl,qspi-has-second-chip as it is not used
Thread-Index: AQHUpmuMXeMdtslsvU+hS8nO3SBmbKWsg0qAgAHipwA=
Date:   Mon, 14 Jan 2019 08:18:49 +0000
Message-ID: <ee3eb5d5-4b04-002e-5e49-d4b766138ec5@kontron.de>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-6-frieder.schrempf@kontron.de>
 <20190113033117.GG11426@dragon>
In-Reply-To: <20190113033117.GG11426@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <310689CA697D9A40888BAC72345605E9@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 9CCC167A7DD.A2B79
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        fabio.estevam@nxp.com, han.xu@nxp.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, robh+dt@kernel.org, shawnguo@kernel.org,
        yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCk9uIDEzLjAxLjE5IDA0OjMxLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9uIE1v
biwgSmFuIDA3LCAyMDE5IGF0IDA5OjI5OjU0QU0gKzAwMDAsIFNjaHJlbXBmIEZyaWVkZXIgd3Jv
dGU6DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24u
ZGU+DQo+Pg0KPj4gQWZ0ZXIgc3dpdGNoaW5nIHRvIHRoZSBuZXcgRlNMIFFTUEkgZHJpdmVyIHRo
ZSBwcm9wZXJ0eQ0KPj4gJ2ZzbCxxc3BpLWhhcy1zZWNvbmQtY2hpcCcgaXMgbm90IG5lZWRlZCBh
bnltb3JlLg0KPj4NCj4+IFRoZSBkcml2ZXIgbm93IHVzZXMgdGhlICdyZWcnIHByb3BlcnR5IHRv
IGRldGVybWluZSB0aGUgYnVzIGFuZA0KPj4gdGhlIGNoaXBzZWxlY3QuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0K
PiANCj4gQXBwbGllZCwgdGhhbmtzLg0KDQpJIGp1c3Qgbm90aWNlZCwgdGhhdCB0aGlzIGFuZCB0
aGUgYXJtNjQgcGF0Y2ggZGVwZW5kIG9uIHRoZSBkcml2ZXIgDQpjaGFuZ2VzIGZvciA1LjEgdGhh
dCBnbyB0aHJvdWdoIHRoZSBTUEkgdHJlZS4gU28gSSBndWVzcyB3ZSBjYW4ndCBiZSANCnN1cmUg
dGhhdCB0aGlzIHdpbGwgYmUgbWVyZ2VkIGluIHRoZSByaWdodCBvcmRlciBhbmQgd2UgbmVlZCB0
byBkZWxheSANCnRoaXMgY2xlYW51cCB0byA1LjIsIG9yIGFtIEkgd3Jvbmc/DQoNClRoYW5rcywN
CkZyaWVkZXI=
