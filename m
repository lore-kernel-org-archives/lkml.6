Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935328AbeEYEnD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:43:03 -0400
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:5920
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753583AbeEYEmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:42:21 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, <claudiu.manoil@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 5/5] MAINTAINERS: add myself as maintainer for QorIQ PTP clock driver
Date: Fri, 25 May 2018 12:40:38 +0800
Message-ID: <20180525044038.37756-5-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180525044038.37756-1-yangbo.lu@nxp.com>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(2906002)(39060400002)(76176011)(5660300001)(53936002)(6666003)(85426001)(8656006)(47776003)(48376002)(966005)(77096007)(26005)(36756003)(50226002)(8936002)(50466002)(8676002)(316002)(105606002)(110136005)(106466001)(446003)(126002)(356003)(498600001)(16586007)(81166006)(81156014)(97736004)(44832011)(2201001)(86362001)(4326008)(6306002)(51416003)(1076002)(476003)(305945005)(11346002)(2616005)(336012)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR03MB397;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD011;1:kmEm5IrRnab5pF0IiWWwGRHaSC2ZjWnd0KWFzsBupA6cb0ZfAG/n+OT7PGRAodOWY71bHPrqBx5zAKFQkgn7NP/zrw198uk/UyqCOpEim4Fwzlf49tCyikch8PwYXUrE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(2017052603328);SRVR:DM2PR03MB397;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;3:GsazUShWys5RQjgNZ/i3MN9xSaX1VBtCdrSYFieLRXdQUsezxBbBc8jjzUtL6j9fqWcQtF/5GYZNViVMYpe1sqIz5Zgv0trQZhnlN+CfMV43X91+yrnU/WWBn4MNGaO6jPV8bGufxarkWlq3tDPzkk81d2MTn5WBZBEMrJj+ceKEDIPDCwiHEsWQsaVFIhfRZ9oKzLq6HbZkhJp8xhfiDt2XXahHvY/wujeR3f89qjs+RdCEhnayJ+TquZadly2pht9Dg8ixBH920T1T32c1lNYZFLupBzyo5kFZLviG86DY6ke5Tccuz9HS4nkLifTnRkxOq2CEoaNxxgRZkdJlqHMnZU2ggF26nrr3HPwN/ME=;25:X0R+MLF2zje1hHI4vjz/yyriyADBzRY2qjePUii9AfKw7jre15Ph/IaubM9O/0aa3wscraBHg51xHhQ41hrCIyAZx0koDK7OPGGVj1IcM6yMJU6VPP7cJPamtWtHMhF8NIQThcE6jBkUG31fpakej2t5hbORrWIlYJhQVyyyCBhQ2KR0DmP2QW47cbIVpGEIjhYEnCgDDwQCndivneXxwVArVPb8S4YV5t89dyh5Eni8gWtqZ1jiuHVeBd1CWOQB01NTrIHGIVp+NFFVcEfLOHW9fLBEJrhHxzXvFEFtch0CzIj5wbfe400x0or5E1TXjk1hVRUkC48vD8chgRPoBQ==
X-MS-TrafficTypeDiagnostic: DM2PR03MB397:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;31:/MKknVeeJYmMK3w8OKRvMNYeQdI2EEJ6eCUTsAA5yLBKQTadrHhDfD9i6YIbSmHX/gTgfXEBBLRi/OHCZCL8mw9uq7NzAh/OEOJB+Tsp0NukRzYBWS3W8NZA1+yP0LXKrwzUbEru+xvPnLfY5XA/WIeu4s51TrdOt/TmxRcFmrv0XECDDrvs6lKj6uCdxXf5gqPkZhW6MfFrw/J/0fuTMYSRQQhYLd6iyIEYpQ0FsGM=;20:TZXTigYczrjhqojXGxKtEZ6LqV9zWnjjxK7fW+OQMTiHn2vV59N4ifjoy4HZKRjQjpXDFKc7pEEz2qmk9ok9r2CJWuWNEbYpeWd/piB05IgEAhVwZWL4iOVzLcKFSJhxZHewth+/M4dla6epSwzYV18OpoyE5Ak/1Taf6+LuoCN/b3I16CpE/nYR/xrdPk0dnlGE28QMZ91DA9VYIigk6xWl6C5FhMnQEwXAHQMOQLUji7Y/qDFJCSCU8Nw62++C573o4lv3kc12TKOh/o2vUBwDblQP4APJKouZNC5thGEd7FWlP2rvuoag7myLnI3i7fC4PJMHPa909oSkotjo3ghZ6VnkUOirgZDZUGNVhsqIzc/NvjJoB/I5vHZ50wHbhCRW327Rs3at4LlZfNY26FQgKdhsbo+Jbievd17f83RsUHcnOrwPg2nAEsfDCw4FBhNsV+sAp355vGHwYUQneuqq+WapTGiu6hsw/b06eP4R2E95GWZk6AyPEufkkzj6fg6KPzSh2yjbprTdJ+v451+uhHjd7XzR87fDuW0fTBJG0OmaB1YrCFwumR9BEdruM1VdWQuwRJLpVPDyB7y+10X55TmUDidRneLSUeoIgXw=
X-Microsoft-Antispam-PRVS: <DM2PR03MB397CFAB751C097D3494AC17F8690@DM2PR03MB397.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(72170198267865)(258649278758335)(42262312472803);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB397;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB397;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;4:+ATIDVXtBJn3xbQ5v8ImkY2W6S1USiNqqBdN/+V4y4nPfVcYWqSE/LV/wvdZIdiFMiPCfGDawNtpu+tTKBs0C8MznYnG7TqIpokIiHmXe3YrTD1TjuFhXLG7ux4OVVF+QYi9hDlDNLPmRDL3v1TykmXz4+ugjWhF2AW1cLn3ogYOiNMAG+/bOjINBi0ZyWfODKronzjEya8RIxISKnnbsK/N6RDZvw6Y2dSIJUUOnMtJIGP+jUYfZNTyImKz/ngT3FgmqS3cvmp4ySe0Ryd8tfAw3BRRtdm4JSL6c8ABfcX3pdz7dpW2PRkCW1cakd4/6Ly4syLubrOhX7pTEsb+WKusS9lpR2yXgarmnLtJ0GrXvE0VZU/TV2KIBklCLtZ1lUiaSxzF2VX3xIfc7g90SItBfjbLKm/dZK/l+1212m6WHvyFOjoZiwP1mnD1ks79
X-Forefront-PRVS: 06833C6A67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB397;23:ZNIoDhgM+6ZRe2V77Lhev6Ks3q9MRZ0RFm5JTgeQxW?=
 =?us-ascii?Q?9LVGDG72hMoXiDlqyfZxvPpFlq73AUuJX/lXAWnld8e17R+zvvyO8Rt8eWmQ?=
 =?us-ascii?Q?h0TYBVA6p/hWhc1PVEfUMlzX8oMF6ED6dEtuIff3qrUBj6z5YabNd1eouTW4?=
 =?us-ascii?Q?l8y3OKifpCEmSm6yBYvXwe9imOILFkkHXn5mnSKr5iD3G+gmTEM2FG1CK8eo?=
 =?us-ascii?Q?roocUQMbeb+JjSIqjI0lHd0JwbW1AQoAgS+LRU0IeXnxUL4sH9W0auagjYsL?=
 =?us-ascii?Q?Mwpo5tLXgCvEwfxwJr8I9FHfoBdtR1YFdyulIaP5RJ+Eew8178/eMWZJzLEL?=
 =?us-ascii?Q?+wIT/OuzzmrcA+Jo6iPe02BD2SskHtj7qvEJNjnKL8leyFXtFZAv+mnTVkn/?=
 =?us-ascii?Q?FpR4GuOOXX0WxpRSYx9T2mqcdyKVGJksCyHSgjCexCDnWvY1/W9SNKW63z5a?=
 =?us-ascii?Q?+eU1bUrKmQIS9QFkoE74KEx2JA0bH/+ZxMZn4dwYh8eT8UVV8gih0Pl+Yz6v?=
 =?us-ascii?Q?rumHuNXF4aJO/CDl0OM9YooyBEFDxMJSi3nKnt9n4+q2pI2Ep+4gMY/PMSVc?=
 =?us-ascii?Q?nAUsn/MgEEwVrsTBBHpYYwsBpO2HWl4u/LpbAD7VJNA5UULpisQ22zO+R/Hw?=
 =?us-ascii?Q?V9sEmXB4R7QLrwnADRXPbv0aa4y4JuQr5p/jDwuqGFl5bME4wr9S+RNjoqHp?=
 =?us-ascii?Q?P0X72LctegKBpYJ2qePb7KHV8NBaWWopt7zeq6EkN+pNOWgoIBtDTHxh+Kdk?=
 =?us-ascii?Q?4LnDLPQ1UW70CCu/bp3pXQi2/EFie8MuwpC694y25LV3sk17xPBIWOcz7Il4?=
 =?us-ascii?Q?haMpw2aEn6+Tv+kokMGJlLzHuhBthFs543unOb16G/aMw1gn7E+hGXcITOOn?=
 =?us-ascii?Q?jxc4Sc43rVtASP49XIoG2TOeHywiwZfd9zIFKE/PwN6RrzTB0h97pDxRLGdR?=
 =?us-ascii?Q?n/bl35d+i40CFl7o4FyErv2tIxO9XdVBinLPvvIW1PrZ74XAqSq4UV03Ma0O?=
 =?us-ascii?Q?iZkta6tgSVURpELpev3LWAVi+VB5IfdPRXDLcy3WG7bhYQy/EUZZMsS1ebF7?=
 =?us-ascii?Q?7ImOakHzZPAlEt7/TK+VHijCCVFmxbR0P6NO7Naw4KDWctljSE7dsyNSetss?=
 =?us-ascii?Q?XTl8ch9P1gL/xotxjeKBe2smTgXd+aFSYVh1GtB0JSUS61f6a64njn7ThA6d?=
 =?us-ascii?Q?5fuN31IrcV3SEdeWcfGtHQ730Mj10vgZ5t?=
