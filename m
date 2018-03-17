Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeCQHj7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 03:39:59 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:40592
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751304AbeCQHj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 03:39:56 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: imx7s: add anatop vdd1p2 regulator
Date: Sat, 17 Mar 2018 15:36:55 +0800
Message-ID: <1521272215-22514-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131657459945346405;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(346002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(26005)(336012)(305945005)(2906002)(81166006)(81156014)(8936002)(498600001)(8676002)(72206003)(105606002)(68736007)(1857600001)(50226002)(104016004)(26826003)(316002)(47776003)(97736004)(77096007)(51416003)(450100002)(4326008)(2201001)(86362001)(53936002)(36756003)(85426001)(48376002)(54906003)(16586007)(110136005)(5660300001)(106466001)(50466002)(356003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1617;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD015;1:rNTXaCnnRwmU2T6dJSvkXptUD0ibIVpGocxFCjiL3TDsM80Pwat8pGZaEZ4pIZN8xDmf+JkaOmVzlp9ONogo6uv5Hbn8r0SWouan49IQXD5qGhAby6faoMfKhv1hn3AE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c76e9ea0-e7ad-41b7-3404-08d58bda4687
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BLUPR0301MB1617;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1617;3:hoNo6nYUuB0o9eXpoRFLz4XKfF9F/+XmWLOKbwTzOHqZMIEMXcDfUjixifJ3n7ZPVwQ7Mci+/64Reg97u0j9ibC+KtcrJK98AyA4bKhD9IAVw3gQFL6UE02IotH+SC6pFMll+sVO8yTYYsRnL1TUnynFEzQ3q1KrYHct79IOsa5Kc8k6Gkgv/8MREODuewCmupGTAHIgtgTAcNlB8yw6q5XvbBbHNKAnvErBnTsV2tLWxaJ93CKP4dDWAW098YBzJzL5mHbiHSW0u8zZq9bScxq0bd8VYyh8ShqOTYYL7+GpCn5BrcVh8ETRpKMoLUVPCjGRz0wuJXjdLy30whHMAJ+0P13qyWdCU9O17tUABYA=;25:0P6Kn1r9VewYK9iDCLbFBrtjxqnYmrG6oadeCqXDYfza2xOjdHmkpA1Fgjc9EqnCJHowaQGjLdD9Pf8FY1whwOMvg2B6V7MmXzbh4YNahYg7KhYAn1caTBn8SVpFPoPk44NIh7Vek21cUwIiOpiPGTM11PiYXwQWU2sEya9QmY2DBv1baeSFoOziKCOYyb9YvV1H7mVzpDUhhxipVbFWQ9iS15H96fuFHUAUlRFlFl05OpQdmwYdWIlsJ2AitcH5JApyaQDlneo17Cu24iGjUcrgrkjyIV6nhVaDB9SImXazlKEQ3BVLLs8QXLjoPyy00Uwp2ZJIIMsbFVOzLJ+6Eg==
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1617:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1617;31:1y9aNkSHO2WpdJA8jJhER6NYQJASrlRzw5jgmhswENwCavhriT5VfThFAkVMeyM6lWBLsQ7TDMDVRUFuW37MVsgs2v4ak0UTCtyrACiaRKsyNNnQ/g9Ga//GzK/m0Wuz0yNpgxGvGvbkGrscpUmC8A97X4s90LKnpXRiBXx4grWzDAzCgSSrmc6oScIAVWEkodDdO5Oy0elM2fCzZjVE1r8obyKVFnO4gugvEHg8U5E=;4:cFQJGt6UMUkwdDJ8cheg4A3GtTq+DMm6eg0+Gx3tl1GqtlzCe6bKN54cLo+tl6bFm3yVfzVSxSPaqLTVPHj1Kx5w4n/1EKbXRhgEkNBKWKM9lWuJa6XQ4mjztrDuEqQBg1gPU8zp3GzeVGQRHhxr6gESjO7SPSYhbAkwsKdKZTsBUkGBaLYy4aJSUBGbU48LSNdlmDubMmLxB5R+znW1RuR282SFeWPlBHxpcxTYTgGkv8iPipLlOtMpqRC7fFtlgezkUXrFQ9OATOmYsxOmqMTDW7j8U2j7bQ08SFcK0wCHIkNGHup1gt5w2qBcED2l
X-Microsoft-Antispam-PRVS: <BLUPR0301MB16178DF2D78066FE1CBB3A0EF5D60@BLUPR0301MB1617.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501297)(52105095)(3002001)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(20161123565025)(20161123559100)(20161123561025)(20161123556025)(201708071742011);SRVR:BLUPR0301MB1617;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR0301MB1617;
X-Forefront-PRVS: 06141B80DC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1617;23:+qcpcDhpG+IL02Bp3KGQ1v3a6gnVmZ+ULiQCX3x?=
 =?us-ascii?Q?aEKNnRK30zKz2WyBtNdJ+TU0V6+G96f/QZgK50LHyJAhW8rSmpk72aziVl3h?=
 =?us-ascii?Q?NvzvttdAXKt5S/KjlwCKy2SFcwZwt4gTqD/cIfOuMMJ2ZCbYnDwZ+JjRIXlq?=
 =?us-ascii?Q?/HAhWp4SYoPSaPi5fnG9bWEbf6FG55HYEOD9tnD1uZ5KrPTzqzNfCEVIkRYf?=
 =?us-ascii?Q?BgOouKrhAryda9DCDbfjPsKpI91k7Tjdne4sE85XKnLPDcL9T2Q2fKe4284N?=
 =?us-ascii?Q?0ONA4ECgmc4yLBZTkjONtRXoTc2ooE8gRRutezm0MwsyJz6S8XpWx2DdDcFj?=
 =?us-ascii?Q?YAuXt8oBmCnF4KsOrEzJnwSVaLdUBW9hSXXX1CvlSV0mHiuQ+U9kLW5WUfzA?=
 =?us-ascii?Q?6U6eDD0WpIHFeRbHBrvzaD86k6Dp3qtvz0g9Ve6JiP1g67o313AKMdFRNWqK?=
 =?us-ascii?Q?q0AWWJdigvuVuj0ORMg+LMm77rHpc7++yj5ItKNTpWLmRSeDFIGk2ky7nzLf?=
 =?us-ascii?Q?/eTOKFH0Eu4S6ZiXm++sB6fw2PmvJaT2407dV/5jujtiu059v91gymFTYAwd?=
 =?us-ascii?Q?vekVhpgZ/aCMU8ozYcI2Xd/pmGLqoQLUoQhKrZhgiKgfwf+cMFZ8tQltEYaI?=
 =?us-ascii?Q?9ZkKvs7NEGmPz9ypN8t9x7H+rkKEaQNbWjV2SsK9fbO9Y8KPOZgjAvcBUe9Z?=
 =?us-ascii?Q?149zdgiFjZScnzRUROGVEax5Vy9QQdhgwJ8JeNcO8+XD1KkYuA9pnjRi0Pd6?=
 =?us-ascii?Q?jtOzQvumgiPrf0tYQoR3wbf6edh1p+Y5OdRWwuJ6iW3wY5mXYNio0vwRNNXw?=
 =?us-ascii?Q?vKgD6XYu9MDglkMAVUU0Gc+PCOl3N5+qakGahJ44mKWSfBLnHptGTuLvXSj3?=
 =?us-ascii?Q?1lCM559D4gKqZGQaFEWr+J4wjgI/jc0LNQKhn1EQGGF1Ew1aVPi716j7WCgY?=
 =?us-ascii?Q?Ry0hIN7pAdiPdNPSAP1e7ZETSrTDQ79jH+LdwI1cIj4YUZwpIq75l17sqQ4/?=
 =?us-ascii?Q?20MLF0iGcs9NVCzsj+fzS6X+8/rg3h8s7yRMba4Bn6Ay2yzLf+Lp+/GtgETJ?=
 =?us-ascii?Q?TAa8mabSyhMSVnL4vq2ch/d8aGDYgRCmKNtdBKKNqaMHX2YdwQw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Q86zFNk1DF77Hftl79taydYaJOddXfjoIEouDWWAbVh6oizBY0FB7OcHcBFMLbd99TCpZn3Cu3Q1sfyhfa1XxxOoJFWttB1mze85Lfja0/prQOv5OGevTBPBqt1lEMCVTH9m52ea34bHSwygX2lXtSxnJ1oR9TYfey4gL1le45H16hZvSn7C+0DeZPxcBcwY
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1617;6:QsaQvmzFil39AIzzAPpVAXi9R4T5e2pqOxDYSz9mRZsbyvna0s58UAw943iHU8REuGpnzEzZgXEh81WI86ZmgZvaqfz65Rx0GpITXr5tjKPwIefxjh6T74ebYkY8/G2mLdxpYi5bYDpSgilX8JCWtUdupFOg9X8vCjbaS5WkV7BFFmaFfwBh7iX8YlyWf7mANnnHppxFTlr48Mb5NoYaSM8vq3SzCucPCdFlGuY4qX8+yQFbGetKRfnqSiNIrtwcCJu8D6se0/4q4e9ByGgL0pULjsrwdUDzn6FhG5jLA66DC0NmcOeQF5G/4O3QIM1sbVH+XbglQW3MLSdIudLFhiug48+ZZV/gv2KfqEKKYjY=;5:FW/RPF1oMebLie/TuAqUjbL9znWbPzPkY+lhGRdZPyNWCUaP/d+vqcL3hwRpbFCyyfLaMFj4QaR4Ec3y209zuhN2qPGh6ZipcQg241DxLRMGI8JHWPaBBhMzzdYCBK2/rIZ29yAQw6WNHkNJ9xdu4RuyOU6XqTTjGnRGhCj1OtA=;24:DejfLP8O+4RjH553pLaA3/HUytQIUH1P4ushRpnjk2x6lgxXHT8umrBjeFl6rq4l5EhlCjhckSxHo5y/m7LRaCSckY2jVdvm3siBx5+g+9A=;7:xj/4viUrRwByKjswoRapROX4+yn9Vq4/b7DMJdfo4GgiBYvk5dnO3JjH4jA4VdVLZ5/UsLsTca5M0oI5AaJZmmRFZV3KKlTbGaUhjdSC3uVCiPoypJ91mxfVSmUnuwda1c2cDya8JaNB0vQgq72Zwdb6JFZ+84vJGE6cIu/6hQT4IEVBFb07rD4LldZNmvkLseeO2/QWQaRJzFMEB7Y9XBSVRQIzO+SWgEjWlJhc6WJminQ7y4Ngi3V0gFfo6bvR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2018 07:39:54.3942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76e9ea0-e7ad-41b7-3404-08d58bda4687
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1617
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7S/D anatop vdd1p2 regulator.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index cd6964f..1210028 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -565,6 +565,21 @@
 					anatop-max-voltage = <1200000>;
 					anatop-enable-bit = <0>;
 				};
+
+				reg_1p2: regulator-vdd1p2@30360220 {
+					reg = <0x30360220>;
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vdd1p2";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1300000>;
+					anatop-reg-offset = <0x220>;
+					anatop-vol-bit-shift = <8>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <0x14>;
+					anatop-min-voltage = <1100000>;
+					anatop-max-voltage = <1300000>;
+					anatop-enable-bit = <0>;
+				};
 			};
 
 			snvs: snvs@30370000 {
-- 
2.7.4
