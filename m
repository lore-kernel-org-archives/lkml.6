Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeEKDhS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:37:18 -0400
Received: from mail-dm3nam03on0118.outbound.protection.outlook.com ([104.47.41.118]:4128
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752469AbeEKDhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:37:11 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>,
        Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        Meng Yi <meng.yi@nxp.com>, Wang Dongsheng <dongsheng.wang@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Tang Yuantian <Yuantian.Tang@nxp.com>, <ying.zhang22455@nxp.com>
Subject: [PATCH 4/9] arm64: dts: ls208xa: Add the identify of the platform to support to set rcpm bit
Date: Fri, 11 May 2018 11:35:25 +0800
Message-ID: <20180511033530.7931-4-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(39380400002)(346002)(376002)(39860400002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(4326008)(8676002)(36756003)(26005)(77096007)(51416003)(81166006)(316002)(486006)(305945005)(81156014)(54906003)(7406005)(44832011)(110136005)(126002)(7416002)(6636002)(16586007)(5660300001)(76176011)(6666003)(2906002)(336012)(86362001)(2616005)(8656006)(356003)(85426001)(11346002)(105606002)(53936002)(106466001)(50226002)(50466002)(48376002)(8936002)(476003)(446003)(1076002)(97736004)(498600001)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB388;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD017;1:KTHcoLCj0uFfGTH85pLAMME6Xcdhm03Pzp0U+uArlb5noEtg9RwGs25NciWQs3tnFvvFhNTmB692eh3aa4tJI/ceKN7D3SzQwmk0H4WqpyRn9uLISFcA861z4x1e9YZQ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:BL2PR03MB388;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB388;3:bgvQJlfj3Qsm3Utq/s4ftMkvuuEI/8uOpL4WTJPi3q2m1yqJ/fmNtAJDcqY2mCqLEP/Yzrt8AlS2gqpRBtcSOCS6gE5A9hZiQxBlEYoH+AAlNA9UoJwRrwl1M/48pkEKkPipKO3f3NXv71CqOv9ON8rNT12E4Z8rDqrN2kEystDK0emmMjDdCUP61yrnqkIPrP+rADAq5M5/1H9ZDHcwQzuTPn5QgWHOcvBqlTQ8gY9XnFPonmHcTGVta6BrYXWeW63T+bFdgSJ+iXQ48aMYf7viWAAQejmOR6qFFkqzOxBG8OMzLYP+tq/BbUie1ydifKKoN7V8zHZlSuohsXhiKB9FNj4p9FliMqvYPwlKOWE=;25:1HMc8uC5ui1y87T0/tq1AkLilr9v/j3LZAC2kNuWtBX0uCr8kkmHmKqz/WOI5K7TbJOAbrqUZ7NsMrQ8jJOqIBrD9PffmxL2fLjXW3IQpoZOBfzHej0+HDCHTzTFnaFJo1NJ4GKk9wq/g4vzk4IO5kPWup7uCpom1WQS1nJrohuy8zNkS3HAa1OMa3qTZgipSoGkVc7b9N+C6fZLzvIFcxfYpYJPG9kNpq3CKPALcj4DzMK0RrtAIb/GWEt3zq7WRstjQdR8e8HwDAo65Oy1z5a88RDIR5O3ld0KO0ISIAJ6ClM3umZ/bFAAk+q+QawB+RKikddh3AAhSXEd641EpA==
X-MS-TrafficTypeDiagnostic: BL2PR03MB388:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB388;31:hOWsJRHoSZ9WO8dPT+fWUdO0PnAug6cJSvYVq0o2axH/OkC7vBDnloz9/rYthb77m9cyZ/qT8HW9htQRh0vA2Zx93MYICcteDAj5sdmavwVPGC3LZYILZ2KY419AS1AeKhiWPX1AkBPpgPdkWidAbQc6S3Lys7CqjgM/L5c9Gc3/cK/08vzzJf67qQdzSuXVOwNaGbi1s/C1kfRAu+OAklwn4ov1u9PzgyeT2XGLtPQ=;20:ZxrILYuTbTCXsBAxyT7uOg/XQNk02WDQu7KO41yQa7+L/xucHaFYPMArwRSIZQyimMZd7aDn/VD4nT6wTzxo9kk5vjVxUq25izeV9x3aseVHYwm1rAeiKk8KZ/MaI5Kb/kSq791iKsRbiUii3dByY7Z/5x3csAKCfb7OlhdWWSohisxjLO8O5fNafXOOtovbSkU1wgeWHeYaImt5H3bMPXmfRs4RvPaRmwFjiP7RXg31md2hJjmKGf+wVFs5Jx70cCAQS90JsU+4xhgGMzYE3q1Mt8AFiaaTeaob5iepArxgzWWv2lFtzQ9BDzykk7ml9FLnyIh/omm5ZceACDwyMmssB6JRLqrANqr8L8Jotf8Omo3oggz44tJfdv4y+2XCwwzJFHN9WfkjH8N9iNOTSbUHdKDi32v/wSLb08lkFah+hb6j8mYSH5eMcn+x/jcrne9crRETE4VsIuF/kjMffIV2AjVzf5id3weGdPNQm4nmawGLlkXWZcxSNPv2ZnTtMGV7WHbPA3sUIgiDAzdVAUcqbtNoyxYsLVCCjYELpQUCAZDEpzbvKfVo1acUkI8nIYRXYyCz+KD+pYbKtZtowbl7ZV1hhCTNQCOx31sYeiM=
X-Microsoft-Antispam-PRVS: <BL2PR03MB388D1DE89E2687B486CF30EE99F0@BL2PR03MB388.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(20161123222025)(93006095)(93003095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BL2PR03MB388;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB388;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB388;4:uC740dWeGuYRbFzsR21O4g+UQ8pWHevwF1Bq9oE5lczdop+CVlrn8GCyKjcwcUSD3zvMoQ7w66B9u7v6bxKkr5GuJGDWtp4nb0NKCIkFFIbVKYHmBMwf5CqV2fsMKvXSlPCDk89tCrdBcLslYfPzf1o38TA4OoFe3E3InPjo2nsgsYiDKpGRGngxhAesAvOSUC+ga2AL+eGBwkvtWlx9fz87kseEmKgeCy3Dt/t4zXMkIA204pq3aYFmUEcN6rtsQCV5A21Dlmb4xVnvubDrutjVZKUhxrsXqphaaVizmPXQdWNOmJpnDZ4e564RJtyC
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB388;23:/auDo9btdgRraLN94oHZtiDm08cGqrbrrOOHAh1guv?=
 =?us-ascii?Q?aOLxDn9i+lrUsifeFTsSmmNIzAV+bPUIkythgxVGRM/t9vACUTwzPjVecwkU?=
 =?us-ascii?Q?tghvQJWkCebk24rSfwcxM3oQsxrQXJKx9OJrd2jW6VwHk1H34YihLdRNgSM4?=
 =?us-ascii?Q?EjUE0An/S7DfTQ8rNRGc0gsdPIWFf35RRRoc8Z8yIc5ajc0RQlTO6u/oYVsN?=
 =?us-ascii?Q?hZiOIhoHoAjHvdr7+SOrz7jdG8BK3Q3aywbvqcI2nh+mfGqw5pWOCAhDb5vM?=
 =?us-ascii?Q?v9r25sgYNhTdiMpn5zmYCqOK7wsygUTDIrMG+/KkT7BNtIb+LiJyU5/AcHlc?=
 =?us-ascii?Q?tSzQVaOb5eyTTzdLBsutAROTQ7HoypdDaUWIyKbgE/eyLupeYmF87EY1SATN?=
 =?us-ascii?Q?8M9Ks7yxUdSE4DJ/Rngd6A5RIZeoURN2iKrObJwBQiY9EVXs2EjzL7YJLmk+?=
 =?us-ascii?Q?AincsepdWtDeavyhzClSPWJXcte7e9beW3f93bj3ehKZjgh48ClDE5KUQMk0?=
 =?us-ascii?Q?vnk1+1KQ5+oCJkoiajqERJ28e0RPgc9joDQoMv8SLEXSPbMQ5A7wGaBIu8I1?=
 =?us-ascii?Q?k5wRRv02cg+hsl8lurnRzeoGxdG7W5A0HcB6AqiqvamOEljQx5yhP+xcPn0x?=
 =?us-ascii?Q?eQGu2WnGdvshg5BKcQn4BvDpeMu1q5PJdLd8OKPvnqWheNNS9m4nxEg0Fr5S?=
 =?us-ascii?Q?aNf2ewgURHEHPi4nz0NLp1xUIh0CVIdAh2/yXvlgfTDl1y1gcyWrzSkbTfGJ?=
 =?us-ascii?Q?u51uPm/6X3BGzDjXUOxRT6Ntk2NRqVIeh0SGFixjLMvLcRaaMaVtWgYAEJ8l?=
 =?us-ascii?Q?l58HTEQkglI7TdGzh/dszI25YkIihVlhDwtENXaxS3LPsy5n7sOeNx0XLLUD?=
 =?us-ascii?Q?Pb6zNj0rch31uBORHWzy6Xg+73HwTiF3H4A84nTW9QXefOw1ebRMZqJ4VrUq?=
 =?us-ascii?Q?DUz636fS7YM3IWOiuDz+ztW0/qymwzQIG6jPePaXa4dwGVZpyBN8B3KWcLJw?=
 =?us-ascii?Q?kphfSy0iac77aWHc2lDFR+6d1N7JT3BpiixO1oNjG6h41x2XTicvew1pf5Jp?=
 =?us-ascii?Q?trfcG/nQco/NwGruyf9a3L1WwXvgX9fc7359dG1LmmMozRQhtnmEgsCsIdkG?=
 =?us-ascii?Q?Xux/fR5/CAOWPQdMz/FgTnf9akQBjJzRWyXZifh+tAZ9UExp7LEr4VmwGdb0?=
 =?us-ascii?Q?N7pZtb4kh8yeZgyPbE2UrWEF6sNHvngNVS6+vjcoeBKmA9JPUDnqasvQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 2yR+KGuIi2nSXC7bIo6qIZvfdHRCv9vYkeYUPWLRaMYPyW5x6zJRNdgDwV59EmzoS3N+TKi/588N4ee72Q/KL776k46HQ/rj1Ha1lNV5ThlLWqR7gP7j5xD+FE0UHUE6Vir71o8LdAEZg3aE4esm71MmfTNNI11LGKRdm4K8eAjy15cJsRFpt0RoLKPe7qTu
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB388;6:LOfUGt7llHfhoUTJScvcom0EugMXOFKExX6HfW5gyo1pFMUc2IuZD9jseVrcT+iTmyXVjrgilmDdyaJQvo25+C7FUUTNlXl/gourHvlEJOiLZpMnY3RwC3muBELiK2A5Cj+UdiThx84gV7QepV0feyRMSs5U0x4nbFYVt3bSoYBSNwRUwq3wtp0ZFgN+rMMtLCANaSrRgFPLvQEcqd/4TWakZ2grOkjFyoj5ls6mY5OBpWRbxbOf8Z94RL1AuWDsAlW0HnfRq4h2EryqSpwqVlOySM9s7vlF6u/JcE2MARp8cqtlgSsUwUjjmFKO1+pn7kJTSqBX64UTudmc2mvJ8lYDgP96TYS+GQRmNgEBlJGHI8XWzShs8M9zenOGtG8mEK/xEuIyzrnUqBR/xUP9BdLcUdxiishWSPRQpYtEAzPZBfd7P+ssP9Gqiqijy25Vdq0cC1Ym1hsfBxerE9OdOQ==;5:wEL1lGFZhA4OHeT3apvatDUP3KnlMPqDALzo921JBpeV0Yoy6bSGQNkcA8ELFZLPkv+1NRkO01IM+vB68MBnL4d360GRMdJG8gaHOt/IOPQzt+TQcoFlzppsKZAw17EO9JDANvMtw/0p2pExU0MTG0qHIg0p/37WS0O35jBCJ2A=;24:E1rIjm18q4IUX4/r0zyeaD+ykAugVN1S8+LdkpY2bjKx2Q0PGcb+Z0nhQpJFBUKM2dZ1C7fT8jXF7sPzGqWsOBJ8BXSPUDYvW5c63R95o1U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB388;7:0HDKuN0iNLaVE+FvTkYl1HHqRpafd4asX7LxDgycTDAYcLWNC+JAmIQtTvkFdkz4vUbE5kuyM8OBWc7m6oq5HSfGZ5t9gjDBQzMxrApvoi95OXvN4exU+hRnqO2FxfWuhBXYhs8pivZkjPTftjHIZLLru9nofR9oSub7I5juPCxyKkJU2hfsU88JTXw1fW+7+IEljzaRtjMxhcOld+FWEvxSzyE4lMnFAcklZo2wzluQGyBOUSiemWlJVQ13bmAL
X-MS-Office365-Filtering-Correlation-Id: 0eec7914-19e2-417c-c032-08d5b6f0752a
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:37:01.3815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eec7914-19e2-417c-c032-08d5b6f0752a
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB388
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Add the identify of the platform to support set the rcpm with
big-endian or little-endian.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index fec61af..973e646 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -896,9 +896,11 @@
 		};
 
 		ftm0: ftm0@2800000 {
-			compatible = "fsl,ftm-alarm";
-			reg = <0x0 0x2800000 0x0 0x10000>;
+			compatible = "fsl,ls208xa-ftm";
+			reg = <0x0 0x2800000 0x0 0x10000>,
+			      <0x0 0x1e34050 0x0 0x4>;
 			interrupts = <0 44 4>;
+			reg-names = "ftm", "FlexTimer1";
 		};
 	};
 
-- 
1.7.1
