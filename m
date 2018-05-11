Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeEKDho (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:37:44 -0400
Received: from mail-bn3nam01on0122.outbound.protection.outlook.com ([104.47.33.122]:27403
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750937AbeEKDhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:37:41 -0400
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
Subject: [PATCH 8/9] arm64: dts: ls1046a: Add the identify of the platform to support to set rcpm bit
Date: Fri, 11 May 2018 11:35:29 +0800
Message-ID: <20180511033530.7931-8-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(39380400002)(376002)(346002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(2616005)(44832011)(54906003)(7406005)(110136005)(97736004)(476003)(106466001)(8656006)(8936002)(7416002)(47776003)(126002)(50466002)(105606002)(446003)(4326008)(86362001)(36756003)(53936002)(316002)(51416003)(50226002)(76176011)(6346003)(48376002)(498600001)(356003)(1076002)(5660300001)(336012)(486006)(81166006)(16586007)(26005)(81156014)(11346002)(2906002)(8676002)(305945005)(6636002)(77096007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR03MB393;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC016;1:Bvo9QBFYCG7++lO+xrJUWWIfDq2OxUBodrpTqpKTMI2sIGpXmlLC5OPaNdGQl3qGyqcF7AAFjyAqZwCs5+QewJ9LpOSCSMwl6Gi2I0YD7+9Lt3rNN8K9SkJGoCj98+lG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:BY2PR03MB393;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;3:QUglRyn3UnWhMBEK3m2Foaq3AZfh57soCmAwo3w0PQQfCnY4LW+vSY42+qRGha84DVzGAm9jvaY99eaMn9q8nayrJoRH+Gj5hF4Y1njMWY+Y9zonfbsHOiufrIgepQmNcMMOxTJeP74JBOGo42dMdbYVRsFj7r5NHjgWND2ewlpoh2UMEyNNApNoeftoZAjCXFDOXQoksfbYf6Mz4kJ4Am25TRpRbQEhsXNLIsWko8i8/HwaAstrzsWAjj611j+xaVSzQPCvm2SB1nxB5UoZsX7b1eHCkjTXSij66S50rOMF4WRnSN8sU58eM2aXIC0hCjnr589/SubHrnGiFSzt/yHOi8yC7q65e9T8Z+6Bq4w=;25:Ig4kLydP24X+I+jTM5hzkL0f3AxjeHGyZ0zA7YgHOZ/2iGI6drPpFxS7/VKidL+fdcVUgM0KnPvH7SP9l4wm9ZUMaxz32iFws2cG0H8xGvr1ymLJ7Hc+BFfKmv0CFR5GejUvSIH9ubQJqROOOCYryVBqKcuQs8sJ0ykJ3Twc1y47uyYO+59/NgEuoVgM5rnSLdm46dPH6KOylaTl8Hv5ZL7UXM3V3LonD9UQ0Z2nrAikFEjrDTEf5hGBHU0csDOuAwUPMkp6Cb1+v9cog/ouOu6ti0g+ZcfxFmzB2tRLI+vSq47VMOQscxFHv3GE4zTl5icWiUNZFZVbxS0CvqYxIg==
X-MS-TrafficTypeDiagnostic: BY2PR03MB393:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;31:wOFkk8XGCbLXlFDT1h+F/YuesRYyE8m8v+JZdQFby5Tv221Zy+hUk5DpqX4w+Tjl9reW/IdgyD8AloeQmRXHhwbwLh6NmzlCY6AxBtkL6UPP7ropXABhsqqyF5QCiPftCDc/qM2R3RRSV16zX0l+ruLHIHdFnhLkvA4Etzb4yYScbK6YKOGYHncwSsHdje9mVOeWaqCVglLg3OtXrmQVOZScIy8b71qUnkzybj1J5Zg=;20:n/KX2j5k/wwUJb1hP6XkdxNuyVy+JI80CODWl2YT9ATuuLZhwij/gRZnOXWBsb/2EG+D2dr6v8T8iTq+Ml8wu62jB8D4xiMjstkgrZtlO8C4bEbccbqk4ohYIzQLX1LxfQEPZpAp2OKv+a5nqHKQqBTgtgDAq9yYGFnpRDhIUH8lP25qbSV5zWuwozD0gM66ji+q9NC5iwPFmhU1VewszGKpY/j6k1y/JGi/E7KVO5frVFa96lL3z2Pl8FlpcASq0GJv20zkHTOWxtUHyJkfhiwGaFUz91hOrzSPrmpe9jnQ2isupS/7xianrP2qFOabEwHqWMlks08fX5ZoetBdl92VfHWOiGBa1uqbcE2dPmKuHoKJeBcgT91JCwJtveQfZd649/7HOtSEF8vOjebE4ZF85xQDlVdDH7TFssJp8MKPkT+ISY2tlBrsLtxkfSFBQ+QYgOuz1SjSIr7WHp1tQnhhpGDbnNtTnCCOCIsRL7mMhwSjGWYY4nT/9WPG2NGyVJ0FrsbyFtbzK6x9SzX06xLoVZyra6+s1XQQmsyIllwQTOMw2jHF5yC6qKHPmpdkLpXFQKsSHTgMlRd93/xfZXGkLEV7+lEfL4wwPzD+NQE=
X-Microsoft-Antispam-PRVS: <BY2PR03MB39306A548863EAEE95275E2E99F0@BY2PR03MB393.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(6055026)(149027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR03MB393;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB393;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;4:QuV7Qmbp5pJ4hOnb33H1gO4Pyusv41JgOT/BHngdXMLlJk2JwLv4eiT1UaAKEpWBi32jfJjWMDol86qje9t9srwIdPvRFUdmCtNZBaA6FdEZRmP8TSjHBkraSh7foPghntBPJJfP0FPs/6qKyM7If6PDmG9iaIuDXMJbIa26wae6PQGT5909dnDSg25kKAzXyAypzOfyZ+93EAwxI1AJbnb/Pi9XbbP1BXrGHcWksL/dZGV5bHrYLTK7UNLA5NMslFBUq2kUxlRmYG4FdIs4OphzKtPMw85csSVp9s6IBTe+Jgd7AIZKlnRb9ZGqSbwa
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB393;23:R4cUfB8fAsOvtrl65v90TJn0NTa0oSHTZuSR+uBEuX?=
 =?us-ascii?Q?SBTA9tReQv0RISKhBDUHpjW2rMQBgpmP9SXaqYFkCS7Tx85TOedHCAKc7TtR?=
 =?us-ascii?Q?UNMpbMjh7VMuC+uIuXy1p8aRUWFXxpvBR+81Na1oDTjEouD1LKB2Fu5bTy52?=
 =?us-ascii?Q?e/4eY+7HC/K/BmGCY9FS8g4CnJ777hy4v/KdGZFMsLd5izsWQtA8stvqPHm+?=
 =?us-ascii?Q?p2uXZnpFHpZHEoUdTLuvRTS7SGP3ZITNajfUXGr40Pezawqm6AwYE/3bQbNP?=
 =?us-ascii?Q?6J7hXjg+1D4e/xvZ70zIpRDXgd59QleAnQr+JVv7gl95sFDhTvdmyco+mF4J?=
 =?us-ascii?Q?GCA2OtJr40U8oKtq5wJh+rwxXRlnGShgWL//GmpuwslcM3uxStEULB26ViG/?=
 =?us-ascii?Q?bb6YFm/CVRrdJh8XzY4NHQmjNAOiWgrYwgcf7YHHN0KmNqVtMrcerhMZHRRS?=
 =?us-ascii?Q?o2h57oEQ/EqLulHGJZDTity+owMMHzApqMjln7gk+SfbgynVZdl2jhyhbW+O?=
 =?us-ascii?Q?8ZVCGFtKQ0nk1NTFtU0HWwj8psSFhu6P1PPiR9vsZPBNl/I6LeAMQPWHIBHC?=
 =?us-ascii?Q?WfnQ2BycIsMh8LqaSQoLnTpAEPGhl8iNSIapD7Rc8CkKVVmfv3MxSiAtzD29?=
 =?us-ascii?Q?UXBvinjauReUIHHoO+4Fsqhu/vlYH6U9GPuMa3H006q7VfAOaSzYzVT9aRcx?=
 =?us-ascii?Q?FuVVtoUaSl8t5u+AjUZusb20tRj5nvZQ4AOdGvO4Ifb5jbmpoG7DDQ6ar6sj?=
 =?us-ascii?Q?1Kx/scZ1WHieaOOHJSLHQziHHYaVWCu1vfnWs1pRZw1561noiU2IkD9uXrSK?=
 =?us-ascii?Q?+hpT6UpSWhkAOWOqNXrvItPjvfqWJPVy4uJQjtOdzQfSnhj5XqPNr9iwaL6v?=
 =?us-ascii?Q?nOQuuctlYS6aGqv1DTY9ZKutFFhco3aIn5lpSzSAo0fLREJ2On7v006YcHBh?=
 =?us-ascii?Q?SRaa9NRB+QnCj83PBiQ2ONpVDalqquf7kRs+0iRCbFd9RMKuxR7fG/LOmWqU?=
 =?us-ascii?Q?sHai1KqMJ6dryXFxrBkU9uRT+zJyk/tGWoT+j3mIOOZlLRNAQtPU227oOhBn?=
 =?us-ascii?Q?tF++nBEgOWtylpRRj53Pg8y9BA8x3D92wNqIul2/IsmZ0hSrnVXXov3Tg+h4?=
 =?us-ascii?Q?2dDQ40K6FMedXLEpM0b9o9jKxRXLdoWI83O5Cls3PuX5W9jfMSjbFc+CemOF?=
 =?us-ascii?Q?4LwRi45IdVGFMSawHFtXJEXtPGg2W1Ka05?=
X-Microsoft-Antispam-Message-Info: zCbDJG1g0ZOy2UEEHIT+/8v6uy0inSgvjl6r96LH27orfW+kHPfnuFKdpAukGk00iOtxllJFpSSXus861I+wZoQNjEVvgI6NoIxPkdDusfONGkycL39LhzPTk5Q+dNelbmi0u8R7DZk8homi48DxqgByCiSJGJkTw8IrTRdgamKOnLOLbmR0GrkXVFHW/oAj
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;6:5gf0zbFG58B0Y+pF36ehukq6RPNanI2GFwv8dvUCFkq1YJ8x7E4EKKhIlfC+dkqapLyaDmvWBsZb7jxOFWEeDpJRz9cD/KlY+kwY/x8Q8LjBcxQoBI4KlWG/uYjIEA+w+xejfs4BCdAivoWmjgylZZFcoRYmZ9YJununcxx4K3MzJp9pSHWLCr7/Y9+Fx4MGkwJq+Z9oWOJA+srIjqDQcNGaCydGI3uFmJdmjJwn+JX+QQtNOdyFMaX3U6SU/1uZ4N0nXSumgJr709EsotUnLqvmS1VWr9X1m3kOxeRzPvZgjKErvlzVxLoHK+qz9ZQps4Lq9zhEs/8cuCw7X1kJMOMbUHeNwVgbQOVfEmF7Hhdn6Z2SLpu5Ge0W/y/bRh3pUWIPFLS+TqSGOwMNiWi8jqa5xgQ+AvRnl7kxqelYg5vSBsLU20HJUwTzptFWKpa74qiWGeJdr+BxIekX3N3+PQ==;5:uX33Waxl4uVfrH0VmtocUiU1yBNp1cuaTnCAvkloeVPkvgGlmm2cLaxMpAvycP6EWhGTsm0xcDC6EnB4xvfeQaUSnacz3ZHOzLuDk0Uri2Ul1V/XCrg6AahyUByDHoyqU9dOZx3Gme4AhJwTGt8b9sxohO2wXvzp6nzLq3HpT50=;24:Hgf0jWPBP+6paDVdJkOOcqIlptNZm/pk6cwSVnc8tkoKk5UlBt6Lr7mnwNEDVmWLRVE8yHMT64ThqLk9Z4QiiJTKE6+/P2oDRxKWzIPm7oI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;7:c/gZdh/s11ugs4KcZOu8dan4LCvmDYo8FNhPBJ89yMIodP+t9+atSRhoF5/s3lL/Mup7kBfgO31woJN52JWnMTtj+NhQKMv7L+YuVQUHl8Y3Cxj/vmdHSPYqbD1F0rerTA/MRQJ+z0TAABL/mKG7uBnTv60W7b8H5YFCtGa7en27to4dZU97N9l6J5vG2x/w6epg0tRBt+CQW/i/TtoN+f1/gGMDN1Mq0gkVR1TKT8Emm+sPAX3ktKj9PldskDnJ
X-MS-Office365-Filtering-Correlation-Id: 03dbbd75-ed0f-4cca-d5ce-08d5b6f086fa
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:37:31.2509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dbbd75-ed0f-4cca-d5ce-08d5b6f086fa
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB393
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Add the identify of the platform to support set the rcpm with
big-endian or little-endian.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 3e09bcb..1ce1153 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -575,7 +575,7 @@
 		};
 
 		ftm0: ftm0@29d0000 {
-			compatible = "fsl,ftm-alarm";
+			compatible = "fsl,ls1046a-ftm";
 			reg = <0x0 0x29d0000 0x0 0x10000>,
 			      <0x0 0x1ee2140 0x0 0x4>;
 			reg-names = "ftm", "FlexTimer1";
-- 
1.7.1
