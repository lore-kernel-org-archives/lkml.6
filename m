Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeEPE4H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:56:07 -0400
Received: from mail-by2nam01on0068.outbound.protection.outlook.com ([104.47.34.68]:22284
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751046AbeEPE4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:56:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com;
From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Will.Deacon@arm.com, mark.rutland@arm.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH v5 1/2] perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
Date: Wed, 16 May 2018 10:25:17 +0530
Message-Id: <20180516045518.6876-2-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180516045518.6876-1-ganapatrao.kulkarni@cavium.com>
References: <20180516045518.6876-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::24) To CO2PR0701MB744.namprd07.prod.outlook.com
 (2a01:111:e400:142f::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB744;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;3:ojtlt9qtAyMrlGQkhTsLcStx1oKG5QWOQYAwKWqcPZhWyoWr5S4sjzi7JVHU1VTpzO1S8OynUqP6HzCdHhPYF3rWopT2WvLhIdpSGZUS8XCn298ZML9M+hld/dvf/sFeaSy7WSeqfXQlG9gYh5mUxT4uCPsqJinYWeutGzD+Zpww57qmvyPXS/T0ryIxvrbhHalAV6OXEnxs41B8JMXShvbW807dz0+CnNCYSUpBjAMFu1v2Ei/1KSzsa6Z0y4KO;25:gz4TaDk2ZH/wP+W5yg3GFd6/HwC0hfDvu74vGBbfckiyu+Mi+HaqmyxOSZ+b55vyRiwKKCvG1PC6NFTidEIN55VwmXtKGVEt5qxuv7EMsr+TU8Yw49lX/De85mwlo/hPnBUbQujcHDmLemOT2q281KB0ZO9+kfcYu7QYjEtTz481kZAWB4hW8AFXOXF5qwfwDe6VcXx4+9gQYrZ/U5yz3jAuoF4cMiazpb51yLaYEoXIqdVkx0fssNS1UE5A5CEyBu0Nq0HPkELlGnf90mM+1bLx+sucfZjuIr6ECF0/bT5CggL+Ng3baaNZ4XMrD8+nK+RprV+lou2Ch5zvVTjQiA==;31:cNmInmF6yxJVRo/FDPPjELcoYXosmsLG2XsMKXBk0YkglXG+scSopmA1k/PVgbd5uXUZOA46xbNsZb7hR72JLFkYNpTRswBiedeCaWZy3hL5FyN4u/MZ19NXgylOOFU2TGLG1WbA3tUTmJxdL04ctzCCAu+x+/Kl2gpQGGy4w5ePBlV/A+AZq73E4gK/Uh9twBXUTFHFBl9/lAT4+f30FyNhIf+RuMBFtWjtMCPfOp0=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB744:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;20:Ra2MIDfRhu642F1vnHU9/WygFsY6P3Wwn51apsXlZoTJasLnpX/yp/MHzT3mLrmCAZr+C+f413g8q2GL7SNy9JZAz+8MCudtZI7PThYrpBec8lQTx1msVVAdi7NaSyq7NQza+OEuR5AV5++jNeESAzg5bYie4e2Z6+KEZ4xfCcBhVY6dFXZuXezEHjPi3p6BrG+1dpFgb6B1eJdVaQUUlx/tkTWFNynFy81WhUHQcu/4Dp5EigjjvH0DfOVZZyClN1jPYsDVfi/R95nux17l6sg5/SQyXLs1ZMDw3ViAoYGO2RacvmxHbG5uEmVwJisPzoPY46PalT2s/AY+Xmge/0rg5+s5rgK7Q21LRoVv0SHOf9wlgchSiimO4/m9TMr22bywDs5OQwLmM2QXbCzYjMOaQzZ1gOHOoS9R3B9sDBWhu0wZ/UERcPXK9Kp4e0zamAo1Yr61ZYXwDQB6QHw/v3oUDAj/S4qJKcwuGQxY1CZsAQUxKcgi6zTDCF/s2UK7;4:46X9NqaCcPITcFcLqyZ+F/gJvG9quyH2MfMMD50Ml4RVp64h5zamulJO9U+dTVSjZwIDX8RmKUO7PgicRFr1LDNoKPRgKLvGTxkrLAo9L9QZ8RyUaGxv8mjCVKHhJ+zlaGDsJQJ+/xvOxcqap8kVUbEOC5G6B23duGwfI88qNVsGlY12gK5D8GglSxrozlHpQtDTgjH6cscLXUFkfOCppPUXG1UZpbKPY6pqz8lqSRKmUjCLMM9jDAvqUreXNbGbTxn5NTZZm2Vkz2d1qhnv0b7cYsP6OrZpGDGrOpjLTj6BlwQpO5+edSJt6JBcVURaz4VRxT35mUpE61YPix2kkiYZ6niAgpYY3mwlnv5KMrI=
X-Microsoft-Antispam-PRVS: <CO2PR0701MB744E7368FFF6E8F94A8D47983920@CO2PR0701MB744.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR0701MB744;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB744;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39380400002)(376002)(396003)(39860400002)(189003)(199004)(72206003)(6506007)(2616005)(47776003)(66066001)(956004)(50226002)(478600001)(476003)(36756003)(44832011)(8936002)(446003)(50466002)(486006)(53936002)(48376002)(11346002)(6666003)(26005)(305945005)(16526019)(186003)(7736002)(59450400001)(51416003)(7696005)(76176011)(52116002)(86362001)(25786009)(386003)(97736004)(6116002)(3846002)(105586002)(106356001)(1076002)(2906002)(81166006)(8676002)(81156014)(5009440100003)(68736007)(6512007)(316002)(16586007)(39060400002)(5660300001)(6486002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB744;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB744;23:ramBECmA+UnwUAM1iIt0DaljyyHM6phxqfXeTEmp?=
 =?us-ascii?Q?K8IXdw+QHgNAIUhP4B5X8bj6LsEPLILdwdh/tw2FNr4556LkO6qwhzLOFYaC?=
 =?us-ascii?Q?i2fmhQCGELcWU3QkCNBimo+GR7JZtZeiLc8xEQTz1jw1iruzLtM5RPm3JfEZ?=
 =?us-ascii?Q?LmDyBMzO8Zgpyohwf3R+ZTZZEnXWCUEQLbvqrlFcrjhiWf+gaPi1E5roWbYR?=
 =?us-ascii?Q?EK+JFjkr3DxP/8mxynjWd3SNhEw3okUQKSZIhjyAHSORtYgIArV/tIg3F7nP?=
 =?us-ascii?Q?oL/Ahv5urMZAxrwAzPz8BFgzIl5IGdXO+zsT9zUHlKN5baDMzi/+wH9YPWn0?=
 =?us-ascii?Q?pC3ZXl53PH9g2y9n5g+gmbvCW23fBQr6Z7TwM26YyQzUlBtzAsUk6FpbRnpv?=
 =?us-ascii?Q?AIGqoqqmk1oKvFOuUfWyA4ZPKG/q0Z4x4iUdLS4WW/mXh2rzasBnUZAqQ/9r?=
 =?us-ascii?Q?H2m0cVolk3s5o/7Ep010oUv+QCP+E0raMrTgPu/d1vM3fUFF2iQhxH+QK7qt?=
 =?us-ascii?Q?I7eBbhjYj8zhH1bYtGHI7q3Fa92dSDgivuoJXXIga0IIV3B1nOnlGJ+1m3Aa?=
 =?us-ascii?Q?uvapQJTtpNmqZpXj/aWwVBPz9Dnn16tvrxTEaXFh1T3t3KnRakYkQbfLLO4w?=
 =?us-ascii?Q?DKYfL0c3Ejtn+67JCmtAcVFimX+H8OXjIDZb1lWH3e8s5xoBRUCcb42gEu01?=
 =?us-ascii?Q?rWldziXyvZlyijARapAIuo/4Qe0mL32hmGT38pPPC0s2YfULiGdUFX4LuqaV?=
 =?us-ascii?Q?0jupuGZiC5tj8YNbrKYYMwkfdLmU9xLQYOUcZMZZr95S3s7S5dZc06R4CU/B?=
 =?us-ascii?Q?YOOdNFjW1Q3eed33ZkI1PtsSSYpM/dnjvtcFuMnkXAYMIUw5mtqHPAxed7Nz?=
 =?us-ascii?Q?KiWeCbO/CrIAaw0N6ta5n8CzRaEy8uTDfAJzJ79lfcORqNfNKbLh//EcU4Tp?=
 =?us-ascii?Q?qdPrRw8ctVdHqxGWB2wtDtDp/QsZSKgTyoBuX8PwhIShiNewvoLL2a8UGtcN?=
 =?us-ascii?Q?VOKzKYi566h1CgMMmdNdFlBR3stpD43npvKiCPpmhSdrEm0qgw0aobe/16c5?=
 =?us-ascii?Q?6wOLzjplyo6B1syGkUNSG26cphULq6iQPXiQO8MJ5GW8cR4hHTBrJRP/AKOj?=
 =?us-ascii?Q?c6QuRu3kYtWe4bsjC7cNxj24L4FgiDFX031hDwTvjk6HT/lDIJuJcAz/x34w?=
 =?us-ascii?Q?oUDM4iNtkohOrYmY9JAaohr9kmA2motuaKNVVqsxqnPP9PtTLMpPnAusLB+g?=
 =?us-ascii?Q?SUpHA2zUSr23otlsoTBI/PR5EhPHwsQbvruOo7Rq5bdYfm+xrr4Gyz9+HoHc?=
 =?us-ascii?Q?CsQdtAzttI5SPvl7XIBwM40gBrVTh8LSI8JiI1023AUA?=
X-Microsoft-Antispam-Message-Info: lTW24oZFfuWvQDg0PvnseuiUYgC4+XkO3WjO8ZYn6gS98yknxFKsM+VMmVHsXv3kyNic+THu9iHQdsUaeKUfufxY0ZEmnFs6LwJmbAUZUpZavTGsWo7sqCQVr/v5t3u4fNLdIuJRz7L6iaAlY+GKPZh9tvPcKNu9Z2vTDmn+rU8DriT+xt9ZIj+9kmbqViqV
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;6:DwnMqPHfD7RpCzOPpbd4RPZpvYxbE9Iy8C115f5xqYKuIGUZjoHNXkmAyUSCo7UxtCw9g2HBOXRl83wP88yJ14QF9ApatBYSGXPaZi9pGTA5YB6dxw+DEmcawkWfTjCc8jX1PNLpP8GJvmyFn39PB6yCRbiQUDjiOCskEsmPoA7ukPYrpqRE44+C9x2qsBz1rlONxBAIZd6Zukb/NVTCl4sCH9NOmNvgkFFG/VlFPYjbfrXejkDewAsZ5vyQWl+VzILMll23eOJdh86vZM1Vr0Lg9TviovQZnEK5K3wpGO4Ok8Bzii3lCY1O46q6LwRTBJbDK/b5+gzzdPAGl2MYBYeTlf9FpJiUbuFnDi3EnmPDVI5oGf071bgfo8T3g6Su0UggeBq401Ua+x24Rtrro80MF9hHncY+m85Bjt338Bk6epVtDCysq6+VxBq6j1WBBkkobP+yYaa00LaeTqDB9g==;5:1d0hUnua58xLNv3Gsx1D3Lxxu6DqRPYGIxSzchyIXPn6eUtqmqtCZtiokYN0Q5e3iZd11Aa7MFTztZUJtVDlwEIOsaop/o4/YnL+mEwLJO7h8E/otGlDS/am3JajJtQoN3Xz5fQdraGeUFs/UUJoNO0JQi8OWxxBuR7NVouUDR8=;24:NcQbbS1OB77zgR6QFW/sJEK8ryXucpHHt9u9ONS5ujKFaFUskAdKCwU6/vUeHXLUXZ3ggfzGbVn+x3Jx2aS+CUOgR2uIZ7f9fN3wMOqPHTM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;7:woXB+mGQVKqQPQQpF1dG8e+WtSsQpyXwpdL4Yui90oq0CKR9A7SvTqXzLV0oVl7R/rZtL3KSr6FaYase07drUA7Luq/3io/Amv/NrFc3/aUcWyL6JG/Mv3O/UxPIDfgQw3NJI30W9VPie3cyqJmxjJJ8WD1TCMFnMmhAYKwvV9JInCxzZjHw7taF1U+1bsZq6lyTLNnEo+xuamdl5ko/L4/qGErE8od7FxjZSh9mCAtouU3bbHKYnuAlCCh5tZwI
X-MS-Office365-Filtering-Correlation-Id: 33c2bcc0-a3a9-45eb-6017-08d5bae950b1
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 04:55:55.6272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c2bcc0-a3a9-45eb-6017-08d5bae950b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB744
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for the UNCORE PMUs on Cavium's ThunderX2 SoC.
The SoC has PMU support in its L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 Documentation/perf/thunderx2-pmu.txt | 66 ++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt

diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thunderx2-pmu.txt
new file mode 100644
index 0000000..7d89935
--- /dev/null
+++ b/Documentation/perf/thunderx2-pmu.txt
@@ -0,0 +1,66 @@
+
+Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
+==========================================================================
+
+ThunderX2 SoC PMU consists of independent system wide per Socket PMUs such
+as Level 3 Cache(L3C) and DDR4 Memory Controller(DMC).
+
+It has 8 independent DMC PMUs to capture performance events corresponding
+to 8 channels of DDR4 Memory Controller. There are 16 independent L3C PMUs
+to capture events corresponding to 16 tiles of L3 cache. Each PMU supports
+up to 4 counters.
+
+Counters are independently programmable and can be started and stopped
+individually. Each counter can be set to sample specific perf events.
+Counters are 32 bit and do not support overflow interrupt; they are
+sampled at every 2 seconds. The Counters register access are multiplexed
+across channels of DMC and L3C. The muxing(select channel) is done through
+write to a Secure register using smcc calls.
+
+PMU UNCORE (perf) driver:
+
+The thunderx2-pmu driver registers several perf PMUs for DMC and L3C devices.
+Each of the PMUs provides description of its available events
+and configuration options in sysfs.
+	see /sys/devices/uncore_<l3c_S_X/dmc_S_X/>
+
+S is socket id and X represents channel number.
+Each PMU can be used to sample up to 4 events simultaneously.
+
+The "format" directory describes format of the config (event ID).
+The "events" directory provides configuration templates for all
+supported event types that can be used with perf tool.
+
+For example, "uncore_dmc_0_0/cnt_cycles/" is an
+equivalent of "uncore_dmc_0_0/config=0x1/".
+
+Each perf driver also provides a "cpumask" sysfs attribute, which contains a
+single CPU ID of the processor which is likely to be used to handle all the
+PMU events. It will be the first online CPU from the NUMA node of PMU device.
+
+Example for perf tool use:
+
+perf stat -a -e \
+uncore_dmc_0_0/cnt_cycles/,\
+uncore_dmc_0_1/cnt_cycles/,\
+uncore_dmc_0_2/cnt_cycles/,\
+uncore_dmc_0_3/cnt_cycles/,\
+uncore_dmc_0_4/cnt_cycles/,\
+uncore_dmc_0_5/cnt_cycles/,\
+uncore_dmc_0_6/cnt_cycles/,\
+uncore_dmc_0_7/cnt_cycles/ sleep 1
+
+perf stat -a -e \
+uncore_dmc_0_0/cancelled_read_txns/,\
+uncore_dmc_0_0/cnt_cycles/,\
+uncore_dmc_0_0/consumed_read_txns/,\
+uncore_dmc_0_0/data_transfers/ sleep 1
+
+perf stat -a -e \
+uncore_l3c_0_0/l3_retry/,\
+uncore_l3c_0_0/read_hit/,\
+uncore_l3c_0_0/read_request/,\
+uncore_l3c_0_0/inv_request/ sleep 1
+
+The driver does not support sampling, therefore "perf record" will
+not work. Per-task (without "-a") perf sessions are not supported.
-- 
2.9.4
