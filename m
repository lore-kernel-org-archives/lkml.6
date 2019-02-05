Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A91C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5012217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="DP9ijxwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfBERda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:33:30 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61935 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfBERd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:33:27 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="23466291"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 10:33:26 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UOckbbOwWjrY8pYGuiGu1lXxPi3bHyFsWLyDzUf/Po=;
 b=DP9ijxwRs/CHjaUco1RbQTyX4mZhRk8bxEeXw2VlYBnieFzBAeOXVv0OwpG1v8BbezrafavAT9Npoi52CJ4j4n8soq5M9t1I8oSXgGZqg4KhqP+mgXexKLgIL46qePtsxCE1FcFuqiphk9YTxjNH0jcxk3PbW0o5QHUQB9exflk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1539.namprd11.prod.outlook.com (10.172.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:22 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v6 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Topic: [PATCH v6 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Index: AQHUvXjkYK6hX5/T2Eqsp/GwdKcA2g==
Date:   Tue, 5 Feb 2019 17:33:22 +0000
Message-ID: <20190205173254.16388-8-tudor.ambarus@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205173254.16388-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1539;6:2o29WW1SS1WeaVIV1TfUHUKsHINVpOCOEF21cc7OCB5lRYNSC7ZAyrjGkuHfW9RgpaX5a48aMmHytAJFnfvTMM38Y/S4W3KEQCic4SleBAAGu/xndKjRL3wUjOsbq1Rc97qmbDExGETmppbiqdPJz4XHuZSpDYutUMjcN1U1nVwdVFAJcszZfV3M5QL+2oJdhKjRYJrgRQ5mm7JM+ubsHAmiBGtvuwuWsH5UxndehmkrfdDxY/SNT2qNVgNIfEojZ4Q2Duq8oBgCcac/OZkQHsuyIdSoAfvx7yq7RgNTL2ZSmRN8WOIjwG+9z5VdD9Ls1OurfVRdbXX/O3z5bm2SSSv4g7e6aGjQmzscKn5QH6TL3oHAwweIOIZY1ziZ8j3nmWi0ofEZL10A1fEze9agSPRmZql/gl0RHWmcyGp4+YznEZ9mrWwSVrTViIMgn+LOxB5lVd6+rijRNAtCXrggBw==;5:aAPDJn+TGPMclf8olp6TVHtJbQUyMxqmwUJVuP3q+7+7DJkt+K24xCUa4/FyLgCA9IjRDV3v2g3UCJ1h8A/TZJ+xGUqI60hBWV7nGJfFMn5fCyfiBD0xxmFUD7GCqJa/BZKzz+4IQsG4MIsM0MZLkj0ufWOKEjBrGjsKZoOD3oWi4QhXLU1VauQfvCCEQ6wcGip4VOVAiCkFz+EcsjWPIg==;7:lZ28BfvZNIBah4I8eHAoIVUC4c2rUOH37xwmlq71b7j/2IXcp7SxzuLpiZRP8bzkvfTVlZjPwg8Dg7zzVOeFwT93pvLqr7BxdzlImk5XIWhHZ2UmjL0IkjtDGKHc3fVkL2PxV9LZSpYvK897cLOiMg==
x-ms-office365-filtering-correlation-id: 5c75e3c4-3756-4828-67cf-08d68b9006b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1539;
x-ms-traffictypediagnostic: BN6PR11MB1539:
x-microsoft-antispam-prvs: <BN6PR11MB1539CF65D7CC27479BE768C5F06E0@BN6PR11MB1539.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(386003)(6506007)(7736002)(4326008)(71200400001)(71190400001)(99286004)(72206003)(2906002)(110136005)(14454004)(316002)(305945005)(76176011)(8936002)(8676002)(52116002)(7416002)(3846002)(478600001)(6116002)(54906003)(2501003)(50226002)(1076003)(36756003)(106356001)(53936002)(105586002)(25786009)(81156014)(6486002)(68736007)(81166006)(256004)(86362001)(102836004)(26005)(486006)(6512007)(11346002)(66066001)(476003)(6306002)(97736004)(107886003)(6436002)(186003)(2616005)(446003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1539;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CsIR3yAsvAzHE1SiOjyhXbNV8okqcixonofTzUL+az6l55jkZECgIS5qllKQ4nfar27CQzEefQ4DHMLdIZbCIiSa5/qZw86a6Oz+hU7+yTS9q6QSm+3GkzZejY0tPfubRUh7C5OqUF39aYK32qMQFUDRRSYFZPsPXHANeM8pESckWNfMYWdUV7wJBNBhSDzWht5dXWgg6grXDAmMB8brgT/QvwlTwfq+6J3G8W0m2RuvfQolQ6CT0+luCQqCUHF4dLRn2T99kuqB17hzBw0skRxJbK9s3Lyy4URgBN48+FcgJjqzoATxMcaoqhtDt+2i90jJV4LJC6GZay/BtVmHXCk2vsi8XBs+8uln3/Jq4CB1bL5NVinvAXeDaeEOimjqMrZgs+AnL7U6WFeVaoIc/iT5eVMpBCxKcb+JilpDpjI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c75e3c4-3756-4828-67cf-08d68b9006b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:20.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1539
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
v6: no change
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

