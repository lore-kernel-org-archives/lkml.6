Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeDYFlN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:41:13 -0400
Received: from mail-db5eur01on0045.outbound.protection.outlook.com ([104.47.2.45]:14493
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeDYFk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:40:58 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/6] ARM: imx_v6_v7_defconfig: Select CONFIG_GPIO_MAX732X by default
Date: Wed, 25 Apr 2018 13:36:11 +0800
Message-Id: <1524634571-5914-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:604:b::25) To DB5PR04MB1319.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:4RJNYqrx6Ne5UXCRRISY04QrBoSJkggKv1D5Oe4WdxmoNYzfHEedFiORA5OcJ5iTU9tb7Bjt1JEWBZewjTHA8+1TIBJYk6lUk8nGu2+V2t5uuVteZwD5sZEK/AJEfKuDLCcj9VAhjNSLW5R2HaHvmy0/fpdpGYfdRdC06FQLFpLHwMYu9POrZ2T+wLwT//AH7Co8zJg+mwEmUsXFHp4MAe4SPPCP+eQD0pcJVFaDbXF34z8Oq9epkDjsELKeC/qN;25:ytMQmrdUAy6rgurj1xQWqqAAa7WxNBWJbUhJV1YhypDP7VP+RqHeyGc8AgL/bRKsFBF3rDD5lkfevPISm2vri68UnttG4T4eDjirFxSbpoOM37A/4aMFmD4MF599NUH8hcxvw5QiFXE9jt7hhjxQiHmNjs0tG1qB2XNNU7biTfGD7/w41DkZWMitgMbSbPP/bDgXkqpHpNv3JM0jkXod5/z/iSjZTHK9H9BCBdZNC+ErcthhKnm2O20QbEWY9Prkq8tyuoLCqJoOzr8gTegegTxbeLOjnL9Olrx/6ICbh7WvriG4vxlAOMiNXQ+v9s535fB8UbHtd6UKGosQq6ONQQ==;31:nGOS4bvscF3Fd6CXZulpWX0FY3TK/CID7FMhcXbzIyOXguFxQTfwuCR7yV8m9+YO3yyjL0rTcy8kDXaOoBPGfjp0xOrsRO2R6P6NrR+abr+KV/2zdxoai9TfsXaZ18pOVSXiHMiTnTxBMeSaGnVU3sKkGeSbX81BjB9RYtm4b3SqGkb/0EzpTtjVdpkpUD6fDeVT7epB2r7m6S0ptfFhhDaC10DTyAfNXOkHIvG3Ij8=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:l29598P8R5mM8Dwx0/sY+yOG+97jNvMJGOI4SV94XSg87d2gDgbn5okQmH52PJl4CnGRhJCTbNViWDDvDGYClcaYULL/Rh/5zkeSf3eKP7dVWGaUvel2ky8xFVZ+5680xFHYiURALjZQUmVE5E+jfhI3ZlZrb2s/jiJcdsxrHMiF+ZjYrFhFgdKi6zfhbOfNrjq2XO2bINgZ3+nVKdR1dyvc5XQ8KFmWKYnWlkmRyuMqeoqqwy7ugbjYU0jB4qjzzDgO6Uqa3xtbJ+gLOe0p8/dxWXGi84wqvNJvqdCm+FSe2nPHVVXj9yLQMsmo27brsylDTnHW/iCf3eMGetIsd+N8bJs637nhfWuTuN2EX9i7Pm3d7wmctNbuF5xvU8HoF36evWCVpQCL4jhGRm09HtpgMy2Mw4EKkgWUnXoNzNprBK61OSPIi4sy6lcfdc+93MPAtUuneOlcEBDE/8vDdytvseR/K+qpJ3953m3pFDpvo8jGyt4+YkqqW3x44pTm;4:BPO4doJVVDgxbjCBKtaNSTVS+RTM48uxiQl5iRVMBIrMN2VOLO3d6MmbpJULGMkDjzoIJgQb2hPQxbMNnlvRLGuuh2e3YO5+0JIRqnMFirmsCJjwwtkoEiex6JEVAHQrQI+CiIZ7/sUU+H0r+Udr2Ca98OjUjj+PiuZSm7mqIV1nqG8UWtC9ZllDlvKMUmBYtybviYKxBEphQXlwkGndUDOdzLX7/IptWEz6seZP78NrxbXo44CNFskTjtDyZrcKUK9HiXUlV38t9mPlaQ61llfaMrh64+HdNEL3949UUQWkB2nK2rUWui7M2L818Uf6
X-Microsoft-Antispam-PRVS: <DB5PR04MB131919E454A5C2B08FACB21DF58F0@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(366004)(199004)(189003)(76176011)(478600001)(53936002)(4326008)(25786009)(16586007)(6512007)(51416003)(316002)(6506007)(386003)(2906002)(15760500003)(8936002)(81156014)(52116002)(50226002)(81166006)(106356001)(50466002)(36756003)(476003)(956004)(446003)(2616005)(66066001)(47776003)(26005)(105586002)(97736004)(48376002)(3846002)(186003)(16526019)(6486002)(6666003)(6116002)(68736007)(5660300001)(7736002)(86362001)(8676002)(305945005)(486006)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:E4Ol2FDB/tqV/DKk+vhfCVpaY5B4c+gTz1egsPchR?=
 =?us-ascii?Q?MDXEUuj8859XQlQXerVTscvgw31UI4qQbzwAN4FDQ+Z5rZRvElvdA9H4Zm56?=
 =?us-ascii?Q?WrASfxxB30C/59/KAG4pbLcp+4BpaNiBiojU5WEsvQ/aubxp8eT9RIP9k7cL?=
 =?us-ascii?Q?Q8rwN2AqQhQ2d6B1HQCvYfjqmfO7dB36EVP1fkiAIqqoigO53NysX8tO1H2D?=
 =?us-ascii?Q?YmOnkI8EcqmDcJPP4rJxkEra5vFs+LdAxP3aKJ3NxByUUgjwZpDfTM8b3gRr?=
 =?us-ascii?Q?hTbnyPMjlbQ8B6HyuMLc6AlLl5V3Iam5nj0extCpnrlTvQR5wg2NXEZ6UUzG?=
 =?us-ascii?Q?5EXQZw4csHo9e/IlKl87Gx2EtgV/PcvaQGG27Vyq/y0mMqqRBq9HslNF+dRU?=
 =?us-ascii?Q?EeWVC7s4AG7k1TLx3A14DUr+QwKGvWvoUVFZOPye0kIQ1LixaibUVcJSDA77?=
 =?us-ascii?Q?2poJPYGHxqOf5ZJSJ6nln/wcPQufq7LKeFgdQg1fDs62jW0iqpahDvBL+FGv?=
 =?us-ascii?Q?THwiUR0q3DBC8/bjMRzZudfXTFrCI6lARTM9YmIscmo/eevQ98dheya8T/l5?=
 =?us-ascii?Q?FiYjkZG6lMEna+6dsnyqCrPeXDN15HUU191TWHX5XQDyrPXFdwIFU1THGZzY?=
 =?us-ascii?Q?7pRYWDhvEkL+pkUUTtT81JpftoYitG60FQtN/ujdLzPhZ/4bO3WWYRioOaKo?=
 =?us-ascii?Q?S3zelrk3FO9MiyqSvyxTJNHh22WUTbzQjNvw3UAmBsgB8E/dz9RSwKqa9bfq?=
 =?us-ascii?Q?PtIOOeWxEi9eYnVYF7SEsG/GHxtmBtCu/hpIqvPLjDsi0b9QJM7vVI3U5cSn?=
 =?us-ascii?Q?D5rtmvSDp7vsMLGy+WBEeAm2th9TlBp6+QLGK01XFKdMHlbCqW3RS5sykHub?=
 =?us-ascii?Q?NCzvi9vCuR4ArFdVUGZojxWULNipD3Djyp7dK7rK5sYBryTxJh/J3+bHXV6m?=
 =?us-ascii?Q?v3fd/j79wAd/a6NPlSpj/Bw61glpM8f+xXgA3Wy+IGVNz6U0mW2tBtu6Lq/4?=
 =?us-ascii?Q?Vm6kLv1f+vkyXSG+diEbEuFCiMV4oJ4nvYZrK7b71lqYQdZBEUiHjZMdQj96?=
 =?us-ascii?Q?K95cHi+YMp+5FkwqFI7z07STknemW+g0D2XpZxFiLwyDg2XP5HKd3Jj4YDTE?=
 =?us-ascii?Q?6YlA2LqVbkWaVObnWgThu7b+ZQEZzncA+h9NSfn+F3QsreZHCUNfTPqhyFp1?=
 =?us-ascii?Q?EC2hPt7hQAhcJk=3D?=
