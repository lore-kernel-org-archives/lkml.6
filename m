Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F219F2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F219F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeKLUja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:39:30 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:42942 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeKLUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:39:29 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 430652A8D226;
        Mon, 12 Nov 2018 11:46:46 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 12 Nov
 2018 11:46:45 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Mon, 12 Nov 2018 11:46:45 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Olof Johansson <olof@lixom.net>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Eric Anholt <eric@anholt.net>, Stefan Agner <stefan@agner.ch>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "yannick.fertre@st.com" <yannick.fertre@st.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
Thread-Topic: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
Thread-Index: AQHUdqh4fJ7CTSTis0KZzqRTstzHg6VEbX+AgAAEaoCAAQvXgIAGbi2A
Date:   Mon, 12 Nov 2018 10:46:45 +0000
Message-ID: <b01d70ae-9feb-985a-8001-dba54206662d@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
 <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
 <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
 <20181108093451.08dfe63e@bbrezillon>
In-Reply-To: <20181108093451.08dfe63e@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <488850F0A853A84A8DE0BBCA83E1F7B7@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 430652A8D226.A81A9
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: alexandre.torgue@st.com, arnd@arndb.de,
        boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        dwmw2@infradead.org, eric@anholt.net, fabio.estevam@nxp.com,
        frieder.schrempf@exceet.de, geert+renesas@glider.be, han.xu@nxp.com,
        horms+renesas@verge.net.au, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux@armlinux.org.uk,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, olof@lixom.net,
        prabhakar.kushwaha@nxp.com, richard@nod.at, s.hauer@pengutronix.de,
        shawnguo@kernel.org, stefan.wahren@i2se.com, stefan@agner.ch,
        tony@atomide.com, yannick.fertre@st.com, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMTEuMTggMDk6MzQsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gV2VkLCA3IE5v
