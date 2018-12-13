Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE890C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE2A2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE2A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbeLMJpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:45:08 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:39624 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeLMJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:45:08 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id DAB566797F6;
        Thu, 13 Dec 2018 10:45:04 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 13 Dec
 2018 10:45:04 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Thu, 13 Dec 2018 10:45:04 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Topic: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Index: AQHUkKVtG6It8sv/EE6xXPNZqAZcLKV4GW2AgARFkAA=
Date:   Thu, 13 Dec 2018 09:45:04 +0000
Message-ID: <1ad93cdf-7ba1-ff49-f330-6bbd0f6c6972@kontron.de>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
 <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
In-Reply-To: <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1B04C5ECA6D974FBFDB5AE84BF4749D@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: DAB566797F6.A1B8A
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        devicetree@vger.kernel.org, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBTaGF3biwgU2FzY2hhDQoNCk9uIDEwLjEyLjE4IDE3OjMxLCBTY2hyZW1wZiBGcmllZGVyIHdy
b3RlOg0KPiBIaSBGU0wvQVJNIG1haW50YWluZXJzLA0KPiANCj4gT24gMTAuMTIuMTggMTc6MjYs
IFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmll
ZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+Pg0KPj4gV2UgaGF2ZSBwcmVwYXJlZCBhIG5ldyBk
cml2ZXIgZm9yIHRoZSBGU0wgUVNQSSBjb250cm9sbGVyIHRoYXQgd29ya3MgdW5kZXINCj4+IHRo
ZSBTUEkgZnJhbWV3b3JrLiBUaGUgY3VycmVudCBkZXZpY2V0cmVlcyBhcmUgYnJva2VuIGJlY2F1
c2UgdGhleSB1c2UgYW4NCj4+IGluY29uc2lzdGVudCBzY2hlbWUgZm9yIGFzc2lnbmluZyB0aGUg
cmVnIHByb3BlcnRpZXMuDQo+Pg0KPj4gQXMsIGluIGNvbnRyYXN0IHRvIHRoZSBjdXJyZW50IGRy
aXZlciwgdGhlIG5ldyBkcml2ZXIgd2lsbCB1c2UgdGhlIHJlZw0KPj4gcHJvcGVydGllcyB0byBz
ZWxlY3QgdGhlIGNvcnJlY3QgY2hpcCwgd2UgbmVlZCB0byBmaXggdGhlbS4NCj4+DQo+PiBXZSBh
bHNvIGFkZCBzcGktW3R4L3J4XS1idXMtd2lkdGggdG8gbWFrZSBzdXJlIHRoZSBmdWxsIGJ1c3dp
ZHRoIHdpbGwgYmUgdXNlZA0KPj4gYW5kIHdoaWxlIGF0IGl0IGNsZWFuIHVwIGFuZCByZW1vdmUg
c29tZSB1bnVzZWQgcHJvcGVydGllcy4NCj4gDQo+IGNvdWxkIHlvdSBwbGVhc2UgY29uc2lkZXIg
dGhlc2UgZGV2aWNldHJlZSBwYXRjaGVzIGZvciB2NC4yMT8NCg0KQW55IGNoYW5jZSB0byBnZXQg
dGhpcyBtZXJnZWQ/IE90aGVyd2lzZSB3ZSB3b3VsZCBuZWVkIHRvIHBvc3Rwb25lIHRoZSANCm5l
dyBkcml2ZXIgZXZlbiBmdXJ0aGVyLg0KDQpBbGwgdGhlIGNoYW5nZXMgdG8gdGhlIGRldmljZXRy
ZWVzIGluIHRoaXMgc2VyaWVzIGFyZSBub24taW50cnVzaXZlIGFuZCANCnVuY3JpdGljYWwsIGFu
eXdheS4NCg0KVGhhbmtzLA0KRnJpZWRlcg0KDQo+IA0KPiBXZSBoYXZlIHRoZSBuZXcgRlNMIFFT
UEkgZHJpdmVyIHVuZGVyIHRoZSBTUEkgZnJhbWV3b3JrIChbMV0pIHJlYWR5LCBidXQNCj4gd2Ug
bmVlZCBzb21lIHNtYWxsIGZpeGVzIHRvIHRoZSBkZXZpY2V0cmVlcyB0aGF0IGFyZSBjdXJyZW50
bHkgYnJva2VuLg0KPiANCj4gQXMgdGhlIG5ldyBkcml2ZXIgZGVwZW5kcyBvbiB0aGVzZSBjaGFu
Z2VzIChtYWlubHkgdGhlIGNoYW5nZSB0byB0aGUgcmVnDQo+IHByb3BlcnRpZXMpIGFuZCBpdCBp
cyBub3QgcG9zc2libGUgdG8gYWRkIGNvbXBhdGliaWxpdHkgZm9yIHRoZSBvbGQNCj4gYmluZGlu
Z3MsIGl0IHdvdWxkIGJlIHJlYWxseSBuaWNlIHRvIGhhdmUgdGhlbSBpbiB2NC4yMSwgc28gd2Ug
Y2FuIHF1ZXVlDQo+IHRoZSBkcml2ZXIgZm9yIHY0LjIyIG9yIHdoYXRldmVyIHRoZSBuZXh0IHJl
bGVhc2Ugd2lsbCBiZSBjYWxsZWQuDQo+IA0KPiBQbGVhc2UgYWxzbyBzZWUgWzJdIGZvciBzb21l
IG1vcmUgZXhwbGFuYXRpb24uDQo+IA0KPiBUaGFua3MsDQo+IEZyaWVkZXINCj4gDQo+IFsxXSBo
dHRwczovL3BhdGNod29yay5vemxhYnMub3JnL2NvdmVyLzEwMDc2NDEvDQo+IFsyXSBodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzkyMjgxNy8jMTkyNTQ0NQ0KPiANCj4+DQo+PiBG
cmllZGVyIFNjaHJlbXBmICg1KToNCj4+ICAgICBhcm02NDogZHRzOiBSZW1vdmUgdW51c2VkIHBy
b3BlcnRpZXMgZnJvbSBGU0wgUVNQSSBkcml2ZXIgbm9kZXMNCj4+ICAgICBBUk06IGR0czogUmVt
b3ZlIHVudXNlZCBwcm9wZXJ0aWVzIGZyb20gRlNMIFFTUEkgZHJpdmVyIG5vZGVzDQo+PiAgICAg
QVJNOiBkdHM6IGlteDZzeC1zZGI6IEZpeCB0aGUgcmVnIHByb3BlcnRpZXMgZm9yIHRoZSBGU0wg
UVNQSSBub2Rlcw0KPj4gICAgIGFybTY0OiBkdHM6IEFkZCBzcGktW3R4L3J4XS1idXMtd2lkdGgg
Zm9yIHRoZSBGU0wgUVNQSSBjb250cm9sbGVyDQo+PiAgICAgQVJNOiBkdHM6IEFkZCBzcGktW3R4
L3J4XS1idXMtd2lkdGggZm9yIHRoZSBGU0wgUVNQSSBjb250cm9sbGVyDQo+Pg0KPj4gICAgYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnN4LXNkYi1yZXZhLmR0cyAgICAgICAgICAgICAgfCA4ICsrKysr
Ky0tDQo+PiAgICBhcmNoL2FybS9ib290L2R0cy9pbXg2c3gtc2RiLmR0cyAgICAgICAgICAgICAg
ICAgICB8IDggKysrKysrLS0NCj4+ICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC0xNHgxNC1l
dmsuZHRzaSAgICAgICAgICAgIHwgMiArKw0KPj4gICAgYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIx
YS1tb3hhLXVjLTg0MTBhLmR0cyAgICAgICAgfCA1ICsrLS0tDQo+PiAgICBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQzYS1xZHMuZHRzICB8IDMgKystDQo+PiAgICBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1xZHMuZHRzICB8IDQgKystLQ0K
Pj4gICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEtcmRiLmR0cyAg
fCA2ICsrKystLQ0KPj4gICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMjA4
eGEtcWRzLmR0c2kgfCA0ICsrKysNCj4+ICAgIDggZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pDQo+Pg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGlu
ZyBsaXN0DQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbXRkLw0KPiA=
