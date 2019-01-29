Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86EAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8956D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfA2Ip5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:45:57 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:54344 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2Ip5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:45:57 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 4328F6A97A7;
        Tue, 29 Jan 2019 09:45:53 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 29 Jan
 2019 09:45:52 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 29 Jan 2019 09:45:52 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: Re: [PATCH] spi: spi-mem: spi-nxp-fspi: add module license info
Thread-Topic: [PATCH] spi: spi-mem: spi-nxp-fspi: add module license info
Thread-Index: AQHUt60C8UqS3FnMwUazAVqci9fJ16XF3fYA
Date:   Tue, 29 Jan 2019 08:45:52 +0000
Message-ID: <0a8ae87a-5c71-0d07-e3c0-b3f665f4ea35@kontron.de>
References: <1548750550-23565-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1548750550-23565-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BA1732D09912D4C94190E3C2F1947D7@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 4328F6A97A7.AE885
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, broonie@kernel.org,
        computersforpeace@gmail.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-next@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        sfr@canb.auug.org.au, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkuMDEuMTkgMDk6MzEsIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+IEFkZCBNT0RV
TEVfTElDRU5TRSBpbmZvIHRvIGZpeCBiZWxvdyB3YXJuaW5nOg0KPiBXQVJOSU5HOiBtb2Rwb3N0
OiBtaXNzaW5nIE1PRFVMRV9MSUNFTlNFKCkgaW4gZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLm8N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5hcmF5YW4u
Z2F1ckBueHAuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyB8IDEg
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMN
Cj4gaW5kZXggMDMyNzIxNmVmN2FhLi45MGYzZDJlNGZlNWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvc3BpL3NwaS1ueHAtZnNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5j
DQo+IEBAIC0xMTAzLDMgKzExMDMsNCBAQCBNT0RVTEVfQVVUSE9SKCJOWFAgU2VtaWNvbmR1Y3Rv
ciIpOw0KPiAgIE1PRFVMRV9BVVRIT1IoIllvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5hcmF5
YW4uZ2F1ckBueHAuY29tPiIpOw0KPiAgIE1PRFVMRV9BVVRIT1IoIkJvcmlzIEJyZXppbGxpb24g
PGJicmV6aWxsb25Aa2VybmVsLm9yZz4iKTsNCg0KSSBqdXN0IGZvdW5kIGEgdHlwbyBpbiBCb3Jp
cycgbGFzdCBuYW1lIHdoZW4gSSBsb29rZWQgYXQgdGhpcyBkaWZmLiBUaGUgDQpzZWNvbmQgJ2kn
IGlzIHRvbyBtdWNoLg0KVGhlIHNhbWUgdHlwbyBjYW4gYWxzbyBiZSBmb3VuZCBpbiB0aGUgY29t
bWVudCBoZWFkZXIgb2YgdGhlIGZpbGUuDQoNCj4gICBNT0RVTEVfQVVUSE9SKCJGcmllZGVyIFNj
aHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+Iik7DQo+ICtNT0RVTEVfTElDRU5T
RSgiR1BMIHYyIik7DQo+IA==
