Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36DBC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B59A222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ncnXisXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391116AbfBMJBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:01:53 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62116 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391089AbfBMJBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:01:50 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="23778155"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Feb 2019 02:00:14 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 02:00:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwt9a91kqT7QK1mpL4hnCETBrUB80Mt9klad0VEyYSI=;
 b=ncnXisXFattDmYSVCyPAjyJ5lb8Lj0IjoppkdGVq8mACC2HXKAYJJuYW5Ih5TisJD1MJFxELr8/2aafP37tJUqlQoKJytfjKCUWVxMaxMiELO3JExPH1rwXq9Yiua+32RYUwsi1Jc+sYKzvLGO/ETzJIPdC95XvMCvV18WYixgw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 09:00:11 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:00:11 +0000
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
Subject: [PATCH 09/11] mfd: syscon: atmel: switch to SPDX license identifiers
Thread-Topic: [PATCH 09/11] mfd: syscon: atmel: switch to SPDX license
 identifiers
Thread-Index: AQHUw3qGDGH/245SdUqZtAPnTvyS6A==
Date:   Wed, 13 Feb 2019 09:00:11 +0000
Message-ID: <20190213085930.31578-10-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: ff6a6e74-edc8-42d7-7c61-08d69191a8ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR11MB0019;23:IjjT6zluULY67LlVt2bZcQOfBz3NyM6e6ddE13M?=
 =?iso-8859-1?Q?UeR596YFCBvfnU3drmcJEet9MyolrZc5Jm3XPfKd87XdbfEHcAQG2iSYLr?=
 =?iso-8859-1?Q?1j2mGF3KxjoTAC5YfMIYNrPdukgM2e37NlPKndtsFxdpwFBHKJYRvC8GlM?=
 =?iso-8859-1?Q?BeFkjgSnnWU8Mt5as/RUy6xdr+jimYXPCcwklL1vsfP/p+nAIcDS9YA/dy?=
 =?iso-8859-1?Q?qqCOvEog6xnRyS/F/JjP245p/jnijnrSvEO9VizUoJeS9GIeXuQFJ+ZEtH?=
 =?iso-8859-1?Q?H4+jbNqZV6pyUtrBQ3pkR4TqFAFSnO6l3OJJhhI1tX42DXdp5BFjTpF2pY?=
 =?iso-8859-1?Q?bRCJrOPg0JvUh9o+UCANl4TZ5s1FJFcnAf4SdXzfftgBtIT7bWvx2MiBQs?=
 =?iso-8859-1?Q?KknYjyFq5ca6HWkc4cEubk83C3w+AB+kdJl95ZLuYGNnYRHiezwcnaFHXt?=
 =?iso-8859-1?Q?KImA8wdonRs6CkDhCC7+mY1GCUhnHmmy9/IQ/yakDLbo5GtvXWiom+d6cC?=
 =?iso-8859-1?Q?rQeDXB0WX43vojX5Z0xd3w/e6Jg0eUj44Pv6TG69UP16uxzvxhieKbtY/R?=
 =?iso-8859-1?Q?6MmWtLr1PbvwpWcDQMI6Ux5K02kEnmwz8qHlbRRhj0ZcfZOSKRvJ63m9mt?=
 =?iso-8859-1?Q?Uh4VMCIXhx340alN4uvl2Pcxqi/x00uZaazbRMf3yR8p4glk8JgqAyUERq?=
 =?iso-8859-1?Q?w3BaiJFz0p+DKrNrC8+zQCplgNYX/r4RRPneAblCcqmib0nsTljRq1SMIR?=
 =?iso-8859-1?Q?2D+ugj/jwdKsOq+lLjN9JIfP0AWGShaubs+z1s42RHn/eaLUBbVdnHx4dx?=
 =?iso-8859-1?Q?QYwPYU15bOcbFTiOgBf97LcTFry8w7kiXPRUlQzWatJ28DzfLXehZRFrlq?=
 =?iso-8859-1?Q?WP9onEBCOb9epBvtEO+RiHd7yV9yyIpEwv4tVSR0eb0pE+owYVGuDlHJJw?=
 =?iso-8859-1?Q?sfaJXX3RSkMKcMKKObXzvIq7Dt1gm/BmqWywhL80Bze9tQ5uV4Sz81n4JI?=
 =?iso-8859-1?Q?fYn6XrZ9pJGV1w5L8e9xCGFNfara22+ouGNs/47VVX5AuxRpOjyPuS38Ny?=
 =?iso-8859-1?Q?2wjBn5V6ZfLfR9j9bPSYyVfB0/inXs+chS4TICy35EhsxYjMv+OXd5rg4G?=
 =?iso-8859-1?Q?ITreMgmCGIyZVBCeci1EwpcORyQ2mJWZhPHa3e8X4tkM0zKggm+EG0zl58?=
 =?iso-8859-1?Q?whkbmBbmfYBaiJqkJQP/NZ3iVJsYN9dqc0d86UTEVxgjKh/Lrw9SVuPeSy?=
 =?iso-8859-1?Q?IEGSr4n+1efaC1SpYDunUywfNu13Y2k1tU6xhVvBAbAE0KuoyyOBkrZ8Fi?=
 =?iso-8859-1?Q?Sy6hravdjt1BhmD5Gj8oRVQXn4LQbS03PbxEsWzj9kmPM5iHhR+R5Mq2WR?=
 =?iso-8859-1?Q?D67kivTfKMgiRn+/+aRIOGBtb99wz?=
