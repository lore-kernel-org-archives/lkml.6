Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeCPHUe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:20:34 -0400
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:36992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753186AbeCPHSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:18:02 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 27/28] documentation: Remove Blackfin documentation
Date: Fri, 16 Mar 2018 15:08:25 +0800
Message-ID: <1521184106-24475-25-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(39860400002)(376002)(2980300002)(438002)(50944005)(377424004)(199004)(189003)(6306002)(19625735003)(347745004)(246002)(47776003)(107886003)(16799955002)(316002)(15188155005)(59450400001)(106002)(53946003)(336012)(5660300001)(36756003)(8936002)(72206003)(305945005)(186003)(426003)(76176011)(50226002)(106466001)(560934005)(7696005)(51416003)(48376002)(478600001)(16586007)(2906002)(8676002)(26005)(356003)(6916009)(7636002)(4326008)(50466002)(86362001)(575784001)(6666003)(2950100002)(966005)(2351001)(77096007)(19627235001)(19623215001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3274;H:nwd2mta1.analog.com;FPR:;SPF:Pass;PTR:nwd2mail10.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC008;1:N9P3s0pm9zjPt31xOMexqVBWy1arsNm5wilkCQdsyb0UCPN9FxJFYqfy+sP84E6MHC9lSJ9JKSyTNKjqk9F9secKyQ4qr4xAHi/ySM4TO0EzKXxGlh9OgKdZyj+2gnuU
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36fb63c2-079b-4eb5-696e-08d58b0e0bfe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR03MB3274;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3274;3:wxgcm6XSZH0pTycmQTlNyPpeZYG1qWkZ7ccoMmEEOZS3dA94ylheAUu+atq9uA9COyy3JRoinVO726IAwu5FEnhz3aFzAwAZyPO4qK+JIa10yR7HM4hQSdp9FyueU++xDWCc2hrpJay/guuh82CdXTHIOS7U/JyhGDY/xet4vWCcq26E0yHClDDzr1X1nFETuhfhZVgHaQEAG7VXHRKR+j0sCsZd2X9lLhMJFb47h8A2plyMj3GA4WzaMDD+rYKaMgNFC4qTCOZORTtHWE7KAky61KxP2JJmjkWjohUpeGFmNDYObVrTay0jqwNZTTyGegXzrs6oJiLinW2UAKpEew==;25:e0cUKUzU+57HW27po1VXBhyybUBp7u5sLNbfJV6I5R5Wbr7i13oKES8y5ZL2IVDCG68JFazJleHHrmLUezcJ9xU9IK8UhhoIL2EWr2GpTlmI1yAxVTqjUQ2OfGpyascmhXYZ2YTyF9rw+yhFRnI/isuqmXwPzyPR/CgwfDtf1C/bJbxjHd5Ua8HFMxEvsDv0ae60n8qJuHXmwE/nJveQl/trQFhqWxe/CoM8r43cIqkl0ITeCcZV0jbfuEQqrXK+AdqyimN4PTvkiFRu0n6sgqDKzFS48ZHK385eaCMnPmqaEXTw5hdt1x8BzO9ngKV85aQtuxEZ1jDvOleG0m2qLg==;31:LWkb+koKW+OgKDmyJ4Hxtg9kH9RuEaTENPg5BTergq52zbZd5K2SYXteg/YOQJtWbl0Dik0PrnADVN4Ta1fXFqaQ6uBtVsgvkGtHbc/s7zHB/xYHjQG8p5YtgKUA+aRkPFGNTiJ7wVRnFVGbide6/b0697Fw596ehQZlz0Xjl/ETnVyGnKAmfoXNrD6DevVo9EzA6v5k5pHSxcch2WrvBtIFIL1EmNI1nmwtWRWGqBU=
X-MS-TrafficTypeDiagnostic: DM5PR03MB3274:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3274;20:alLbm97W58VkMIkUsrXhDZPUkEGtrqYUw+V7GH3QVDIUTob4HHjOKCZdoNKoqzGemi/hcF85QMJzfGt+H1g0OkpTAyn4hygID0ymRamGRYnkVczsxJv1WBT79jR1HZ1I8glIPQF4CsX6E4h05LGCCgvky38rhDIvjZVam2zFXJBJJnOw2qjARtjr60fgmDPoJJonQJ8yrl4m/VLjS+HDIYKDZUtvC+/8bgbNFrQii5rAtrcpjqeuiYMzjrXLPHdO83GFj9+Z13E4JUKOVUqhIQDHGMWF4oZvJUsLBytIcKswwlM5GZqQLMaVHZCFSdMBg/K4ItZ/T50dB/1Wjpz/6xIflf5dZdWaIKOuNW0/qmrhtlSRs1jb+37mnBvJCIefdiqVvK7G84emkIcbsVMCVTLcCdy+Y0lFtdTmVRqxpJV9LMwvPn0pQRtslrFLsV8Vuuea0pmtPUJxFoOMWhl2gxM4AmIoBJgpnjGfqh506i755Hrfi7k9MAvQOKJskbU8;4:fTN85p3KPVElGBJdYABesE1WcTws0hVYWwIfSxTAwP5dyKhFSpn85yBboWggzsBnBSv4G0cgw1SiutIwsVco5qVGW690RAy8xPaW96Fd441U3K8ZG9fTKaOpw+cN/U9nKtLGl9l6mgk8dKk+BKoBmHp99fyjPkLU79gQIB1a5+GgsZ0TDVz7j/n3FYfYPr8i/1k/GtrKuP3BUmu0Oiu10zJBz6LLPw5a6r/Aqm5F7xKlCfVvzgR5rT8Azcm5fpEbubViuqEht9cunE2IVMcvuqCe7wNxnZbbp38UDYusid7iGTI68pe5n6jBqrDKO29/xGKzjFBiXnpZric8NKB63LQefbtPa6px95M2DzR+BAgMtmcicIZvMgmpia1RijNdXc1LUh60zhCsiCm+SxepIzlLxkyUvS8M8A/DASIFHaU=
X-Microsoft-Antispam-PRVS: <DM5PR03MB3274094C912B055E69B3337CE0D70@DM5PR03MB3274.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226)(240166546044246)(232431446821674)(108721460000369);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB3274;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3274;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3274;23:3ON+4Cp1kkk0G2ZGdGXD9qn2V+LlxFgU6LnWLb0KJ?=
 =?us-ascii?Q?nUf31Vg770a9QziW+a3DO46RQZuVmfiPJfUpxq05sUhgQvhYjKQa3kZUTeOb?=
 =?us-ascii?Q?sYkL3OvfMsEYGQut9j048XJQzfcqOFMbTO1xsShAG5px8EqFpIAMJ7ykExTP?=
 =?us-ascii?Q?Z0epQJtjYxKLu9w2GyWLI3dq4IoKKP3x/cWc+ElncwUtElOHT67YDn8e96RK?=
 =?us-ascii?Q?7yMj79bXRBD8T93sCNB6rekddEO/1vioqkN6RUc7ipBYaJfsiEUHw2DAkM70?=
 =?us-ascii?Q?JEwEGwbQRXmj8OSizX6NG2s90IaXA1+7S6dWdHmdROXuhQ6dR2EWvHQ2UZZl?=
 =?us-ascii?Q?g1whHcwZ6WNb4yyYV5DtiwIFz/YDac+EN0yUxIjtenLFvRIc6rhjz9h/DxAs?=
 =?us-ascii?Q?Kdv7M/rae6DVmGA3t9wWm9y4HurLzUBu2+d3NRPv7aqDiig2ajN0DDCz9J+h?=
 =?us-ascii?Q?cZchpWooalWJrLUPjQ6g8dG8zZzZclGmprgmMpIA2PeChTMP83xtq6qU8Ivc?=
 =?us-ascii?Q?EKSn3gsUOXSrHrafAQW/0DAn/FcaIMKT40P6rhXGFhQ8Qxi+/5ChhgI7pkGt?=
 =?us-ascii?Q?ZO5olVlXWeGj5k0Kw0w5JFncXzoXZET58vb2zxue4Pr/MiAdfWEsRfGLFcuL?=
 =?us-ascii?Q?hTeVuDrAzfs0X5lObSZaVBxHOOsLgM3yCvATFGDtfS6y8Sv9VAlnSy/mNNKI?=
 =?us-ascii?Q?6kY+lbl7xPzCJIZT/nf0DHlQ+YYf6RwW88k5ixjWtbYCAOOstOHg0oFZTcbP?=
 =?us-ascii?Q?wlLWHiqH253DTopybvEg3nuE410wz5lwPfZIyQUpDmWB/gP/Dh7XYus7a5qr?=
 =?us-ascii?Q?vMkD5lrZ7GdSAJbtKKu36ZHB/JRXDDqpCE/ULEM8xjTUSFD76Djt6P9ylJUo?=
 =?us-ascii?Q?6LJjKjGEIJk/1QVnGBURAkAELWGk3RlDUg1tPbGPib20Czs1mqnS4zGy2qjw?=
 =?us-ascii?Q?EaeleY60vLJkG8Z1cBQB12RrosGzBU9MWRKN8F+Hb8EMD4+yrKSZtusaA3nP?=
 =?us-ascii?Q?9VjARIrZ/xW1PYOXid/snOgOxiTRL/2se+YNWBhRBkCuK1lDJjVyJahCNmfm?=
 =?us-ascii?Q?wJtFzQVLS7WPA2lDfvsl3s081XHFvVAzcMZ8C0dHkkY/dImJh3q2WjMhKNwl?=
 =?us-ascii?Q?Au1gf8KjKHx6ei///C9HQCyECihgT2nJPjXIW9C4M6/MSgbkN4lpy5QGRYaN?=
 =?us-ascii?Q?w2enJWlguZU++FAPgGNBmEd9Q6N0z+RKizLl4jGyPNmCqBTLt+OPLEN844dU?=
 =?us-ascii?Q?1ca5TAQmYauQUo8GvjnaZ9TWRQoxDIbOnatp0cB8DwfocnSpbW+8tTGNilev?=
 =?us-ascii?Q?1I5UUF46zTUyB6J4YALptI=3D?=