X-Microsoft-Antispam-Message-Info: qg6fJ7hZuSGXWIPNwUR60VkPzQFsLwmPsqCyfyt3H7/3vLwZeJSf+aveqBccWVU1Rm4r5wVjhqO7LfolZ6zNkuVcZxUfA9sgooDHpo/PkSNdyj0ATEPoxhh3/aXdtpuBpJteNg8cIsWx4DFXREO/8s5umjuukeXCJCX9W7KezqQlymqTFxh3UUNs/zmNOfFh
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:dUGTadsAJopPyOMt56JANkFqgFIZygPcmwMdYP58NS4tl4Qi5kwrP97UqVGXwBFx/MhK8w7Kr4dAhH7UE0Xan4rG63chPq+oeNRzieUz6RwMMphJeFWiqgtGJppzueBigFNSUaKWIzeJ9zLA2AZypaDFXP8KJN553eoh9RqHxpJBgz9p6MXh8PFUwzyL7zjacB68W3eoWbSUzbWARg/vXCq0WDlqdlxgZ9YHHLU+LnNYypEDQgTsZrF9L0am3k2y0/w7q8s3rTkPjlfABiRrdyzVL08PUiyskLy5zHkzwO1jb9J8rxCIr2RE1ZILGRTsKuHw7hqty/qRfseW9YX6NcxUf8n+kA+rRAgU01aJ25HIRnI9sd95h5n/p6WB19AVjgFdcogz8B52eqX/sNyUWapqTqhedTczSjUIB7kNG1r5NMCseiNAqRjaGEyDFQptGZER2CmNkdvLkM7kSqF2wA==;5:8P7pn+nPv+eV311f+bIx3jJz3Exx88nUtafwi6X3UgkPtm4kAAu4SFzCOYrQwlKxK+603um7yuI4+xkKM7xciDn5iiJLEPt6MaQCFnPkeJVNcfLdQchHvhoEKPzSfnIFkmDORqImV05zsDE+jjvO5BDhsZG+lDgSzdvgoYpRXMY=;24:fz7EEihn1303tUAp+K3T7JIXXj/DSpZolzaOS38Gx3jcC6oqyjoCLJRapkDzV/dGkxaMvrz2y7BhObNzsHm0NPyzYJdMLVLi3OYvEurXOxk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:uB7NS/U+wKno/akYbt4C3Wmu/Sg7VcP8TSeXtMFGpOK9jeWNaODkf+TGMe3w0R/Tk45T/kJxYCF1gYVRGh/ubGuj7O3wn5Dqgw2h3MSqgsch7BwSq5J5LkUoF03MB7vB6ikOcENIsR0WmiAQWgmTGeXGXXm1U/S6uCHKYTMEYBtM3MMbxnGfDO6RwqUgcoG7IRvKPHTOoop9fJ+Lgomth0AevpQ4RhwPlGcaoqCLHRiT6M4p40IEpw/tCOn4Rp/4
X-MS-Office365-Filtering-Correlation-Id: 73dd817c-2ddd-4720-4b05-08d5aa6f1dc7
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 05:40:52.0952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd817c-2ddd-4720-4b05-08d5aa6f1dc7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable max7320 IO expander for i.MX platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a30843..8455d39 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -199,6 +199,7 @@ CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_STMPE=y
-- 
2.7.4
