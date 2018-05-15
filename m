Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeEOKJR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:09:17 -0400
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:62176
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752442AbeEOKJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:09:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 18:08:26 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: berlin4ct: use SPDX-License-Identifier
Message-ID: <20180515180826.2ab39f0c@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:404:14::23) To MWHPR03MB2639.namprd03.prod.outlook.com
 (2603:10b6:300:46::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2639;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;3:2OLUKlkOlHaylRKEqJwPecnaH0tmRrxtBXv1PqVFoVLYYIKH+ZDJJrDamnm0UC3TGSQuKxT1ZPgvavR9O6iBAgxNUyYXa/zcqtiGMzyjFz6CEdK2HhDm4PvV0YzsFN9h4VItPgt6u45M+60Kg45Q7ELwaiWQqgDY0qZeY3EgIlvvCFNpxdI4BnG3+EIG/Z3qLQ/1MJHMIkPNSRBG0kiEc+8UWC6Xjx8gWMEP82dH73U/gVavkbgWf3SxUVjdj7nG;25:jwG49TT2VN6LNCVeiYxFcHxNgrZ1Dq8Td0eAYQW3FiCu668/CfXLdO08U9vXcCnLiuoYBqej4eIptRagEzZaZ6qT1/rlFOfHItNf0Op4J/bGq/VpIIzdCWZvul953xf4Zn4OqdONwtHqwhRZ0jof8KIU/LDSwK9jwMFwpHbeTEb6EN3VS/gAi1mKar3ZkfDPeDhTr7JUbRXBygwbm+bkuF9RW1801WVwZvln/xv4kY+6oeRxhPFrEUILlbE6mXycgNyuNGYXtjNp5oSVvH3b1ny9avi48Cc9r5qcALq/Mnf/hJ6OCLnoB7F67uvjWvId0qKxiZIX01uvhkNO4OZmiw==;31:+WMbki+hHtRiGhmHPfmyNYSNoRAtfPqUS2MJAEmNjobaYftwJUBk/kR6dUS4M9Atwyj7ic/4geM1bHto7UWDxn93u3SuWZzjgjbeBJ5JBndgjF20vLoV8KyRJpvZSuV6Nx/SqX9qyu4jKzCKu7N+d0Hfc6kMkSPW16Ug1WitIgiPpIICbChQY46+IiMsrokoxsqt4cp/mFCkSBAkNoA7OX6jOtfvtwAO7U3+GhYmaBM=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2639:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;20:jLOy30LwYlle2j8rxJU5NgnOdE6ZsLdqNLIWn8Z/Do/QzPXf9eU+A8iMgL9WqrNin26N4ETKz7Jq7xAMYawzUibhyVIbI98TGTh9N9icXEbeF6ZiGXHS1e/2kvnHY+uQ9BskfrND2Nwg5LzbqlXrc+WSW6hEiqsLPniDex4I0DuIeZViAh0mMXA+CZ6hvTbLYkwTtlLiVLeIJCC24OYiMMGOAbVSeABQ5340NRKRuPXL+pZfZvG8nBs6aQWpGHcjYc6qnn+t7Ozm0njT7Se6nqnN6sMSnxnqFq/wnr7M7Syv8KzIi4w4noLpJbjgdaxaGNBPMi7hZEmomYhyx2UEjodEIQ+wFjbD/l9HAEHfDMKnweaFlR7w/wCmpDSlfrs70eCoo7Pa0qDOklXPQ+bCS3JjyDreKwj5z49TK5cV9NRRUKGInCY5HI6D7VQlxOLIXjHKkhyyU768pD/0f3mjj1Shy9PWQG3vIaCXzBqXoVPm5dqVuuaoWc4nVfwleQiD;4:nsv1I48DddMLCmCmcbqvUZ/639y7EI29GBLVCdqpqEDtoT5zxW1I/uesKNAHixEEjhwhHGMD+CBIy5ElreGgqi6pp0FnGFg4t5TAM5E3VC0CYEryw3CHJJrfk514AqA0Ig6snJnYi5nEn5T1b8ft1GY9kXKn78sKGs/HPWvcoesnnpufkhVrH/6jj9mftxBMnGRHU8tRIVyG9vWPgBr4EAcP8LsPJhlacKRtjxluKr4n/SZ/xquaLxUJkOQ3yaoBiySAPLDDvP8wguRgNdkpKw==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2639F6A2BC3E48EAA5595B9BED930@MWHPR03MB2639.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR03MB2639;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2639;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(7736002)(305945005)(6306002)(53936002)(2906002)(5660300001)(1076002)(55016002)(9686003)(3846002)(23726003)(6116002)(16526019)(230700001)(6666003)(186003)(7696005)(52116002)(50466002)(97736004)(81156014)(81166006)(106356001)(105586002)(8676002)(26005)(50226002)(33896004)(476003)(110136005)(316002)(68736007)(25786009)(4326008)(66066001)(39060400002)(956004)(86362001)(478600001)(486006)(966005)(59450400001)(47776003)(72206003)(8936002)(6506007)(386003)(2004002)(32563001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2639;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2639;23:TlI3F0EFQiZSUkhIMA9L7fMGi37gtvwq7cwlxGTDA?=
 =?us-ascii?Q?iE91Qwe86aQGYeLSMkQAICkz195y+8QuLWAFum6b53hBya/tMM2KnLny6cj3?=
 =?us-ascii?Q?SjDu1MjgLPW1kdNTDw1ZtuwCixldZgmNqZrIxWbyf5Nlrx2AoOm+Rznic5a1?=
 =?us-ascii?Q?1Rprg9ogo9oT+hnFZlp3vl02n4+bmwgK10xgTJLUmRJs2sJvPtHu06BGjrMa?=
 =?us-ascii?Q?4WvKk8pUm+qGBe2TlzAviP3cGvvVAR+f0OC4IfhfHh/zZnGKs6ahRPElCfkd?=
 =?us-ascii?Q?wfb1YsFK97g335eZZ7pD0jwIjp/zf1+Ofczgs/pZyDSRJ42+YlRQ+KOxbgVp?=
 =?us-ascii?Q?7Hm4a+b8b4XQJipXsZAfRAe1e/F9cRGXOWdrtzcC2En6pS1vJFrzSfUoK/WC?=
 =?us-ascii?Q?geQzalcw1Crgfev5LosZswFN9yo1ZB8AaRnr0XWBxSqxV0Xa9OtUzTi4vDvT?=
 =?us-ascii?Q?8HXeRNGH8jJJ1nAZ44xMU4hcqdDGlEkJkmP3gCed5pQh35Yu146A3usidXR9?=
 =?us-ascii?Q?5J2Na8aScQ01dPxE4MiMUP4VB0Kc0Ca0sgkrTncpY5u9RcTfkrA4MFB9e5rU?=
 =?us-ascii?Q?DrzUVACXEXCTXGiQiKCLZwUdU5HsF9fvDlJQigXO6HiJXTyTFMvIiGVWIK/3?=
 =?us-ascii?Q?/BYgmrfl6PULa0RMnB96r6thmzpOMiy8KgcSlIevePv/hOoJXHOpFRxazixO?=
 =?us-ascii?Q?ZjkLcFbZ8Ex8LIPG/M6zY5jARUe2BQQn5qfeNltgbwomU2PxWK6CfOQbPdGW?=
 =?us-ascii?Q?NFravqgwetmXRzMexRoaVM7eVwsh8DCUVfpfpsM7uGY4ZDMt3Te23099v9O3?=
 =?us-ascii?Q?/XWnItfd5lVsG+SQANmk9ghqR4kkHds1uINpXZMA/ydq1egwsynyOg22YPZc?=
 =?us-ascii?Q?3hDkfAW4sLrNnhXijs/Daof6J2/OugbLmutg84N5IdDi1GUShWDJCueG2ux+?=
 =?us-ascii?Q?lBHHQot8x6WhtUYNlQt0QI8kESjS5U4dpc5YEPr7h0DLS/hHFoBhhCgT3Y6u?=
 =?us-ascii?Q?lEbUJpkSXRBncYRLjmPjVJdQG1wQzb5J2LgRKFIu7hDW+T7Cp3vku6Zuf1bi?=
 =?us-ascii?Q?B97K4fEJwmvk6JF1Oq5e8zvaucv2bd714bboaKf+xMAOSOBkjAamvYQlfx/X?=
 =?us-ascii?Q?5AR7ZLIa9b5afNGJEQFeCBeEaeFPAeHqxrn0chWzRyb3l8roGz/653uYv8XK?=
 =?us-ascii?Q?N6jnjUy1ThoCibsCJpWIzfzfQh84Zx5o8fJJuEW+EHxyd/bVl7gENR8U1ge6?=
 =?us-ascii?Q?HYFvxF0K8l6oHNitz/HEM37la3fzch3b0z96XWkSwy83CgwreK3LMYXtEbaN?=
 =?us-ascii?Q?Nje9biVTXXHFUL7gVSlpnM=3D?=
X-Microsoft-Antispam-Message-Info: fujlomuRgTY0XYO0MSbmk9wZPcy01rpNVIU9cxpZjE5s5nJwYqBYNBH97GHmm34BgcDyFpphnbvn2NEMoK8XMl/aEwkxGEWlHlHBKo3jfXVaxwkuWdeaIhIgE66WWeP2TOP947ugr2jOEhKJRrOnFvJtD9Z6EZ+ebfZoa7w/m0SD8sjjxUio9pjrVyUYqLu2
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;6:CoJ/O+xbaq0sdll+FGLTFn2w3u2E8+3WEJflj83SimUQAKigLNP57jSulUjRv44gmUxV+NW2llitd870flv3VIUlsb0Ch+GiEn4f+SrtKkDLGNOPo9eUUovPDMPPB0xwdwKpdD7lszu/JGR2eNzlfeOMy6OvUTbeQfhnt6okccZRIDzcp7FTYJ7OeXf/qSySONALJVT+rn1MzynKfFnCiPhEMa8hZUaePtKbcVgBM+ArqUn2Jt20OixZ5gSgfzz/bKCZnYtdWuWezh+cc7WLeQrXgKVR3ZcvnukX8pIaJtBz0i55Gd2MXVLVfvrKG4ARYktH3fRH9XaDM5hdCpvJNbgNwHh9976x05hEuMpke3BnrhGsOZP4V1DQ+wVsi3Lp/RO+qwpztGOMJDjV78ZkIbrkHajK6oP0pJnEPSIq2QtvPxOD3jLT5yAu8P/nD0HPiuu17Xd/DI1jo1WG5CrD1w==;5:ioUzh0C1S0Zqk3JABwMw4j94Mis3TB17ATKxY5a4mNvEZnVQ8FIlApXXII89LISNa1X5Gw1hQgw8d/40ZmSWYiMBNzvHj4ef6OThDGPipn7oXSd6gn4Z54uiQEHrSo2F9e1Ikodvasmfk/sFYaTp9G6UbovmCcMSGIeugZqEtpc=;24:K+rw02wrI24V0Z3xheAe1lyB+43SG8ryY//VzCWDgMFalAeWBxQStNGlpJP31mU/n8dbu8YSfvbGvqKNYk6595cChhNthxWmGaJ8MfA9+Qk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;7:qpDgIXGisP53/TEsR/nUifY1yczfk4hHr8dnqp0kIuYI2/Zo7As/MnmrqMjJKPZlQAQgvTmRsb0AJUHGid9vumcbRQHiEPbG5lbg8dYBhZ4DBh175lTFWq94rswmjgn7JWaL0TJSUSB1s2miZD80lZkbRPMhEBYlck1On4RcXvTwu1zFfRbfFYDQmhN2mLFUXqxYOOK+TWuDZe8xniCttGlILf1CRnStuB69goyy0rwvTDtrhXlZBXgqzsVYHMyF
X-MS-Office365-Filtering-Correlation-Id: c2511182-dedd-47f6-df88-08d5ba4be85f
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:09:10.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2511182-dedd-47f6-df88-08d5ba4be85f
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
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 39 +---------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index d2f88b92d8e2..216767e2edf6 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
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
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.17.0
