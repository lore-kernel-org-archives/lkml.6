Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B47C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC25220870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dd0a2umI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfA2Jt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:49:27 -0500
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:43885
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfA2Jt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FU0zrbAbKa57Fitc3b9C6D9KS41z+nyW5e2tfGe1ik=;
 b=dd0a2umIaO942Ix2K0w9ECdkVb0tPjSCeRZuEKtcpMA6LBnQPFxuO9N8e6vfOR23hY+O0W8ZVhGlp0kqIRXsJsfQUc7QOAimkDKG9vjCvr6H9AN8yVgqV6ggoK+TAQwbiieFj5YoVGsXmxbnPHllh+toq5rOsVWgV2EcsWxMkLg=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4240.eurprd04.prod.outlook.com (52.134.31.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 09:49:22 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%5]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 09:49:22 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2] spi: spi-mem: spi-nxp-fspi: add module license info
Thread-Topic: [PATCH v2] spi: spi-mem: spi-nxp-fspi: add module license info
Thread-Index: AQHUt7fpYyKJev1QqU2j2/cYy8Wrpg==
Date:   Tue, 29 Jan 2019 09:49:22 +0000
Message-ID: <1548755240-27319-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0126.apcprd06.prod.outlook.com
 (2603:1096:1:1d::28) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4240;6:ERQC5TJrEBog0Xd7qfdJTXASP+LwH39c6XVY9PsjFK3MW8R+ZtzmCJpPC9Z2NUSyMSoLCf0Q5TSD9a5N+7eyVTbOYCwciWpeQXcNNxV9SO+jLc0JigvKJHWstIb8/0LGiny1zZ60TxTep8MkKOGL/vD42kesLRtecdSGlKm0jNaRAfOsi1+4ZHiN8Es/sWBe+xNNynPdfEQlhuVdrMGRoJT7ILp2eospRdJu0eyRRFTsenytsfLXCnrLKvwrgqkFdCqdrmd0hNLNaZER51YVk67S3+SvYkyNpZKV9w6lo7oiDAjZUcd4iKCwAmU5IxwlHizu1dEZnzM9zNjqAwsxHg7ikDW+crwY8b9ZaywSKbp4QNw4hSINUQ/SWOAeHsgyiyaBQVUF8vEcMdxUUeTn48BtI7c8dh+yDp1h3GlgQ+AFgcNf9WZ2oUV55OJqlM2bylTUjjBStCfOLlCVT23i0A==;5:xrMpFWsfwTbl8sWOkuxwmI+PUjbnVcDlV2WG+aLi8NNBchOqoqgff/3VhhumVjb9WFTVk7UFqwT3olXv9IB2gLRlUA/ynp3MpnuSWjW4O6GavBglo1kFhuE+A6FOu20p4kwwlr5MDwPdGePL/SM0mXkRriZwx9tzaLwSsKY9rfka+3hwtyDQkvIwMQCYTF7GZ3ff4Sa5T7Im5+ZdRKcZ4Q==;7:pYOJ9aq5B6GTe6GBgx0GLJH5q87D7DQOw62Cw6h65vkH+YqJcDCm67IFW7mRS2Xwqz34TDxF/vjZ79RZMn6aPPBlBjvY4exejDsOeQUZB8vKOilN2GAArU4VkuQICSMqRS85qHHKvJCd2+2kRmqJFw==
x-ms-office365-filtering-correlation-id: 7bacb5f0-4813-4395-cdf4-08d685cf0bd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4240;
x-ms-traffictypediagnostic: VI1PR04MB4240:
x-microsoft-antispam-prvs: <VI1PR04MB4240C20950FC8BFADC15BAEE99970@VI1PR04MB4240.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(4326008)(52116002)(110136005)(2616005)(25786009)(2201001)(476003)(81156014)(102836004)(2906002)(8676002)(81166006)(478600001)(316002)(105586002)(39060400002)(86362001)(14444005)(53936002)(99286004)(106356001)(256004)(54906003)(7736002)(14454004)(186003)(7416002)(71190400001)(66066001)(50226002)(71200400001)(36756003)(97736004)(486006)(6486002)(3846002)(6436002)(6506007)(68736007)(2501003)(305945005)(386003)(6116002)(26005)(8936002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4240;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S9aIYsrz51l+/7fLUQK6r3bOKyVUFEGvLu5DeENHlKAirNQGarXXwygLU+noHHuqdKtlwpHtnpTnO2yo4pgjh/PIef10CMp1cuev93MhYrFUyqZiJbp6FRwRsRJkyS1Q8ERRdPOklEvNXdLmI4w5o10KyT//kfL9UfVbojyG2wEXlfQlxUv+O98oa7/5yp68Jo196mAeItuBgk18e1/FcouEEOHJwERg7oyDIGwg76U9nYsIZqtbU1ueIJ0BUW4AjxxmJ1/sSBvNBiUVE5/K+7pKzxNWZBeXC3Qch10lmJXNqfqT37UEwtjYdL+t8FrpLbgGUma5WA1AfKLmnVUHqKi7e6pDxptUfBLr9og2vyEa5XQWWpVMfpbnXeUaiA3yKsBtY8PhHFbzVImZDF19WoazALvoq48uY/oQN2jjl10=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bacb5f0-4813-4395-cdf4-08d685cf0bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 09:49:18.3021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE info to fix below warning:
WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o

Typo fix in Boris Brezillon last name.

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
- Added Reported-by and Fixes tag.
- Typo fix in Boris Brezillon last name.

 drivers/spi/spi-nxp-fspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0327216ef7aa..8894f98cc99c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -26,7 +26,7 @@
  *
  * Author:
  *     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
- *     Boris Brezillion <bbrezillon@kernel.org>
+ *     Boris Brezillon <bbrezillon@kernel.org>
  *     Frieder Schrempf <frieder.schrempf@kontron.de>
  */
=20
@@ -1101,5 +1101,6 @@ module_platform_driver(nxp_fspi_driver);
 MODULE_DESCRIPTION("NXP FSPI Controller Driver");
 MODULE_AUTHOR("NXP Semiconductor");
 MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");
-MODULE_AUTHOR("Boris Brezillion <bbrezillon@kernel.org>");
+MODULE_AUTHOR("Boris Brezillon <bbrezillon@kernel.org>");
 MODULE_AUTHOR("Frieder Schrempf <frieder.schrempf@kontron.de>");
+MODULE_LICENSE("GPL v2");
--=20
2.17.1

