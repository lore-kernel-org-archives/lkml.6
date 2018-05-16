Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeEPIUV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:20:21 -0400
Received: from mail-sn1nam02on0057.outbound.protection.outlook.com ([104.47.36.57]:25248
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752831AbeEPIUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:20:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Wed, 16 May 2018 16:19:23 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: berlin: switch to SPDX license identifier
Message-ID: <20180516161923.2a39d8f2@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK0PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:203:52::18) To BN6PR03MB2626.namprd03.prod.outlook.com
 (2603:10b6:404:59::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2626;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;3:WtlJxMc3jMuI6RbMtQ6uqg5CZhlxyEf7qZ4gU4w+nZw7Y5OkXwD7VlZCkYmm9vp/wZt8o6AdycTIGAj6dtT2LBwuAbccp3R6a4FQWgklxN7qKV2kISGjuEdnNCYKtQ/x0DoNLNc0cci0xbCeOYM1fxg56mI8T11BhKH1+rzmcpw+n2j6NIZZia8uvs6tMnIipPCztmQ1F8aYj+wsvyTO2g6yY4CtRS8rqXphlE8PHTxOgisRqkyucwEAiK9C1a8R;25:fjSRAuKkr21JqqnzGovZXg0sT3vhHShwQVTrlMovxbp4IVXgzd7HQ9M10d63LfrPEzznuoax5+mxqZQEmoeqivQaksJWve0P9OEt65Tomoyy9F9SQKM1loGi6dv8Jp5ldMNEbsup3GC5hSrwhxk/1M3Q3ufR6cFbTfVLeFv6KIlTG0wqTtcSMlD4IyHv8mBWSRo76k7QrCm8/rOuKO0tXoRsPTxL1nf5wWi5iki+PiUO+6i+8/dJ5h4Fn7qO95wyRluBgUuQvJ/wzRFOjIlo28I6ZVxzGWk9A9c4WAQ+5XtIyMTCY1SOiPzPemJYceuTvn7SFsWyvnB81LDTU111ng==;31:ytcnxnrkyXPLXLbuqoUQpK6Dr2ZAEi/pe2KmzufkijN7furUEP2+0l7c4VW671v98VTMuyRty3sCl67xKyJXs2nAI+oP9uw1Z8sJC3lhWzcv3KW3v6T6nFIqasEU1tYh3ypu3Dt0FWfAsQe59OnZ6U0/irK99I/nPv55SAVx3bGiv4FdDPCt1elpbyIKyvVXQwW6Q8D+Pb62cMSoMQrhGbGh/o7RVJGt7OdCneB4M4E=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2626:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;20:67eUMsZTxXAzmYb2CNsrdERzansV1bqOO0IFy40dPEgQbGwmObmuXFO8GHlNl4nmLVo2B6v5j1jAtBqW/ltSfVmGJ6enS7cFk1iaeZgcJUhHJxDmzyfnKdqE6IRNDvpSossK7GYoB4onPkGR4gF2el6QAN3b3Q1RK4qGvQx+QaiNxs2dEXzB/DWXf58uekrT1U0nRxROvSVo7ZMGcFbvGZdtqXJLMo1czJXwaJAfomSnAnyZ7cYp59EI44AXJY/m/dq8ocYvIzOd0K9TEx6YfQtNiAWLlQCA7T5HlSP+PIzGhzWABLZVC+ibKvsSCfuC/DU8PcMzg13t8Ngco0nfb8Mxtq9bO4ZAXx/SrF31EN/cIX+snZ31tXZukIu7dvq2B2MxVp5rfbs/GMB5U2h5rVv8IDB+dwD8ifVV31S/fciO5Ugy8GdYcwylstxrlf3lwIwhVJOfOWW4+2wFumZTt2clUIjDOjk0Y/OSlQPUA4gZ9k3P57dmkxKtavftRUSR;4:f05x+PwTtHhYofr2Mcmycv/wesIzHyIVd6PhUi5YAfvAr3+mlSJX3KEmNusiJ5Hi4K2SmKQLUOlM8vsir+nvic155jOJkddDbB46A+kdnSDhjmMsyIlqwrtZvgzcl9xQ9XacY1YKFu9aGZFSoSAC32enNIEn4x9S145idBqtPue8+EACUbXa7v+hUbj4mGyjKpDSKIjyIbA43CWUppfR04KF2tA3aEnzW31+V3jeR5SrP3AZshuwoBS7WTJpGvutSKEtQNQ13mcEVa8gqqMFAM/2g/inAz4w0U5Q6s/5x0Mrmf3K3Bb+S2+U0MrB8XeD
X-Microsoft-Antispam-PRVS: <BN6PR03MB2626A6F00E8BA6EC14AA556FED920@BN6PR03MB2626.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2626;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2626;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39850400004)(39380400002)(199004)(189003)(9686003)(2906002)(386003)(6506007)(4326008)(33896004)(55016002)(97736004)(86362001)(476003)(50226002)(956004)(186003)(81156014)(486006)(8746002)(8936002)(8676002)(53936002)(1857600001)(106356001)(81166006)(26005)(105586002)(7736002)(16526019)(305945005)(39060400002)(6666003)(7696005)(5660300001)(50466002)(68736007)(52116002)(66066001)(3846002)(6116002)(23676004)(1076002)(47776003)(25786009)(72206003)(110136005)(478600001)(316002)(2004002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2626;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIyNjI2OzIzOnI0N3BaSCtobEtnZW1iMVZsR3NVMkRobGxO?=
 =?utf-8?B?MVlKaE5rTlI3c083RzhUcFZTZnVSajZITkhpRG01OVRwNW9GRVRuQ3pJYkZ6?=
 =?utf-8?B?UGREVGU1SDRhSWhvK1FuZVRMVGhaVkRERGNPeG5kNEE3aVpOQWZFcUsrQXFp?=
 =?utf-8?B?TUtDRytlTkxSdGwrZ2NEK1UvYWR5eTV3RzhrcitzczVYR3Z5QWN1dmc4T0Rm?=
 =?utf-8?B?QlJ5aEJvWmFhUHdXc2YxWTJHc2ttUGJIYy9tMFVOUnJUNDQwbCtSZllOWmF0?=
 =?utf-8?B?OGZPTmRSdTJDZHZoUUlWU0cyaFVqNDcwSTBIK01nSkNtbkkzWmxrQ0NCbkFE?=
 =?utf-8?B?R1VqSVBqUU9paFFQc1RTUHFjZkxvS2xjSkFEd2JpT0hOcWViNXZrWGxTY01n?=
 =?utf-8?B?NFdYRC9Ld0l1SjZpaEk4VkxmUnZpQW04TXE2MGFiVmdzcmxoZFU5Y1pvTlRN?=
 =?utf-8?B?NG5lQjZ6QTNRQ1B2R3BlOGZ6MjVhRldDRFhXS0NoSjI1QUMyK3dkRUJvQjA2?=
 =?utf-8?B?T1VGVVR3NzF1dmh3WVVDbmdRcE0rWDQ5SG9ERkpLV0l6L1ZTVlVaVkpGK1R5?=
 =?utf-8?B?RzZYUmVqendqaU1MYXdiWjJWWVZuaFp2c2ROWmt6SnBRYjk2ME5IZDJ2VXFL?=
 =?utf-8?B?b3ZVc0NBWWR0ZjlsS0w1Tk5QQVFHeWx1elRZOEN3dXU4NHk2RkhHUWZ5cTFv?=
 =?utf-8?B?c3ZRSkhZN1dUdDRzcTluL0pFZmR0MTZIa1ZXbS91RjFuN2E0SG1TQ2hjWk5V?=
 =?utf-8?B?cXdFN00xdXovdmhobWRnQkdGTGJlbnp2R3JtK3ljdmpQaTRRbERQVDRuaG84?=
 =?utf-8?B?NUxNc0dBM0RTUE1kZUVGdW9XTGI2MS95cFJNVW00N21BbDJoS1ZuNUllMENP?=
 =?utf-8?B?S0o3ak9yaytmN01XdzNQNmlNa2JWM2tBZWZJRit4NmtVcWhaTEw1WmY0OXRl?=
 =?utf-8?B?RnQwRGtmQlJvRDZHRjRwOVdoWUpLZkpmUmJSQXFOTDJjMkZvT2I4M0ozQXZr?=
 =?utf-8?B?c3RORjUvNE9Zd2hLcitSQ0MxUFJzQjloOFJtUkJ2NEhJcHo5RFdPbXRZdjBV?=
 =?utf-8?B?bVRHT20yejFWYWxXYk9URkIwYS9NS1dNNnU1K2tlbnl5Yy9PZnA3VEJaV0dX?=
 =?utf-8?B?T3lsZEptYXB4b2Vtb2tKV09GNGpJU0FxUkp2UzRlMHRMR2tRU2E1RksxNy9H?=
 =?utf-8?B?V3pMWlNHZkZTQlBWaEh3amR4NlRSTmZmYjhHOG42MXFTYmZHWUgyUUIvc0FG?=
 =?utf-8?B?c0U0Y2k1UHNVSXI0Sm1tZlBqMmxiZVpNWU9VRkQ1cVpqNzFhT1gwREgrNDFR?=
 =?utf-8?B?alFXOUR6NktHMlpwSkxHT1JHOHQ1Z0txb1pKeDg2TG1ENDNDYnNHTGsxMGdV?=
 =?utf-8?B?VWZKbGR2WjYvd1YyNlFjU3ZpWWkzZ1c0V1RhUkMwNWNQWnZMM2orNlNZSW5H?=
 =?utf-8?B?alpCUng4cklxUTBYa1VCaklLNlNZRFY1S0tlUVFKWTlsYjljVmRDUTcrVkE4?=
 =?utf-8?B?Q2hQK2E0UU93MFhUYlhyS01xR2xLekNRUU50eGhtM1MzblBRcHN1OWo2bXU5?=
 =?utf-8?B?ZnFiMW9sRDNyTk9SNXpzYkt5dDNUNnhVL2YvN1hWMTVXUWdDUzlZc3ZYN3NU?=
 =?utf-8?B?UjVQeDV4emViNkEvbytJZDJSOFMvUU8zc0xxTVgyV0VxOUsxQ1QzUHFYQ1Nl?=
 =?utf-8?Q?kMrB4UOux1JdHQNEMg=3D?=
X-Microsoft-Antispam-Message-Info: fDW/bg+ySiGq5OBsCHaORC3R6af7m+wDnXg30xP/DDsYTRWV2Ll/w/UrmG98iqUmQqpkXMWeOjqD4sq9WwCT8EkS8Gpu7LkfTgiasZn7QyOGC1oQnk0oE9bl4HHtl1BkRbJ8gSOFyySU1ojlJ9J6WHhJ7EQVIp7tbZkz9HIaJjL6aIWDn7y18K1aw7olG+/r
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;6:XBQxeumJhQNvqXLjxlXnQkk9v5PlNUBRxV7VbFOCgroZb3UkleiCvZ5GGZe39J6kAg6ITkTZ6k2RjiW5DaWWrq9La+qTPYWS7fXt+t2LND76pM1TQZLMqYXJ3pvveQyZebtJhJ+KHZvEfVNCLt9WKQBuyrtBjIhQqw7LeHWxSNCsqEYl9xW39Ar1JvUY8PeZNyUQfKLY4Lk6bgtiDLkY/5luWUe6VxFXEScDAUXYfeL8bJGpQ95/jpi+ivlSUgO/ugAMumfAjQ/mhLlArYJzdBiB5nHd7J8BM/fkychi5ecJF46Z5hoiMSjgbrn0Sukha1wEsYF1LZoHB8UVUnHt6ApO47Fjq06xjKRqUuPO9fQ1WDhbM1BecIJLUEF258ke+ylzlZBEUY4j7FQt85H5WSoMqOSUtcvMas9WK8RmOC/nwjTQLqOjM1AuFKvvLe4O6xlcNofNKp8zt5uKOk3Xlw==;5:pmyPbm5PqCj4ZXiW8QYWxjR5xNfvvJfKD+pM7UI6Cb17zjuJxKbuh1mHySIcWubsIR27J0AEaChGv7WElhOmntyLE1DqksPZWDT+Y1waObKxNbS/3ZPEmg+WX5aDjSBfSEl6QI+hLMXkrfHByI8edTcVJRT7vIql+8QuBVP6A/I=;24:pIb5PHeL5Xeh27EwH/CU86moPbUfsLxcozy0lKBBRPhsEyHATUcuUGyhB2r69oecEQ4264gdee7bASFCFuA/pHshKTeS09kT4GispDaBI4E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;7:MZRz+NZ/fnEST/K5/BNmJDkkCUUgZjjcMBmjrzVLi9xEwQe+NmWQT+QxAxwMhXSaSvvjv8tXBacaq6ffAoUvAcELIEpJTER4Eiz1ej4ozKft7UYIlrI+t+vHhiXk1WixS5ZPyjGYsMqOVd8buAlErq37LI4IbGrsafpmk63qlVQ59omqhxHxUbkyXnIribG0z6nOHjQxFrhhLtoqapU2zIOtYK9dN+gwWv73fa7jz904QfyZKXQUje807nw3oMcJ
X-MS-Office365-Filtering-Correlation-Id: 3d8c925e-a4a7-4560-5b96-08d5bb05d8e9
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:20:11.7404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8c925e-a4a7-4560-5b96-08d5bb05d8e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2626
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G8KTVi017685

Use the appropriate SPDX license identifier and drop the previous
boilerplate license text.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/mach-berlin/berlin.c  | 5 +----
 arch/arm/mach-berlin/headsmp.S | 5 +----
 arch/arm/mach-berlin/platsmp.c | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index ac181c6797ee..2424ad40190c 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree support for Marvell Berlin SoCs.
  *
@@ -5,10 +6,6 @@
  *
  * based on GPL'ed 2.6 kernel sources
  *  (c) Marvell International Ltd.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/arch/arm/mach-berlin/headsmp.S b/arch/arm/mach-berlin/headsmp.S
index dc82a3486b05..3057885d9772 100644
--- a/arch/arm/mach-berlin/headsmp.S
+++ b/arch/arm/mach-berlin/headsmp.S
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index a8ae4a566d99..593fc4a69d84 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/io.h>
-- 
2.17.0
