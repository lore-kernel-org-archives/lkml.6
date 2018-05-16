Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeEPHtv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:49:51 -0400
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:20233
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751288AbeEPHtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:49:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Wed, 16 May 2018 15:48:57 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] phy: berlin: switch to SPDX license identifier
Message-ID: <20180516154857.00b37622@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0022.jpnprd01.prod.outlook.com (2603:1096:404::34)
 To BN6PR03MB2628.namprd03.prod.outlook.com (2603:10b6:404:59::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2628;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;3:gVgJinLGcIzogblj/ismhgOUINxJ4pl5urLSatKI3fQP7iyCLX+Qc9S403c+ehwmbEHHpydV4wtiFFqFUGSU5tzuCJAbHdyO3duZCySBqbKIkoDaKjo0eC7koYqrdVdDx6ftSfJwMIlIkA2wj3wL/QNgRbc6BpHO4qhCvmcGQD8uDWdW6DeLJ8zARfe4enhKbgarCpHkQ4SrxxG8Xr9odcON37YmEq+y8wYBy+6xqA/VIkghNxcv8XN5CEit1oBC;25:my6FiXkf7Vr1TBn73pfai4GIRXiR18sce20zmDyncRk0WZIue0QildHgWqf9O7DhYblisC1NH6vajHg2x2gChWW/9nVXIy7m9P6CaV8Y5BDgcdXtnhDyl3hB5kGA0NFF1Ui5GBjUdcEdpFByjIJT82XpP5HAEK2IvGZYAiCg86wRQrvHPvGxAZgHtkukGQkS2N/m7r0KKiT15QCcuESCpo7WyiWTcAj6Mr+SNAmZtdkRPltyWV3u3l9UmWy/mwIb++Zyx0PhEBdq++dHl8FBFVEkoG/iX9XYXq7SQSJXG7VPP8pxRv21Fz7dJN0resK7zjaCCT7CT65OXpm9DuffFg==;31:fI9WNnoJW4XjYjQAlhdg44gOm82D0O7OHSrkrtiRCTSWxxmr0eJ+ULDlxkpSyxfyP1ACYI1Q47oc+e0qtxup9Vjz85CS/pyQ131X62Sg/ICFF1xUhSdTVG6UgMG2eUXbFDmku0Rtq9KkJnXONoz0vd2nr/Wo06AlLebgmGCVEEeTbb1e/bwmRjBOuuaFF4eYGV0BB0zGwX2QjZQoatioU5rtMPlg3QOW36DRdLfu9Ac=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2628:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;20:eKtWhAthRkC4su7nv1s9AA7Kx3Nrlyw8AUdsZDTgCRoR7IoZj7QG2+XhBqp5By1ZA74t+uU+Gd2C0QH32BkUYPyt0wSntTdnleRYn1sp/e9kR+t7COeoJS66anLeKhQGE/uWh0gtZnLxFiCSHGDf45I0MSaC8SvNPq26OfzmM/m7fEpfi71mRsymv1uiPszxKPlksVyppnoOTsrPFVy3fjqYzhCGx7hEXDyWRgCajZh8wvOfqLrpeLvmvD03fPdcQxdT7vy3hhQbul1tlKZ0xOffYRnIAxkELK99n9X4CHlF9KrYRC6EkdL/8kRX/a1Lhix2d9INIwN9Gzhw6Qhjr99AvprAkpB/uQi4RGhH1moVOW1XpZJylEzlDsngYbOlE+59FKk06yBtzgxevXAjkXrkkhqHdJeTDgabKJ68mt1KcFr5tv4D0NCjkwTk5g1IaZn/Q4HalBwzLLOc1ItJsO4CjTuMd46Rlk0dvOmKmpHN2Ie6y6FplfRjcpCkgvc/;4:KrJZtyL8jpVQ59G7BjraX8zpd4ctDpLXXCe60wVXwUi6msJ2MCP+dKdytmzWEaCwcJPDttODQ2SQiI39ZApbrleENnwXetT9XFHsjW/maF7ZuljTV26YTn8n0h7MjpLsBqTK8nXlY8WyNGrTyVmOgBsDGkpWy49GyMRZxYhbVfw3wXw2FOC+6GGgOuXDAsfd4hVlWG0J9WBc2kgagiCjnowRuWLh18yqnQQ61JoONaUUR3QoDn9PwhuWSFhydWyFxeqhyXGihRO3917jTKPzTpoFabilWt6WX9UJKXrt9zovSKPLwYptdwtN1vKhBMIA
X-Microsoft-Antispam-PRVS: <BN6PR03MB2628855720B1E017C300D371ED920@BN6PR03MB2628.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR03MB2628;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2628;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39380400002)(376002)(39850400004)(189003)(199004)(7736002)(305945005)(4326008)(68736007)(7696005)(23676004)(52116002)(33896004)(1076002)(6116002)(316002)(386003)(3846002)(47776003)(66066001)(6506007)(8676002)(26005)(55016002)(97736004)(476003)(81156014)(81166006)(9686003)(486006)(86362001)(6666003)(2906002)(16526019)(6916009)(106356001)(956004)(1857600001)(5660300001)(8746002)(50226002)(105586002)(72206003)(8936002)(186003)(53936002)(50466002)(478600001)(25786009)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2628;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIyNjI4OzIzOkZZNG9RWjZVbkJCdnBxd1ZSbkt3UzlKQisz?=
 =?utf-8?B?RWZzUDJxM2ZhSXByc0pWMWt1S3NYOHVkQTROVFA2WWlnUDBzV1Z6ZEhmMlBC?=
 =?utf-8?B?am9zRXBYWWQ3cytaNkxKRC9BZW1RaXoyWUtwYUhmV01tbWU5c1l3QjJPWmpo?=
 =?utf-8?B?T2R3dXRWSFRzTSthMnVzOHdrSEs4eWVWY1BPRU9xa0NVcmM3MHhvV1gwenBL?=
 =?utf-8?B?TmU1SXJxS2VSb3JYVHpyaFVESHV1RGtTUjE4VGliejJLOHM3L1JJMEZaTkpz?=
 =?utf-8?B?Yk4valZMTVJwYXZZdXJGc0krZ1FzVi9iV2NWSUxzYjRTK05jNVpHeEE0SUo4?=
 =?utf-8?B?TjVtNjU0TXNiN1ZYUWZIbUloNjlxY2syT1NJNjNVNUtJdHVSVC9UQzNSNzlo?=
 =?utf-8?B?S21wN2dtMUxSZnBveERiVGx3azV4UmI4elQ2QkQ4UkxCZmR5K3E2YU5UYkxr?=
 =?utf-8?B?WXlBYTVJZmdEdWJzQS9hNVZvU3ZZVldpYk42aWZpZGs0TkJpZUkrRG1tREoy?=
 =?utf-8?B?STYxZWJvbUNZTnlFcE5kbEMzNTNKOC9KNzlucWEzcm1DRnNsNXYwRjgwbUNE?=
 =?utf-8?B?UUpOZEtCa2xtdTZMdE5TRmVka0IvM0NPTUMxb0lVdFlxOUwzKy9CZ2w4TUc1?=
 =?utf-8?B?N1dwUHBIdHBHNDc5TzhUVTJXRW5mTjgxLzZSeExKREtHL2lyVFdvRG0xK3h2?=
 =?utf-8?B?S0NReFlST3E3cHE3VlRPSTVDZU5teEZQblEvUzV1eWtLeWZtUDRQV1VCVmJL?=
 =?utf-8?B?dEtMdEo2RmJIb1loQVhkTVBlckJmSUkvYzBvc011bGdSUG1yYUJtMWRyZld6?=
 =?utf-8?B?MmZqdUh0eURpd1dmcWJYczRUbVJrMURLRDRqS0tkTi96dWlLUHMyZTkwZHlQ?=
 =?utf-8?B?K0x1UTlHK2F3emZBY2RjSURsUXE0K3JhY1FORTJvYWoyaExpZTZNWnlYbCtr?=
 =?utf-8?B?S2V0Yy9uVnpuaTNqWXVwM0lJeWtYS1AzREEwRElZTE80aGY1aGZmcFJvOXIr?=
 =?utf-8?B?eUx5VkNKbFhIRWUrM2FhSit2RzlhQ0NMY2pKQU5oUGdBejJ4bUtSZDRXdWpz?=
 =?utf-8?B?N2JiWlhDckNOOE1jbzRETWhEcHI3RytlQ0FSeEhzUFJxWndQdzl5b1lwek5L?=
 =?utf-8?B?YUhsOGkyNE1BdFczaXNxZlRsd21iQ1JiUS9rV1h0MDhDRS9jZGIvbWxWSDBB?=
 =?utf-8?B?R2ZTNmp5VGV1ZlFTRTJ5aXFXZklFeDlzb29qbGlQc3R2K1JDNmNhU0l3eDVp?=
 =?utf-8?B?MTRhd1piU1Y3TDZXQ2hDaEwwUlJRbW9CUmkrbEhZUFVyUUtpcHBVcUpsMGl3?=
 =?utf-8?B?Q2Y3cWVCMDlkVW5BOGpQVFBSYW16Um1MMUgxSktxUUo3YksyV2duRDhxTnVj?=
 =?utf-8?B?WnVNNkdtdE9EYTE3ZWNCRmNvVnhnZElhYXVPRkx2NnowMzV0cmZhNFhZRVgz?=
 =?utf-8?B?RTVoK1NHeFhGN0puQ29zTHg5aXJpd2tjbmFMVGs5VEtIK1ByMmQ5NVY0cFMz?=
 =?utf-8?B?VnhZU3VuMXJQUFowTmtObjdRdEJHT0QzYjFpR0NXS0x6TmFxVzBqRlc0Vlhu?=
 =?utf-8?Q?2bJ3zY6434MdJ1Zez4mOVEZVMl4cGUG7uAdQK5FeIB9c=3D?=