X-Microsoft-Antispam-Message-Info: 78FgpshNHzuqrrP5LdT1gGlPeaRiVVPLgTPg9O8EYS7WE+Xcm3OJNbuiOohBny2FgkiCqZmrw8yPUvCwMVOBeGoVERQtxU9WewPfjpFj6wBDPbCDtNF552nqkyf5qGol7H9VRDB2aCnU5GHntSAVj0ofKYN5z4O1r/2Rn/Wxmccc/w3tiv6cp+uyRsuaDCY+
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3274;6:/iJMMc2CXLcXtA/8cPI5J4gDBy3fcTHcFz4Wgux5IQyiVML0CiHoW9HWoSAdXfkJXYL+9s4jm1nVVAf/Gfr475qtFwgUqLahGofsbHHKpUKMRzn6G1NdBps0Mf5xSwUh+ONosF6/P4o9k4zh1FeE7TZuTbMzeEU6EpLkoMvYs2ffSA2nP9zcNrqbrzE6On7MAd8XuZ84rl98INwujx/2snZMBPhyMBTYAlwpjx4PTqj/3faSksBOIvt8+mFx6KnImr+julthzq/g7JQlh0Vl46JU8mGibDxu8vg1ptmxiqIMD2HxFf0EklE3uqytYWkpehHc2ghu6PWqvxgznivq2oj6B2xhVAgIc4G0r9EOnEM=;5:CLgemQF1GT1wBPlYwnT1lG5RNnSMyKeZ3DnURJaYPWdxM0g9jQAtCdVwS7Z4dO90cDr1uT9gGqMy7fDQjsqmo9EwAsZguyRhtDFH0NsyKIaMabv/6Ld4PrHOaQV4o7cD4jNEZk/N1g+RN3slI5/Z1WSF6z8cVzwoonJ9pispnfQ=;24:bV+5KXtQOyFJX3ENEEUP5fEFp9jKr/WDA3TJGmqxuLGnERHd7FE8JLLY/GYlFdruvEbb8wEbFen9LKRAnrbAZrmk93Mv9K4NtptLIOzIDbk=;7:L5f1OkEp8h/W7Hoy6ZrV0AvYfE/KeCvTFSlLPKDoYzTWW/rV+P2X1zDqWqBudUXp/jLAlH26siHI6ytytffUWwS1KvBW2JXUQXZRVBFNBrk5MaWHvX7DHurzgkRcRKG11zCKenbNytB9kJNQ+om1GG/7ynvCnWnu/BYZG/2jc8HAM7rVnSjpr9oJiQ98DPTWOCk6ONRv50tCobA5BSamlGnWi0iNVHobwUt2J0Go/sUHeY71TMh3YwHJ6bHTsaeo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:58.4514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fb63c2-079b-4eb5-696e-08d58b0e0bfe
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin documentation
---
 Documentation/00-INDEX                             |  2 -
 Documentation/admin-guide/kernel-parameters.rst    |  1 -
 Documentation/admin-guide/kernel-parameters.txt    |  2 +-
 Documentation/blackfin/00-INDEX                    |  6 --
 Documentation/blackfin/bfin-gpio-notes.txt         | 71 ----------------------
 Documentation/blackfin/bfin-spi-notes.txt          | 16 -----
 .../driver-api/usb/writing_musb_glue_layer.rst     |  3 -
 .../features/core/BPF-JIT/arch-support.txt         |  1 -
 .../core/generic-idle-thread/arch-support.txt      |  1 -
 .../features/core/jump-labels/arch-support.txt     |  1 -
 .../features/core/tracehook/arch-support.txt       |  1 -
 .../features/debug/KASAN/arch-support.txt          |  1 -
 .../debug/gcov-profile-all/arch-support.txt        |  1 -
 Documentation/features/debug/kgdb/arch-support.txt |  1 -
 .../debug/kprobes-on-ftrace/arch-support.txt       |  1 -
 .../features/debug/kprobes/arch-support.txt        |  1 -
 .../features/debug/kretprobes/arch-support.txt     |  1 -
 .../features/debug/optprobes/arch-support.txt      |  1 -
 .../features/debug/stackprotector/arch-support.txt |  1 -
 .../features/debug/uprobes/arch-support.txt        |  1 -
 .../debug/user-ret-profiler/arch-support.txt       |  1 -
 .../features/io/dma-api-debug/arch-support.txt     |  1 -
 .../features/io/dma-contiguous/arch-support.txt    |  1 -
 .../features/io/sg-chain/arch-support.txt          |  1 -
 .../features/lib/strncasecmp/arch-support.txt      |  1 -
 .../locking/cmpxchg-local/arch-support.txt         |  1 -
 .../features/locking/lockdep/arch-support.txt      |  1 -
 .../locking/queued-rwlocks/arch-support.txt        |  1 -
 .../locking/queued-spinlocks/arch-support.txt      |  1 -
 .../locking/rwsem-optimized/arch-support.txt       |  1 -
 .../features/perf/kprobes-event/arch-support.txt   |  1 -
 .../features/perf/perf-regs/arch-support.txt       |  1 -
 .../features/perf/perf-stackdump/arch-support.txt  |  1 -
 .../sched/membarrier-sync-core/arch-support.txt    |  1 -
 .../features/sched/numa-balancing/arch-support.txt |  1 -
 .../seccomp/seccomp-filter/arch-support.txt        |  1 -
 .../time/arch-tick-broadcast/arch-support.txt      |  1 -
 .../features/time/clockevents/arch-support.txt     |  1 -
 .../time/context-tracking/arch-support.txt         |  1 -
 .../features/time/irq-time-acct/arch-support.txt   |  1 -
 .../time/modern-timekeeping/arch-support.txt       |  1 -
 .../features/time/virt-cpuacct/arch-support.txt    |  1 -
 .../features/vm/ELF-ASLR/arch-support.txt          |  1 -
 .../features/vm/PG_uncached/arch-support.txt       |  1 -
 Documentation/features/vm/THP/arch-support.txt     |  1 -
 Documentation/features/vm/TLB/arch-support.txt     |  1 -
 .../features/vm/huge-vmap/arch-support.txt         |  1 -
 .../features/vm/ioremap_prot/arch-support.txt      |  1 -
 .../features/vm/numa-memblock/arch-support.txt     |  1 -
 .../features/vm/pte_special/arch-support.txt       |  1 -
 50 files changed, 1 insertion(+), 143 deletions(-)
 delete mode 100644 Documentation/blackfin/00-INDEX
 delete mode 100644 Documentation/blackfin/bfin-gpio-notes.txt
 delete mode 100644 Documentation/blackfin/bfin-spi-notes.txt

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 7f3a072..2956d7f 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -66,8 +66,6 @@ backlight/
 	- directory with info on controlling backlights in flat panel displays
 bcache.txt
 	- Block-layer cache on fast SSDs to improve slow (raid) I/O performance.
