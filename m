Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeBHJcw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:32:52 -0500
Received: from mail-cys01nam02on0082.outbound.protection.outlook.com ([104.47.37.82]:7679
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751974AbeBHJcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:32:42 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC: Leo Li <leoyang.li@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 2/3] arm64: dts: ls1043a: add cpu idle support
Date: Thu, 8 Feb 2018 15:54:35 +0800
Message-ID: <20180208075436.38443-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180208075436.38443-1-ran.wang_1@nxp.com>
References: <20180208075436.38443-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131625559602600781;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(305945005)(356003)(50466002)(498600001)(5660300001)(106466001)(77096007)(6666003)(97736004)(76176011)(48376002)(336011)(2950100002)(53936002)(51416003)(2906002)(36756003)(1076002)(68736007)(26005)(26826003)(316002)(16586007)(110136005)(54906003)(50226002)(59450400001)(86362001)(4326008)(104016004)(81156014)(81166006)(85426001)(8936002)(450100002)(47776003)(105606002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR03MB1417;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD020;1:UjGkCWM46kYylX6C4YOx6MNNcHp1SzTlStRjxozieRn6MnFKXNywPw7A+7kdNljHfTovt1F7/cvDOqwpRDuq38UAHLin/Qkju+cktZd6Zei0Eer1BX9iUZLcKrU5KfcE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04e49327-407f-4e15-9b4d-08d56ed6e5f0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BY1PR03MB1417;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1417;3:owYlHsZvfv+HT6dVPKnFo8Z4BQvzGWLkUr/P1maFOybV8lcxpLox3LiXZJ47Rleu9OtcCtpUutX+hboV9XCT7Xinq8yzWkbBQvIoyynPKKhWp97RkGbO36TojWVKCbVv9zak+bhT1ePZvXBSKvic8D880X699J4n6mDluRQ4aFi52AOx+DRDOPlc+TxWaYcbkoXZmroK6AtB/bdHqm5gHHxNkk9RPJxazwgyDgTOEwFNqwJJH6V1RQShntMelJteBQmSxVM+ijFHsllezBnCOn1aUD9sm2JENyrPJ3NTY8NKNiCtwzZEKwt1rNwoCeD3xLqnXba4lF9OfBtxd5OGlOvl1HbG6a4cnI/jRd+5lOs=;25:0+Ocma5EkVLXbocW+o0qTiK8C8extLk7eQX9zuJjjYe7WB8gmk3TuEifoy4QbZ8j+rEoIc8SaNbMo1/y7hRCDLfY0I8XUqv5bQ4sx5gA22di/Q+yZC7ya6eBJnKEfoUjMXZ8/3rjaj8E29iaHXoo7zC8tB61kgifCiv5QdfFHPEC/ZKSE8yCFkKaZ88ytIV7nSzUcMvgV1JU9H/iZnWyzwTwwRaajqrqG38vt5VVKJpjpPCc0cGF4dl0tlNHorPfOVNw5sg0y/51NT8ThIM/kWcKJE3Msc6kYWM3fkOwvzGjh61gWH502/rL1D/UQuGjLVNiw/mOZyzhqOESFlsIiw==
X-MS-TrafficTypeDiagnostic: BY1PR03MB1417:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1417;31:a2ya7NCycGpZordPFKzdfumGCF0G4TuUoLFRlFjWZ4pmpF/nOhx/jky6cmy0CooPhN8SQ3mz6h4kY2vM7VAcvanN8i4MBWXg++R6y3mB6vVYaA1B361AthbHRnYOc3FBl21sn5grx/mvxoF5Mxqyi/4xq3IlHUyjWEB2PpnWUOJ2BD3Qc9ziNOrfDDl+OBPjDwx3/IXbA+tTfjteFm4RE8ly9bpZfZlTsds/azDU24k=;4:t4BQVv/OOb6TBrrtFtMTvalVHxepfXKIJohIspZpe8hp55u3PA6OypqD2BAj2NLwQ62h8KsSRkHAgk/JfxE6YbA6JRN0d0NPl6cVEcDCxzsR7La9LWvQvhcW84PZbT9h4nCb7DT+H5n2VAsZM6GxtRdDu2Z4jWQVgRz9kSKx1lJX2vjUsKlxPePfgkLHhjUYW8ehTxq5ORflnceuhwHfyqz6kIOyqS3T7Ose/NnS1JNLOcjdsUU57UI4BlbZQCvsHoavvcWcHQAvpTmFPEE0zHatdx9YXym5EUlcmFdOJqP3vsvdQ/xgVKcrzsSu1dZG
X-Microsoft-Antispam-PRVS: <BY1PR03MB14176EE2A995530571FDA22FF1F30@BY1PR03MB1417.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6055026)(6096035)(20161123559100)(20161123561025)(20161123563025)(20161123565025)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BY1PR03MB1417;BCL:0;PCL:0;RULEID:(400006);SRVR:BY1PR03MB1417;
X-Forefront-PRVS: 0577AD41D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR03MB1417;23:jFTXgwxSdEUNWEDA3ODWdc8drveeaGZChLHU6vGNW?=
 =?us-ascii?Q?2b1KDwBCDqABDjqZkzR6AgJXf7o4HXbDO1Z36mjpO1dQZ/RU0SRmLE5a3r5W?=
 =?us-ascii?Q?5SgEYE0LQ/QtIu+5AL42XZc+md6Drlbw5mn5UAC4T4RxROczcs0ua6pZKJNv?=
 =?us-ascii?Q?H3sxwKk0Y68Yb4Xx6fonEfayEKigyr9Q+jeUdnYeOsp3hgXVnZOZ5SKMMPXy?=
 =?us-ascii?Q?OvoLC01RvBirPe78nml6/gu3GXjWmoV1ZYLgVKg+fZGJLpzxL9rlPiCQHdT7?=
 =?us-ascii?Q?bt5fEFXP9HzK2rzGWXGUkb++rc7Iwc4SKfxbFzlD4VILa27Vpt0x2E6Hhxx7?=
 =?us-ascii?Q?gK8yQXKLtXuuqfASZduGvik8yGMrGqUpeqawoNYoVPuuYYfMg5q80F+LG8lC?=
 =?us-ascii?Q?SHZf7f4hOlnOQ8E+mFzJsm72/SVmh8XiXfnDRBekR+KdoEz25m6GcxZMs5l8?=
 =?us-ascii?Q?vPXUvoLfPsRbYm5BQx40nSnKAlblah5HQU/cEQI5/b8WcY0hlh+/Rird4JLg?=
 =?us-ascii?Q?UjYlsTvjHMLeIoOm70Q0S03Axiao700oNLTLDRf5jedc7HQUuvK9ql768YcN?=
 =?us-ascii?Q?jgGY+fhFiznOTxqk5x5/9cX8dBB/b9HMs5Hg0130rCjSPF5P/q3XadwGOHgw?=
 =?us-ascii?Q?qMIgfrtvICSjOm9nCm5E+7V6zWJXTI0uAMydGCl/lgfbM+u0p2Mrld6TZqwE?=
 =?us-ascii?Q?ZEt1L94mUAtEwmpcIbusF33zI2GpwbzM2lGSxB2AjlHAYk7E6QEIDIhPixqP?=
 =?us-ascii?Q?DqsCOSBXDtl2cvt6RN2ad28it1JW2ipPUmZmZPdqiVYTyNyjCkqLEawN06c1?=
 =?us-ascii?Q?weCaLImH6/Qvqn8th+qkNig4Nm9B4JouLGuanGEXaWWZL6Ppzb35csG/0NNd?=
 =?us-ascii?Q?W2CZr5VpxwZsAjCZBhdfNpOIxtjLS3rdjikA6qHkSLv9pOXejs0BMaHy3/xW?=
 =?us-ascii?Q?JfEiHiba9FTWhjv8Q7tj+/FDMgA0SgnC9jVxY2FxVtT3hZrgsgtbDhOFOFRK?=
 =?us-ascii?Q?wZ9XwruyjI9ydUNy+MAqFoGxPkf76GZR2grcFN0RZJSh+ujoIfQ4Dtp9oCHX?=
 =?us-ascii?Q?YjnwCDFH/P0XPkvPn418kidJtP1//QCBzhbZtFFQJfefhYkRD/b45PZFE/Kj?=
 =?us-ascii?Q?4qhxsVEwkPdSYZex01tvedlo+mtVh0k04E+4z4ytj/h7UjVRVUWrw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1417;6:B9Zh6s9UGn98kFwp0NFWaTl6BlWfWLg2CGsHPgbOymUECyjEFzi2WIb7atTkiLzVVQZGLQgnM/0fe/zLN7nNezlXlsbowi7iv3/CbIvkzpEd1AhWU2NYo1N26q1cyC+ebAEvHSgKu9UrS8u7uRRrMdVlM8OoIOvjClqmEMzTqQCAsTczQiwQA4RhNxWyF1WLGzWYa1oqFtL9aNyyBvmfMsr5g7vfBa2mHYtBVayUmWVEHYVYSxNXZctDi0QYTkudGnpoXibxKyWHMv5woogOrGQxD79nU86LwwrMOV8dLaxQet31FpuaC4Pij6mLw07CGaqHn2uK9cL3G4ujtWGMkDuT1e1v6ruErPrik746fqI=;5:KCXYe1HZuqNH9W8LXMQCncP9Hi9mIBw6UhFjg7h6Oft0ngcqKDSlo7epgnp5CGEfL6LqQ3CbyxVcjjqwrauB+uBazN5/Qcfn3L1IYA+hAerWoh6G6bi6Coz7e94ulaFKeAE8z3IksNk17J4dRe3wAo6DSEzs9O1J2ZD2wllTH3M=;24:G6wwfaFWP78Ux+95qukh6plTuxUFZ/sKvtGuNA1cb89zObdMTnXGlPGlg6PUbV5uaIDAENcjwuviCGRz8+lRfH033SWm4ZGFZpQgMgK/AI8=;7:t75oq4HW181rBLYYzy2MKWALmz8PPFaYLEYWWaPUK3vYNr0r1m2MVdE7RTWUElz0J/Z5uAlt03a8pX+Rcc3nDlRLaYik4ragQlbeodVBP+Ff3QZ0cc5m7I/+5ilQM1Nd5tGuFTIUQ3TXoINiRVvP7i0h4h1NSPwN80TP65l6gC6nfJqLyFtriVsRfwDZtFx4oMd+LRrQQ83+UgHibtShJiK8B/HZiNJ8o6gsMZzrMC9F6euXxiC4ylILvyjtjL12
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 09:32:40.0104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e49327-407f-4e15-9b4d-08d56ed6e5f0
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB1417
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 380e7c7..18828b9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -81,6 +81,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu1: cpu@1 {
@@ -89,6 +90,7 @@
 			reg = <0x1>;
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu2: cpu@2 {
@@ -97,6 +99,7 @@
 			reg = <0x2>;
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu3: cpu@3 {
@@ -105,6 +108,7 @@
 			reg = <0x3>;
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		l2: l2-cache {
@@ -112,6 +116,23 @@
 		};
 	};
 
+	idle-states {
+		/*
+		 * PSCI node is not added default, U-boot will add missing
+		 * parts if it determines to use PSCI.
+		 */
+		entry-method = "arm,psci";
+
+		CPU_PH20: cpu-ph20 {
+			compatible = "arm,idle-state";
+			idle-state-name = "PH20";
+			arm,psci-suspend-param = <0x00010000>;
+			entry-latency-us = <1000>;
+			exit-latency-us = <1000>;
+			min-residency-us = <3000>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
-- 
1.7.1
