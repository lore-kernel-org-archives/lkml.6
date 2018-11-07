Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF0AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0985B2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yq5RpJr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0985B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbeKHAnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:43:25 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:18567 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKHAnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:43:25 -0500
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="20793200"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Nov 2018 08:12:39 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 7 Nov 2018 08:12:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzxGz83XHOJ8TnHnoV0sdkAcnfYUJpKEwNJvs6Cr4HU=;
 b=yq5RpJr5C1QRr8ttir3PsfcUcUlA3cC1mPWSJjHfs8JnFT+KRoCMpouCaf/OGoF/drE46tjUc5fFI1l2ymYoEddJUMhQM8G/0kT/AlpuOSEjjDdnspEw3gHAnGE5UU9/nwywOEqGogYhUNwOWjaGqovCgD+j50y0Ddxbuy+/HmA=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2257.namprd11.prod.outlook.com (10.174.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Wed, 7 Nov 2018 15:12:36 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 15:12:36 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 2/3] MAINTAINERS: add maintainer for sama5d2 PIOBU GPIO driver
Thread-Topic: [PATCH 2/3] MAINTAINERS: add maintainer for sama5d2 PIOBU GPIO
 driver
Thread-Index: AQHUdqxRZIT1HnDnzEmzct538P+4AQ==
Date:   Wed, 7 Nov 2018 15:12:36 +0000
Message-ID: <1541603580-17448-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0097.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::23) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2257;6:M2hMvH1v7oTo5wGCg6uTcMtMDS9GkEM9tbMflSY8hZ8DINonrXme1apP33Jy9DXf5y3tUn4Tye+YjYVemMYs9WtcGMegMdYA6cDTAO5svmVBbZzHk94JFFuA5OeeATUtspEkp1w9QKhZoIlbM/U91x38kSTWCJ2B6UqGbuVSJV8UykfV40xRIrR4437CuFUzA/YpErCHkWtFqnfo9JGe/Bb4o08JNjrAbRaCqZvGh7t5OkWmemxIMepqAoShWluHfnhC/C918Sf3tZ3VqY+C/UzkzwMUJnEYYf1EZ7zDgt25hAIlE6KIXpSzBNbYpeutkNJjl5+TkU4RuB+d9EDs1Gwu7t5fEeIkvGxrO7+QQuwFw+CgSeadOc9x+dwnZYA8vHMHz/1HvKinIAmE0MS6Lki6PfRzugm7cRHFJ4uB+t58X3r1RYp3vbUNJ6wiDtPfHYrDCWezA88git/87kh+mg==;5:uf2NVOeyXVQgWWV+ZV+VO8Vwt1LU4i57YODnWwkp1nnW+8wWC5H5hD5DGpFWEhuQt6sl2KVEa5OokUL/u6aCJQMuoZsh93rdRTNf0D5bZeaopEThWXbfjZkVzWD52/OC0SOwrqCWzN6E5G2mjU5a8AKBLRlozqGh7dyprfcPKWI=;7:MfR58i+GB7HhM8dKbP6ut0ETJAp2kDD9zdSg5WYy6sCevNGpmCgEd0AZVGRG8OAMLYeOWAtpRz2RKpORSAfA/OekvpgLihyErNYa9iWKEUT5C/VYCwa/+PEHDj58KtVwNo8BRmsDsXOrqMK5SNzVzA==
x-ms-office365-filtering-correlation-id: 75576654-714d-43a5-ac62-08d644c3735c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2257;
x-ms-traffictypediagnostic: BN6PR1101MB2257:
x-microsoft-antispam-prvs: <BN6PR1101MB22578ABC1EEC4742EA2EDB9FEDC40@BN6PR1101MB2257.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2257;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2257;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(2501003)(5660300001)(99286004)(8936002)(4326008)(97736004)(105586002)(72206003)(386003)(102836004)(6506007)(14454004)(8676002)(26005)(81166006)(52116002)(86362001)(81156014)(2900100001)(76176011)(68736007)(106356001)(217873002)(476003)(478600001)(36756003)(2616005)(53936002)(305945005)(256004)(6512007)(446003)(11346002)(71190400001)(71200400001)(7736002)(2906002)(6486002)(6436002)(186003)(3846002)(66066001)(6116002)(25786009)(486006)(107886003)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2257;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BuUxYSfDNzdUTMG6il6UJCda+1OIhSKZH5d1CilyI5Q72GCPEXYXuoSfuPgtGjYEwUpTjsbHQ+iun4C5I1hT8eEAmUVTosBg72T39hofKomB3IQJHfZC82mq18hx89ZqZh0b6TjizAo0BJX7DNqacqcP8yC7Jqx2cbpvRnD6clJWWgVLJMqNDfx0rIwPV0RgEad4buE5pZ93WShuNC2vf7I5uITvwkAgQifIuAopyPVeTEMZ++Y+GYB9gn0LelZlUBliyw1QZxMMtAtLC1uuywSSzJiKtJmaIqUtyHI3bicOmD7Ae8k/YMb0s6hkZcghHL269eRxNVe/rh/oOIKRnZzpjxXTZBUb5xIqh6cG44Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 75576654-714d-43a5-ac62-08d644c3735c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 15:12:36.7080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2257
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a maintainer for the sama5d2 GPIO controller
driver.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..88369f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9760,6 +9760,13 @@ M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
=20
+MICROCHIP SAMA5D2-COMPATIBLE PIOBU GPIO
+M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-gpio@vger.kernel.org
+F:	drivers/gpio/gpio-sama5d2-piobu.c
+F:	Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
+
 MICROCHIP SPI DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
--=20
2.7.4