-blackfin/
-	- directory with documentation for the Blackfin arch.
 block/
 	- info on the Block I/O (BIO) layer.
 blockdev/
diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 7242cbd..b8d0bc0 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -89,7 +89,6 @@ parameter is applicable::
 	APM	Advanced Power Management support is enabled.
 	ARM	ARM architecture is enabled.
 	AX25	Appropriate AX.25 support is enabled.
-	BLACKFIN Blackfin architecture is enabled.
 	CLK	Common clock infrastructure is enabled.
 	CMA	Contiguous Memory Area support is enabled.
 	DRM	Direct Rendering Management support is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f..0d9b5b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1025,7 +1025,7 @@
 			address. The serial port must already be setup
 			and configured. Options are not yet supported.
 
-	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k,S390]
+	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=efi
 			earlyprintk=sclp
diff --git a/Documentation/blackfin/00-INDEX b/Documentation/blackfin/00-INDEX
deleted file mode 100644
index 265a1ef..0000000
--- a/Documentation/blackfin/00-INDEX
+++ /dev/null
@@ -1,6 +0,0 @@
-00-INDEX
-	- This file
-bfin-gpio-notes.txt
-	- Notes in developing/using bfin-gpio driver.
-bfin-spi-notes.txt
-	- Notes for using bfin spi bus driver.
diff --git a/Documentation/blackfin/bfin-gpio-notes.txt b/Documentation/blackfin/bfin-gpio-notes.txt
deleted file mode 100644
index d245f39..0000000
--- a/Documentation/blackfin/bfin-gpio-notes.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * File:         Documentation/blackfin/bfin-gpio-notes.txt
- * Based on:
- * Author:
- *
- * Created:      $Id: bfin-gpio-note.txt 2008-11-24 16:42 grafyang $
- * Description:  This file contains the notes in developing/using bfin-gpio.
- *
- *
- * Rev:
- *
- * Modified:
- *               Copyright 2004-2008 Analog Devices Inc.
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- */
-
-
-1. Blackfin GPIO introduction
-
-    There are many GPIO pins on Blackfin. Most of these pins are muxed to
-    multi-functions. They can be configured as peripheral, or just as GPIO,
-    configured to input with interrupt enabled, or output.
-
-    For detailed information, please see "arch/blackfin/kernel/bfin_gpio.c",
-    or the relevant HRM.
-
-
-2. Avoiding resource conflict
-
-    Followed function groups are used to avoiding resource conflict,
-    - Use the pin as peripheral,
-	int peripheral_request(unsigned short per, const char *label);
-	int peripheral_request_list(const unsigned short per[], const char *label);
-	void peripheral_free(unsigned short per);
-	void peripheral_free_list(const unsigned short per[]);
-    - Use the pin as GPIO,
-	int bfin_gpio_request(unsigned gpio, const char *label);
-	void bfin_gpio_free(unsigned gpio);
-    - Use the pin as GPIO interrupt,
-	int bfin_gpio_irq_request(unsigned gpio, const char *label);
-	void bfin_gpio_irq_free(unsigned gpio);
-
-    The request functions will record the function state for a certain pin,
-    the free functions will clear its function state.
-    Once a pin is requested, it can't be requested again before it is freed by
-    previous caller, otherwise kernel will dump stacks, and the request
-    function fail.
-    These functions are wrapped by other functions, most of the users need not
-    care.
-
-
-3. But there are some exceptions
-    - Kernel permit the identical GPIO be requested both as GPIO and GPIO
-    interrupt.
-    Some drivers, like gpio-keys, need this behavior. Kernel only print out
-    warning messages like,
-	bfin-gpio: GPIO 24 is already reserved by gpio-keys: BTN0, and you are
-configuring it as IRQ!
-
-        Note: Consider the case that, if there are two drivers need the
-	identical GPIO, one of them use it as GPIO, the other use it as
-	GPIO interrupt. This will really cause resource conflict. So if
-	there is any abnormal driver behavior, please check the bfin-gpio
-	warning messages.
-
-    - Kernel permit the identical GPIO be requested from the same driver twice.
-
-
-
diff --git a/Documentation/blackfin/bfin-spi-notes.txt b/Documentation/blackfin/bfin-spi-notes.txt
deleted file mode 100644
index eae6eaf..0000000
--- a/Documentation/blackfin/bfin-spi-notes.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-SPI Chip Select behavior:
-
-With the Blackfin on-chip SPI peripheral, there is some logic tied to the CPHA
-bit whether the Slave Select Line is controlled by hardware (CPHA=0) or
-controlled by software (CPHA=1). However, the Linux SPI bus driver assumes that
-the Slave Select is always under software control and being asserted during
-the entire SPI transfer. - And not just bits_per_word duration.
-
-In most cases you can utilize SPI MODE_3 instead of MODE_0 to work-around this
-behavior. If your SPI slave device in question requires SPI MODE_0 or MODE_2
-timing, you can utilize the GPIO controlled SPI Slave Select option instead.
-In this case, you should use GPIO based CS for all of your slaves and not just
-the ones using mode 0 or 2 in order to guarantee correct CS toggling behavior.
-
-You can even use the same pin whose peripheral role is a SSEL,
-but use it as a GPIO instead.
diff --git a/Documentation/driver-api/usb/writing_musb_glue_layer.rst b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
index e90e8fa..5bf7152 100644
--- a/Documentation/driver-api/usb/writing_musb_glue_layer.rst
+++ b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
@@ -718,6 +718,3 @@ http://www.maximintegrated.com/app-notes/index.mvp/id/1822
 
 Texas Instruments USB Configuration Wiki Page:
 http://processors.wiki.ti.com/index.php/Usbgeneralpage
