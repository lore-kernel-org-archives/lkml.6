Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851C8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B974222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="X24b8q/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbfBMJBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:01:54 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62116 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391090AbfBMJBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:01:51 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="23778162"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Feb 2019 02:00:19 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 02:00:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfvSRjdfPYR59gKW1BzgBjSZaKSXcSVAPmXOnSBdk9w=;
 b=X24b8q/zr1PaYNV3zkTKqdl1kThdQDePHz2Hw6eZKovPv28IoB4s+BTsNNi5U0F6b4ebxuuSdetMT5kEoWTq0Ih9/cWfNOEFohMOsJOU1xsf/ZS7UURHem+mu3HiN8yHIARxdARG0fmIazjG0f0t0zdIMmCL22VbXFlIOAXdqqI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0002.namprd11.prod.outlook.com (10.161.152.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 09:00:14 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:00:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 10/11] memory: atmel-ebi: switch to SPDX license identifiers
Thread-Topic: [PATCH 10/11] memory: atmel-ebi: switch to SPDX license
 identifiers
Thread-Index: AQHUw3qIVB2XFQX9qEiZejjebqbq6A==
Date:   Wed, 13 Feb 2019 09:00:14 +0000
Message-ID: <20190213085930.31578-11-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26b2d0e8-ee04-4d8f-5776-08d69191aac9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0002;
x-ms-traffictypediagnostic: BN6PR11MB0002:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR11MB0002;23:fL97miKXoojaIc2+QcjoAVmKgbk/0kMbH0tW4+Z?=
 =?iso-8859-1?Q?+zEp9ic+QkvlCLkRD64rxrIwfn0vl3GYnkBz/WR0eQUiWE2NoicpmrlpjH?=
 =?iso-8859-1?Q?NZgBgixO8ztrMtsyVL9tm8einRy9KCIhOwEgbUgQD85pLHjAfSbmZ3iOF8?=
 =?iso-8859-1?Q?kqN+uLemVuEvMCMaftRsEE5V6D/0A5wT0yxZisTMUmFU1YjwsgnrNLYcU7?=
 =?iso-8859-1?Q?iZ1/a2U4A35lDzLM6noqwKYZ8ClVg91QAKupCXSdvp/YYjOF5Ef4Z3m2Kc?=
 =?iso-8859-1?Q?3/qVaIbDPiFfjEPFFDye9DQ479kQP9g+sin83+qzzFhpA9QbgHSLrFfYJX?=
 =?iso-8859-1?Q?URZxNnVItvyJyTbT+Sd+1OakDG/UaBadvZw7tnP/UlzAeoKGA+IWaaacXo?=
 =?iso-8859-1?Q?TUMizMhBGhosdM/Vls+198iJkRUxc8F30ZfjeA+TNvcXcNaRY6B0WS/c36?=
 =?iso-8859-1?Q?V5ql+LIqxAvOVTnWLaFXcPQhxFzSFRJcBxkiLOMv2+D9cWKoLMLo8U8ECL?=
 =?iso-8859-1?Q?pfxkNvc4TAN8dFAay5wGoTy0BcC4jG/XsjZK8ykOYMljwZ6JOHi+z+WEOc?=
 =?iso-8859-1?Q?HPZ5ksqA5S/QdDscdfOTtW9LNuJDUMmSlFqmvGivDOouvhbzStLo0zeMLj?=
 =?iso-8859-1?Q?gQAp67eVbSa+A1xyc5zWEChpfoTtFSx3OAmDFwFQgQkqb2nAhFjCawiajv?=
 =?iso-8859-1?Q?GLwbFq+L35U4N87gQM7vDNBkTn+3PzQUOszbiFZ8rTJotazsLoV+TeDrJy?=
 =?iso-8859-1?Q?f3N7A/AQR6bQC8WpQBixY40MmyuloBRlNqHz5bprEvRSQeyLoNy1o2N4AC?=
 =?iso-8859-1?Q?EgPyTByPwHvm+9+tVkdLHECcJSqd10vW62et9haGQIrwOZ0bjPrcvC2xyV?=
 =?iso-8859-1?Q?+1s6JkIQrhChaOME+t9J1WulpLEUY5tzNAWRo+0lw7Tgko6kjajjiK2vEz?=
 =?iso-8859-1?Q?i7tyqipidDkMPOwaxLO6mPT+HtQFvcsRiaKMVJVGP39gx52KsKj9kSVtj9?=
 =?iso-8859-1?Q?1V0C7/eBY/j1NLvAuckOVF1DXHzvyOzuKanYIE1C19FG9yVlh2j2LzKzpQ?=
 =?iso-8859-1?Q?7yiZk16cruInUwcfke7mAdjGrccGLwzAcUVKT0qLHTaHbd0qIf4aBMl9Z0?=
 =?iso-8859-1?Q?1QW8hjgVRPcRcyHs5zEKRuuECfmHXI3pV+Zar63i259KVl4XGtUQ8VHaOw?=
 =?iso-8859-1?Q?Lfr5M9VH3EZ7alSb0dDrw14dpqkQxQtMaf97xEz3PdlMdjnCAvUSefLZGR?=
 =?iso-8859-1?Q?4UPfTOAx+e57Ig2fEtpwBjGY/7RPMX2+2Gr7hxQ7DUNJ1wp6bSD06soCOM?=
 =?iso-8859-1?Q?BRO3PKy3qFTUnotisQkh7Sln9I3QD3o1kWfjw1x7uyS+zA5JjAyXH2BWND?=
 =?iso-8859-1?Q?fDtH4/XPLJlOnh/rGHGtIAA2WA51Q?=
