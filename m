Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12850C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECA2204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfAOPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:24:05 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:37780 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfAOPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:24:05 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 14FA667A8C7;
        Tue, 15 Jan 2019 16:24:02 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 15 Jan
 2019 16:24:01 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 15 Jan 2019 16:24:01 +0100
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
Thread-Index: AQHUpmuMXeMdtslsvU+hS8nO3SBmbKWsg0qAgAHipwCAAgeLgIAAAZcA
Date:   Tue, 15 Jan 2019 15:24:01 +0000
Message-ID: <7ffa6d92-3fdd-f838-ab6d-185ea5f1c103@kontron.de>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-6-frieder.schrempf@kontron.de>
 <20190113033117.GG11426@dragon>
 <ee3eb5d5-4b04-002e-5e49-d4b766138ec5@kontron.de>
 <20190115151818.GD13895@dragon>
In-Reply-To: <20190115151818.GD13895@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <A70D2C538BB6254E8E263CC9273AD2A0@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 14FA667A8C7.A44DC
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

T24gMTUuMDEuMTkgMTY6MTgsIFNoYXduIEd1byB3cm90ZToNCj4gT24gTW9uLCBKYW4gMTQsIDIw
MTkgYXQgMDg6MTg6NDlBTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IEhpIFNo
YXduLA0KPj4NCj4+IE9uIDEzLjAxLjE5IDA0OjMxLCBTaGF3biBHdW8gd3JvdGU6DQo+Pj4gT24g
TW9uLCBKYW4gMDcsIDIwMTkgYXQgMDk6Mjk6NTRBTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3
cm90ZToNCj4+Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250
cm9uLmRlPg0KPj4+Pg0KPj4+PiBBZnRlciBzd2l0Y2hpbmcgdG8gdGhlIG5ldyBGU0wgUVNQSSBk
cml2ZXIgdGhlIHByb3BlcnR5DQo+Pj4+ICdmc2wscXNwaS1oYXMtc2Vjb25kLWNoaXAnIGlzIG5v
dCBuZWVkZWQgYW55bW9yZS4NCj4+Pj4NCj4+Pj4gVGhlIGRyaXZlciBub3cgdXNlcyB0aGUgJ3Jl
ZycgcHJvcGVydHkgdG8gZGV0ZXJtaW5lIHRoZSBidXMgYW5kDQo+Pj4+IHRoZSBjaGlwc2VsZWN0
Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNj
aHJlbXBmQGtvbnRyb24uZGU+DQo+Pj4NCj4+PiBBcHBsaWVkLCB0aGFua3MuDQo+Pg0KPj4gSSBq
dXN0IG5vdGljZWQsIHRoYXQgdGhpcyBhbmQgdGhlIGFybTY0IHBhdGNoIGRlcGVuZCBvbiB0aGUg
ZHJpdmVyDQo+PiBjaGFuZ2VzIGZvciA1LjEgdGhhdCBnbyB0aHJvdWdoIHRoZSBTUEkgdHJlZS4g
U28gSSBndWVzcyB3ZSBjYW4ndCBiZQ0KPj4gc3VyZSB0aGF0IHRoaXMgd2lsbCBiZSBtZXJnZWQg
aW4gdGhlIHJpZ2h0IG9yZGVyIGFuZCB3ZSBuZWVkIHRvIGRlbGF5DQo+PiB0aGlzIGNsZWFudXAg
dG8gNS4yLCBvciBhbSBJIHdyb25nPw0KPiANCj4gWW91IGFyZSByaWdodC4gIEkganVzdCBkcm9w
cGVkIHRoZSBib3RoIHBhdGNoZXMuICBQaW5nIG1lIG9yIHJlc2VuZCB3aGVuDQo+IHRoZXkgYXJl
IHJlYWR5IHRvIGdvLg0KDQpUaGFua3MsIHdpbGwgZG8gc28uDQoNCkZyaWVkZXI=
