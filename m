Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE71C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC0520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC0520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeLJQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:31:09 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:42928 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeLJQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:31:08 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 0227B67A65D;
        Mon, 10 Dec 2018 17:31:04 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 10 Dec
 2018 17:31:03 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 10 Dec 2018 17:31:03 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Topic: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Index: AQHUkKVtG6It8sv/EE6xXPNZqAZcLKV4GW2A
Date:   Mon, 10 Dec 2018 16:31:03 +0000
Message-ID: <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCFF43A4956638429CD7C267D0D3E012@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 0227B67A65D.A4F60
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        devicetree@vger.kernel.org, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRlNML0FSTSBtYWludGFpbmVycywNCg0KT24gMTAuMTIuMTggMTc6MjYsIFNjaHJlbXBmIEZy
aWVkZXIgd3JvdGU6DQo+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZA
a29udHJvbi5kZT4NCj4gDQo+IFdlIGhhdmUgcHJlcGFyZWQgYSBuZXcgZHJpdmVyIGZvciB0aGUg
RlNMIFFTUEkgY29udHJvbGxlciB0aGF0IHdvcmtzIHVuZGVyDQo+IHRoZSBTUEkgZnJhbWV3b3Jr
LiBUaGUgY3VycmVudCBkZXZpY2V0cmVlcyBhcmUgYnJva2VuIGJlY2F1c2UgdGhleSB1c2UgYW4N
Cj4gaW5jb25zaXN0ZW50IHNjaGVtZSBmb3IgYXNzaWduaW5nIHRoZSByZWcgcHJvcGVydGllcy4N
Cj4gDQo+IEFzLCBpbiBjb250cmFzdCB0byB0aGUgY3VycmVudCBkcml2ZXIsIHRoZSBuZXcgZHJp
dmVyIHdpbGwgdXNlIHRoZSByZWcNCj4gcHJvcGVydGllcyB0byBzZWxlY3QgdGhlIGNvcnJlY3Qg
Y2hpcCwgd2UgbmVlZCB0byBmaXggdGhlbS4NCj4gDQo+IFdlIGFsc28gYWRkIHNwaS1bdHgvcnhd
LWJ1cy13aWR0aCB0byBtYWtlIHN1cmUgdGhlIGZ1bGwgYnVzd2lkdGggd2lsbCBiZSB1c2VkDQo+
IGFuZCB3aGlsZSBhdCBpdCBjbGVhbiB1cCBhbmQgcmVtb3ZlIHNvbWUgdW51c2VkIHByb3BlcnRp
ZXMuDQoNCmNvdWxkIHlvdSBwbGVhc2UgY29uc2lkZXIgdGhlc2UgZGV2aWNldHJlZSBwYXRjaGVz
IGZvciB2NC4yMT8NCg0KV2UgaGF2ZSB0aGUgbmV3IEZTTCBRU1BJIGRyaXZlciB1bmRlciB0aGUg
U1BJIGZyYW1ld29yayAoWzFdKSByZWFkeSwgYnV0IA0Kd2UgbmVlZCBzb21lIHNtYWxsIGZpeGVz
IHRvIHRoZSBkZXZpY2V0cmVlcyB0aGF0IGFyZSBjdXJyZW50bHkgYnJva2VuLg0KDQpBcyB0aGUg
bmV3IGRyaXZlciBkZXBlbmRzIG9uIHRoZXNlIGNoYW5nZXMgKG1haW5seSB0aGUgY2hhbmdlIHRv
IHRoZSByZWcgDQpwcm9wZXJ0aWVzKSBhbmQgaXQgaXMgbm90IHBvc3NpYmxlIHRvIGFkZCBjb21w
YXRpYmlsaXR5IGZvciB0aGUgb2xkIA0KYmluZGluZ3MsIGl0IHdvdWxkIGJlIHJlYWxseSBuaWNl
IHRvIGhhdmUgdGhlbSBpbiB2NC4yMSwgc28gd2UgY2FuIHF1ZXVlIA0KdGhlIGRyaXZlciBmb3Ig
djQuMjIgb3Igd2hhdGV2ZXIgdGhlIG5leHQgcmVsZWFzZSB3aWxsIGJlIGNhbGxlZC4NCg0KUGxl
YXNlIGFsc28gc2VlIFsyXSBmb3Igc29tZSBtb3JlIGV4cGxhbmF0aW9uLg0KDQpUaGFua3MsDQpG
cmllZGVyDQoNClsxXSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL2NvdmVyLzEwMDc2NDEv
DQpbMl0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC85MjI4MTcvIzE5MjU0NDUN
Cg0KPiANCj4gRnJpZWRlciBTY2hyZW1wZiAoNSk6DQo+ICAgIGFybTY0OiBkdHM6IFJlbW92ZSB1
bnVzZWQgcHJvcGVydGllcyBmcm9tIEZTTCBRU1BJIGRyaXZlciBub2Rlcw0KPiAgICBBUk06IGR0
czogUmVtb3ZlIHVudXNlZCBwcm9wZXJ0aWVzIGZyb20gRlNMIFFTUEkgZHJpdmVyIG5vZGVzDQo+
ICAgIEFSTTogZHRzOiBpbXg2c3gtc2RiOiBGaXggdGhlIHJlZyBwcm9wZXJ0aWVzIGZvciB0aGUg
RlNMIFFTUEkgbm9kZXMNCj4gICAgYXJtNjQ6IGR0czogQWRkIHNwaS1bdHgvcnhdLWJ1cy13aWR0
aCBmb3IgdGhlIEZTTCBRU1BJIGNvbnRyb2xsZXINCj4gICAgQVJNOiBkdHM6IEFkZCBzcGktW3R4
L3J4XS1idXMtd2lkdGggZm9yIHRoZSBGU0wgUVNQSSBjb250cm9sbGVyDQo+IA0KPiAgIGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDZzeC1zZGItcmV2YS5kdHMgICAgICAgICAgICAgIHwgOCArKysrKyst
LQ0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC1zZGIuZHRzICAgICAgICAgICAgICAgICAg
IHwgOCArKysrKystLQ0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC0xNHgxNC1ldmsuZHRz
aSAgICAgICAgICAgIHwgMiArKw0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEtbW94YS11
Yy04NDEwYS5kdHMgICAgICAgIHwgNSArKy0tLQ0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwNDNhLXFkcy5kdHMgIHwgMyArKy0NCj4gICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1xZHMuZHRzICB8IDQgKystLQ0KPiAgIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLXJkYi5kdHMgIHwgNiArKysrLS0NCj4g
ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMyMDh4YS1xZHMuZHRzaSB8IDQg
KysrKw0KPiAgIDggZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pDQo+IA==
