Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6441CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BB0217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XfzXBf0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfBEPoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:44:09 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:13872 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfBEPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:44:08 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="26335548"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 05 Feb 2019 08:43:46 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGlbJXjikJlrkHHTVJ9geo2R46SZ5fXlBZhArgOtX8A=;
 b=XfzXBf0N9+KfwImv2bNSgozeBJ1pzWWF6cNIFB1C5A6wYdZL3JfOPoi3GRVOeSPr7GStTQlAkvDM5q9itQspwo4LLiOh//1DCpmaknXVYV9+RAb/byqW6Lm7fUmOuuy8Udt99r3FNzWA9/tah59r7ycSyWB2X6FDUA/GjJKHS30=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1235.namprd11.prod.outlook.com (10.173.26.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 5 Feb 2019 15:43:41 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Topic: [PATCH v5 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Index: AQHUvWmRF6I5G49TeEqTxsqkQ4mJIQ==
Date:   Tue, 5 Feb 2019 15:43:41 +0000
Message-ID: <20190205154257.29529-8-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1235;6:oScSqi2I963Vt/gexoGAAjBtuuQImvhTWI78ZSv4gf3gOhDOsoaloF6WDO0HyrijgXVSzj2OcBoH3RNC2zQMccxlLCVAqL+kIyOStsEQmheEseAiaub4QtEjel+Agk+AqRPMio852cuFI0jOcSokAKP4sFIgNdJiodU8Jgq8LM+XzxzxErMKZTVxhz96GkqfpGcaqslW4xgAJ4KWe4RoopQw5OKVzeGxLSQbPCKCeaY4aWkb/DPJAaK/DMZxGMekZeVCPg+yaEOAoLxdHWkMYPHEJ9aF+zQrOJ1uXXlmXD44wDYIaXKn8+D3U7crIrMOWfWXCnW0kIBRx6V7Klqltp8Xxol4aGWuM/yQyVmorg0/qS4tyW0REZpcHLZc9Bio1+0FTY3X525eexknnMBjbOQvTnQLCRpeUhkH5eJZGV1Yn4O/E113AIGKpu6JuXQ4Mm9dWCkIw+nOhtkVeNbr8Q==;5:hiLylVo0oGcidSwGH+uNvcQaTWVxUL23Qw2/Xz0uWg+K4Nh6FoAiqeJkx8gVkWt2jfpd3mp1d/QbJAEFFAYYWAKuTpWtCRUAXibi1fT1kEFV+OR9EaMoXsHejfhOf3H3wAxzNlpB8snu3f+5V4PA5ugC8XsNsBxh941RXXxUuVxbPrS/hEiNgIx8u4DIy+e50D2/6kBrAM9qsRq83vXNhw==;7:zdJxFAvlWwhU55u+FyCD7ZNlupkWQCx1U/TIw54rpKKNWuynwnholaPmi/wLFDONe+TGcjGRgUXt7GzvXXN0SPUG2IClMrIe9XWn2sm3MlNMofX2udqJc90jxLT/8YgidLAxI5z9Yup6H8XsFQjNsQ==
x-ms-office365-filtering-correlation-id: b70879d8-0a88-415a-3b63-08d68b80b3ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1235;
x-ms-traffictypediagnostic: BN6PR11MB1235:
x-microsoft-antispam-prvs: <BN6PR11MB1235F3C1532346765B8807E3F06E0@BN6PR11MB1235.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(14454004)(6306002)(7416002)(486006)(305945005)(11346002)(7736002)(2501003)(6506007)(186003)(102836004)(26005)(68736007)(71190400001)(2906002)(476003)(2616005)(106356001)(97736004)(105586002)(71200400001)(86362001)(54906003)(72206003)(446003)(36756003)(4326008)(6486002)(6436002)(386003)(478600001)(25786009)(1076003)(316002)(110136005)(8676002)(81156014)(52116002)(81166006)(8936002)(50226002)(66066001)(6512007)(256004)(53936002)(107886003)(99286004)(6116002)(3846002)(76176011)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1235;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1mtSMgUOhW7xBje71xL76p3wFFqx1jdOJPkcJNOmuwRykl0MI3aSEHg9hfwhxyrpIEtAYbtiQR6IpqYYZFUAtTRuEpqDFTmKBgWdlCfpaKOG6PnPmZ10a7BXpy2/Yl8eM8eGLhjWVon1C3dDBKZkc435WnmlDEDmrKyAinYpVrOsh21aecvqLXUtXe/2D7mSofetPDu1MUDmulWGC2cEoLLRV8miuTMpDXMr+SuQePzk9F9bfU+VM5IqfzPMRiNgnIHVQde+HbhtN30RPqtf7KJlaM8wq6d6lVCjIVq5SJYH9aMOec2VfKPx7hU19P1PRboQc8f2Wo0L/T4rvv1UufMD0pxHLQz7SzzgRh8ocYvzlmJSnqmSaZngtZwSjZcZV4DpJL2AmDYr2YL0ea1PLGZKAhtVxzsU8WGQIMUySiQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b70879d8-0a88-415a-3b63-08d68b80b3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:38.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1235
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
v5: no change
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 06c31830d07b..ce4f8a648f45 100644
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

