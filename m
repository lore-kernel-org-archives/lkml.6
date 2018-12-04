Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1638BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C494D2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QF/JCnTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C494D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLDJwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:52:43 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24005 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeLDJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:52:42 -0500
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="23959753"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Dec 2018 02:52:40 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 4 Dec 2018 02:52:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctqfoZCIhb89ULt1gVkwvsLapgJwdtOft8/Wu4yi4hc=;
 b=QF/JCnTxm26kA9AZiEg9Xy1W21HF9io/jLh+rguJOhZC98l0CKQbhEkFQQV9KjGSxtOnvV7a0TazeOPFYzsUYzNFKPDx4+RKDkcnIDulIP/PnQ+3Ff83lwp+JDFj1kgqOx5SfdJrc9O1s16R/+e5KfOFew+X6XZSvyXZZT60mOU=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2083.namprd11.prod.outlook.com (10.174.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:52:36 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:52:36 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v3 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC driver
Thread-Topic: [PATCH v3 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC
 driver
Thread-Index: AQHUi7cVMzqpOg6K20iNC50saN5j1g==
Date:   Tue, 4 Dec 2018 09:52:35 +0000
Message-ID: <1543917126-32572-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0214.eurprd07.prod.outlook.com
 (2603:10a6:802:58::17) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2083;6:T5vTClqxqee9jy02xF2U3+6NBGy80Rs08Rhs6XhZJvzpi5K2tm7M61yglrPhbwakT8JgXWqFZi8jfkNF5OM/YSONbGc7Q6TPohcezjKDKoFtDsBEH7KksLcgRZ6ISOPZ/LYG0Ddd3yyxut/DtTav6wgIGDhxccO30AI+c98kFo6laLlOwcmbLg4UHx78OwumeHfTY2cNZpYwOs8NNPwihgSxR8ciYltQBNCTcNejxut8nC3cdYNA7cyH8t8i3yB8XHBF+DkIvjHkBI1LURvq8zXoVG9yYm462pX3J6R4HM0m67jyOhQXoPbHpp+0a1/Zj33XqESad7sBj+jAyMpH4YwlvCtYwKjWgstfxZ2oEZoCJTFh64Ft8oEwgzTHbZnuGg+GW6HFLdqHsmfxLUZlM2diHsZ9TP6hf+VMKzCfeyR5JQDGKVEYdZPc2Ej8GaT8q3CXssxOa3VIDf1HsrOYwA==;5:P/9xEASqv2cKWQFLQYdVpgeYmSWeaOmA1oifSiUt0N3O0JRbu7D6OE8+OLZEsOpDlplQ0s6XaBBqfK7mdllFuriMaBRPEPxp1bwEBggDGaSHdxJCelkZzFcHTq6b78lGd0ZOo7/70gPa1YWMo095XUqcqNxPKFtw7m9wZrSxnws=;7:/jHQCNPXgPTxPkxEUXGRt4123MWKlmiy56flZSPAqEUw1yuT6qaP+tP3W++L3cFqBhiC3OaPZ4/VZFs2Jel9rwTsFm5FOKSAGStXsB3/2f4o78R+uvUhNXutnjzQCxeyE03YE37wNGsy/ConNrDjxA==
x-ms-office365-filtering-correlation-id: d36e2650-7920-48f0-a3a5-08d659ce35e5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2083;
x-ms-traffictypediagnostic: BN6PR1101MB2083:
x-microsoft-antispam-prvs: <BN6PR1101MB2083D760A3125BAEFE74B3ACEDAF0@BN6PR1101MB2083.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201703061421075)(201703161042150)(20161123560045)(20161123564045)(20161123558120)(6042181)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2083;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2083;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(386003)(54906003)(186003)(2501003)(72206003)(498600001)(14454004)(446003)(110136005)(2616005)(107886003)(11346002)(26005)(102836004)(105586002)(106356001)(6506007)(4326008)(97736004)(39060400002)(36756003)(53936002)(68736007)(81166006)(7736002)(81156014)(6436002)(256004)(8936002)(8676002)(305945005)(6512007)(6636002)(66066001)(86362001)(25786009)(2906002)(476003)(76176011)(486006)(6116002)(99286004)(6486002)(71200400001)(52116002)(5660300001)(71190400001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2083;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b6Q+T25jI0NZLfMu7cIAqXqRMXFjpH1IxLl9FDn8DKseIHQzxLJfWzRPQY7tKU2im8yMsawSO/pVaMwCG+mX9QYx6BGkLrfR93NiFazsUfQU0pvSlgR2iuzS+dATjzoB59v77ZKzyZQW4TmYlGiqa+IFNeq21cZfDN537p7r+08cedBImu/napVUQNH5PcftN0yA8rR5c6vxp1XcihhD8iad8Eedu89FHaOpNc2Qg+kY6KxhMcaIGFYzyp5x4BVR5Ty2KTdI8DsqEtg/J1aKIG9USIzeZHp2uuO2CB0FxVUAH9KbLYGlDoiA+4UmsogTR5VE9zl2hbuSV5YivJXvkWMkn8cg+Gl5CM/xXPDTCYM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d36e2650-7920-48f0-a3a5-08d659ce35e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:52:35.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2083
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a maintainer for the MCP16502 PMIC
driver.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b755a89..6a74a65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9730,6 +9730,13 @@ M:	Ludovic Desroches <ludovic.desroches@microchip.co=
m>
 S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
=20
+MICROCHIP MCP16502 PMIC DRIVER
+M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
+F:	drivers/regulator/mcp16502.c
+
 MICROCHIP MCP3911 ADC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 M:	Kent Gustavsson <kent@minoris.se>
--=20
2.7.4

