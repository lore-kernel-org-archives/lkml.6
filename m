Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCWTLV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:11:21 -0400
Received: from mail-dm3nam03on0060.outbound.protection.outlook.com ([104.47.41.60]:23465
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751843AbeCWTLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:11:19 -0400
From: <chinnikishore369@gmail.com>
To: <p.zabel@pengutronix.de>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Nava kishore Manne <navam@xilinx.com>
Subject: [RFC 1/2] docs: dts: Added documentation for Xilinx zynqmp Reset Controller bindings.
Date: Sun, 25 Mar 2018 00:40:59 +0530
Message-ID: <20180324191100.18363-1-chinnikishore369@gmail.com>
X-Mailer: git-send-email 2.16.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--9.535-7.0-31-1
X-imss-scan-details: No--9.535-7.0-31-1;No--9.535-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131663058761201752;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(39380400002)(396003)(2980300002)(189003)(199004)(4326008)(87792001)(426003)(110136005)(55446002)(83322999)(106466001)(51416003)(50466002)(105596002)(63266004)(8676002)(48376002)(8936002)(81156014)(81166006)(73392003)(36756003)(26005)(87572001)(6346003)(9786002)(336012)(77096007)(107886003)(86152003)(498600001)(16586007)(5660300001)(2876002)(76482006)(1076002)(2906002)(305945005)(61266001)(6666003)(356003)(47776003)(2201001)(86362001)(82202002)(50226002)(316002)(73972006)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2531;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT039;1:QanSaa1cOIwsrbYTRsHdfRkVVctHlziVz8hQd5tOU4df5QG4cvXvtDTvy6J+WErTpl3wAifFnwl2d2JKa8yeIe3dxaGv3CfxRop0EtSavwPQ9ACYD+qZHHrGyBWF6Sg0
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b2274e-f504-46b9-6a27-08d590f1d9e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR02MB2531;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2531;3:VO4CbHvB/HkrTd4Bg+NyAWG6K4cLyy7MgqfzpClzgrUmqy0Uo4XQs1IPWpHoImCQ0CoUyaH2zzZHhZS3rnWkiqQWjTEKMe0Ui/pzr0lGEKtVuw1pHAoBjhb2c8VVsGVG16yRJnFS3r8MiH8S6a0jGL3hQGPkydf50K81pZJZgQjVVyv/kj19osacrJwVfMYQNWfTeMxWv0nhF38fQBgC2YaP0r/HbsBmi2IDVBShCe/R6GhwT2SxmB1UkYdq4Xd7W3cHkCNxG1zCf3t8R4mzI+8xQCCsXDlLSWBl7RJt+tdZLhAVDZdV9UM/2ostR0yU/bC9Hi/szdJ56oBh1SZ+764hH+pF249pRsIwGcWXf/8=;25:GM5+vdqoHsYRLqBOy3qxtTsYyVY8KIOp7qv5Lj248vZG80GSj1xydvs9IrXg2caeB+CPgBi5wryj63dxgv5PuGUNNW/IspKtpIb5AlBLpjMdTyQNKoJKf9O9z3Z54nDgHobsaC4xOyHmoNikuRmMdOdmBg1bjrHZUiTd+D0yEr1QEv/fIXiXa+VVkqvHDYtDuUdhJtgccZzA4l0dIHAfdBroeuCV8V4MDrPiZHuZX2UNocp7iUcDZe53GI+PnstKoI9lLKBELks3Qmc+LqfGPbBWdbbd/EhtBGEgwpW6P6fz6G56ZUOi/yJ5K5IX8qQpW2TLJKMe8rCJG9EsQ7xi9g==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2531:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2531;31:VZWqsKjDgoumffFkk3yRddagyj18V2vC1VovwUbDDyPA6CTqtZw0PC7hxjr1mT68SP4cLM9eHbxVBgvK1S7sctpygDOF3cyuzKNf+UCVIT3JLKTIEzIFPv1IWFzn6af4QiWueJeyNeFhsHBvx6/64Cukm7dqVY7HYI2YCNE0Xvj6/uV+hv8t1rebz9vEKJPMh8cz3xTL2nFbc/4FTgvYHT5dEg0C1wzd428c3/87uFg=;4:tqzO6R0dB9kPKhAYdwB3/qmaU7OS1lkB6omOsNwd7yflfSiv1xiE123GFF/Mo/SDZXDJHK29Rz0saVRpaF5jFsmZC1W13aAbztm/rC5+obJGBaDoHX5wr2fpcO7Efk+iQDtpOqfhJ4+l0iZEmDqtLFcNjulTtaiGVvcla6H/AIo+slyMs+jcVD7tbT7wSFel8VzaVkEMC/40fxDR1i2YiErWqYRLP2KF2KFxRc8x4nkZotsHZYXmWKP0o344XTcBSDwHZ2kPKVwOR1b0b6uM0o3bMXlioXmwzo5uqM/3SGE58fmRzN+d48hxPS5yNKylqfcrjWUEyobfRH5B70v08fEQ1XnZ4yfMax4wcNjb4a4=
X-Microsoft-Antispam-PRVS: <BN6PR02MB253114C968DD2791B02FCEF38DA80@BN6PR02MB2531.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123556025)(20161123565025)(20161123563025)(201708071742011);SRVR:BN6PR02MB2531;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR02MB2531;
X-Forefront-PRVS: 0620CADDF3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2531;23:wUQE33qIQNsZPBkYk/7X/BciIIHTcCo0kj9HiYPUf?=
 =?us-ascii?Q?8dpY9Jba5a4o03j5JExqdyKoKNNwe8g5Jp8YhFMBi4l36x9fFdtOs2E9/+Z2?=
 =?us-ascii?Q?+QuGZ1FyHUxn2MvcureRYQmRamU7eNr4RgGiMo1o4V3nSvzc7l1OZnUDqDHU?=
 =?us-ascii?Q?U42fDoRmhUDpt7cjCsMxVesIBPG+ibx/19psGlHz4fKEf5f1bTgHWdu8QYL4?=
 =?us-ascii?Q?3/W7cHtYvtzYVqMhxnqbOPvfwqtGiqrxmM7DLLmXZkLBfYe0NOcuo6D7rgwC?=
 =?us-ascii?Q?Oi+bF54MNpn/9XqIdtIyj6rpjoem/vI0vYynnVgZ/Yf3uzBEHwGVr1jUjsl2?=
 =?us-ascii?Q?/eUzlTC8At3uuJiZ+8DRHBOSk2Y7vBa9EPzK+J0g/+uRLV1xsB3DqIKG3a+c?=
 =?us-ascii?Q?Gi6WELs7ULNbZ2CydyTx7G/ezw8vISyRh42sspWsWES/VvI4XzlP213oHano?=
 =?us-ascii?Q?aEzLdv62LAkQiDy96irxWvAMBrulpY4Dg3/gN4/0kY43pWpuW8Lsro/7zIja?=
 =?us-ascii?Q?HjAqBTYABbY0n2++XgbA8+19+O9SvYiqkjyRX6sDnQL2r1eS0/uUPbbLE3En?=
 =?us-ascii?Q?Mv3B4teHpY9Pk8P7TtyqnjgaT2NM+skJhxTSdMmkNMpBSAtDeU11A3wyOz9o?=
 =?us-ascii?Q?j0Pde53154JOlfvDaQsxIJsCH1JdL38ig2cCYSnRW8G+nZsKeQFxQB/qFAe0?=
 =?us-ascii?Q?InnHtpQiDv37XZh8iB7GesdiyBYKQi8xjZVVWxqf3KtQHa/lY+XS/X/sGdnt?=
 =?us-ascii?Q?Dodd9+h7YTJpFYVxtUwtnjj1GhnvX4CZLoXErzv07OgbvD29HTjjq6Eaavd8?=
 =?us-ascii?Q?+luGTf5cBHza3wD+0lDg9FSZdFKRXM3344lVsaDsbR6VvWqJpBv/bTUnxSJO?=
 =?us-ascii?Q?/SlwKplGrJ7V+EUq6hMlNaac8JbI77IKuJLOUY02lrk/YdPsK1OynrBUhk77?=
 =?us-ascii?Q?qf1TlB5YJ4mJFmAdIkJecNI6skr+vkXuOe/q3Ba0eNKByPB3wlrl7XF2FPgm?=
 =?us-ascii?Q?Qh11BC12Pkjc4nR7mIeRQTnw7yQJcsd9K423lhXkAJcsNK/d3wLLkqKI9RC5?=
 =?us-ascii?Q?ldtYzR4Lonwg9CrSdor/V84UJeTo6tasucwmrp4Hp2kRwRJsmQH04dbQS2oq?=
 =?us-ascii?Q?PT+boaOcfRVtw5qDkP6SftMmCT34OvEaQRcRMwhmjba4Q/OF3+5z/nUp41PF?=
 =?us-ascii?Q?6zo7rzAJi9kig0PzIRrXDJB2BvX0FdI6PTIjagWDHdErY4j92sA2LVzlkjuM?=
 =?us-ascii?Q?s1HaWuahX93F78vJV6Vr/IlaiRJ/hC7D/ikajqJ?=
