Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeC2K64 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:58:56 -0400
Received: from mail-bn3nam01on0046.outbound.protection.outlook.com ([104.47.33.46]:23168
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751209AbeC2K6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:58:54 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] MAINTAINERS: Update my email address from freescale to nxp
Date: Thu, 29 Mar 2018 13:58:48 +0300
Message-ID: <1522321128-18132-1-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131667947321348556;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(396003)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(106466001)(4326008)(498600001)(575784001)(50226002)(77096007)(47776003)(68736007)(450100002)(26005)(8936002)(26826003)(81166006)(5660300001)(336012)(85426001)(8676002)(126002)(36756003)(105606002)(81156014)(356003)(53936002)(305945005)(59450400001)(16586007)(316002)(51416003)(2616005)(110136005)(50466002)(48376002)(104016004)(486005)(486005)(476003)(97736004)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0301MB0895;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD010;1:Dhxbyv8J6Dv81L189FoMy3HRTUEn7hpP6ezQ+lJsArRDJQktwXz2IYO7KZ48zoPzP7sIdSkpH3RuLw4uYYrfCKzot/I8J0ArJnZlFBlNKASf6oWjWL5d40Y/1Z5w1hBZ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d228be8-b45c-482a-656c-08d595640ec6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM2PR0301MB0895;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0895;3:oWh5FFlDH0ChKJ5InUFX4OUjGe1J+z/697eaDxZnBd6w+9tqhMNvboJ0K99syaWA8HNuX1cMRhkWxL+2J4Md9piZxcRZcgQsFKhA6N4E4hBH6Q+FcUN4uc6BFhOWeES346H3zKr0PZQVM7Xe823HNMxed56fW5xbv3o49+E/plzk9Cc+lt0kD5+2ypVlb2ljy0d7UxZwmRcNBSaK9Hj3WWm8FVdIedWs7rqlvBzRvdsD7nBi83QayzDaU33BRmuuKxomlCAlneQQfTiY/l/TXLNsi5k69XDChPAEKtXVS//JDLv+87g4sZz9EJrwHaeTcd8615wNJ2+JAH3jDdFsRQz1H2F8wy1svod82Cn39tE=;25:dYi1rASnhGMYoRgKT/rRDD8+vMOx3OqWuBGw3kPOoHWDb679bqHhvZxFPZqWAWa1ctY6U75AABeGBWLtJjVK9O1YgwvfWzE1p4+qz5FK8esyi3polPc+iWcQch07+vQlvCWwAlwdWFXXa3psC2lT0l7+FrrDlBufgvMsXF0VQBSCOvOYVTbQu+7t/XE5XfcgrweUySRv2xgXBmpdlaw6cVXbD7i1o/bmsllrCkFxXt8J84iBhhN1j8i4RnaXvJ/zGhsXi/8hNowYwox8FMnFl/0j+J020/NLrbTt3vmUUymVALBb/CzP+vnSEChLzjbggDEbD+uO270rB9r1ewdXhmGB/D2upZSd4sbOsFqs+R4=
X-MS-TrafficTypeDiagnostic: DM2PR0301MB0895:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0895;31:8LB1xPXc0GkWNZ3c6CxVhXXkb8K/50GHvBWKsAN8uMMMNeoQ4mh+5p+cTFm/pVf4NKkRPuGxp7mSd+now4VsYxlNnhLEs+DSVIJfu7z+r5xXJKcZxcqbAEb1ABTbHDtGDRc8cAHN353xi0m/4sz5cgZgYjTa+rbTLDRO4I/p3jxKcDnBQij8aoGS4JB/xBNVrm/c8VWg9b/vcXG8h/3ZdW7IPZK+afgvyPzPpq4nH2A=;4:5SGYBLe317vIzgdqY5jErfZkYCReO53eNqTVTjgXCfzFpx4GFV80yAY77mGnIBaYJYb87qLhHMhQTWq+mxbmn93IFI3r5fMwJPbKet4wuhZtUFK6kRA+rPtZ0ow57AqDvx0X1Cgt3PbzNS9oEq5dknttwdERovExz0+OFwVgMLxiao1RC9jKGsd7mge2TE9iWNxBrPgYD9zXKOQlx+sl69OIZmloKTDkC6uZ30Oehz8KmYczyQ2WoEwwI3i2Qv3GA0hjMBAAE1uoOSVepj5NxmC8wfPtKPI0R29cNjR2jaAPvIRe4WYqYKVv1pxq7zouqd/o45QRQgHEXZHs5kFGUK4TFDAoTeqN0HN6JtiIc/0uaKVsExH+PvowrVRz9avl
X-Microsoft-Antispam-PRVS: <DM2PR0301MB0895D5B322175E3A3AE3838C96A20@DM2PR0301MB0895.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6096035)(20161123559100)(20161123556025)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(201708071742011);SRVR:DM2PR0301MB0895;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR0301MB0895;
X-Forefront-PRVS: 0626C21B10
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0301MB0895;23:uObPwmqd7kH9/D2ZZtKDuhu82fZPYzv0uQt14/b?=
 =?us-ascii?Q?4IrLrBGkP76Gph4OwAhctPl3eqq2CSWg6vumck461tfXrLAVY5MA1tAVPR8S?=
 =?us-ascii?Q?9X7WzGqEQ0PG+nVBg5BdT7mMWWEs07kY9VnZXX/CqDieQ0bZ9dE9XQ+ZEtNo?=
 =?us-ascii?Q?rEA7iZX0DoRlvn6fz1Bh/CTKIwFHefMxvA8MiEP6aCY3ZV+9bMaUZ56QCx1+?=
 =?us-ascii?Q?PjUzVLNtghV56KWWfB1t+cc5c30N3q0wOXrbrfSGT2eZjTElfBaqUzWvZ1GV?=
 =?us-ascii?Q?PClcv0IFhGO+1G54dK+J5MhHdiRE9zGR7WhK/IvcjRK1Yft8Y9KclQqTd/xM?=
 =?us-ascii?Q?PZ80/qEO1hcwEl8bHM0WSx9xorqylgJJ7zRCKY796lnCYaAJDXqIK2V5NPrQ?=
 =?us-ascii?Q?29+yDJCE+2eQTNch9paQI86+f7+tCyMCMZyicDtM4hFOwcgJeNPuGxXTtMq7?=
 =?us-ascii?Q?quy07VI2iR9sPwUUAeM1wvrsR/onKlLBLFmhp8rxUTl3giFizhhzyLI1yyap?=
 =?us-ascii?Q?l22Pjg7dPvDvxDtXJJQ731+6rQehClrOwJCrbIZ5FRT06DyTg8wfQR1BVPf4?=
 =?us-ascii?Q?6EDv2L9oWHvQTXmKSkxsoPF0B9DsAA8mNlByWBGzTcq3Gj/XSDv5KAYbPmip?=
 =?us-ascii?Q?btMxdRsw+rAYXf2eM45c/xE6Ifr8wv+dnsHgzOrKBZCXJppy5Ygemv+n7Pp8?=
 =?us-ascii?Q?dtGPg0G7LvV/wcHFfdGCW74Bl0JIUZTVGc8JOf4T9F0qkl4B8x+bvhOwr12j?=
 =?us-ascii?Q?woH3yerrI4G+R7rSPA1F01FsQzZRA7oWxQza6r8Xp+CcRzGjS3ekotWsAN1u?=
 =?us-ascii?Q?/wpVkXpRJCqwhFetw6flTz8/uaDfbi2MSo+BM6gz8e0LPY/Mkz3I+yMcjFDk?=
 =?us-ascii?Q?41qYgxHOWtljuc2lSzSoERp9fmniTH5SqpA01a22wsfs5AXRTXBZ3yE/8dAT?=
 =?us-ascii?Q?I7SElqGQ+4oFnZG6pudrlHf5Vf92ueymkHMnE7zIETcAKVegPSdufCIxHKq8?=
 =?us-ascii?Q?jXpGmZD+kA9MAEgwY6KthTSJ/6Iz4UCyRNUucYTRUPA9BTDRmw75ltROZkrz?=
 =?us-ascii?Q?+IvRhdJ56M00a7MMhkMOVErz1sK1Z+sobDuqdS4A976OzTM68Aa6htAxXOkp?=
 =?us-ascii?Q?kldW7RMWU/Sy3Hl6wb4G77HHYK3NtgODCGLE7rM9HV6O2EkLUlwtRWg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: wY4s5zH4HE28nnQsgZgunOy3dIbQ0YPqHz4Wfs8qDJm7lwaKTztjmX0haLzXIMnmg1Xbku3luMS9a3fA9z/PXmDoU8+XwCebGyMYnkRIKiIAQUsGrmK062vpSqg6D9uTM8AHPkv0Lyjy3sShoEaJkwAAB8wKeVXeduxd/u+2AZJfFGEOX0Bl0gX+CI2wEZqL
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0895;6:615FTcTU31hJR0Tr3TpIJbgcCVhVw9SezTGXpj93AIeq5kHojz9eWwrk5wI/ePVY3DIGJsOW7fWwK04qEiOUeTn3rWHvr+Gpfxns5HgSVfrdpl1cGiUAy5J1sF0o6cw2NJx4dNwMeQ1FwjCiPn9DliUqGFCs1Ji/ZbE6yTZU6SQGr8mTTBaPXgKpm8Yv/YMtIoHcmaCHnsG8VFmdiJ5T95p81juz8o25lMzGS3ffz5IHZKv4PiI+KRJ4kj6cMKTK1cRR6ti/i10e6UlTf/3NGD2g74f74SWi87lVbVzLpQ9ls55NtUFGlWTurERn3faDnIprvCpGd9841R7yAi6Euvo+SDdJGJMRV75kGSTgyJQSe08g/cB/f0B5vHNvRnMEpObKfywjXe5gFt3VFxwjjru2BJhCDngNdg8BKf5nli5dRuI4/Oq/Msa8Sfg7Wf2c7DdKKlHMriIrvTpa0GWBhg==;5:V0+lMw/ZnzbGoPV2136WPhusvFV+4tZphnZIGZjp23TodDUi3CExND35Bn26ITwMa/ETvda5RXYd6l1cJ6hwp/HLh3FxAs3oadCA6TFN5ci40RB2qCOrYS8oHjYbp7Q/7owZyNyTD7y5wCAI1FzjqsNrhrZSK8m6o57SBjgQ1yo=;24:KnOPTp8Lea9MCqqFFsqOvCN+sdSmb3RlODtvEwl75qmrazt+2ElR2hZiwRZbmoZCkXYVoRWHaEQt7NjM8KxQ1SUc7j4yJovMNTEKWQi3ogU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0895;7:sKvxHiUEsuIs30MyZJmj+0vssL/t295/95c83Uypxbk8UDGWBIc6U3BP/T86ZAbAQAGP3qAM7IIZJryv/KD5vOIbXN0THXI47BPdbc0DIecqHV98rgqBjAxxeBsJhPuBrjngSQ2rvzxvnZdSs+w9fuaz+PFUFrZx3UY8e7DImKnITgAD5jH9C40DRq7xdQ1Emhb3EjpgWlu811CG0+MBpat88CixAI20lvVtJ17UCDcIxK16D3DKS7zx7e+NCVVn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 10:58:51.7916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d228be8-b45c-482a-656c-08d595640ec6
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0301MB0895
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The freescale.com address will no longer be available.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73c0cda..274ba58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5637,7 +5637,7 @@ S:	Maintained
 F:	drivers/dma/fsldma.*
 
 FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
-M:	Claudiu Manoil <claudiu.manoil@freescale.com>
+M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/freescale/gianfar*
-- 
2.7.4
