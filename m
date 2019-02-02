Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71040C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AFB20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mODGZ6Ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBBEIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:08:18 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:63642 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfBBEHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="27191416"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:32 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pvt00qqVzMLZn/UCJ+/YKsE/CZLw8CWmMBL0wQ7j/M=;
 b=mODGZ6CicPl1Bx64kftQLKm7kYOoVEHxhuIuH7p/RyjrKLefsJZIE3ucPEOR1w9oJwr86E1yR+DnKgZjpX/oSlEmmaMXfSJQAPxQbE/sVSHrxcqXsasCFXkTxYnAS7YgfuOZANl94p8JJPdXM29X2YjT+7qP3I7a2eZsga2uieQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:30 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Topic: [PATCH v3 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Index: AQHUuqzRNdsKEnSdbUq+RS9yduoJIg==
Date:   Sat, 2 Feb 2019 04:07:30 +0000
Message-ID: <20190202040653.1217-8-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1300;6:is7X89S7Jl72uzSHnKxDoKgfjj/iXmGHt8XL399G6ha9VIbesuNaDiZhjb+sPOJ6a0gXSQKPdQ6+fonQpakHeyZ1Ij3vrsvpoILoX6ctX1ZWWRM/cj0sZr3/DzDkyhRiH2VnEoTlfdvk79Sg6nAToBCfFHx/grvRDhA21Mdo2VJWcsmdMFRtvToVK8p2nT6Qe3xbIoFiCbiryWvHD2Hp+f+ix4PqRh/+Oe44NG1qXepPvW+3lAtuwSs8a2xai6ECnGdXxkzsdirpa8yfnySqfAaF9OLIevySJqtYJjjnVRtKnTpBqny56x1Pgdetx07Pdx/s9RbLqYctFd28zMnsPnUunTSqZ4zPAAL5COkIktvz1hAW20gcGJDiVq5glvqlApnngi+lYuXWZ3AmBoYiSH544WITYjKBQaBZnzdDy1AfAcpOl/XOGJBoBY8QfDTsDegv03QFTChBzu3a/F4FHw==;5:T0MINPJ5oFfITXtCT1g1RsVmbLgRtg7KgJOzupgR71O85hV/Goxrff/Y7EmNDq5Us9yv8O3WCVOdIqbltW9iSgcmjtvqqdNx0dflr+kamJofuBY15OvULe3xZ10ItO2WA32XqCExTh+QIUle1prQYmBVkoHIA9Dc3ODIPXnZegu3gh9Uydys+4D9GuWyxY+JVpXpfRB6B1NtpnKc7Cp+WQ==;7:zfHBtjKuXFslZIBHAGUh5tEvKyGxwRY0vWe4vcngCFuHYDz49YaAUNHYlW9yapalcSOrQy1i/Ifoz3goRCau8JwKw1ZxjvZ1NgsSnjNVAE9IW/JzmYCWczcGezZ7wWdmWow8JnkT6VRIWDx6tcAUGQ==
x-ms-office365-filtering-correlation-id: d462366f-9d59-4691-b00b-08d688c3f375
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1300;
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB1300843D36F43B1030DAE394F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(6512007)(316002)(110136005)(1076003)(305945005)(6306002)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1300;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Uajh5CXVCQKOxnKSC9kdTLuhf7vGX+FNv6rH39kK/CirpWYQuoO+GxqjqC1jsnxgJCuDT0j5UhQG5JufLwt1m8QDJiVXkQ+Ha6sRz+jmJ7twtqLaz6G2RW9J0xYkWixz7+I0CW5F+cEiwdkneD4yZA7d+48GgJj82a9j+3N2ZrKMi/ZorrSMLcde70q+1kK53SxHVBVoIgf0oxidBvlIZ1pjR26szHkx2wdSaaK29VlTbIPnpZN5fCYivW6rpgtHG5E45mPP+L1Maic9SXFbYZcV5fqpDmF3Yp1mif7Io31r4cmatBWAAtzoVubV0R8ZStUGvhag0/h82klDfBJ2m0hJJ0zD6YdFc7K9/UByDAX6OKd+R05mjEOz+J3VfvKgg5X70IKw2+3Fd0WL9imq4aAXKfGMjoVWDY/Q4b+BIU0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d462366f-9d59-4691-b00b-08d688c3f375
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:28.3653
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

Adopt the SPDX license identifiers to ease license compliance
management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 80b77eb4ec5e..d26d4cd0e36b 100644
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

