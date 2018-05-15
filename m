Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeEOKNJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:13:09 -0400
Received: from mail-sn1nam02on0045.outbound.protection.outlook.com ([104.47.36.45]:44257
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752404AbeEOKNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:13:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 18:12:16 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: berlin*.dtsi: use SPDX-License-Identifier for
 berlin SoCs
Message-ID: <20180515181216.6d82f7fc@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:404:15::28) To MWHPR03MB2639.namprd03.prod.outlook.com
 (2603:10b6:300:46::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2639;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;3:6zhZjqsaNxDpG1ul9Ggvs9tOrzSZ0XoyQ0sjyuuaELhVkXOnSpC8L5t6dgFYPybcQHw+pHxm+FZh2a70tQU4sS90uLqcOi7Et113R6u6mNer+3euDLaulwkEl6K4houQimXcz7VmZpLxP0gkBLMM+brEH5iwZ+NeWd+xWiQQUczN/BL9xMDvTsZwpvgntKlEwTMZ2ED5pFU8vh3cWTx6ERYCV/9I73lOVU735MeMPb6XpAVAVKnglk3YZU2jwkP7;25:ZWdDR4p1FuyQv3951CuMCJ3blJnaKbvPe/HET0NAW6z+lxigycL10lxDmt+XJ5ha0m7B+Hk7D3Kpkq965+mej/663Jk7wzXMFFdCWdxgHy4lmuKOw5VoCW/gvKJpsDl7z0XsQXU3aPMPjlt737xIot+kkIvW60Yet6lyN7VN4l1k70yMD7+n/ULa9N22ieqNoOu4Iv/iYz8+HrXU4++XhoNZZFT7p7WWiXZoW2RuXJgLIZLqRMV7xpcYc88KOBzmHSmkaxk2/Rop0FhXU3GNrpAWs8o/xOmSVre3+td+LjjPetl5cwcxA+UHAegd8vlPFEHcObjXV+0p18dDSCHrMQ==;31:I8zxP3+4uyzu7S3GwzrHgm1x/3pTjNuvjDcNdSeHOiZnIoKc1d0TkjYKvIBtTNvsnwLk1Fp2AC+9dyt447Y0JiLOYhona0JRh7A/Tk1zEGXFVfoA2XFV0/DMkA0F7J000V1E89dKmXNIzC+1DPC96Np/5apNAPtTy1vdoFPzydI+TZPiXNU0RApxUbeKzcafI/M+jk11FQRjQPFCKBcLS/t/0raNHJ/xoE+Mo4J2FQM=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2639:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;20:8JFAGznb8RoSqfUOAsJRpjSFWd8yu666PhmoumVHOdBXdgRqYQyTy+6y5sJvSnPGiZhS3hi+EgSlmqkNraG90HiJgkRDiIizUoNHV/9j3TyYFEDOcTCT6V3zIOkrMXY4mqIi0QOcrsNO4JPtLmckGoBgHB5Jj3E4B3EET6h3QaZvUF7jizX3I1soOWiAzVd1hrUEZOkw57HgwZHF/7fTe0BvYBBLi0G2gJDq3VxBl7Je277iuMQzScPlMUJoLb9CfsVqGGc+GRNzFKQ7YOTepdTnKuwosMSWPPMPsDsYbqFfpnBtDUMwb7GoTVpj7aDO09qP+M0MwyN7EXd+7jjf2TFL53/K3AI0fB4im0k9fH0SLPRGMeoa1kWsTAzrWQfTLj1SFg4iu3byB7WjgjjlNbHVB1rZUlj690iGXqyb6SaQxP31jmhlcp0Bf8fgI5CuMPjk2SYqJiK4qVdLfv3MaUgT1tLlbemXNnxVwRt4znqYly4fW1nVudoZO73i2JC8;4:c7PTaCU9T68XxSZ9Pvxrx1NXhhZ8ot5ymt9bMOcs+wNQvYzvOPP2zboM2T1q8f+vPf3+ClvfFvANBLY3ls3YQ//VPefzOldpiI62Y1EvrNJNibI5aVzMbJG/OCNvCvw6HxckjZiaATxQghhRvnVXkCzFBP+KvU+oTPJLBxiEGjosqtWwfsO56IupKphJgh3jJCBdmBui2k/pUgzNjfqpxmDcsFH/7GNSN/zy7QJfXlwXN395m364YsJ8KSQOplJGptGgeTCWoKMo/ZHGGE5hKdzo0rVcSBR724W+tSLqjT32ACTuRoCURqKbwHDMZ3nL
X-Microsoft-Antispam-PRVS: <MWHPR03MB26393D1D21FFC67757BCAD2BED930@MWHPR03MB2639.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR03MB2639;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2639;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(33896004)(4326008)(476003)(25786009)(110136005)(316002)(68736007)(66066001)(8746002)(81156014)(97736004)(81166006)(26005)(50226002)(106356001)(105586002)(8676002)(966005)(59450400001)(8936002)(6506007)(386003)(47776003)(72206003)(478600001)(956004)(86362001)(39060400002)(486006)(53936002)(2906002)(5660300001)(6306002)(6116002)(1076002)(55016002)(9686003)(3846002)(7736002)(305945005)(7696005)(52116002)(50466002)(23676004)(16526019)(6666003)(186003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2639;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAzTUIyNjM5OzIzOjBUU1BiYStFSXFScDRMWjBBQ0Z6Mkl2aVRi?=
 =?utf-8?B?ZFpQWFJmd0VNRVQwemw2UmZqajAycWJSMVM3MUNEN1d4Vk1uNGVPK3M1WGp6?=
 =?utf-8?B?L01PZkhiOVYxVjJKaDdIRU9mWS9jbHhDVFRGV3FrN0M2c2ZXQWM4RE11UkNX?=
 =?utf-8?B?RjRRTEJJc2RQcmRtaDRSV1NsdXJKR2didWtZL3p4RkVPR0IyaE16MVZuUHpR?=
 =?utf-8?B?RDk1dlJxbkdSdiszWlhNdHZqdW1UMmpnbnhlM3FlSkU0SFpHa2tRZmZGMGNs?=
 =?utf-8?B?MDFWSUlZRkJGeW5TUTQyYUd0cTBPMTh4VE93WUhiRVh3eDlhWmE5dzJQdW53?=
 =?utf-8?B?amE2Qit6Tm1XSDEyN2hpNHY3QmQyL2lBNkwrRHBSMUgydUpHbjhDOFBnWlBq?=
 =?utf-8?B?RTVkcWZ1WlpMb2NuL09QWFFtTG5TRmxFN3E1OEZYQjBnTUZMUGdmbklsQ1d2?=
 =?utf-8?B?WllxOG5aSFZ3Nlg4aVBsNHBuTmhJY0VlQjlCR1dmRkhoL3V4czJxeExKYTIx?=
 =?utf-8?B?RmgxMjQrZk5LdUplT2NPRXlsUUp3OWsyOXhaS1NJeGR3Nmpia0NQeGk5SWdG?=
 =?utf-8?B?WEdpNVhWeXA0eUQrUi8wc3htcmJ5SWNTSDRqRU12a3FuYVBscHZ3UXRhdWYv?=
 =?utf-8?B?dUdGWDZpdzJ0ZmFwdU9FVUY1bmQ1bXA3SVZLOVR6L1czM3plRDRNY25PV2tl?=
 =?utf-8?B?VGEyQW4yK3BsSTNGZlFOYUNsWm53SWZCTlp4dCtMTlF4L1M0OVdWZ0xuYkhp?=
 =?utf-8?B?WkNvYThEZUlLMGJMelJuUXNpb01vYzV0OFdGWitQcS9KdmRwZFQ5TkIxYTNX?=
 =?utf-8?B?Y1NRV1FDOU9rbWlGbUV4T2xKaW1HZW45Q2ZpM0hCNjU1NUZuaysxeGlodkV4?=
 =?utf-8?B?U2k4b0JsMzVCeHZtRDdKVnZzbVFQQTMrZzVIMDhramh1VkZtdHdsaURQY1N5?=
 =?utf-8?B?dHRyS0FQZ1EveHZqWnZzYW1OemJLVlF4WGVHcTVNREw2VlVkTUJKVVJPa0M0?=
 =?utf-8?B?ZDVVajR6eHVhdEQvaEFLK0NobTdqc3dyYWFjanJzQnA1c0FPMTkwd0QvSmJn?=
 =?utf-8?B?SUtLTEpLbjV6S3JnZktqajZsQnhzMFcrbkZCMWZZSUlHTkZpc3BPN3diNWJH?=
 =?utf-8?B?TG0vVSswQjJ4Q3RZRVA4S2hmNU1zZStVQ1hBajFUSVNGVmt0T0tPU1JYaGtr?=
 =?utf-8?B?Ulg4dHcrNFdMOGNHQ28vMENUbTd3T2tmSDNqcHNDbEUwNzdjeHVJLzJJV3JZ?=
 =?utf-8?B?SldBZXJZWld5cFQzbmJvV0lvcEl2SG1wUlFnS1ZZRHpuQ1NKR3VxN0I0NXFs?=
 =?utf-8?B?TWhCUjNjRlpMS2RCZGkvL1hldU5rRlhjM28xSHBVQ2IxL2ZHL1BteDRGU3Y4?=
 =?utf-8?B?bUJaZGhFZmw2aEt1UDFUZU82MUJXdjFhWDVUUUZmV2FHWWkrb0FSTzF4TmdS?=
 =?utf-8?B?eHIxbFBaR2tZYy9tRjkwaXpsK0JJMEpUYUlQWEI0VTBJdnRCcWl4Z2xBYUVu?=
 =?utf-8?B?Mm13MnFVdkpCeHdKYnRPMXRvSDFiUTZ0U0QzNS9jNWVNN1NCckEyUm1yODRF?=
 =?utf-8?B?QnR5aXNOeExJUEc3WEhtRFdPVUZqMWFnc3F0ekZFSFdFZWhiWlo2TXQ5eUZI?=
 =?utf-8?B?RjBCNlJGNTVhcTRFTXYxWkdjbkpRVWN0alBUUlYwdXgwVFowY0NmMXR6MDkw?=
 =?utf-8?Q?hf8v3h/929zocp65E7zHrS0Fh9aQZvRxoIv2Tyi?=
X-Microsoft-Antispam-Message-Info: 19mjxkU+SQKHt5wdUZHPmYjgepipgdFO//WaKmphrHrl7AHNQlLXAz0JUW+siSSYcJqrS/cpPVoKleR24px7TUvRJ4Uu7ihH0IKf4Pe5fC0hSlvs6eX2gawTw5xH4AR8cZLUsCPj54ZMBeCdqmPiL1KI5CRRLjQ5IT2shJcFqCoA/v5aJanj6Hgj8JphRMje
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;6:r0+R4PFT5SvqaV/TVtl2MqKWVYazM7axsBfE8JqMw8iSJ3UOc5CBm5avy1xHsK+cayEVKp7izE2LE45OV8lrnbXee/n+S9e9I0RiB7O5qRzPnhhHbGEQeLd+YD7qFLdGtMZ/lvVENnF1xVkzYL6hCIHRc6UwMcTvY4lLLK7vtacwuzkcWs9aYzaBgg254FajSMJsPHpRrI2UwFMc+TNyVDPQUogrX9sh3ecE8dIXDyu5G/vyVGqfvnaNv7zbFB85ihghRiOnjSm1YAalOVtQ5Qfqof7GfA/KEfcRZHITIErxqeAJGVVlpPJcv1ZE+R1pbnZnzF2DGAh3/yj0QHDwcRFzQZ/bYpzTFiZnON1lfhgoK0Wv3XRocPvz0h7AbiH8xdFAHrH5/l2h9zPZb5oKbRELk0tDNv+jyvHQrAA8iCIl5QLzEwsLr70xFPqvtroH/Nvd1hnMQZt6O4zRmpVJNQ==;5:7CgVcMYKzYYguLZSbADxvhIL5yaJqeQHwQ08c4TuvUy3v6UzXlRak4ZQN5mYVOThyzJtDYmR/UNxW7S3wCeZqUwapKEuJv3PfkvgD1yfgR31QteYLpPsnFkPWVacdrLcwcbRoHD+9r6i+k4moO6LgjPPZj0zg6nnNIhlwkFzmtQ=;24:N1F+a/aeNIh8HXQob3cF4QPXwOg9eh6hlLxKMSKXi1fjmJqHHiFrTH2iCPxDdP/MZT4Z69fekTbD0mW/gA22OBnmCE/nznzRGmHp50Vdpas=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;7:GTNZTYES57hGE2C0ypC2Z/JWO1J5IWDzpBnMbbu6zMk7W9yVjLnzQ47zN/rIc2KpWBfHpDNwNs0q5fL1DF1k/RGsAuwKhE0OVAlsaEvYsR7Ttmv7rKjoJ7gWrzR0aDPpUt7mGpVjNCUyqZ9VxkdLcCHw54xlc/JVV0vUfmvXMCbquFQ3HT0A4i90zaNtXWqQfXzGdD9zOVd5hWjhTfjHVNaEfIE1+7Qxsla72ng2GO449/vO1ewi2JdT0N6HHBLQ
X-MS-Office365-Filtering-Correlation-Id: 82d7780d-e20e-4056-2223-08d5ba4c720b
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:13:02.1562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d7780d-e20e-4056-2223-08d5ba4c720b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2639
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FADDI2010325

Follow the recent trend for the license description, and also fix the
wrongly stated X11 to MIT.

As already pointed on the DT ML, the X11 license text [1] is explicitly
for the X Consortium and has a couple of extra clauses. The MIT
license text [2] is actually what the current DT files claim.

[1] https://spdx.org/licenses/X11.html
[2] https://spdx.org/licenses/MIT.html

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2.dtsi   | 33 +-------------------------------
 arch/arm/boot/dts/berlin2cd.dtsi | 33 +-------------------------------
 arch/arm/boot/dts/berlin2q.dtsi  | 33 +-------------------------------
 3 files changed, 3 insertions(+), 96 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 787a9d042ad9..db67377af266 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Include file for Marvell Armada 1500 (Berlin BG2) SoC
  *
@@ -5,38 +6,6 @@
  *
  * based on GPL'ed 2.6 kernel sources
  *  (c) Marvell International Ltd.
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2. This program is licensed "as is" without any
- *     warranty of any kind, whether express or implied.
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
 
 #include <dt-bindings/clock/berlin2.h>
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 501c59d97eae..387d02803690 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Device Tree Include file for Marvell Armada 1500-mini (Berlin BG2CD) SoC
  *
@@ -5,38 +6,6 @@
  *
  * based on GPL'ed 2.6 kernel sources
  *  (c) Marvell International Ltd.
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2. This program is licensed "as is" without any
- *     warranty of any kind, whether express or implied.
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
 
 #include <dt-bindings/clock/berlin2.h>
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index f11254e70f57..82e176011d36 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -1,37 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2014 Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is licensed under the terms of the GNU General Public
- *     License version 2. This program is licensed "as is" without any
- *     warranty of any kind, whether express or implied.
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
 
 #include <dt-bindings/clock/berlin2q.h>
-- 
2.17.0