-
-Analog Devices Blackfin MUSB Configuration:
-http://docs.blackfin.uclinux.org/doku.php?id=linux-kernel:drivers:musb
diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
index 5575d2d..740879c 100644
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ b/Documentation/features/core/BPF-JIT/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index abb5f27..eff8cc3 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index dbdaffc..7f90c27 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index dfb638c..9239b54 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: |  ok  |
     |        cris: | TODO |
     |         frv: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 3406fae..38f2b5f 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 830dbe8..d5f6330 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 0217bf6..1100345 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 1e84be3c..250248d 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 529f66e..a23d2f3 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 4335324..145f65b 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index f559f1b..6a4bb93 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 59a4c9f..38f2ed4 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 53ed42b..6f617f7 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 1494439..6b772ed0 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/io/dma-api-debug/arch-support.txt b/Documentation/features/io/dma-api-debug/arch-support.txt
index 6be9206..1c07e83b 100644
--- a/Documentation/features/io/dma-api-debug/arch-support.txt
+++ b/Documentation/features/io/dma-api-debug/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: |  ok  |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 0eb08e1..2d86648 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 514ad34..62bc1e0 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/lib/strncasecmp/arch-support.txt
index 532c6f0..d71b852 100644
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ b/Documentation/features/lib/strncasecmp/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index f3eec26..4e9f51b 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index 9756abc..4632644 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 62f4ee5..1cf417e 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 321b32f..aea2efa 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index 79bfa4d..7414867 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 00f1606..f0f6cec 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 7d516ea..6b305e6 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index f974b8d..cafa704 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 2c815a7..ccbfb24 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -33,7 +33,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 1d3c0f6..54fa603 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ..  |
     |         arm: |  ..  |
     |       arm64: |  ..  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
     |        cris: |  ..  |
     |         frv: |  ..  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index a32d5b2..dc0a901 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index caee8f6..ca3aa5c 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 1cd87f6..8535d3c 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: |  ok  |
     |        cris: |  ok  |
     |         frv: | TODO |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index e6d7c7b..cffcf08 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 15c6071..9b1ab68 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
index baee761..fe4df2f 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: |  ok  |
     |        cris: | TODO |
     |         frv: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 9129530..304b941 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index f6829af..3efb2ae 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 1a09ea9..aadc97f 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index d170e62..76cfb97 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
     |        cris: |  ..  |
     |         frv: |  ..  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index abfab40..3a6546a 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: |  ..  |
     |        cris: |  ..  |
     |         frv: |  ..  |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index f81f09b..fe1e3b2 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 0cc3e11..d42dbe0 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index 9a3fdac..bb9cd30 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ..  |
     |         arm: |  ..  |
     |       arm64: |  ..  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
     |        cris: |  ..  |
     |         frv: |  ..  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index dfaa39e..f7b7626 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
-- 
2.7.4
