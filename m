Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4613C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B2A2192B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="khN8+nQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfBBEHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:21 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:25474 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfBBEHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:19 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="25777618"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:18 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOZ9BpFBEPsFA0EiR5ojy7DVHJASEH6vVKiIOIyJ/6w=;
 b=khN8+nQXAqMeDL0STjrcgWS6D4NjFVOK2c7ZS9IfShp6w+h5378kRcwee4mRSbc9RoDgXV0+U17DvqSc+YXCr0d2PYEGhttPySp150MiZUrb0oW8AS3VJR5zhpfiU1XltAxK+daKD0eITTAFfB39olpKR2z3e2pBapzYDErDaAg=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:16 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 02/13] spi: atmel-quadspi: order header files inclusion
 alphabetically
Thread-Topic: [PATCH v3 02/13] spi: atmel-quadspi: order header files
 inclusion alphabetically
Thread-Index: AQHUuqzIGjK71QYKTUiJxXc80Uj4Hw==
Date:   Sat, 2 Feb 2019 04:07:16 +0000
Message-ID: <20190202040653.1217-3-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1300;6:J1mD6W6t0fkIVBr5JdVLYJGvB/qA5Y1UwrZ7FCsl6rxE1vYuEFu5CNMia+VIsO+QfxRNtxBiVyv4qj8O7L/mFnrjtcD8i6HqFLoDZfl7VNXD15qxCF7m47dOc9MYQEEUkXmiD+yqCKigS3m0NI99AZq5YEfb1/V+IJ64hEjbKy20aT1Zu+UHWr7hFUdKkiNaxDVJA6+92eZ4EcIcsaI42G6DnZKFaiaM8nT34oowHh9wXHmltLS9gOEQ2TL6Cd47DX9hWwhHHvv5ZJDEp/i/U/YD5w4BbIsi8OtSZw/zTW8YrkQJVTwKt5w2+XcuyfSXv+1LuDgg/xcZKcwRkNc0lZvBh7r0ASHyeWquLF3EcK/JwH6qSi1/+gX58jllRbxo+VGrCaMdDqbAv5GB5gnHvGRb3N1u//4VxmidtunYLHd95pSoRhSNGMaReuYc8A6snWgC2JgnJvK3xqop1sj9lA==;5:z8ZyFcp/w5B/Xp3/EmFISYEglh7B5uEnfbjgbVNBX0EB2p1i88kYgxNQTKOBVfxYFKSIj9QhmkxHNcHX3ovQ+6luQ3sqLvZWdErzEFh84HRYvMxBKW7P7jBQnruL01yn7LH736ot5dhKSrlWoC/5tRYqAK9Jx4O8FfdjwmbRj7a+aX1GjUUVt7DRHcRBchuDITgsUb4lkV6SptNuqJk4ZQ==;7:Ed6jkTaKB1hCONHZyAQCJljK78tmkvtR95rRdRtp/yBmfDZ8+BHG6yvqwIudpEprC3KyIy9OiggVmwWdTocDNNO14hv//queiNNcm7T/FobyRxpysbpwccPyGFeRBYqdfkZBEqq5X7dHGWenmmBXZA==
x-ms-office365-filtering-correlation-id: c5bf922e-7d12-4a69-7436-08d688c3eada
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1300;
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB13009C75F7517C9273149279F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(4744005)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1300;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AjOfBTZpwzn/Y+hU+oPHrDKMR1fLwXBorNnJl3kEJ7hgBloKWg66OKMZwiHrfgPf1al3uJ2fWYcoDaPgN02/xtuKkwyT9YCEVhURCaRWIHuopBd62JPt37yQI6XHxYQUw2g/LfYV/Fa/MsHSdMWEbipFck77V+L+Er9TjORZLfseJu3ZXj//96bQJZtKSUBWKb45aFTIvrET2FYFPap22mznaCV/MfiYH1TPIa69jMBYcuOYffFqggUnfR3/YZvhDJB7O4h7t0LxEtXOcVNQ5R0O1W3noGGMF8wrM3/X4dQNycXYPyCvwhecusUWXqEwI9O+jwKyU6ZJR0G/anKOxNcCfSWRtfsLsXmfBmA4I4nhS+vWoybNNrtWocyyaRTnP4uj+Ru7dCY1gUFn1TV6SEgwqrFgJdRfthqguz9SS7E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bf922e-7d12-4a69-7436-08d688c3eada
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:13.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Cosmetic change, no functional change.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 645284c6ec9a..feeddcb25e1f 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -22,16 +22,15 @@
  * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescal=
e.
  */
=20
-#include <linux/kernel.h>
 #include <linux/clk.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/of.h>
-
 #include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/spi/spi-mem.h>
=20
 /* QSPI register offsets */
--=20
2.9.5

