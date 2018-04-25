Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeDYJCO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:02:14 -0400
Received: from mail-co1nam03on0048.outbound.protection.outlook.com ([104.47.40.48]:58525
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751408AbeDYJBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:01:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com;
From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Will.Deacon@arm.com, mark.rutland@arm.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH v4 1/2] perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
Date: Wed, 25 Apr 2018 14:30:46 +0530
Message-Id: <20180425090047.6485-2-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::24)
 To CO2PR0701MB743.namprd07.prod.outlook.com (2a01:111:e400:142f::17)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB743;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;3:OK7oHKQ8y0aU4FUYgqZf+KcIYM7VFnGFxWX23AUvvN7oVu+/mLyU89ovcyUpotgzJjm76+Gv8h0tt22SiMMYbQeWxPXH/Qy42yLGtacY2c0DsCP1fr84sS2kUKcxXQuhzpAjRdTcMKpeScKoaYl1LUSn8T8+wq86ktbvmI1OvbflnKqO/YSBDoTXgn61PV37wYG0L3BOPh+FVJHosUG9s04zcoCRYt/RewiAw6yeA8jBYErY9hj/A0pv6Ga+pRCl;25:yQgKRndqJ0eKGl5LtUtv3B3luLjB/8W1qBiPRYQ2JKcYCB+gQz5XJg80JPsKhUh3ALpPUyrDKKz0KpYIlIr6ufsiEzJHnj+0Qa6Y7uI6IVLPYiVaYP0qoA8oOSkcwX6z9FZH8YYUIxi1viyLOsjTEvL2S/SswgU+NLsR68L3YWAWVLUcmiH2BK3YZfW2IOJ3sAQp2wNuIIO3PtImvjjoltIg7KvG0dgAsLBw2IpeQBDV5tAfbeW6COYSsh/oJVa34rulw0leQWCUSflBCAId7Oio1Mu3cg2X90nMxdsZYwH0mrgZFDEY7T1cB7IQAg+sW+NVYizgwTKmAaJ0Hj4jyA==;31:za1MYMxOq7uzhGrO3xFaepgOU+inVAgarKIRcHRDYzuyX4zQJHyT6uGgN1dUrxnHXjCSeJ5H2klhJzXO4slZRota/TNjdRKKlhKzNv6N/Xc4gyPTLxiDCC/rn72HXn2ISAU1M7JpEvXjYE3kFcyzcoqAtBIwjaEyVZLG/KPO7CIBhROqsBENapoEftxzEfQ6wK0b1jnud8OiFsXVryOqVPM0VWF9uLCjXP1JU8f3g3A=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB743:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;20:vWL162hIu0LBbGsjn5d1mfDtl5wqESH3w6yjVfIv5+iHD17VVKWcqnM++LsIjojecOVQlu2K3lDvrOWXV9cljczR7yozdzd1LfFSJevKgK39wZZRvNiIpdGoE+Pfnp5l/t/wvZ/OYr1NgdkWT2BFtm/na6hzBj9T9w3u4T5nZWUlLWl/Ea89Q3E0O0zvHjVgsbudq1P4kwbesu/TynhZwloST519+ElxsWXAsQ8JKD7eABkTtDCuZg9z4GODccONbOzpnjgzh5swSDK8XA6t3VF36e9kFmX+AKuybXl4dADZtOha7/hTtvvfLBSeFH6gHxj5WmCDQLLVj1ygncJeIFmuXhYfWqAsStL680j5GYx8RQUcNLfWfFXj1ROLhZni4kmVWXzhqDGLo2g6CTAfG7NuAwfQ/qjQllI9gTuqfkgYyvUj04ZZ2BUqBYidIUbAorM6qLf9LmKaebSoAlCO9PXhUOQgMMB1o+9HyjuLsnTrSBaeDm8IRseNO8TmB8kv;4:P5TFwMgy6wfO6hu/bWoa430rhkJQExPg+9vCMWvlEqgd7g8yYqkQtEolCeVNEnZj8lJw8kBqpj6YBUxsH+Z7guWXBw8NKKROSb8opayi2Tka8NPNzMJmW/wzrvEKCJWUk8twH4xFtp6SHlB7i3Kf7F+WdgRun0C2U+OObjb+yz/6/9RMQXlw/iMRPKZmVxl2vIBRqcQPWYJ/G9jhEd4zO76nIsMIUnrnroeq9ArtOXuQvH+I+g0XDi7VvY0PwmMXnRqQuqKgGePszaa9qhTU/vzN5+tAXzQS7G0SO1fPuB3JEfRqu/mKitV8uXiulRiZwpkP6gRX141sWss06sBu+DQGsSudVUqrn4HWH38rVDM=