x-microsoft-antispam-prvs: <BN6PR11MB000293C13354F03086644E8BF0660@BN6PR11MB0002.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39860400002)(376002)(396003)(199004)(189003)(2501003)(110136005)(54906003)(2201001)(4744005)(86362001)(3846002)(25786009)(6116002)(105586002)(316002)(106356001)(52116002)(1076003)(97736004)(76176011)(102836004)(99286004)(2906002)(7416002)(36756003)(6506007)(386003)(305945005)(486006)(2616005)(71200400001)(71190400001)(6512007)(81166006)(478600001)(11346002)(446003)(50226002)(7736002)(53936002)(66066001)(26005)(107886003)(186003)(68736007)(256004)(72206003)(14454004)(476003)(6436002)(4326008)(6486002)(8936002)(81156014)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0002;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lYxO8Lu4lB/Z77flbM3CZ1Sl9DaBGKqLXxxHsnoYwCzkUZUQM6/bFf37FoAKmw9SbtPrO1avCg+rmRj+cybfyyN/a3ZZzQ7LBSNJE0T83FQegfmCSMEqxHxdv2WNKS7DZfDBZw6U9A7aNJiCKvh+MzJYuBjrl9mskZ05M+BbNjLl5avB2qPuTuGOpDoLVjCDZGo16YIJAXPc3HGHhEPGz20CbOZalHR11UhfjNPTD/8MrJsf3FlFQQWV7qIsYGkyNK2bGT/2P/ss0ieKH2eWoYgBFj9aW9jRRfFFed82Swi93JjWSI+dZ37WcO7A+zA7IrCb+z9oyztsteCVCSizVgs3ItSkNvBulLPG34Ne8XoXmUuiE3uf102rtllvBrytltjprlJs+v8simVApNZ6863B8KLwI4Rv4EH+gRFsGrw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2d0e8-ee04-4d8f-5776-08d69191aac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:00:11.6310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0002
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Adopt the SPDX license identifiers to ease license compliance
management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/memory/atmel-ebi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 8515196c2b03..14386d0b5f57 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * EBI driver for Atmel chips
  * inspired by the fsl weim bus driver
  *
  * Copyright (C) 2013 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
=20
 #include <linux/clk.h>
--=20
2.9.5

