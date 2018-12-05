Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEBEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8812082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="XfhckRH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8812082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeLEIYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:24:52 -0500
Received: from mail-eopbgr1410130.outbound.protection.outlook.com ([40.107.141.130]:36837
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbeLEIYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ0u0BtCYQ2Jo+CRXQRxyxYEv6jFDJ8e0adJiFTmzq4=;
 b=XfhckRH64+bRP2pn7VHa6jmb4vP4blK1R0jhT2IRGZqJ48qJwNzOJ066A96tzxB9toCu3QXa4iMH89Y0ntOMK9Z2C0paP0aeo0jfIk0ecL2rUvfeyQEWcXD1IckrcaGiN/dogZ8oqhnoW5W5j8lRKjskPklIChgjc1hk1K1kZUc=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB4094.jpnprd01.prod.outlook.com (20.178.140.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:24:49 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:24:49 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] irqchip: irq-renesas-irqc: convert to SPDX identifiers
Thread-Topic: [PATCH 1/2] irqchip: irq-renesas-irqc: convert to SPDX
 identifiers
Thread-Index: AQHUjHP8rbHeGRj5IUGY9FNRfk7xZQ==
Date:   Wed, 5 Dec 2018 08:24:48 +0000
Message-ID: <87y394bd9t.wl-kuninori.morimoto.gx@renesas.com>
References: <87zhtkbdar.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zhtkbdar.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR06CA0048.apcprd06.prod.outlook.com
 (2603:1096:404:2e::36) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB4094;20:hUb6VNB8w3vqOQ00TdLBQOX4AYSXbsbeoRs33nZhDkewIEgn9HuCAW0d1Zz8REfm4w8AqdThchOE6X3+deREMv51q405mWdAXuBAfWA3/ZyjbeDirRRHoT/H+x3fKy5tUmyOoTeQMAwqzG5dMXrT8E8hza0aEKmGjazWULgqb8E=
x-ms-office365-filtering-correlation-id: 1a0d2660-8914-49f4-3c54-08d65a8b1f0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB4094;
x-ms-traffictypediagnostic: TYAPR01MB4094:
x-microsoft-antispam-prvs: <TYAPR01MB40942180BA84C33D05702915D4A80@TYAPR01MB4094.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB4094;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB4094;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(76176011)(6512007)(102836004)(66066001)(5660300001)(53936002)(305945005)(7736002)(6506007)(99286004)(2906002)(386003)(26005)(52116002)(97736004)(14454004)(186003)(4326008)(110136005)(36756003)(316002)(8676002)(478600001)(6116002)(81156014)(71200400001)(105586002)(81166006)(106356001)(8936002)(11346002)(446003)(3846002)(25786009)(256004)(486006)(476003)(68736007)(71190400001)(2616005)(6486002)(86362001)(6436002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4094;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cgWaI5oILOTVOMnH1vknHZRKzZgcKfKIKyFk0dIuKDRR5xacxSlnNElAmEAeOIBup1NOrOaphf7SmZVlnSEkDuUpZ59F2HWixp/1w6hCyAJU/+gHYvybekt3WXL1McTJZXr3DrJUIcigxzSyyOIPQlS25mnNf2wwrwdNlHF26kxATE49vVTpe2dVpTaDOoAkF9t7K/gDGuqG2RhmP8A8HaUTSS5rZQzRHxzs9fxNBotTEt4XjdNiBw6JWHezIO3s8vjGzB4rxbDfGhkNjQkZTpBPtm6vv0WuzfzLDo/Xdp1flGRwM4HBlOB7Fl7bhZCYT5cDzLWyZG4Ff7HUYtpm6saQ7nepi/kkL3rJpKJOuZ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A536ABFD2E512B49A5899B26E253F71A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0d2660-8914-49f4-3c54-08d65a8b1f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:24:48.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-irqc.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renes=
as-irqc.c
index a4f1112..a449a7c 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas IRQC Driver
  *
  *  Copyright (C) 2013 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
  */
=20
 #include <linux/init.h>
--=20
2.7.4

