Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE6DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27262133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27262133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeK1Bt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:49:27 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:37646 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeK1Bt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:49:26 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id A4004679696;
        Tue, 27 Nov 2018 15:51:07 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 27 Nov
 2018 15:51:07 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 27 Nov 2018 15:51:07 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v6 1/9] ARM: dts: Reflect change of FSL QSPI driver and
 remove unused properties
Thread-Topic: [PATCH v6 1/9] ARM: dts: Reflect change of FSL QSPI driver and
 remove unused properties
Thread-Index: AQHUhjtbWFBD/g7imkCtHxLSenAFw6VjY+QAgABAIQA=
Date:   Tue, 27 Nov 2018 14:51:07 +0000
Message-ID: <145763f0-1e5c-3886-a11f-b37677715989@kontron.de>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
 <1543314174-28580-2-git-send-email-frieder.schrempf@kontron.de>
 <20181127110134.7xdwo7ird44qj2ih@pengutronix.de>
In-Reply-To: <20181127110134.7xdwo7ird44qj2ih@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <5841465BB16FB44B85413D4E8E3104D8@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: A4004679696.AC9B0
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        fabio.estevam@nxp.com, han.xu@nxp.com, kernel@pengutronix.de,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, u.kleine-koenig@pengutronix.de,
        yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVXdlLA0KDQpJIGFjY2lkZW50YWxseSByZXBsaWVkIHRvIHRoZSBNVEQgbGlzdCBvbmx5LCBt
aXNzaW5nIHRoZSBvdGhlciANCnJlY2lwaWVudHMsIGVhcmxpZXIgdG9kYXkuIFNvIGhlcmUgY29t
ZXMgdGhlIHJlcGx5IGFnYWluLg0KDQpPbiAyNy4xMS4xOCAxMjowMSwgVXdlIEtsZWluZS1Lw7Zu
aWcgd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gT24gVHVlLCBOb3YgMjcsIDIwMTggYXQgMTA6MjQ6
MTlBTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IFRoZSBGU0wgUVNQSSBkcml2
ZXIgd2lsbCBiZSBtb3ZlZCB0byB0aGUgU1BJIGZyYW1ld29yayBhbmQgaXQgdGhlbg0KPj4gYWN0
cyBhcyBhIFNQSSBjb250cm9sbGVyLiBUaGVyZWZvcmUgdGhlIHN1Ym5vZGVzIG5lZWQgdG8gc2V0
DQo+PiBzcGktW3J4L3R4XS1idXMtd2lkdGggPSA8ND4sIHNvIHF1YWQgbW9kZSBpcyB1c2VkIGp1
c3QgYXMgYmVmb3JlLg0KPj4NCj4+IEFsc28gdGhlIHByb3BlcnRpZXMgJ2J1cy1udW0nLCAnZnNs
LHNwaS1udW0tY2hpcHNlbGVjdHMnIGFuZA0KPj4gJ2ZzbCxzcGktZmxhc2gtY2hpcHNlbGVjdHMn
IHdlcmUgbmV2ZXIgcmVhZCBieSB0aGUgZHJpdmVyIGFuZA0KPj4gY2FuIGJlIHJlbW92ZWQuDQo+
Pg0KPj4gVGhlICdyZWcnIHByb3BlcnRpZXMgYXJlIGFkanVzdGVkIHRvIHJlZmxlY3Qgd2hhdCBi
dXMgYW5kDQo+PiBjaGlwc2VsZWN0IHRoZSBmbGFzaCBpcyBjb25uZWN0ZWQgdG8sIGFzIHRoZSBu
ZXcgZHJpdmVyIG5lZWRzDQo+PiB0aGlzIGluZm9ybWF0aW9uLg0KPj4NCj4+IFRoZSBwcm9wZXJ0
eSAnZnNsLHFzcGktaGFzLXNlY29uZC1jaGlwJyBpcyBub3QgbmVlZGVkIGFueW1vcmUNCj4+IGFu
ZCB3aWxsIGJlIHJlbW92ZWQgYWZ0ZXIgdGhlIG9sZCBkcml2ZXIgd2FzIGRpc2FibGVkIHRvIGF2
b2lkDQo+PiBicmVha2luZyBsczEwMjFhLW1veGEtdWMtODQxMGEuZHRzLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4N
Cj4gDQo+IGRvIHdlIG5lZWQgdG8gY2hhbmdlIHRoZSBiaW5kaW5nIGRvY3VtZW50IGFjY29yZGlu
Z2x5Pw0KDQpCaW5kaW5ncyBhcmUgY2hhbmdlZCBoZXJlOiBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3BhdGNoLzEwMDM3NjEvDQoNClRoYW5rcywNCkZyaWVkZXI=