X-Microsoft-Antispam-PRVS: <CO2PR0701MB74357E6248B11C7F7F4048C838F0@CO2PR0701MB743.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR0701MB743;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB743;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(8936002)(50226002)(7736002)(1076002)(2616005)(81156014)(478600001)(72206003)(5660300001)(316002)(5009440100003)(81166006)(6666003)(3846002)(305945005)(76176011)(105586002)(6512007)(50466002)(66066001)(68736007)(6486002)(7696005)(6116002)(59450400001)(2906002)(97736004)(4326008)(25786009)(11346002)(386003)(446003)(476003)(47776003)(86362001)(8676002)(106356001)(956004)(53936002)(44832011)(52116002)(6506007)(486006)(26005)(16586007)(48376002)(186003)(39060400002)(51416003)(16526019)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB743;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB743;23:/V0CCiJTLxioBTlRMbUajyOhfnlalEylPWlN13vb?=
 =?us-ascii?Q?SLmh1mlRRH3K9nPDiM8gmls/+kcM6iZ/SZpwbRB/oTiwmZnMq68FlEzU+uuK?=
 =?us-ascii?Q?WykPdsa0RFby6d0vhnQaTTW9keXzeXEnDZqqk3GRRphqh4rpv5OWtgY+u6lD?=
 =?us-ascii?Q?KnZ3t0JtGDtwRBIJPw+4h1mzt+BOoaR2AwTRyiO4bghWtLFBwt9s33/BnWch?=
 =?us-ascii?Q?lse90fI+jlYVhivelnBLJPGcf0A9AghFVAZW8zsxF2XUf4EIqKkRZukz+NVL?=
 =?us-ascii?Q?rwvEveLVC3HWIk+Q29YMT8DnJGBuJ6xOzyVAS5xQlbtxu4VxPWf0mTkWDOj1?=
 =?us-ascii?Q?NBwWCdQsHtp6HKJE603/U9ZdeNo+IUgI0FgMreMOVOpw93z8o1bpuWjPla5U?=
 =?us-ascii?Q?uw+xf5Q866olMe0iCB0pYuBb5Z2ltalyl9Jj4g6/EjyMZZ/r13uuw8l2wpGa?=
 =?us-ascii?Q?mfhFLoVYaw1aiVeWPNU7euwp2+6aKjqkGjk6pHdP6mc1/EBdZbfUd/CBRzy5?=
 =?us-ascii?Q?NW9+6m67YsfFKRj+hJ8PKoVbsUugDgYi6iA757HJ2kGTRK/4YwwYvJL+KUvB?=
 =?us-ascii?Q?4AAyntlGCflbB8AMPtIPgzzW4xMw2s4nBJpEr/J+BbHeTKXhXcPthVBewvl1?=
 =?us-ascii?Q?efvL13hri7051M9KwdODwlRo2CSFMXjZFI8JXAA+yOJNIAdkUziPTc3UE1st?=
 =?us-ascii?Q?dhjzNuukxysAdLZAa5QsorzJbptpznQ7s+jlYbU0wAqd8Iw5vDUBzHr035sB?=
 =?us-ascii?Q?e3bcfiOWHsSYiQgUicrpDnbsVVIvC02ilUz8w7HwE4XZ/hiVIhdA0x/2bf8h?=
 =?us-ascii?Q?C8yzCMPSLSzYgcYnQNSc5fWHdv8CZ2GpBpvCXCVWKuWKT8f8QKyK60PWjcqv?=
 =?us-ascii?Q?AIqV19xJgFEICyhZkIePWYOVuyrW/Ih8shIaIehq9kN7ovTe5QTEThV3AyAT?=
 =?us-ascii?Q?dS3qNJJSe/wmo0Wgyq09WFgjkAxWQvVftn5gRO4ZmRKeS0YjEtV/LR6Ug/NP?=
 =?us-ascii?Q?Wp8bGlZI0WfO4PXt8Ym9BngRSMBVtLNZto9qeNVZ88o6Jz8oVk7RC1aGZubU?=
 =?us-ascii?Q?Ny6FK3PsNiLe/6Hfr8JZ9qs+F0RyU/vfXXhBieD1mw4kYWhybK8NQZkEEaPn?=
 =?us-ascii?Q?VpY55l/BsXpHvPbwc38GesA421hF8DVHZQ1GeROyY8hrOH4QU5ZZE2xzQciC?=
 =?us-ascii?Q?CPXnBGYKgUtkvAfh/B1dgxFnopP2uXE04mu7KrI7XPunAUR1TRp7u+rYp/bR?=
 =?us-ascii?Q?WrgMxXGWKbOyaBxEkvrtSpJ5K88zf+bXBnhe9mHvuyOuAeAlufZc/ZdYbNH9?=
 =?us-ascii?Q?TK30Bc2dII2o8PhBYM2jPZsklPt0q/1TlK5qTG/klys5?=
