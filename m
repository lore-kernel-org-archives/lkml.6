Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeEOKK7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:10:59 -0400
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:1376
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752162AbeEOKK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:10:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 18:10:08 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: berlin4ct-*.dts: use
 SPDX-License-Identifier
Message-ID: <20180515181008.0ccf13ab@xhacker.debian>
In-Reply-To: <20180515180826.2ab39f0c@xhacker.debian>
References: <20180515180826.2ab39f0c@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:404::33)
 To MWHPR03MB2639.namprd03.prod.outlook.com (2603:10b6:300:46::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2639;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;3:bVAi5YTy05up3NcGTycvKpelzAqQh/ADHVRgbhbfqgXo3Vjh4oNTMe32Ca2b4GhPtNbM3Hc+gEvOi/6OFzXmTCu6nOaJvnSY/H2LKC+MUtPDCEx9ombwcfqJvclI4mKiXUo0CqNUso4B8gvu2Hq+fEda0Kri03xGQyVpRWqshIbCjM78qcoPCkJc1zgoG8xeiroBoq8A6X8ytciSZh1WQIssFULcAxNJkEVN5fvA0MpHmi7Rqmcx6yCZlcl0HUsS;25:VoAFIae7HDJ0Wlkhsmat5SgPAAHSZaBHogp5+is78TeBZSOl6pUkPuRFLA31y1Pg0HglByqXll9uElkHwMtezLZ4N4+0rlk5/HnfMAd878ikHI6FCUby03o7EFut4HdVJmWOa3+M8b9Lw7198tlGboJC29wSYFA73cJlZRmNkccAAJhF68xH1V/z9abfm4i3DhmmfSJg5crMT7FKMzFQsokLm1X2vSAd1JajpOMMz9lpbKAVTNc2UP+gVGjIh+cDiyKHFchloCrShOb2KCnS7z1MTGb6ss7jOSSyDkx43PHsYjobPZsUgvo6UWkGm1/htGJhbcwedXsP8YJp3MaDFQ==;31:oUCETWn/yya2w6X7f/TbXiFqDTTfdnG1gzmYASmR4uJVrLGnecnPiUh/lWojDqWe5FYlB+miXTnUkulkoA46TK2jqF9q9mIeqS/SOQe1ClvRNPZjpoAQn1WkE8a0lHm+YGWmFlo47djiB4Df/5W2rljLc1YxyzZcpmNcjxko87oDQJfCPim/DZ8JM1T40oy3hT4JOEZhZfoQ+1sk/VCoAlt9cty6awnip+cC9gcrI24=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2639:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;20:YyAYNdIKYvdNCVkYXiDZuxNLesDLNTxiTJAsm4ynLd++DK2q1/edO6042utoVJfRDTZtsc7E+AMlCO81+UVNpNGXxk0rz5//NT4PMbwR5QAqxK8DqxdgZWXI32oBh8mMIuyKFCIvP9jTHCAKOUyaD9lMOvpGUFX5MVM3xMgiUUmifHoyrV48dTsSpeCnLMjOqpdzrDFbFpkPcL+5F/4TOCdQX6TzcrqjQaLuwyVo5uEQzPPPHUvCq6jTfWMiVnbdpCfAeb7ndFF72fJsH8uka+MtSZGFRBOSZCXlfu6KrxZCWKUwTL7d3s4qRcbTM2eM1j+dDGiWLGssP54pHlkNcTWM/V/A3NxFzIK62pQSPN3p4j8wY7o/95ggmPPsQ5rYFjtYLcBnwlDOs8eVT4Rur6ppWMDMdOS+zzkmqfHV75qN8P1q6u8FKuQ201mVZkS8KmsLNyG/Bv/tuWG4CuF42uzSt5MjzNGVhY5dPHzrzm9WpV4crVRNfU1UAVJlX0dp;4:xLUqe5mSzk1SiuO9O/ZCrBX7hn4bU3cZFdhrdxYtlDfbExX1vsYAofejGBeyavqWTpMsm80dZIefePOqQlHmGyUyPsiuK2bqNyQJK9xDyHQQSNRIn1Ke85GUL7klcI9NsoKyUk2mDA22BPb0v+85IiaI0XlvNf9Xe4CgPoKsES9KG4fU+V0NllrdWz65MXX8gkPHB6P/CfRM3GRuilohs1GB7yTruNoRwsYnFnkUTsexRVSobAaEG5bTBXvivtpWFEk9CJ1AVEJFBjKBwCCEqw==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2639ECD015B66987F0894EDFED930@MWHPR03MB2639.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR03MB2639;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2639;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(7736002)(305945005)(6306002)(53936002)(2906002)(5660300001)(1076002)(55016002)(9686003)(3846002)(23726003)(6116002)(16526019)(230700001)(6666003)(186003)(7696005)(52116002)(50466002)(97736004)(81156014)(81166006)(106356001)(105586002)(8676002)(26005)(50226002)(33896004)(476003)(110136005)(316002)(68736007)(25786009)(76176011)(4326008)(66066001)(39060400002)(956004)(86362001)(478600001)(486006)(446003)(11346002)(966005)(59450400001)(47776003)(72206003)(8936002)(6506007)(386003)(2004002)(32563001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2639;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2639;23:97ApEMaUdMU09eBA7nCsE5d4zo2ThK3BHqf5x4cYD?=
 =?us-ascii?Q?1OkRrOW68KUmDqCK7nZVN9ZNww4XKpQMZ+TOecv8fLN2jMHT8xkyibop1eMI?=
 =?us-ascii?Q?f4wg9eoN3lY/iPqU//vtyVzp+fWIqOtPFnrrbW/cUJ+WC8NRztCdG9iAxKP4?=
 =?us-ascii?Q?766EopyPDWgXCEhcMPDy9+yjwXXGC1wUi8FYYSmqeGPXoeJtXUtNP42KKlgj?=
 =?us-ascii?Q?BS12Stkgbz4A2h08nvLqauJ8nNh4hp2GSxC/VkKq2YOiIP+NH7Dl4J8Qybwo?=
 =?us-ascii?Q?vH5oQ8F/+cSCt4kbxeHxeMYP40th04oqTpv/EbrXXprapkjIqct4wI3KsaQe?=
 =?us-ascii?Q?SYsrNG9sdHUNTpmSUUrXfucDWuKyAZWOlR4cYc3ljOd6bNcl9CefaEbPh89o?=
 =?us-ascii?Q?CQNd+nTOdtF+uh5PJlYMxGTwIhlHaMvx6EuC6jqK2ANfO8gtO86MGhpSBtcW?=
 =?us-ascii?Q?/xD8i4q2Gex+mPKW9YJ2DlLN0gEAIdDpLef0y/LpxYceVL7dXhC4KYB2hBPY?=
 =?us-ascii?Q?Lyt9ulPHH11j9Bh70gIujHjaV3ue44WQNnMTVOzpdhti7EWxxIjEYkh1vQAK?=
 =?us-ascii?Q?HpCmOUEeSe6WMiT5xJch3YgwtefAGC3/f+rmKlN+9/ltZPv6bQp7r0hvldj2?=
 =?us-ascii?Q?aJ8GMfBGpWoPqJWOmv5B5BMlEZme7U5eUHuDAwg/ulVhv/fhYF65QJQHDzr4?=
 =?us-ascii?Q?2MnXeSYGKexXiMVsGo5ezKEjQJy+9itFcZfITBx46gD4UZ6thocbC6KiKcmc?=
 =?us-ascii?Q?32RSy0feweqB+Wk55KYj1p8i0VUBPAsVSaRKa1HVxFooJaZ0tQ6UY+5L6P2K?=
 =?us-ascii?Q?kMDHSKQsQ8ykkDkf0JAksH74ZZhA4qreolJG+J3dnj/x1A4ZVhxlKLHzZDtW?=
 =?us-ascii?Q?QRjOJDgMqBtUC+gf0MxyLyRj8ZekT9xwACjaq6RuBK2CQBkN3kwaGsC65O95?=
 =?us-ascii?Q?bf5NIxIdt1LSakac2gu9UrCP3dwoE8gY/p25OewxogM8vPdTaQPbG4cUbgOY?=
 =?us-ascii?Q?1R+zHTsstmJonlzIRGBW326xovDkdC+/llylL0Mi0izfyQ1ATSw5tXvv4miL?=
 =?us-ascii?Q?SgaALCTcGxGRudPt5UdxUDDAPYVH3U9s0fpw6gsOSkOzCxHIKxbucXLecUmf?=
 =?us-ascii?Q?NyCeTLym083eGB0SEEScESH6xnIgUZNr6aIMtqUVbGyxHoFc3I/N3EkRUTB/?=
 =?us-ascii?Q?W9OGRhdWyr9FjLf+zso0rhZu36NEbJs3KY+biS094az137vwMno8HqqNSCwj?=
 =?us-ascii?Q?zfnQ1sbmrayqhCiTNCePg3KoX1L1W9/EDVgmvEvfRsXRH+B0s4rYeR0BPbep?=
 =?us-ascii?Q?yGYyKDLoo4CoeqUCwDQYAGVEAiVk3xwvUuv195+28URD7BH0iY7UOig90j0X?=
 =?us-ascii?Q?BDuUw=3D=3D?=
X-Microsoft-Antispam-Message-Info: JKsnGsbfJlA0t8wYbv7rMxuUWjobZvToWp6+BuFJw+JdJmj0BkQSSJXjsh2J5+1+zSma6j1xHkAU6viGRHEe9ZjvbPkf1y5S8+HNhxXH+57mZbTg31Iz918kWOWzVsXJUe2vUcgU4CXu/EkYc84Fqd15H3vOW1zMrwViIPDFu1BA2OpeQav9dZwrAPsPgPeo
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;6:7oKZkcPrRmfWqWNd4wKlNHh9DGZB07bXzFHBXaceQrixeV+m7nXSt+o6ulL5Nqo7dEzHxRNTFVVw5jSy/jvpfb2BvDS2cJczO1yTt0VhCgkn2U8CmfiraPPF8hIbIPz+l4XPmSIWWZSXHJZ8PTeZ63A4iJBsVA0/O/vuApm+wph94kmSFhlGOO6qGdiaMyiY2TI7LUINaDskZAcdqjL5CRa+GQY5W/I50sDDocHtwGNcjtbyMOaLt0ve3gxmkrMYXhs/cYOkqgOW1lP3VGh9UIbsG2/rZqefCAems1g/9FSxnDITf4JJgY7fROFf0yYu9EVfOv3D4VWFoB4otANck+zpW7MftKKESEwIBklYNYP1oAhkdMgPPdrdmJ4TeLyEuSJ27vyU6NpAnYNoXwTKZg+W63UPXbCq4OuduAoXhcqa7Xc8Db3GvsMnbJHpi3RM6rd5mTiqsza4Q41jj46xwQ==;5:IgGg398xxNCkbz6ii72DmJx4Uk5i3Dve5phudr4qls2aSiBQ9ooiibPkQ9f7SEhNmT37xRWuWdynV63OlgQfhty2XBOluYh92+CZQ+dOYKztOWu3GR+/njruyyuYEg6Rmk7TgbLCAQC1CF2bUDuSuQVl43LVR14ee0zAjt03IxA=;24:NR6KKC0hYNGudUvlwWVv6HfQJfIjoqqp8ucRqAoeDz4+9oBKDcUp1jrq0YtTdLS341jCnaTbq5ajUizBoewFPEplcS2+I4LxYGiSHY8iA6o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;7:tZAE7qw1ZR0ew2Z8Ho5GVAtFiCBnOy97ArQX8rdV1msMIO6s3smYZr9iJgr8AOjN2sl0jq9PcxBU1yvaIA2Qc2YCmVQi+mSnH2+5fuDLfVa3zJzZv6OqbqoqSnVMCn6ZlJTT2oUMcyktyhaHOiz4VL/RlJ9642GRH/DBXxq14hHuxhrBu26bSn03f2vW6+Q+ZYXhAxzeyIWVlOHeYFgDNKwEmAMfmswfpdVBnO4w0KYl4RnLR9iSc4HJPN4SXb8q
X-MS-Office365-Filtering-Correlation-Id: 5ae80c01-b199-4d51-5109-08d5ba4c254d
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:10:53.0304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae80c01-b199-4d51-5109-08d5ba4c254d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2639
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the recent trend for the license description, and also fix the
wrongly stated X11 to MIT.

As already pointed on the DT ML, the X11 license text [1] is explicitly
for the X Consortium and has a couple of extra clauses. The MIT
license text [2] is actually what the current DT files claim.

[1] https://spdx.org/licenses/X11.html
[2] https://spdx.org/licenses/MIT.html

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts | 39 +------------------
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 39 +------------------
 2 files changed, 2 insertions(+), 76 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
index fae6c6924705..c64a179ebbb7 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
+++ b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
@@ -1,45 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2015 Marvell Technology Group Ltd.
  *
  * Author: Jisheng Zhang <jszhang@marvell.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPLv2 or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
index d47edad13e68..277dccfa05cb 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
+++ b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
@@ -1,45 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2015 Marvell Technology Group Ltd.
  *
  * Author: Jisheng Zhang <jszhang@marvell.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPLv2 or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
-- 
2.17.0