X-Microsoft-Antispam-Message-Info: rlY91bOI1YNCj8+/zgfoeIFkprEnRjurARzu2b5OLEsIcyCjkD9K1jHq04+Gsfx7pQSiakKQrHd3HCLcC4SmbyuD8KWGS7W72TkbgDvt6oXlsXZ5AhCO7PunmLolcC2buEL1xnFoykt3+ZwORG3K2FpehHO5ha4ap8VT2Kx2Kn3wtGqIxfT1z3tBjthty5nx
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;6:hTErcA63eZkEfmBhGt0Rm06ZTdYJXMQyB8O/GusRojsl8mJ1HykO/BNrc7wHc0OvEdWDfe38Fx1nxaXNeiExkxlslTSwBUKUS6Wk7kRcN1xf9ZVKu/DAvYGXMxKmbFGTHlI0Cu6E3mcOKZdxDabpeCv3ShTS7wWy+JP303g3h7FjDI4a/7IbyRwgP5kyN5+gGDERHGMVDcC0nyCZ/nsX5NLRIXyVKexPKZUyfIXMOXcrbNLziNpJxO4ZfYvnL5TckQUr2eHsa+CgwBAQFFHejFapeXKntWCt2m9xoaODY6ivVmfLWyBhRmyOaHEeS59n5i85AomOS/wc/dsTRBAYJh/I7PwLsg0Qv22b9eBg6eAIcfuNXWuLqD1aymV/WSvQvfjEM4masa2uGGdmNtrHSbQEOki36Bll1y2Q7GahnPq6/+n9VVMf82YEqjO9508Y4YkjWxfCv0jvV/YRgZwjZw==;5:EtVMclrWuLzctacx8j3rerG6/zcfvcK8KvemQo1kpFl+P+epialY6VOijM5STHz1sTlxbrGAPTBhJqSM1pQgC95O9ZP2NIHxc9bx/d3RU8bLPVAHxGGfIlyApWVI1AeEYfghQKZ4JlUcB8IKuibuDo3WNHCKAdzIfCpbmvTsKsU=;24:oH/xr3HRA/WhGskBJ2z0CgL6Uhly8BgCp8vr06EE9BTx7qzxRktEQu2gr0Kjf698KxvUaVgJMu1gGzZFjb6aYZH8u8LizAtzj1/055DIRjs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;7:wpaD8OaJE1w3TW+/A6Tcs5GG6PdaDV9+OJArZx6++C0Q86VOnNqy4KLgtrquDLXWynS4xHR8buxNqFSSUtc4XrVpAmIBHSY+GNgQsLKHoVv5be9bnl8l/MkR231KYIm7M+em2igkmmiKBNjQqHai+KXKIdumWa22T8XxkDotozUaSoJRMRZ2XLql4syX33KTygpxJOhZCBDzkR6qcluqk2WGQrYcxJZ0DGj/hv77a1wrVJ7iCvlu8bRgPDLMZpm/
X-MS-Office365-Filtering-Correlation-Id: c50f7e21-bfa8-4cea-b616-08d5c1f9e42f
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 04:42:16.0270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50f7e21-bfa8-4cea-b616-08d5c1f9e42f
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB397
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added myself as maintainer for QorIQ PTP clock driver.
Since gianfar_ptp.c was renamed to ptp_qoriq.c, let's
also maintain it under QorIQ PTP clock driver.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 MAINTAINERS |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b65225..a71d4fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4411,12 +4411,6 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethsw
 