X-Microsoft-Antispam-Message-Info: coUTUZ19wtO5dd14cTwG15t1gTX9+EZXvbcrh01DWLXUAxTAYa5iRf4Zo8EgVeejOg+roeo69nk6MrQNyAouUFrNnhoti+k1SQcqjyWNnHaDIIYTKgqUiNN+JW2LmIaqJkdGDSeiRZDjMS1wgnq+J0bOT62yKIRZ4g4u3CCOpwhc+gRUI87XzhdZZpf+Npek
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2531;6:Mxrywb+5UtUusz8sWMWkZdK83cGjLhhZOfJieCJ5g9tIfUTlRr06B145uhPhXqimRV/UY3zJ+iDhy6PbxvzauwcMWZE1PGXS8OnfqDWy97W5MS7hNmD/Eo0kPllT6RVmKYqrIpVsK3hEGMi17yqWlzGIqQ0OZHQGsGVKFtpeihsjbX8h+AFWMRwn1Da0eraV0EYX3ZwFySYSoNrJja+7LH8fdhX6R5FW2kpUfXPlaMsosyoKLvi6D9iMPNVOVJcLnw1jOqGFlkYZRjQdrd3DKja3gJL5JxGLBrfekjP+jO6CsdHS3012PZONl/uypp4nMTEX4XMKQCVgf6CUWQGkxHVMnmpNfwmkxPY0izySDtgpusJjRYylz4uQzBeHQ7cSfOiEeEinJ5ihrVXK6d5XXVGnYky6ZrrFG7ulLFthvL4UpZbrDXmCNlDjFq82gzVqsB6ODt99JDB8sL6oB9HsNQ==;5:btw5hOQJHamle1WfduEbP570i6EVyeUY+so8uZfVGy82dIv79o8O5GrnCAK2BsKCab27+BPQwSwHYRoVV7oTyYv6c71iyklznqmR3anbIbJtFC6f4HN0db8UTJ/rRxW9AOzmqPPjKbC2nQPACS7iwYWfj9wbl/x6eNaobbplNw0=;24:eEFW8pwhVOw+FcaAClNtT2BGyFhu68rlEX1EE2XzQnVYXtB4gDEwKpWugd6cWHsIuS9HOfdus+Qixi9w6Yn9o/AHgoMY4qhKnsnvXGIO9N4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2531;7:CbZP9t+aNlccDvD4FlW44V7AR2S/n45R6AfCHY0Zy7oa25plWBXEIbbHvnov+yHLLp4qUgnFrQPiLzhiQzvOZW/ftmm4TpxbrzCt0Mb7dYAVh64QOC7dNkGtoTnPZ1kJ3RI22+IFzge2nWIF0jjOWhp2ZuPufIPEVJAbKBXRSYQ3WtchnCnVf439+lpDng1oMNNs1ohBghmKwcZ5wfyNoXnL/hB2iCEBanWs0Bg7XI2nPSeaAgXdps4zqBzcI6rX
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 19:11:15.5264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b2274e-f504-46b9-6a27-08d590f1d9e9
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2531
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <navam@xilinx.com>

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 .../devicetree/bindings/reset/zynqmp-reset.txt     | 142 +++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/zynqmp-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/zynqmp-reset.txt
new file mode 100644
index 000000000000..161bbf5d1cae
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/zynqmp-reset.txt
@@ -0,0 +1,142 @@
+Xilinx Zynqmp Reset Manager
+
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible: "xlnx,zynqmp-reset"
+- #reset-cells : Specifies the number of cells needed to encode reset
+		line, should be 1
+
+Reset outputs:
+	0   :PCIE config reset.
+	1   :PCIE bridge block level reset (AXI interface).
+	2   :PCIE control block level,reset.
+	3   :Display Port block level reset (includes DPDMA).
+	4   :FPD WDT reset.
+	5   :AF_FM5 block level reset.
+	6   :AF_FM4 block level reset.
+	7   :AF_FM3 block level reset.
+	8   :AF_FM2 block level reset.
+	9   :AF_FM1 block level reset.
+	10  :AF_FM0 block level reset.
+	11  :GDMA block level reset.
+	12  :Pixel Processor (GPU_PP1) block level reset.
+	13  :Pixel Processor (GPU_PP0) block level reset.
+	14  :GPU block level reset.
+	15  :GT block level reset.
+	16  :Sata block level reset.
+	17  :ACPU3 power on reset.
+	18  :ACPU2 power on reset.
+	19  :ACPU1 power on reset.
+	20  :ACPU0 power on reset.
+	21  :APU L2 reset.
+	22  :ACPU3 reset.
+	23  :ACPU2 reset.
+	24  :ACPU1 reset.
+	25  :ACPU0 reset.
+	26  :DDR block level reset inside of the DDR Sub System.
+	27  :APM block level reset inside of the DDR Sub System.
+	28  :soft reset.
+	29  :GEM 0 reset.
+	30  :GEM 1 reset.
+	31  :GEM 2 reset.
+	32  :GEM 3 reset.
+	33  :qspi reset.
+	34  :uart0 reset.
+	35  :uart1 reset.
+	36  :spi0 reset.
+	37  :spi1 reset.
+	38  :sdio0 reset.
+	39  :sdio1 reset.
+	40  :can0 reset.
+	41  :can1 reset.
+	42  :i2c0 reset.
+	43  :i2c1 reset.
+	44  :ttc0 reset.
+	45  :ttc1 reset.
+	46  :ttc2 reset.
+	47  :ttc3 reset.
+	48  :swdt reset.
+	49  :nand reset.
+	50  :adma reset.
+	51  :gpio reset.
+	52  :iou_cc reset.
+	53  :timestamp reset.
+	54  :rpu_r50 reset.
+	55  :rpu r51 reset.
+	56  :rpu_amba reset.
+	57  :ocm reset.
+	58  :rpu_pge reset.
+	59  :usb0_core reset.
+	60  :usb1_core reset.
+	61  :usb0_hiber reset.
+	62  :usb1_hiber reset.
+	63  :usb0_apb reset.
+	64  :usb1_apb reset.
+	65  :ipi reset.
+	66  :apm reset.
+	67  :rtc reset.
+	68  :sysmon reset.
+	69  :afi_fm6 reset.
+	70  :lpd_swdt reset.
+	71  :fpd_reset.
+	72  :rpu_dbg1 reset.
+	73  :rpu_dbg0 reset.
+	74  :dbg_lpd reset.
+	75  :dbg_fpd reset.
+	76  :apll reset.
+	77  :dpll reset.
+	78  :vpll reset.
+	79  :iopll reset.
+	80  :rpll reset.
+	81  :gpio_pl_0 reset.
+	82  :gpio_pl_1 reset.
+	83  :gpio_pl_2 reset.
+	84  :gpio_pl_3 reset.
+	85  :gpio_pl_4 reset.
+	86  :gpio_pl_5 reset.
+	87  :gpio_pl_6 reset.
+	88  :gpio_pl_7 reset.
+	89  :gpio_pl_8 reset.
+	90  :gpio_pl_9 reset.
+	91  :gpio_pl_10 reset.
+	92  :gpio_pl_11 reset.
+	93  :gpio_pl_12 reset.
+	94  :gpio_pl_13 reset.
+	95  :gpio_pl_14 reset.
+	96  :gpio_pl_15 reset.
+	97  :gpio_pl_16 reset.
+	98  :gpio_pl_17 reset.
+	99  :gpio_pl_18 reset.
+	100 :gpio_pl_19 reset
+	101 :gpio_pl_20 reset.
+	102 :gpio_pl_21 reset.
+	103 :gpio_pl_22 reset.
+	104 :gpio_pl_23 reset.
+	105 :gpio_pl_24 reset.
+	106 :gpio_pl_25 reset.
+	107 :gpio_pl_26 reset.
+	108 :gpio_pl_27 reset.
+	109 :gpio_pl_28 reset.
+	110 :gpio_pl_29 reset.
+	111 :gpio_pl_30 reset.
+	112 :gpio_pl_31 reset.
+	113 :rpu_ls reset.
+	114 :ps_only reset.
+	115 :pl reset.
+	116 :ps_pl0 reset
+	117 :ps_pl1 reset
+	118 :ps_pl2 reset
+	119 :ps_pl3 reset
+
+Example:
+	reset-controller:reset-controller@0 {
+		compatible = "xlnx,zynqmp-reset";
+		#reset-cells = <1>;
+	};
-- 
2.16.1
