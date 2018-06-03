Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeFCChh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 22:37:37 -0400
Received: from mail-he1eur01on0074.outbound.protection.outlook.com ([104.47.0.74]:52960
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751086AbeFCChf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 22:37:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle driver
Date: Sun,  3 Jun 2018 10:33:46 +0800
Message-Id: <1527993226-19587-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:hiALlebYFqSLH6Wt3OqLJRWpkcSTsP7Fz32jjh0Ici9RtuV8mn/jABiIoO1cfeHDae6rNpjpCcWWQg4zz6xT5cS25M+OLpPj5qFzFS6OeulwQmwPVFPekBUa9Cefn8Y/bVn0SsgY8ViqccLHft56sF6u8oJena0EA/T74C6QVPu5LieBjQ+qEkKqZaUQJOcjeT+vtpFx+N4KBdke+qBvzQkOP05wyxbBu3jNbzIPYSAMk6JYxvU0mYZLCvC52aPQ;25:rOypN14eEpp4BvMzZ/CnzKZKNAZJa3o5xJ2Xpre9t9IDPqpdUocreRkwXqkzhPvrG4AQHpGI3hDekkz4JzHz6lHV+EC3O/ozQfWbdDZrEvJ+kGUWS++2YpYMC9X/pJpGZ3pIB2wszyrfW32vDWcAraYTHoKHxUk8RkQA/BIWTscvObMo2WNds3x31xrV1HEFa9W6Z971zsy5FLHmmIS8P3JIGXx0Q7bMKBTQ0Ya0SbFFA6pXoQhCmce2uySze7AGjxjT/7bEmFbtMAZNAfvueyvV+M3Xs+CVrAtmQf4ol1e2V0YvLm5Yt/ibmfOaZe0yEY1YtOfTMYS++dAWH6rcsw==;31:tmmJ2FsGon7gV42Q9jcMpmz/dWr7gdlKJ9QA3ZjuS7PKHMbiyH7vK62U4JOzu6KkDlHJlJPmePESvT5UMB75mLj7Rb4tC6lqHpeYMUkPG2Ggal14tWf0ZyR7VnSof2xV3rzKaS7WHusFk2oUgJJPxtWkQHO12nHzQ9mz/UP8Fs4kglFVc0oxh93jFZYnbiuaB1m9BH/BuWQ5epz6YScttrH5tJDVHhtF1YMcH+Yb8yA=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:uQFALpO/Ws6hJ7TcZtAlG3nLKHRDvaVWcIVbs4jN7U9Hb5GlLe3cFcVZDbx0Jni0m687qeOgdaExrs6J8jZiJy1ghhBMLepI9yCoZdd/8874DOJ5W/JUGRYOUxjDKaSyC+P2orvwuwnHHk5fsq1xyoY5anx4OXPXF2c++cWQ/cs05T55Pd9WVXi7fbsTOTau20xmLL4+qf+s2Qtd5WMJsueB8tnpopJ95Uwz2cEZyhHkIN5ISCcNDCT0rqVCG6lTq9BHve8HavmTW1BPVtGTsNXvzOOPyMZPMftAJUKUduKnZrszxwwPRQPenC227+p/W0sxCtxmt8MbWaTEjPBsCyNvDFP0Rhpfr8BTc1vZdfiBRoVeCUAzaya2FPCd2Jov56xkFTK2HNeh5cD5muK/jPjBvQ1vxRLms4fAVjtAZL7AgYVoQLx2Uu0xqPxhdlt1+xZeWREIOcHjtFD0aQz2INHFRWsX/fFKa8WyU6LY9vG4Lk0PJmg78ZVwttX7BBWP;4:QJAkAmgYcOxqoY7b+ezpGGJ9b2Bd3W56dhlgIDX1fvhXv5HUdVsZZRqTYg7zRVmrZp7+qaPSQlv3L5CSflDKha2+dqjRS2vxjbinj/9XarVbD9EnLKl+bESSPFWepYVG3JGOjUfMX7kRnVnaihsZNwwvJYgk0aLatX5MBy+V5n2f6+KntrxokNdggKe3P2iJwEEGJ1B6uK0RrmcyBclmxZo6hSKZUd/+i1zu60aFnOXxpRzIaavEWFGGoLGyxgbjgR1lMQHEVuxRryKkJBg/jDQNuwzPKTysg2hLjH7vHcFdEVqV5qOJS0ETQKm3hpOD
X-Microsoft-Antispam-PRVS: <HE1PR04MB132392AF635AB74DAF2E1B2BF5600@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(39380400002)(396003)(199004)(189003)(105586002)(305945005)(97736004)(86362001)(2906002)(106356001)(478600001)(66066001)(81156014)(8676002)(7736002)(51416003)(48376002)(8936002)(81166006)(50466002)(486006)(186003)(956004)(47776003)(2616005)(476003)(52116002)(16526019)(11346002)(446003)(16586007)(76176011)(6486002)(36756003)(3846002)(6666003)(6116002)(316002)(386003)(6506007)(25786009)(6512007)(5660300001)(4326008)(50226002)(53936002)(26005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:A9a3EMoDmAcV8TQF2fEP4E3Q2xhjanFwOP+rEzej4?=
 =?us-ascii?Q?Fvf22j8KMdhweauIsINgg3+YK/8fDcOGUn5Q+V3NKNqzYUssfb2miqCJhh+t?=
 =?us-ascii?Q?XzZn4MxWaYGiT1IMNWTTs59BAt/tJFZIh6c88E/A6DsF1U/O8DcPway7wrI5?=
 =?us-ascii?Q?P7yWkcnjQt5YURdgqoEzmSFM7DUzGUMIjw09Yb5zQh/caUwl7aTNIuLM4N89?=
 =?us-ascii?Q?YbfFV2FcS704BFAdgvIgYLyMdljAFo4sfRV9ixihiGmzbQbWOc1ccOmiuiSH?=
 =?us-ascii?Q?PUctmovQvI/93TpIltuEPcTo7aprnQJk/GHRjoF16ZTupgysMMHAhbNSFsC0?=
 =?us-ascii?Q?0FW8GCCaZBRPK7oG9h3XII01sfRQYSXAY8m0jCKSQYs/e3GgoY0sbZH1d/ZD?=
 =?us-ascii?Q?XsSnKYS0Mb1Yvbn0c81NRU/9Jdn+EKYEMq7K571IFKACcanrxTF2QoYKjDnB?=
 =?us-ascii?Q?kD/Esvb50wMC4+Yhzw3TdvY+tAUEXURng0uJwT+8ZBurhKqTt2z1i4Z55ckC?=
 =?us-ascii?Q?weLTEuOXzHNaW/OZaRZIn/KLWW5m7uv6o4n7p95zU125uKZSfp/O4C3X9hOZ?=
 =?us-ascii?Q?uUxldwr3QdQBNCeHqiU+j5LntjBw6BZLb3gKTDngb7V6rKc8fElMAAZ/I9ma?=
 =?us-ascii?Q?gQlOH37+nQ+Mc6rUBN9rQz3OPhRi5g3Ej++jCuotqEzaa9Zd1yZSlIkZzUJJ?=
 =?us-ascii?Q?w9pi4/YuR8k1fcKKfFBUbrY6pVl+6Sd4nmAW69zazvNFUIvmyEFRoRTwhd2t?=
 =?us-ascii?Q?s4ztnvLP/n2Oy3VdgrFbQCBPj533Ue9IpP5sXJtbpP37sO0XdcBb22hrMHib?=
 =?us-ascii?Q?tphJMZN92AG0Tq6ca1mddc4oIrobEO19APK5QR/zh1kiqBteDz+8XFyTSbEx?=
 =?us-ascii?Q?m6FcBXB3iYR2UOCgZxkql71d0xKVpRuU5crtioz7ZMX+nAjYHQIRVPIzwX6P?=
 =?us-ascii?Q?j6v4z8r1fG+tLSh98oV+4J8jVf+T8UqH96lZt17xPEH9qKVwt7Mv7Kq9IqfI?=
 =?us-ascii?Q?+ernEnt8R7P902kCzNzFojJFf8OX6Qzglz+NaQoliidHCYfyxSUdSR9S71n9?=
 =?us-ascii?Q?V5GokTPHYnt47X2tr1Hzr2A3W9fRgHMx4HFP8Q/kCVXd/kMbx2d3rWLj1ySV?=
 =?us-ascii?Q?zuuggcG7o2UKgnIgrS+S7EGJTCW1VLck/0rM6lPJ2u9G1mwTm2Clw=3D=3D?=
X-Microsoft-Antispam-Message-Info: l/4Z2gwzYFUwDZaV/5WwPmTv6HmdUwdaJuzGh8lPaM2PrhKeeVERXrkXMM4wU1PNT4B6usw6Mu+AoHgrDxOhHrgOIxIa+6Dm4POrp7LueK9Gf/6whyP8At8gfwdmtJoW/8baqcd/bNT2v1NnWjCqtl8039zCwtHuVJ8bnKl/7Lk3Ynjkpx+89pQ7n92ttY1i
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:U6Dweiw3zB36QzbRH4X8OioXbja8nNBB3CXoxCQLf8PqcA9wGA8qFLIDpcDBsH0ySlqRIcUCCSYCrcNHnu3hm0OuXHYUBH5Dfqw2hzfGmRgAYRoc1v4cIh3jY2SWjMYYPi/Kfyr9XKpBAOK3eUQm7c+negZfJqhlun8Fab7DtbIFA2U9tiWvAd5cH3EBZG7JNIN9Sz/nuwWsVZG2K5bf8YX+SCTvdOP7rF6gKeeccJ3SWDUeu6U0vRy1w7Y4tOm1pZLRA9iiUuGO4KEN5xszIlq6Q33/8QKYZUK6Yz6q2uhe6KQHZZ7rVG2TcUQYUAMjPw6GHGIrssB1t49YL5bLkn9Nj4sQy53Ydraph1pBtO5Za8oKhJ32AHLlSoQgeJrDOF+9M6pwjiLDVgR6z+/lgZuHZwYeGXOD/o5wi4Zxa/jsdPR2mvxUv9sl1h8QXCvko0EupMocS7YG+DKQSMiEWg==;5:Kw1++WpLO6O7SXyUhUluLofD55uvX5Qwz2Vj02H85onA3BBKD2bWqqMF+69pYXzukjfc1NhXw1Q0CyGV7ynOU+ctuonH0HKjeyAg8hFNkBa2/r8W7ttlzTLBGbKQ1mA2FuaOtDsuC4bWXdZ9c3Aa8mcMBJoAUFTyxIW1pYKBxzk=;24:mGbsmVMcdLK0Xysvapnh5drsL6Vn5pCRyu095M7vEXdP6PNWfL+jiQPAIv7NzZTGVQjP4A0T54fU/sCIuPC0vpeEWZlx5qRnsiee4J1ZBvk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:VXA1iiVGJC0lud+j/XtnGLQwb48w+z0D+Jogl3hPNcnbaq2U5RqQYpkvJSsfe04/4VPUgOxnjCM6olw7aXXVi7PkinuEXGpv+d0UWNVAJGneLhGuDFPjM85/fX0+L4BrwrUBAF5bxQ94t+opqaJVo2faZ8mLvv8wjUvOWxavUO6i+PLUycT4buw0fuBYbGn1J0Pb2oMOCJvUwr2+ngz7bVsNqf26EsGopLgptREPXqVCEdZBckjmklHgK029LCuM
X-MS-Office365-Filtering-Correlation-Id: fe1e6a29-6c91-4dc0-187f-08d5c8faf406
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 02:37:28.0149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1e6a29-6c91-4dc0-187f-08d5c8faf406
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL supports ARM power off in cpu idle, better to reuse
i.MX6SX cpu idle driver instead of i.MX6SL which does NOT
support ARM power off.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V1.
 arch/arm/mach-imx/cpuidle-imx6sl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
index fa8ead1..8d866fb 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sl.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
@@ -12,7 +12,6 @@
 
 #include "common.h"
 #include "cpuidle.h"
-#include "hardware.h"
 
 static int imx6sl_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
@@ -22,11 +21,9 @@ static int imx6sl_enter_wait(struct cpuidle_device *dev,
 	 * Software workaround for ERR005311, see function
 	 * description for details.
 	 */
-	if (cpu_is_imx6sl())
-		imx6sl_set_wait_clk(true);
+	imx6sl_set_wait_clk(true);
 	cpu_do_idle();
-	if (cpu_is_imx6sl())
-		imx6sl_set_wait_clk(false);
+	imx6sl_set_wait_clk(false);
 	imx6_set_lpm(WAIT_CLOCKED);
 
 	return index;
-- 
2.7.4