diAyMDE4IDE2OjM2OjEzICswMDAwDQo+IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVt
cGZAa29udHJvbi5EZT4gd3JvdGU6DQo+IA0KPj4gSGkgT2xvZiwNCj4+DQo+PiBPbiAwNy4xMS4x
OCAxNzoyMCwgT2xvZiBKb2hhbnNzb24gd3JvdGU6DQo+Pj4gT24gV2VkLCBOb3YgNywgMjAxOCBh
dCA2OjQ0IEFNIEZyaWVkZXIgU2NocmVtcGYNCj4+PiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9u
LmRlPiB3cm90ZToNCj4+Pj4NCj4+Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5z
Y2hyZW1wZkBleGNlZXQuZGU+DQo+Pj4+DQo+Pj4+IFRoZSBuZXcgZHJpdmVyIGF0IHNwaS9zcGkt
ZnNsLXFzcGkuYyByZXBsYWNlcyB0aGUgb2xkIFNQSSBOT1IgZHJpdmVyDQo+Pj4+IGF0IG10ZC9m
c2wtcXVhZHNwaS5jLiBTd2l0Y2ggdG8gdGhlIG5ldyBkcml2ZXIgaW4gdGhlIGRlZmNvbmZpZ3Mu
DQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2No
cmVtcGZAZXhjZWV0LmRlPg0KPj4+DQo+Pj4gSGkgRnJpZWRlciwNCj4+Pg0KPj4+IFRoaXMgcGF0
Y2ggaXMgcGFydCBvZiBhIHNlcmllcyB0aGF0IEkgZGlkbid0IHNlZSB0aGUgcmVzdCBvZiwgYnV0
IGluDQo+Pj4gZ2VuZXJhbCB3ZSBwcmVmZXIgdG8gbWVyZ2UgdGhlc2UgdGhyb3VnaCBhcm0tc29j
IGV2ZW4gaWYgdGhlIGRyaXZlcg0KPj4+IGdvZXMgaW4gdGhyb3VnaCBhbm90aGVyIHRyZWUuIFRo
ZSB3YXkgd2UnZCBwcmVmZXIgdG8gaGFuZGxlIGl0IGlzIHRoYXQNCj4+PiBvbmNlIHRoZSBkcml2
ZXIgbGFuZHMsIHdlJ2xsIHRha2UgdGhlIGNvbmZpZyBvcHRpb24gY2hhbmdlIHRvIHR1cm4gaXQN
Cj4+PiBvbi4gVG8gYXZvaWQgb3VyIGJyYW5jaGVzIHRvIGJyZWFrIHVudGlsIGJvdGggc2lkZXMg
aGF2ZSBsYW5kZWQsIGl0DQo+Pj4gbWlnaHQgYmUgYSBnb29kIGlkZWEgdG8ga2VlcCBib3RoIGRy
aXZlcnMgb24gZm9yIGEgc2hvcnQgd2hpbGUgKG9uZQ0KPj4+IHJlbGVhc2UpLg0KPj4+DQo+Pj4g
U28sIEknbSBub3QgZ29pbmcgdG8gYWNrIHRoaXMgc2luY2Ugd2UgYXZvaWQgdGFraW5nIGRlZmNv
bmZpZyBjaGFuZ2VzDQo+Pj4gdGhyb3VnaCBkcml2ZXIgdHJlZXMgKHRoZXNlIHR3byBkZWZjb25m
aWdzIHRlbmQgdG8gY2h1cm4gYSBsb3QgYW5kIHdlDQo+Pj4gZG9uJ3Qgd2FudCB0byBjcmVhdGUg
bWVyZ2UgY29uZmxpY3RzIHdoZXJlIHdlIGRvbid0IGhhdmUgdG8pLCBidXQNCj4+PiB3ZSdsbCBi
ZSBoYXBweSB0byBwaWNrIGl0IHVwIHdoZW4gdGhlIHRpbWUgY29tZXMuDQo+Pg0KPj4gT2ssIHRo
YW5rIHlvdSBmb3IgZXhwbGFpbmluZyB0aGUgY29tbW9uIHByYWN0aWNlLiBJIHdpbGwgZHJvcCB0
aGUgY29uZmlnDQo+PiBjaGFuZ2VzIGZvciB0aGUgbmV4dCB2ZXJzaW9uIGFuZCBzZW5kIGl0IHNl
cGFyYXRlbHkgd2hlbiB0aGUgdGltZSBpcyByZWFkeS4NCj4+DQo+PiBCb3RoIHRoZSBvbGQgZHJp
dmVyIGFuZCB0aGUgbmV3IG9uZSB1c2UgdGhlIHNhbWUgY29tcGF0aWJsZSBzdHJpbmdzIGZvcg0K
Pj4gcHJvYmluZy4gV291bGRuJ3QgdGhhdCBjYXVzZSBwcm9ibGVtcyBpZiBib3RoIGRyaXZlcnMg
YXJlIGVuYWJsZWQgZm9yIGENCj4+IHdoaWxlLCBvciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0K
PiANCj4gT3IgbWF5YmUgd2Ugc2hvdWxkIG5vdCBpbnRyb2R1Y2UgYSBuZXcgS2NvbmZpZyBvcHRp
b24gYW5kIGp1c3QgcmV1c2UNCj4gdGhlIG9sZCBvbmUuIEl0IHByb2JhYmx5IHJlcXVpcmVzIHJl
LW9yZGVyaW5nIHBhdGNoZXMgYSBiaXQgKHBhdGNoIDENCj4gc2hvdWxkIGJlIG1vdmVkIGFmdGVy
IHBhdGNoIDUpLiBUaGVuIHlvdSBoYXZlIDIgY2hvaWNlczoNCj4gDQo+IDEvIG1lcmdlIHBhdGNo
IDEgYW5kIDYgc28gdGhhdCB0aGUgbmV3IGRyaXZlciBlZmZlY3RpdmVseSByZXBsYWNlcyB0aGUN
Cj4gICAgIG9sZCBvbmUgYnV0IHVzZXMgdGhlIHNhbWUgS2NvbmZpZyBvcHRpb24NCj4gMi8gcmVt
b3ZlIHRoZSBhYmlsaXR5IHRvIGNvbXBpbGUgdGhlIG9sZCBkcml2ZXIgd2hlbiB0aGUgbmV3IG9u
ZSBpcw0KPiAgICAgaW50cm9kdWNlZDogcmVtb3ZlIHRoZSBsaW5lIGZyb20gZHJpdmVycy9tdGQv
c3BpLW5vciBNYWtlZmlsZSBhbmQNCj4gICAgIG1vdmUgdGhlIEtjb25maWcgZW50cnkgZnJvbSBk
cml2ZXJzL210ZC9zcGktbm9yL0tjb25maWcgdG8NCj4gICAgIGRyaXZlcnMvc3BpL0tjb25maWcu
IEFuZCByZW1vdmUgdGhlIG9sZCBjb2RlIGluIGEgc2VwYXJhdGUgcGF0Y2gNCj4gDQo+IEknbSBm
aW5lIGVpdGhlciB3YXksIGJ1dCBvcHRpb24gIzIgd2lsbCBwcm9iYWJseSBtYWtlIHRoZSBwYXRj
aA0KPiBpbnRyb2R1Y2luZyB0aGUgbmV3IGRyaXZlciBiaWdnZXIgYW5kIGh1cnQgcmVhZGFiaWxp
dHkuDQoNCkkgdGhpbmsgaGF2aW5nIGJvdGggZHJpdmVycyBpbiB0aGUgdHJlZSBmb3IgYSB3aGls
ZSB3b3VsZG4ndCBiZSBzbyBiYWQuIA0KU28gaWYgYW55IGNvbXBhdGliaWxpdHkgaXNzdWVzIGNv
bWUgdXAgd2l0aCB0aGUgbmV3IGRyaXZlciwgcGVvcGxlIGNhbiANCnN0aWxsIHVzZSB0aGUgb2xk
IG9uZS4NCg0KVGhlcmVmb3JlIEkgdGhpbmsgSSB3aWxsIGRyb3AgdGhlIHBhdGNoZXMgdGhhdCBj
aGFuZ2UgdGhlIGRlZmNvbmZpZyBhbmQgDQpyZW1vdmUgdGhlIG9sZCBkcml2ZXIgY29kZSBhbmQg
a2VlcCB0aGUgZGlmZmVyZW50IEtjb25maWcgb3B0aW9ucy4gQW5kIA0KbWF5YmUgYWRkIGFuIGV4
Y2x1c2l2ZSBkZXBlbmRlbmN5IGluIEtjb25maWcsIHNvIGJvdGggZHJpdmVycyBjYW4gbm90IGJl
IA0KZW5hYmxlZCBhdCB0aGUgc2FtZSB0aW1lLg0KDQpEb2VzIHRoaXMgbWFrZSBzZW5zZT8=
