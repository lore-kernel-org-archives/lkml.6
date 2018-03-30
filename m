Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeC3DCg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 23:02:36 -0400
Received: from mail-sn1nam02on0069.outbound.protection.outlook.com ([104.47.36.69]:23588
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751164AbeC3DCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 23:02:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 30 Mar 2018 11:02:11 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: ARM Maintainers <arm@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] MAINTAINERS: update entry for ARM/berlin
Message-ID: <20180330110211.36455347@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR03CA0021.apcprd03.prod.outlook.com (52.133.186.33) To
 BN6PR03MB2628.namprd03.prod.outlook.com (10.173.143.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f8246db-2256-4651-f266-08d595eaae2e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2628;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;3:jYCIj+NWOVhHvXNsEoFWGF/bD6H+RXOsGIWeB9CjVMnd+hs65MeQp8ocdTERxwIZ7xL8NyGdGkjQCLdSzymVr6q7o4OshYoeI6LP0CJvdmNSt/EVmEF83AsYPtqOrzrtDHrzd7ipd8NjPj8oi5V5WyY/S6HlmKlrhuiI/1Pp5W29IeWaEC3c9kT9E1xuFswZcsvH4or7H9whJYO3zXrVvEay1wHsfvq4z8R68yn/1HXcgvMutauWx2iTIowLMPTJ;25:mo1VhuM2OXDP0lnE7d+HBrxEardLpzpY+ezE2IX+U3cwMhldOezQVENPGvqSn4jX6PhTg7+IHN3sPdM8/UaM+WPU2ePuYPRIQyg0wD3LMH2PnjHySyHFunxchy5indPaw8WVPhE0I957kaHmWzjNerrg6EdBfkODog+uEHhucqRCkGeaVVBYJVq4xUTgRnNmXR82ZVgF7ifUQVgaiZDImEKjIPXZi7P4JMg5CWyLRCbWnP4UI5SKIp686T+pCrymH2mZ/RqfHRQ6g8OTwbQeB7l3JJYUihs0PJV9EvJ8CGRWy6oV7f0Tsj7W5pyXgIjoKCEfAzjHcFqyBUSZtsCjSA==;31:lZaDBmTJ+BK4nU3Dc+Lu85oGrGpTkuzhNWfCPIFw6UPhUjDanWSBzkWPANUwzO/3m+UZiVR2Y7Lu1e8Hj5+uzI6Mm5AgS8DtZXRgzMNNHWrL26ZPH9K3utw179gPyj9ftoEyH0kpndbRDJ9at62r2Joq/Xs17bGhrIXE5XvSuB/3w5AgiCJWQlp5eemXPun31urt+/25iMKcViH3wTTzOyJJIBiVM6EgSLjePmmmRH0=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2628:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;20:d7f95UCtdknh1Pi74sdwwcdYIMVfi3EOp/GxWwYQmw4DUx1MZQAUvdDiEmhcAqK3YeyJLlLjt+Mwl7tUcqb/POHNmra5CQ6UNyaiMCMmiuvZT2mHPIaP+4CtuKOHrX6eHLSaWl3bSDEhq3VcjRgD/wa21V7KV4AayAwM5XE+PwM7ZVkGZevMW1nBw3IA7t7kboO+HTlG5coVpfIniW/oRaPZi7I3XZL5qAFJ1uHbaMADUPyJl5S3qLFOx+dVU96blef3qyci5M+VuecEcXvY9Xfw2wxs38jgQ21p/O46yb8p/kuWkabv3Llf/YfxL05Wm0HV+hDB0Ksh6l07OutWOIwlctqBEDFkXpUCizXz4MNADqM3J8hOz2kZIGLCCfBLcvc8aWHZyPO3tsAPIdNd05Ufn7K402HUtk9qLoYHI+jcJ8Uu5cWhIacrmxgRrTtzpGs2c+hqb7SHlhiahxXq1HG0pzOps9uEwq1ElvaOXZYOlt4DJGIpP9rt9nZZZJD8;4:GIdpoUe3/FGqmBrjCbi+MTPx9RfORLcGw/iOORjxEWvZT77bGPinwO2hRU1Q/FmbcvtBBF2wvQH26V9viDpVQSiX2Axam2QVK/n8DbHXqptBvSj45ULkOi7VKb7VoycDF0vt5Y8E1b3dYfVaGIBpKcMVfWyKPPEovRnsoG6nFWfPOWmAYNBEJZH+6ETKi0KcVBE/ULPhG78Khy3DSIEZRzCbBr94zLw3g6WHL7lICu1fYLpQggpaJmL5x8BFULPb3UPoK3jKwcg+aYhUEgdZ/yWoSpYjwODu6kMpHeYO4wNbPhcasEmBpqGV1Ry/XronlfPzOOARHAi2hfDmfoFb9tlJCYM52ikhezf5+77p32uRB9d1OzFQiNeu+h6tdtUw
X-Microsoft-Antispam-PRVS: <BN6PR03MB2628D946BC2A9282EBB8E5ADEDA10@BN6PR03MB2628.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(85827821059158)(258649278758335);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2628;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2628;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(111735001)(199004)(189003)(68736007)(52116002)(110136005)(6116002)(23726003)(386003)(1076002)(478600001)(8676002)(6666003)(15650500001)(2906002)(26005)(70486001)(50466002)(47776003)(97876018)(966005)(72206003)(105586002)(66066001)(1970100002)(8936002)(7736002)(3846002)(7696005)(55016002)(25786009)(575784001)(476003)(316002)(5660300001)(53936002)(106356001)(8266002)(230700001)(86362001)(486005)(81166006)(117636001)(9686003)(81156014)(486005)(97736004)(50226002)(6506007)(305945005)(956004)(4326008)(33896004)(6306002)(186003)(16526019)(39210200001)(15866825006)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2628;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2628;23:+o4YjVfyYKAt32xTfS0B8DIiiIblpRLT3Ofvu5OXv?=
 =?us-ascii?Q?pvUVZ9I8tgxjkWftO8pUA4k4SUC1pGxYDpF+R+OSRNQ1QXZ9FNKkirD+OC4X?=
 =?us-ascii?Q?fH9kMo8c47VzGcsGMcgyssXgGtkCspqwSwLefkgRn+lp9Zummr4BvBOL2Wcc?=
 =?us-ascii?Q?XghXZbiZugdaVXVzJibCLlA0lmYCf2DPcwl7FUaJB7lMxQspQb6/EGeF55Yv?=
 =?us-ascii?Q?nJFYGrMuU2fAa4sGmcv28WFigaCWCwrttB3n+neygfpQPp3euFmFBTPeCb/E?=
 =?us-ascii?Q?X+/McjMdbAgpIEOKjNCQFs5Kpx3D+dBurkybpnWBgv00KLridE5Q6CbVA0o0?=
 =?us-ascii?Q?iDX7RJu9sxBLFEu9nrn4qF61t1xdcmZF4ytWyJPvKzWc/jjZOOufcnXUa7Of?=
 =?us-ascii?Q?q131pz+9p3BAWE5tcpHB88ytmm01L2IHwwlB69uQNBWVZdh2Jt3jbpvYB13M?=
 =?us-ascii?Q?AgIydDyA0ZJ2N3//O3SHbJ4p42lxcP+jqP1sBxw641henU2KpVkv99ni8nN8?=
 =?us-ascii?Q?QzT9S0R9Ff6YAAVbgsRukG3HzGBXGgeIHKCqUvXiqBFyQa/UBWB5BzPwzKMc?=
 =?us-ascii?Q?Lf7mrtd60YeKdVRCXwOXKiT29lUzgRyh9JHsqtMrARBYOXbmxF+eemIjys9m?=
 =?us-ascii?Q?qjAbSNI6Q2sg7zERdHps9qOBmlOk78pGWYr/QQtwAIbnHIZz//w8Y2VI77zq?=
 =?us-ascii?Q?7qQXFEx9qbi+CDtJaNrH1/ZYd5gssRvWpHA8HUvKa53WGMXit1B8ygNwQ+gm?=
 =?us-ascii?Q?/trEFIXd7gWuANgjwDv48h9s2aTAWqczp19xPfqfIyq06LBLHSdwq/Cm1Sgn?=
 =?us-ascii?Q?t3uTPOF5PTjwA1reFU3knjb4Ee6VrbqmldFa3RglVfdCZYyXBeZi7D2uyuDd?=
 =?us-ascii?Q?26BQTl8bZdgcZAUvqNXy1NhQ3Rqs/yD6BFa13ebxCgwb1tN7F3Rk2yiqMrbe?=
 =?us-ascii?Q?IxNgtmrFUpL9ADsljpOrQaFPkNNTyBwWqdu0fpAfC3qvhkd+64Nr9y/Dk31n?=
 =?us-ascii?Q?qxbQZwfh+8Bb2DCnUIPjXRfOR+4aIS5MSQa8irqr4PHYB61l4ONbcAJIjOZV?=
 =?us-ascii?Q?qwhGC9OXU6kJi+e3ouy7erRqh7fO/Djod1efsuX+YEYEXhMP3NP90SSaeC1X?=
 =?us-ascii?Q?ic9L/WLwqw06y9HZ0Ujb6/+rAvkTsKjbcoZqHOci63A/X4Sllyy35hCU1Ke6?=
 =?us-ascii?Q?obp5949jr6teBlBj+m8Ic0pTF7WcVLlhsV3BKKV/GYnvyamBxjdS0kKbVwUC?=
 =?us-ascii?Q?JejlEs1NMpLDdr81l4XHjX3kp/QHOBlpchfq0kGXi0UWI5oUMsTMSevDoq11?=
 =?us-ascii?Q?dNCLpGa3FeFPEWglmU9//Vn9vGREuPRLGBGxr7hUOHLSqPxbrEAVqMx3RvnG?=
 =?us-ascii?Q?vKJ95Z0yEKOHvq11hxm7RAUwWmzLUl/sgO6oEKwuB0emL3etN8TCsaeAA+/X?=
 =?us-ascii?Q?nNS6jdann/BziBoJmistsONzCL/1k6BGFMzJ1APXAv4gm6lPwo1?=
X-Microsoft-Antispam-Message-Info: raluQDz7DgN0OmyhWnsyn+MaZpOhPCSjs+646GKHBj7Ue7TVccsHZxVf7WGojJ9E2tYzXljx8OozlBl1l0wBDi+oGoXmlsB5INma93gl09vE70X+LiwIFPFlDdtm0nMIxJMUt9NDuZz0p//lPUR/B848fotx67YIGq+k/okWymlp6BsDcAie1eDJWqfCAsO4
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;6:KvTJpZxb0IwZKD1hGC56EJwBRMRrM9pvRGeGOwHgqNUNhmDHLN1WM5vjaIO+9hsZ5HG1/uVA+nIDRGgcx00iSmDwJGYLOzdhhqxBg31/B3Hk1JN6l+9sv8NXdPoQJnW1e5+5mxT7jEgMA+HCSgQdz8DCEXlqf3LaLybt5cSIEHOgFNL168MULx/v0kaxlU0tWNHavELGxrEUzkXW6NgWGF6IpYTdLotLKMEr+7nnL3E/qfE2HV13iTxr5La+qFPCP3GxyBqO6b7RDyTngfSJ2cDQ0wb8b0bk9z5YTPWH0GL7OIorZfh8hxYVrPC6oVQnm6exmMlF5B1jDXo8wCs9ZjmclLI7K7NieQIDXqCbP4uPA9WjnFlYUQqRskohD9rA5UrcqhF/0MRPHTHWTaut/bbbssUqWRkf6DznhFVmOhBeE5b62QL8bZvA2XPa4ORQejBKrdHup+ko5lp7+u+NiA==;5:eCVvpXoenOqsxTb51ZIUwDYuapQoZ5SdKeAKxB09tqz3dO/lpSzzQxwFMbTTJvEoRHk3suwNyGuIHQbTj+av/eiO4N52mQUo5KogpARKWcaH2I/9YMqHBHGBGqOHhEd0Ojx8hFRB8C8pyZQI5VlO5ycbLXOCZnjtpYtlxsmPYaM=;24:Fc937WFMlwN6N6ETg8fJnYbzjtApi0Yzm92ZPmLe5nfYTcTF0qMQeZSvuiLNiwLTGM1JibzcjWVvGPLbU8cdgrDaSTsTC8UY2AbJ5wny6kg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;7:py4gxGJRr2I6EVyaSoMNuZGKqj1AgC2IEOzjpgkANnlKH2GRxEikUGvXcyNt6bzGeTYuDJl0yDUqUbLDk9kfz2WuijldGwyzkiCZTl+J74B6pFWo0dNc96MWvtBqco7Qxi2euprndu7ITZmQ3ZifqRPQeKbhlUSqcWAsUSJi3xBw6chuJUVOjh2clubm6HstUqzs6YJnORQwy6vL8v+3WUxQt3KtPM/lgFs5Q0g8vuK+ynxvSniQj7hy3pz6gQy4
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 03:02:30.5999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8246db-2256-4651-f266-08d595eaae2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2628
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synaptics has acquired the Multimedia Solutions Business of Marvell[1].
So change the berlin entry name and move it to its alphabetical
location. We move to ARM/Synaptics instead of ARM/Marvell.

This patch also updates my email address from marvell to synaptics.

[1] https://www.synaptics.com/company/news/conexant-marvell

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1:
 - add some comments about this change. Thank Andrew.

 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e950b8b4a41..0a0da6a8e607 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1578,15 +1578,6 @@ ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
-ARM/Marvell Berlin SoC support
-M:	Jisheng Zhang <jszhang@marvell.com>
-M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-berlin/
-F:	arch/arm/boot/dts/berlin*
-F:	arch/arm64/boot/dts/marvell/berlin*
-
 ARM/Marvell Dove/MV78xx0/Orion SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
@@ -2006,6 +1997,15 @@ F:	arch/arm/boot/dts/stm32*
 F:	arch/arm/mach-stm32/
 F:	drivers/clocksource/armv7m_systick.c
 
+ARM/Synaptics Berlin SoC support
+M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
+M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-berlin/
+F:	arch/arm/boot/dts/berlin*
+F:	arch/arm64/boot/dts/marvell/berlin*
+
 ARM/TANGO ARCHITECTURE
 M:	Marc Gonzalez <marc.w.gonzalez@free.fr>
 M:	Mans Rullgard <mans@mansr.com>
-- 
2.16.3
