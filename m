Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D3E20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZBxQY0pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfAOQ55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:57:57 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:55292 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfAOQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:57:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="25348814"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Jan 2019 09:57:54 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 15 Jan 2019 09:57:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV8qXlNDdFQqGsFTs1d7O1aMuODGbct5KXxFCRLJUUE=;
 b=ZBxQY0pdUKuUoJKcG9eBiaSa4Gz9dX3TTUoFsfb9LR6Id40mShSnbeEze9L2xMGbANZp8S35G37UmC8WcVu5DX7b4CAgCiRY3PcqwcWHFdu/J+fZhsUZMdcoFE08hRf8IaKj+t8r8FSFMZOrk2UnqpnpgHmlKID/NRQpiMZWK2E=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1778.namprd11.prod.outlook.com (10.175.99.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Tue, 15 Jan 2019 16:57:52 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 16:57:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <boris.brezillon@bootlin.co>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH] MAINTAINERS: add myself as SPI NOR co-maintainer
Thread-Topic: [PATCH] MAINTAINERS: add myself as SPI NOR co-maintainer
Thread-Index: AQHUrPNzzpAHOabtAU2JQkYTK78mZw==
Date:   Tue, 15 Jan 2019 16:57:52 +0000
Message-ID: <20190115165740.32450-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::25) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1778;6:9M/nt4JF+kGy2xVVQuFL38CsmOrqDhTnH6mYEak7ccvpTB07+lqSJ40F+vy5rjf58Z7/NfR2Y0BDlcrN5or1hQ2K0DfvZ0RicbtgU14E7Kt3XUFUmXee4i66UqgOsA/kE/jlSesCG4X8f3pCjXvhE4QZZX0y8MhBxP9Y87mYFwC8qXmZZaNowgw1ZTWo/T8o0/fShKo7OA3M9IiSfCR/tmw9ws3E5VjO2qdkhYg0pXHQcpwqlOkw8G3HpOquMeztlS5Ex0awDf9aEL1oDWU+89k3r9DvuPJx14aDg87JNTT+0kSiRQ7MkzUGnP0ah8ys30H5ZOG0aMt02Mzt2NidJXsrxDMOFDFPhpIvMMTvIw388aiMnfVnXI+pANCKoisMyNQ21eGH4f+CpLYRvkZVDfyRDPLxGE1mkSnR0NPjtjMEwyty/e/yl+W0ZBR0slvQjZo0BOJrTG/lpXNkRFQBVQ==;5:2Se9zjv9v1D85Yh+vJWJv8qAoTwGPws9rHa6pyz0M5F51HJxcnFdjYErJ6CM2WIs0VpSM/pEocc5uN/JlFPXOTIFuVnnWYGwQG7l1WEK8Oxg/9a0Si4JbjT7c5/DgqOMa2VW3SuWAJikPMNvvPcAZmJgtJzCN1kq9COiYWLWmna0CyU9vevFIUr0DoO3SrWu6PwKLcfbvZzj1rFIdV9vzw==;7:r93AMrdjD3P7ZS51k77QTR+txUVDUF7fcj/bG24UvkFseJn66syB3W5gnrYzXdvz//P4WQoagJBd1HW5IxfxXhBgcWMh8Nm9PhQdx5+bFDOuqQpB4p4T4ZxjKIk81kmbQd4P9Irm8602lCMdjUTRuw==
x-ms-office365-filtering-correlation-id: 670a42bd-2f57-4f04-1ed1-08d67b0a9624
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1778;
x-ms-traffictypediagnostic: BN6PR11MB1778:
x-microsoft-antispam-prvs: <BN6PR11MB1778AA05C7ECCB5748849335F0810@BN6PR11MB1778.namprd11.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(72206003)(478600001)(256004)(68736007)(6116002)(3846002)(1076003)(4744005)(106356001)(105586002)(6306002)(6436002)(14454004)(39060400002)(217873002)(107886003)(6512007)(476003)(2616005)(53936002)(5660300001)(486006)(4326008)(186003)(25786009)(6486002)(6506007)(52116002)(97736004)(71190400001)(66066001)(2906002)(8936002)(81166006)(81156014)(316002)(102836004)(386003)(71200400001)(2201001)(50226002)(305945005)(99286004)(86362001)(7736002)(36756003)(110136005)(26005)(2501003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1778;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s+CsdgsvXIAlKRaJLf5kKFfoqlTUNG4y90SN1uEwTyww07QD5hQCQSsl+NQXGDxEWf1Oq2D44ISMvkYofzMrVuAu1O9w2GD8szvXtUDia4BVPG/PIrYHeHTzW8yEjOedgosSFdp1tYu3JH9vgUGPyluKdt+bMeIE7oONwPjyjjz2N1RzBAUpK9mCdDsqBPyz3d1rGrTbw3N+7iTc4l0siMhxuzjl6c5WmX36bSvg4ZfJ+WYccShhR1o/tYTy43NwsYSmeOB3ACSkNj/5Xlp0hX4P61nUgKB0ozBxO2fNuRGoaR82O1VRbkKWA8Q1Nf/TD6+4E9Xi46kuF9ExI++PzPtQX0zRXge8GAMPE1ocBMFSA+edaOi6lCYte9lXa6o6Upo3J5N0eruAnsd0dMTplpdy+Dnq3JvGQcqiO4tNA1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 670a42bd-2f57-4f04-1ed1-08d67b0a9624
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 16:57:50.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1778
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

I have been reviewing and contributing to the SPI NOR subsystem
for the last few months and I'm willing to continue doing so.
Volunteer as a maintainer for the SPI NOR part of the MTD subsystem.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6682420421c1..7deb0e91e3ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14081,6 +14081,7 @@ F:	arch/arm/mach-spear/
=20
 SPI NOR SUBSYSTEM
 M:	Marek Vasut <marek.vasut@gmail.com>
+M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-mtd@lists.infradead.org
 W:	http://www.linux-mtd.infradead.org/
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
--=20
2.9.4