X-Microsoft-Antispam-Message-Info: Sl6lvB6hq74mhIFWdWez8ZAeEwnNlO34/7u9pnL4HIbhitLoDwfKH8YFaATeZPPvMYUigaBB9b0jG9lbRxeMCFB1tFdcOIFE9MOsSBl9GC8mTyHra9wd2iNGmrgxFTM3rnqmWm6Jf3LhUZamNdTgMl26AI6Y7+i7NA8kfPyjhNNNgQqh+E3ghzbdgJxwCr8t
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;6:nh1ydc7cw6BM5kyc+ljDzxU7ne7Ihu+vLz+CisikDoCPtXVaTkONC5DP8n632hYP2DK2i03rBK34Jr2c4OMrSGTwDiK0YYXmxS8vX9eItyq/JiIgO8MuBRq+32/PBXKH5UabsikqdvFfi4on0mgKsRFiqHO69SxFqQFvGCBSm+brJ/+fWYDUtYX1FTW9ZioEAVUbjOLkTUJ4MoMf8cYy/x+qsirkuhTYnt9E+5qmqwkrZMFxCUnn6J49aX52mhV0ZmQMgUk8BHSQQeEMtDr+VQivDQfB/8Y0ZQzK2dVQbqExccFvL8vYdnok/X9mQiV2yenetHMWs+iEDMlKqp5O117ZywqGqaGlsojKZ+1H2fkGe0ykeLzZvNpEA0Z8xmOSWEShCYqpKpuiafEX6JwQfzN1shWDwqOWxcqOb6ePUIjs9P3dJhAl+Hv4s0H51qMPBu685k9w9gwobgpLT/qjzQ==;5:3M+vJ2t7W1vosWJ2jrLcMx2OGab66ye8d5AQ0jivJAhEm+ZL8ey8Bcs64gyVaCuRfPkQjkuyZVE8wK7J9v4v751gXGa+J/AcQz157X356c9lVAwe6hGCjC0RRX9HmKJ3An1ijzzV3ZD1z1h09EFU4cr6v/lL0b/zexWFxu/wSBs=;24:T0kKwmsKmRdjOFstI7xXfznfP+S45Bu+BJ/8Zfk6O9YX4ywIR1nobpv5QGF4vGiLX/OPuT7dzjf5WnTdELvgrhPFHtDVWGuhsAA9RoFFsDY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;7:6pn1lQXMJ/1ZdytDZaG7At2fahgJjnZb3ctJRHsRziJVtY01/GycW4Y6mfGcqoBhtvt9h6psCZmZ2u2sXD5h9kjeuU7/aCvbAzDLLtNTUO84q/h19Ux/900OMVd+gFG8y9JYOAP6Bv4LuUOW4TDxwDGpvooMb975WXCL6/cqdqgIuV7BZhIAz4S5Pt5GIzbER9bAjCfZ0Yu0FEgfxbmkJTDoc8Wy7Nu0dBHFnnPo2jva93pzA7gFMq7N8DBENDoL
X-MS-Office365-Filtering-Correlation-Id: de698ef7-03d7-4050-fd3b-08d5bb0196bf
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:49:43.2031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de698ef7-03d7-4050-fd3b-08d5bb0196bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2628
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G7pVea017430

Use the appropriate SPDX license identifier and drop the previous
license text.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/phy/marvell/phy-berlin-sata.c | 5 +----
 drivers/phy/marvell/phy-berlin-usb.c  | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/marvell/phy-berlin-sata.c b/drivers/phy/marvell/phy-berlin-sata.c
index 2c7a57f2d595..c1bb6725e48f 100644
--- a/drivers/phy/marvell/phy-berlin-sata.c
+++ b/drivers/phy/marvell/phy-berlin-sata.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Berlin SATA PHY driver
  *
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/phy/marvell/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
index 8f2b5cae360f..a43df63007c5 100644
--- a/drivers/phy/marvell/phy-berlin-usb.c
+++ b/drivers/phy/marvell/phy-berlin-usb.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Tenart <antoine.tenart@free-electrons.com>
  * Jisheng Zhang <jszhang@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/io.h>
-- 
2.17.0