-DPAA2 PTP CLOCK DRIVER
-M:	Yangbo Lu <yangbo.lu@nxp.com>
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-F:	drivers/staging/fsl-dpaa2/rtc
-
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@microsemi.com>
 L:	linux-scsi@vger.kernel.org
@@ -5648,7 +5642,6 @@ M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/freescale/gianfar*
-X:	drivers/net/ethernet/freescale/gianfar_ptp.c
 F:	Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
 
 FREESCALE GPMI NAND DRIVER
@@ -5695,6 +5688,15 @@ S:	Maintained
 F:	drivers/net/ethernet/freescale/fman
 F:	Documentation/devicetree/bindings/powerpc/fsl/fman.txt
 
+FREESCALE QORIQ PTP CLOCK DRIVER
+M:	Yangbo Lu <yangbo.lu@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/fsl-dpaa2/rtc
+F:	drivers/ptp/ptp_qoriq.c
+F:	include/linux/fsl/ptp_qoriq.h
+F:	Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+
 FREESCALE QUAD SPI DRIVER
 M:	Han Xu <han.xu@nxp.com>
 L:	linux-mtd@lists.infradead.org
@@ -11429,7 +11431,6 @@ S:	Maintained
 W:	http://linuxptp.sourceforge.net/
 F:	Documentation/ABI/testing/sysfs-ptp
 F:	Documentation/ptp/*
-F:	drivers/net/ethernet/freescale/gianfar_ptp.c
 F:	drivers/net/phy/dp83640*
 F:	drivers/ptp/*
 F:	include/linux/ptp_cl*
-- 
1.7.1
