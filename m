Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB50DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7521921738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="i96xM/V3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7521921738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeHNONM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:13:12 -0400
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:5656
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbeHNONL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU0SrN++HuLoh7eH+lPocmQSHd72fxv3/yWPyY2fex0=;
 b=i96xM/V3Tvnh+tPzwW/89k/XwcEGqkQzZADBnRuP85OX2o1Ry/TWblRoNKgdcrwdTRmG7xfj85ruSXiMJB/2Jl8+TAC0fM0oYpGR4E8oEQ1XG4xLPDBu1bqzWVHpJSWLawOUzVOXKSAraItKqZAhKQZ+Cyhqj9FFDvFzlGy2zMw=
Received: from BN6PR03CA0006.namprd03.prod.outlook.com (2603:10b6:404:23::16)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Tue, 14 Aug
 2018 11:26:22 +0000
Received: from BY2FFO11FD005.protection.gbl (2a01:111:f400:7c0c::100) by
 BN6PR03CA0006.outlook.office365.com (2603:10b6:404:23::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.21 via Frontend Transport; Tue, 14 Aug 2018 11:26:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD005.mail.protection.outlook.com (10.1.14.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Tue, 14 Aug 2018 11:26:22 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w7EBQLK4015996
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 14 Aug 2018 04:26:21 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Tue, 14 Aug 2018
 07:26:21 -0400
Received: from localhost.localdomain ([10.44.3.40])     by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id w7EBQJbG019642;  Tue, 14 Aug 2018 07:26:20 -0400
From:   <michael.hennerich@analog.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 5/7] drivers: misc: ad525x_dpot: Update MODULE AUTHOR email address
Date:   Tue, 14 Aug 2018 13:30:18 +0200
Message-ID: <1534246218-950-1-git-send-email-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(438002)(189003)(199004)(476003)(50226002)(77096007)(107886003)(186003)(86152003)(356003)(486006)(2876002)(8676002)(305945005)(2906002)(426003)(8936002)(6346003)(26005)(47776003)(126002)(51416003)(86362001)(49486002)(2616005)(575784001)(246002)(336012)(7636002)(54906003)(316002)(106002)(48376002)(50466002)(16586007)(478600001)(5660300001)(217873002)(110136005)(36756003)(106466001)(72206003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD005;1:uHUy4dihLHneB08NN9tRXmlkODxp75N2M9DJ3WAJrfmZAe09vSqT/PXvaIHaVlCvMr2Rikab5vKqI/KR0rswmh6R5wYUkB75I4gzC+itpU2mcAjEcIm2WwYQWJoFYrrM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edf6c7e0-0411-4d5e-3120-08d601d8c38d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;3:elIr9rofztwiBwYgfI5tuHnqHs0fT7S+5eUmuJBU1XadNIofbM5UsW8j3RWVe2AnEPlrPnw6/3xlWMBxFu2QtCbzyRuiyxq5G2vG7bxRg8JpnMGnmGmIrhlCOL2wC43xHtQ2ui3rViM8Ps1WkUiZQ7+uIJELSghVvUkjwpm6c2ikTbf+YZewjebDjcEu240UFKi7IVwdI+Dx9TxbR26Nwo11dgpxr74s8Fw14nfb7/5aYm/kj/r9JI/9+ylAxZsFQjrsE2WTuv1P8nJ9e33n7OkyYJH9ngzsEOe37UCG309D5qjrhPRXw5lJjoB9LP7nUsMzB2jyDKSJjuMaWo90o92NNtfkW/v1A2BT68cqzhg=;25:1AuAbp0hi4nuLZVfBIPwA5vCDXTyVIkkK+ze/8KLnlL+t0B2kj4pbOGBIz4VmGMb+OhwKfM8ALgaHncA8qjLVQ/ni5HC/lgBLo6brBnl6yUzlp0/IkudrsRvc9N3IHcjGyPD6rsXoWVVksix5HbpM9vBDHQHXmN/ax1NF1N4+Ci9gu5y/QonahVZFkq1gJGyvFkn+QIgFe/LgQlvJ2OAZs2BHWDbk/CrH/1Ov7xfnJiGjdMOpHRk3tfp7vOLE5Zc3wkBqGNbP8vyiyRK5H7HYVqSlY169XiJlFsxhlHu7BFSAImR8pU9Bfge/cIo9JvnrkTP4ZqwN7qnrFePujKgTVg9PIAD8PiIrOrSDeq3ecM=
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;31:Scsb1U0RLE5S3ej7JhOAyoC0WDsw+AvSrgQL4ULJHKbmF//SY1jvsCysd4jqB4QgXyeEwVgbDnE6WCCjgpI314DkY3bWl5oVZ5MLkBlFItWAgYaJMRx5IzEd/BEYMVuv1vKUW0zyOTLWcnJRRJgxARwzBfdO/Xr9mc7yzul1mkfKhhL/Mz/DYykmeGFO9gEk52TpKpMQkpeSvP2Gk9no/nvg0DDwOo4DCiAeGZEctac=;20:K4kYYR4TTpL9an7vT6mBYhad40rAzIb8g23bL4C7nLEBgbsBdXYaiJc/Bv3QfIFEvFmw4I6vSUlY32ZUtqT19mVAKcXQvV3khTUyQeWqWd0926BzZ1e7qqb664NEJW2J60Hw0sQyGt+S/ZQhqzE56YsPIho8QwoZ5dOdlVUJsg9+lIG9zJgFhzSAU/JBKlC1w0lWZqPpsEpxIYCzPcTRSXyPhHIru/R7NeKZo+d+9oFp87nn+GfPL154rl2iOFvVoTOb1XmLs/sOmM47IqaNIU1R+U+TM6zp9sOvPEZVgMhZxLrWRmZ6ju81+5wXPuv07K/kOSKuhWvygoGK+5ER4cyPcBKlHHvegpBcoFXX2rPJgn3gb3rgjX7pX9ZSOE1Sl81oGJkQBkpVbq5FFxU6E2jhny7mLh9msM1+91MG02IU14PC0hlGptaoRDHV1U+QJM5HCAGpwv3+4IW+MZq3g2xee6s6uQNBjd10JsyaMXY07xg+hUU6FL41/oJok9i6
X-Microsoft-Antispam-PRVS: <BL2PR03MB546CC58C6EBDDF871D653AD8E380@BL2PR03MB546.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL2PR03MB546;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;4:fzIABklu2lNCVvDcQOiHjHEdvSv0I7yPLMxY8NNsgd6iFPS66lfxi4qmc6f4SoOYIQ1peQBmom5dYg7isfn0kxg1/5EcfmgWS+uwmPXZbL89v0/YiX+MTIev+i69ofNTOusfdY7d6eZeu2X6z9vaT1RX4Apda+A9waT9HPqH92lD6mNkTF6amJWGkXzYYSt62oN/ZNMAkcMwk/pu0OfBawsNV46rEjtHqKKEXUL8cQ9FogLV2Ui59UCG68pmm8d6LPBx+60WIMXZDZl+r6S1mRboFMBOpd50ysayRHzTQVyyb+Wg1B1tynE28DjhypO5
X-Forefront-PRVS: 0764C4A8CD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB546;23:PgcH793EjgcvRHi/Ed8xNcYmNemeau2Ykc+R03hCVH?=
 =?us-ascii?Q?ZzvbYhQ6kyi8hcO/SD4BmDpBnGJMe9sJ39FDsE10iitBH/pSDYYKnkYXBTXF?=
 =?us-ascii?Q?kjF86nirhf7+MLiD3uuG70TWnUsrjhvkUOeO5GWRZiqYhFBo+YD44DP/S8hN?=
 =?us-ascii?Q?eD+MJRBVsMo7ZMKyMt4cRrUIZZjj8bIgZlzF7Hmw1FQvRrXRipRKpYtrYKDF?=
 =?us-ascii?Q?cAs5n5ctZ6Qcm7DuPHwCn1Y2/sEXSCRyDZ3PWniCN+hOJRtrt8HbYau29O28?=
 =?us-ascii?Q?F4bLFDgprSGidB2oLk2py0O6EnU0L7pPigHPJY2sWg9x4CRighWXUNHLzKbC?=
 =?us-ascii?Q?qHwpO+TZxUS8/cRtAFUREPwqFL55GzzvxbiQp3Spc15rN0LSHkU3PtQackj1?=
 =?us-ascii?Q?zqc+a+tfxUEYU4tVzs7ghKbO1BJldKhZA8SeXQdhBQdGTefnOJ/8uoeWJJjm?=
 =?us-ascii?Q?ezvRgLpfHUQEKTMEmOu3yfULOddQmLXQiUOFtT6V3nKcjSI7ZjQa2l9LnpC5?=
 =?us-ascii?Q?ClrnO0gRaZgaydXxivLerfjoKNRBh7Au/+BSx4p9ERVPJeuPEEtpfW3MLAH1?=
 =?us-ascii?Q?hFUd+lJyxS3yRFGLXS9NVmqXGQZQb2S4wAImheJ/XTQFGeWUanrdXYG0nOSH?=
 =?us-ascii?Q?FBEFcE4pws9615Rf1XR4RiK80/gBD3PKptnR9Nrp18m9gyQmFw4KQ+fk75e/?=
 =?us-ascii?Q?eUBp8E2pErgzgaLnuQH+Lvo6IEvzRDGMn9+NHmiB9w+6ihP11aYgGIkvoTP7?=
 =?us-ascii?Q?UH6lPiuD6ytvB+mc9DzaOLJaAk1BQnNpm2Y5rHhvdHwB/dfR3gi02tYYozBQ?=
 =?us-ascii?Q?jjNlZn6Mo8+zX1hkZyNd17dzgcBECPb7vaFripru5JdSOAi+3mLnptcsq7VB?=
 =?us-ascii?Q?p8Wa6bS6/qgU+Z8stSB0Q+sCIume3NpCEYCIC0AzEbfGy6FMCr+UksnXW6rS?=
 =?us-ascii?Q?bmnY1q+aZBSf8/1hZU5Y5tMclYyAAlCp2N7a9H4n1dqjifE1zKmzE0aZs175?=
 =?us-ascii?Q?1QicwZqB80dXakCgT5KJ2PrnLq34vsad7TIlrAKm8L9Y11b8opAbmf3ifRi3?=
 =?us-ascii?Q?U3h5xxZqYL5PRdE/BJgZ3zsyAI5jb7zHpfnfcQEGJ3m65ywA=3D=3D?=
X-Microsoft-Antispam-Message-Info: X4B+Ippy1qTljfr7q5m79cAcYDEQbCEjAdYfN40JrGWutd7uvabl06BZpIReUv8HM+J0JWoEc+MtSUb2gS8lIr6Q/cKUPA3OLNfm3OXJHRDw6TITQCNzz64tXH3R2s/50i0mvYFzlyAOMvm4m0CbP85pVvSRrOkiETPDaYwraqGAANshA9OvgiWVViLnOTFh8YLB4EkMcv4SI7QramSQrpikIiNTvB19DheHNoKIQPdaaKis7x2rMACFjlrr/YtZk5QLx+de4QtE4+2Ov127gjJ7e7GjtUoIbBrov4vIYCJgk5k/vvNj2pjT6oixn0l058YbqTfSOi7KmfRBV+a+pBhyC2rYWJNIOvriBk7ztj4=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;6:rEjOemiZDwezIa9T1MxB08JI4qn2yLG9gfpjyPH8vGsMzwC0s1VGf8Sp8gs37rgRaF4ooM/PEQ7ffKGJ+RO7rfl6q0nCIZViTHPFpPi1gF41aBRUDJBCO2jXyDqRmNJfs0eqdv6XsmLImuExsIV3lBdxvKhThbW9KGoK8IHehmFIZ2JEWdIiy4RDOj2pwXzw7NXoyHesF1GPDi/Amvldrlna1OlH3SSd7kT4E4p14JBaGLfWCS2vT+Jxl2x2zs+4EHDpbgftxkMDZGsJcwI+4c4Sd4YdyLi9IMJ2GzH3Twu5Ls9HlAxBmyLqUnXlhkiSvCqUuPEsybtY9MH2g70/onRS9D//2JHaPu5ipNWP8eP/1spiB0deLC7/LpsE72C4fuk5Esv3hZmHwpkMVMz4LVJ9CZR8Mf/9RjqdtHzYfTUj8cDPvdsgMd1Sj0xF9LWYRkHrRUefWg78cxQfr438Wg==;5:JLF6uojSffMW3UPtZuHFdPHHh3cduAXEFK3jgJ38oF8Sfyk0Dy6N42X3n7UxQNsIP0PKOGyB2L/PjIVP5VzjPBeCY41dUkWqLIJUr08rLCRzXeROMjjJ9jTOgilB4YsTwFb4wh7skOxqHrap0BvOpsS4O4bpvlYpX1QRHPsHWpU=;7:NejfEkrRISXVLS0MdSPIldxzswgYltEw7bW1yqisGPQ9m19/KOUdIqe1MBFCwOqbcobBxF+EzpM94KzXj/rFkFfM9VPXqppLx4awfsE4W4fezrGrWDMMFLo7Ow9+Fkg9vxgKL/dE0eF9ud6Gl51l8t9YFkG8k9fpd4e1WM29B+AewiLV/Uoc3QUTmxZe3JtFYkMHYBbAJ8bwI1GbTcYVC54y992GfAAY1V+0JR+WPrpbx/8ltqy8a2TtQKF3XqcI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 11:26:22.1909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf6c7e0-0411-4d5e-3120-08d601d8c38d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

no functional changes

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/misc/ad525x_dpot-i2c.c | 2 +-
 drivers/misc/ad525x_dpot-spi.c | 2 +-
 drivers/misc/ad525x_dpot.c     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/ad525x_dpot-i2c.c b/drivers/misc/ad525x_dpot-i2c.c
index 4f83200..1827c69 100644
--- a/drivers/misc/ad525x_dpot-i2c.c
+++ b/drivers/misc/ad525x_dpot-i2c.c
@@ -114,6 +114,6 @@ static struct i2c_driver ad_dpot_i2c_driver = {
 
 module_i2c_driver(ad_dpot_i2c_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("digital potentiometer I2C bus driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/misc/ad525x_dpot-spi.c b/drivers/misc/ad525x_dpot-spi.c
index 39a7f51..0383ec1 100644
--- a/drivers/misc/ad525x_dpot-spi.c
+++ b/drivers/misc/ad525x_dpot-spi.c
@@ -140,7 +140,7 @@ static struct spi_driver ad_dpot_spi_driver = {
 
 module_spi_driver(ad_dpot_spi_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("digital potentiometer SPI bus driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("spi:ad_dpot");
diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
index bc591b7..a0afade 100644
--- a/drivers/misc/ad525x_dpot.c
+++ b/drivers/misc/ad525x_dpot.c
@@ -1,7 +1,7 @@
 /*
  * ad525x_dpot: Driver for the Analog Devices digital potentiometers
  * Copyright (c) 2009-2010 Analog Devices, Inc.
- * Author: Michael Hennerich <hennerich@blackfin.uclinux.org>
+ * Author: Michael Hennerich <michael.hennerich@analog.com>
  *
  * DEVID		#Wipers		#Positions	Resistor Options (kOhm)
  * AD5258		1		64		1, 10, 50, 100
@@ -64,7 +64,7 @@
  * Author: Chris Verges <chrisv@cyberswitching.com>
  *
  * derived from ad5252.c
- * Copyright (c) 2006-2011 Michael Hennerich <hennerich@blackfin.uclinux.org>
+ * Copyright (c) 2006-2011 Michael Hennerich <michael.hennerich@analog.com>
  *
  * Licensed under the GPL-2 or later.
  */
@@ -760,6 +760,6 @@ EXPORT_SYMBOL(ad_dpot_remove);
 
 
 MODULE_AUTHOR("Chris Verges <chrisv@cyberswitching.com>, "
-	      "Michael Hennerich <hennerich@blackfin.uclinux.org>");
+	      "Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Digital potentiometer driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4