X-Microsoft-Antispam-Message-Info: pkXWsjwCJiigWopUJVQBTE9/yatXl063RXaM2Q5Sv7udTT20soTUHBPvsoBAa7VAsd4pZXkzJfVGhWUEuCGFzuERJDBTSTy4jie4CA5IRDpsZpEiWM0xSoXW2x9zHkSOZinIQloTAJYgE2MOmC//silh/d95NZJUK1rS11wolByS09w9IKRERovVNEsM1a9L
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;6:TQ4V2q06b8x98NeMTdO1lu6oqvNTEYxvad1+yIYZx0g1Uoh7jYzumT8DWfc+IwNuYui3uffak3h1MkFspX0sF/2NttKtpvrOcLCSVVWjeEf1xdlPypwHnxkeTxGCy+bQOdy58o8PsO6hkscR8pxuuCOe44Eszu3NM75jbbLNCrRj3w8XoXdUqMeoxnm+x+fW/50I7X2KUwQjMqU3lVcqITdFoYuDSVqcElH5Q4wGYjfKeDodWbEebEkDZtHZX8gSLzn1oHjMvjeRn/3LsBO2IzwuQqjFD3pcKgGntV6DRVERQfsEv0JepAritbpNB912D67mj3ay9T3N1Nyuv//5GkLgzbpmzwxkBspEk5BOYuVAB9c6inTm90OlQwXNQLl4DcF0PsCbA50r5SCAZTYdIs5V2G5/scADVI8yWp32kbljT5SQmZNWEBywn21rpvLK5q0PVZJehZyqMmI3Yp8Olw==;5:nr9Oic3xe5kby3aHWlSqa7Mb4mQK1q6hQ8kn3moDvxj2Lp4aiqsQsR1xDmZD9QAxl4J35ItJT+pSbfajSOI6AGwUo0kTM4JKFJcgQ6MeiFkOhybcczvKDQXGnjszkKPdEV/0+1+yG3EWdC3OGnKd0jgwcvs/uD0AqbeTSE0BSMg=;24:lsvcCWo4+B2k4xVW3N1WvyxbnGVPMeISXzbdu8LheQEmPcKSml4/elBq9LJn9t3d5+uVG6PrBm+pMGEtvGWuUQ5CyQEWPftuaJULaV1LxnM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;7:jDFGaaUPy7WMCBdS2iqkv1ORG3WmO7TwWlJf564zXX4r3kHZcNv6QxwJt27ufttGRmFGPbeU1LOgUK1gPAnLQyI853z0+lW8SI3AvdX5vSEteCBMswNSIItD2JEvd4MN+MoSsKYBoeXDyu3/1eO+2V/zmP8f8lb/SOzfNAoOLuVVh5mV1cmuICVyZF+Yh+j7oWHQ+LtsB3dhqKUyljIR6q1kiX32kO24e60ldswtTjFPbMRSxXI7LrlVibwfEryY
X-MS-Office365-Filtering-Correlation-Id: c21ddf7a-67d8-4801-21ed-08d5aa8b2303
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 09:01:27.2690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c21ddf7a-67d8-4801-21ed-08d5aa8b2303
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB743
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
index 0000000..9e9f535
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
+Counters are independent programmable and can be started and stopped
+individually. Each counter can be set to sample specific perf events.
+Counters are 32 bit and does not support overflow interrupt, they are
+sampled at every 2 seconds. The Counters register access are multiplexed
+across channels of DMC and L3C. The muxing(select channel) is done through
+write to a Secure register using smcc calls.
+
+PMU UNCORE (perf) driver:
+
+The thunderx2-pmu driver registers several perf PMUs for DMC and L3C devices.
+Each of the PMU provides description of its available events
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
