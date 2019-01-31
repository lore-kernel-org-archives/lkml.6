Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DCCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32EA2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XwwBPZ/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbfAaQQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:16:09 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62809 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbfAaQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:15:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="26148221"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 09:15:47 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLjQsb/3NW/C/x4/nENRIQ/Hk4nUjCIlwQ7U5YFGzI4=;
 b=XwwBPZ/5TIWVKgLmp2DpW6mtfHyVUiCszPQ0MEdi6yokm4NBgEVZSa93LQ3d6VTexjVUJZpAGBafTopAB8bAONS90MLytcF2QTofkLIzsCrm1OHlOL3xyGEewxdM5a+UP55M4tkdkg4Dd/o56ctI4CdEn/ubTqG+kK/xMNyb00Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0004.namprd11.prod.outlook.com (10.161.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 16:15:44 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 07/10] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Topic: [PATCH v2 07/10] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Index: AQHUuYA3//fOXr8GpkeybxtYbePJ3g==
Date:   Thu, 31 Jan 2019 16:15:43 +0000
Message-ID: <20190131161515.21605-8-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB0004;6:WzyH9A759S+xSIKCS8YynkkwOA2lX40GN/rrWB5rdZNKK85OPG92FI5eXTvkWebOu9JdsZwBXL8HJvNSsRBHaHBD2Cze8RSCNnNENuNnQC5JD2+iaRgiKTGw4SggAp0YeJLPMJjFBE9IPeJfZFeWIzC6UQ8aB/i+8OTll0ZWnNZZVKD+2FEhYkf9X7u1PVP3Zb5n2b/rwYVU23pMftVMImqSxbkrf0AoykIFjfSoJ51uTCuEOn40co+dg/+eLGuW0nDmZDmZYdk24IOh5WwRoBxEH18gH5E3eqNtGqNvKbGWOCLFKY9wh2RFIYqK813N5wYg9IpNpQzJjJAbWamWuM8tYYJtgzjiO1w1+ay0U9HrYJNAJKxKOMcYjss4rbeyuTHLRAkTFszTiQycmVgsnPKLd7z4i6MTwrVUib08cpxlKi500+GHH7RPZLWgdhtBgK0v77lttK3hS+6B/ssMWA==;5:GNKiIqAi6Bd1HHA28X2bf2QycwjDlVOhFNzGQkOV31JrD785vf8upiHE2cPKoVI+yg1wOoaHeySclTlPQFW9f18oUcuLKZFW7+J9FlCQQSf4R1pkDSoe80qOR0PudekmxfQmFi+IwdIqh+mT7G8wg2OqYhjai9CY4/blEn9GMyVE4m/UMj3YW+XgNwmflmI0rZNrCtoU0nxiP4iGQEGEmA==;7:wOne6xE4yyoGFD44sSkNWJDL+TcG2ddS80ZI0MTdLUpU33p/o4Wy27+cCi/IUY7lLr0MpB03KwpYOvC4f+QSd1w/CldOdDjJ/hEMzvisXJ7wyMHcKpGtVLbG/1E+UokmafaFkgKLi8buLowVv+Yiww==
x-ms-office365-filtering-correlation-id: 1b5f1537-0565-47ae-9216-08d6879759e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0004;
x-ms-traffictypediagnostic: BN6PR11MB0004:
x-microsoft-antispam-prvs: <BN6PR11MB00047E6FABCCA5BB50BF98C6F0910@BN6PR11MB0004.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(14454004)(186003)(86362001)(36756003)(1076003)(76176011)(68736007)(81166006)(256004)(7416002)(8936002)(72206003)(52116002)(6486002)(386003)(6506007)(305945005)(11346002)(2906002)(2616005)(102836004)(50226002)(6436002)(66066001)(71190400001)(486006)(316002)(6512007)(4326008)(446003)(107886003)(71200400001)(476003)(97736004)(6306002)(26005)(6116002)(3846002)(105586002)(478600001)(25786009)(53936002)(54906003)(99286004)(7736002)(2501003)(106356001)(110136005)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0004;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kb0gmGv3D5MSbH5Ud/5XylnaxY/HIQP7SadZU7qc6ZiNfl0MUeBhdHFca+9+2PX6fNnx65wehczzAk6AsxkT3Xi5u7fTgaxHdnl3fIV3sfxOPRq6kPPtsxwuRvrPNX+XwfjFbEmAiGNWkyEBR7SH36GuJyW4FksVYulkj8sGAAgVl4hBbZ0J47/Wm+HaRwUzU22kg8BlJYEJputpGeMVcwq8T8eG8eMD8pATE/ONzCTEIe4LWDMHQ+NKLsgZdODDwvHGkT6bua+oy46B4FNwHcUhKVOAwt7IT7rKNryGz8w4ZZPbA143q4Zbk9uwWSVhp2UyILUkrkbeN8EZIMHLpBZbIWaX/V5tGgfOZ4/MuFL5psW8wm2ntdByk91vGLYVT+ONUU2fVK+onl4giu4hlP6Fo90LooH6bpSNcrRUgHU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5f1537-0565-47ae-9216-08d6879759e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:41.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0004
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Adopt the SPDX license identifiers to ease license compliance
management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 1f7cf5d2953a..d3e76acf8517 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Atmel QSPI Controller
  *
@@ -7,18 +8,6 @@
  * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
  * Author: Piotr Bugalski <bugalski.piotr@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WIT=
HOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
- * more details.
- *
- * You should have received a copy of the GNU General Public License along=
 with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- *
  * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescal=
e.
  */
=20
--=20
2.9.5