x-microsoft-antispam-prvs: <BN6PR11MB00192F2F8008A4D93B14006CF0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(7736002)(305945005)(256004)(25786009)(36756003)(2004002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 848cl250TAC+o8bi811Meq3CkM6gjMKIjJPo5seBAK8eRlGlBlR9OsAwMc4psnpVJdNvPY8FZuZbjl/nE6BkcaSfQIeFR5FHxLrGvM/Z1qsJJN1q8HyxCQEJlqfdXRXO+oT6cpb1qgqbUrrD4KJO9DXaiVlTLGY5ao5qvNTLOs2jo5FfhBrPZm0H6sXEN6DewgEmuXMX1is2OLDaof5nmWW3c9lGLorOhq39yc2CgH9WiC6O+uARhJDXEXnNHKgxguc5mSVEXkUq96v6c5esf27Sxt4vnGVE2YqUWe1wiVV/KTE2n6PALu92u7lGBtkElryvRetEeDlN8ilhHw8khLNirXFL6PBA+MELGlhuZbRlTsJKkD/4CRo90Q2ahiVCCh18b00f69uw+nv5eRBpag9W6INdrzcHJ/laqDWw8xc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6a6e74-edc8-42d7-7c61-08d69191a8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:00:08.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
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
 include/linux/mfd/syscon/atmel-matrix.h | 6 +-----
 include/linux/mfd/syscon/atmel-mc.h     | 6 +-----
 include/linux/mfd/syscon/atmel-smc.h    | 5 +----
 include/linux/mfd/syscon/atmel-st.h     | 6 +-----
 4 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/include/linux/mfd/syscon/atmel-matrix.h b/include/linux/mfd/sy=
scon/atmel-matrix.h
index 1e2cd118e4e3..20c25665216a 100644
--- a/include/linux/mfd/syscon/atmel-matrix.h
+++ b/include/linux/mfd/syscon/atmel-matrix.h
@@ -1,12 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *  Copyright (C) 2014 Atmel Corporation.
  *
  * Memory Controllers (MATRIX, EBI) - System peripherals registers.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
=20
 #ifndef _LINUX_MFD_SYSCON_ATMEL_MATRIX_H
diff --git a/include/linux/mfd/syscon/atmel-mc.h b/include/linux/mfd/syscon=
/atmel-mc.h
index afd9b8f1e363..99c56205c410 100644
--- a/include/linux/mfd/syscon/atmel-mc.h
+++ b/include/linux/mfd/syscon/atmel-mc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2005 Ivan Kokshaysky
  * Copyright (C) SAN People
@@ -5,11 +6,6 @@
  * Memory Controllers (MC, EBI, SMC, SDRAMC, BFC) - System peripherals
  * registers.
  * Based on AT91RM9200 datasheet revision E.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
=20
 #ifndef _LINUX_MFD_SYSCON_ATMEL_MC_H_
diff --git a/include/linux/mfd/syscon/atmel-smc.h b/include/linux/mfd/sysco=
n/atmel-smc.h
index 7a367f34b66a..e9e24f4c4578 100644
--- a/include/linux/mfd/syscon/atmel-smc.h
+++ b/include/linux/mfd/syscon/atmel-smc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Atmel SMC (Static Memory Controller) register offsets and bit definitio=
ns.
  *
@@ -5,10 +6,6 @@
  * Copyright (C) 2014 Free Electrons
  *
  * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
=20
 #ifndef _LINUX_MFD_SYSCON_ATMEL_SMC_H_
diff --git a/include/linux/mfd/syscon/atmel-st.h b/include/linux/mfd/syscon=
/atmel-st.h
index 8acf1ec1fa32..5b6013d0c440 100644
--- a/include/linux/mfd/syscon/atmel-st.h
+++ b/include/linux/mfd/syscon/atmel-st.h
@@ -1,14 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2005 Ivan Kokshaysky
  * Copyright (C) SAN People
  *
  * System Timer (ST) - System peripherals registers.
  * Based on AT91RM9200 datasheet revision E.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
=20
 #ifndef _LINUX_MFD_SYSCON_ATMEL_ST_H
--=20
2.9.5

