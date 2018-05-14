Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeENLoH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:44:07 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59646 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752882AbeENLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:44:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180514114401epoutp0454a1e8d164e5e310673a3adced0043dc~ugCn_qFqk1061710617epoutp04L
X-AuditID: b6c32a45-8dbff70000001020-1b-5af97681f4fe
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 14/14] thermal: ti-soc-thermal: remove SoC family config
 options
Date: Mon, 14 May 2018 13:42:21 +0200
Message-id: <1526298141-14045-15-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCmqW5j2c8og6PNfBYbZ6xntZh/5Rqr
        xantTUwWl3fNYbOYvaSfxeJz7xFGiycP+9gc2D12zrrL7rF4z0smj74tqxg9jt/YzuTxeZNc
        AGsUl01Kak5mWWqRvl0CV0bbIuWCGR4Vh3bvZWxgXGnVxcjJISFgIvFiXytrFyMXh5DADkaJ
        rp42FgjnO6PErP4fbDBVZ568ZoZI7GaU6PwzgR3C+cUocfP+VhaQKjYBK4mJ7asYQWwRATeJ
        WUv+gNnMAlMZJTZNqAexhQWCJPYfXgNWzyKgKnF/0g9mEJtXwFNib2MPE8Q2OYmTxyazgtic
        QPEN7S+hruhhk1g0JxDCdpHYPOMTVFxY4tXxLewQtrTEs1UbGUGOkxBoZpT4tmMPM0RiAqPE
        nvVCELa1xOHjF1khjuOT6Dj8F6iZAyjOK9HRJgRhekhs/w/V6Sixd/ZGaBDNYZTob5vFPIFR
        agEjwypGsdSC4tz01GKjAkO94sTc4tK8dL3k/NxNjOCY1HLdwTjjnM8hRgEORiUe3hUrf0QJ
        sSaWFVfmHmKU4GBWEuHdbfQzSog3JbGyKrUoP76oNCe1+BCjNAeLkjjvGqWvUUIC6Yklqdmp
        qQWpRTBZJg5OqQbG5YpdWx/cOu4TctSr1362n+O/Unm5kEdzFrhklv2f+7qkuOtJZVRk4pny
        cwV3NPfZnL4dxaEn7Ls+xUNgxfyIwHPpWZzNvIEqX0zTWLKk+m1/8v34cP1UeK9ckJ7nk6/5
        Dv/ym9aH/stjs0/xY+y+V3ai9evvX+VtHe7Mf5LM1j57d1CC4aISS3FGoqEWc1FxIgCirt7q
        xQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xgG5D2c8og67n3BYbZ6xntZh/5Rqr
        xantTUwWl3fNYbOYvaSfxeJz7xFGiycP+9gc2D12zrrL7rF4z0smj74tqxg9jt/YzuTxeZNc
        AGsUl01Kak5mWWqRvl0CV0bbIuWCGR4Vh3bvZWxgXGnVxcjJISFgInHmyWvmLkYuDiGBnYwS
        7acb2CCcX4wSDdOPs4NUsQlYSUxsX8UIYosIuEnMWvKHEaSIWWAqo8TkT6fYQBLCAgESL26+
        BStiEVCVuD/pBzOIzSvgKbG3sYcJYp2cxMljk1lBbE6g+Ib2l2C9QgIeErd/t7BNYORZwMiw
        ilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMIy2Hdbq38H4eEn8IUYBDkYlHt6A5T+i
        hFgTy4orcw8xSnAwK4nw7jb6GSXEm5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpiSWp2
        ampBahFMlomDU6qBUSnxTsX9Y2XxL9hnp273y3Dv3L35VuYR16NJzx9wq2+TFRLaUvIzYWZJ
        VJnBrPqWRV43l/GcUAqVNDJfUfvK4uUscfcfsV+3r/qbstywynrlpdSE9d7FkhzP0/z7mVKy
        QtuPmz5jPbzHaqvkJY8rt27PEr9q4n0t3UXu64/dbAHbFlWfVD58V4mlOCPRUIu5qDgRAHwM
        B00fAgAA
X-CMS-MailID: 20180514114400epcas2p193e6f6643171575aab079329bed79c2c
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180514114400epcas2p193e6f6643171575aab079329bed79c2c
X-RootMTR: 20180514114400epcas2p193e6f6643171575aab079329bed79c2c
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114400epcas2p193e6f6643171575aab079329bed79c2c@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before latest changes:

$ size drivers/thermal/ti-soc-thermal/built-in.a
   text    data     bss     dec     hex filename
   9540     152       8    9700    25e4 drivers/thermal/ti-soc-thermal/ti-bandgap.o
   1604      48       8    1660     67c drivers/thermal/ti-soc-thermal/ti-thermal-common.o
    228    2264       0    2492     9bc drivers/thermal/ti-soc-thermal/dra752-thermal-data.o
   1172     256       0    1428     594 drivers/thermal/ti-soc-thermal/omap3-thermal-data.o
   2376     256       0    2632     a48 drivers/thermal/ti-soc-thermal/omap4-thermal-data.o
    160    2008       0    2168     878 drivers/thermal/ti-soc-thermal/omap5-thermal-data.o

After latest changes:

$ size drivers/thermal/ti-soc-thermal/built-in.a
   text    data     bss     dec     hex filename
   9532     152       8    9692    25dc drivers/thermal/ti-soc-thermal/ti-bandgap.o
   1604      48       8    1660     67c drivers/thermal/ti-soc-thermal/ti-thermal-common.o
    392     200       0     592     250 drivers/thermal/ti-soc-thermal/dra752-thermal-data.o
    152    1100       0    1252     4e4 drivers/thermal/ti-soc-thermal/omap5-thermal-data.o
    644     224       0     868     364 drivers/thermal/ti-soc-thermal/omap3-thermal-data.o
   1292     224       0    1516     5ec drivers/thermal/ti-soc-thermal/omap4-thermal-data.o

Maximum possible space savings (CONFIG_OMAP3_THERMAL=y with
other config options set to n) are down from ~7kB to ~3kB so
it is not really worth to have extra complexity and keep SoC
family config options. Just remove them.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/Kconfig             | 63 +++-------------------
 drivers/thermal/ti-soc-thermal/Makefile            |  8 +--
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  4 --
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  8 ---
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        | 19 -------
 5 files changed, 12 insertions(+), 90 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-soc-thermal/Kconfig
index fe0e877..b16f239 100644
--- a/drivers/thermal/ti-soc-thermal/Kconfig
+++ b/drivers/thermal/ti-soc-thermal/Kconfig
@@ -2,8 +2,14 @@ config TI_SOC_THERMAL
 	tristate "Texas Instruments SoCs temperature sensor driver"
 	help
 	  If you say yes here you get support for the Texas Instruments
-	  OMAP4460+ on die bandgap temperature sensor support. The register
-	  set is part of system control module.
+	  on die bandgap temperature sensor support. The current chips
+	  supported are:
+	   - OMAP3430
+	   - OMAP4430
+	   - OMAP4460
+	   - OMAP4470
+	   - OMAP5430
+	   - DRA752
 
 	  This includes alert interrupts generation and also the TSHUT
 	  support.
@@ -17,56 +23,3 @@ config TI_THERMAL
 
 	  This includes trip points definitions, extrapolation rules and
 	  CPU cooling device bindings.
-
-config OMAP3_THERMAL
-	bool "Texas Instruments OMAP3 thermal support"
-	depends on TI_SOC_THERMAL
-	depends on ARCH_OMAP3 || COMPILE_TEST
-	help
-	  If you say yes here you get thermal support for the Texas Instruments
-	  OMAP3 SoC family. The current chips supported are:
-	   - OMAP3430
-
-	  OMAP3 chips normally don't need thermal management, and sensors in
-	  this generation are not accurate, nor they are very close to
-	  the important hotspots.
-
-	  Say 'N' here.
-
-config OMAP4_THERMAL
-	bool "Texas Instruments OMAP4 thermal support"
-	depends on TI_SOC_THERMAL
-	depends on ARCH_OMAP4 || COMPILE_TEST
-	help
-	  If you say yes here you get thermal support for the Texas Instruments
-	  OMAP4 SoC family. The current chip supported are:
-	   - OMAP4430
-	   - OMAP4460
-	   - OMAP4470
-
-	  This includes alert interrupts generation and also the TSHUT
-	  support.
-
-config OMAP5_THERMAL
-	bool "Texas Instruments OMAP5 thermal support"
-	depends on TI_SOC_THERMAL
-	depends on SOC_OMAP5 || COMPILE_TEST
-	help
-	  If you say yes here you get thermal support for the Texas Instruments
-	  OMAP5 SoC family. The current chip supported are:
-	   - OMAP5430
-
-	  This includes alert interrupts generation and also the TSHUT
-	  support.
-
-config DRA752_THERMAL
-	bool "Texas Instruments DRA752 thermal support"
-	depends on TI_SOC_THERMAL
-	depends on SOC_DRA7XX || COMPILE_TEST
-	help
-	  If you say yes here you get thermal support for the Texas Instruments
-	  DRA752 SoC family. The current chip supported are:
-	   - DRA752
-
-	  This includes alert interrupts generation and also the TSHUT
-	  support.
diff --git a/drivers/thermal/ti-soc-thermal/Makefile b/drivers/thermal/ti-soc-thermal/Makefile
index aa1c38d..2986e1e 100644
--- a/drivers/thermal/ti-soc-thermal/Makefile
+++ b/drivers/thermal/ti-soc-thermal/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_TI_SOC_THERMAL)		+= ti-soc-thermal.o
 ti-soc-thermal-y			:= ti-bandgap.o
 ti-soc-thermal-$(CONFIG_TI_THERMAL)	+= ti-thermal-common.o
-ti-soc-thermal-$(CONFIG_DRA752_THERMAL)	+= dra752-thermal-data.o omap5-thermal-data.o
-ti-soc-thermal-$(CONFIG_OMAP3_THERMAL)	+= omap3-thermal-data.o
-ti-soc-thermal-$(CONFIG_OMAP4_THERMAL)	+= omap4-thermal-data.o
-ti-soc-thermal-$(CONFIG_OMAP5_THERMAL)	+= omap5-thermal-data.o
+ti-soc-thermal-y			+= dra752-thermal-data.o
+ti-soc-thermal-y			+= omap3-thermal-data.o
+ti-soc-thermal-y			+= omap4-thermal-data.o
+ti-soc-thermal-y			+= omap5-thermal-data.o
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index 98b250a..fd344f6 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -114,7 +114,6 @@ struct temp_sensor_registers
 	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_CORE,
 };
 
-#ifdef CONFIG_OMAP5_THERMAL
 /* Thresholds and limits for OMAP5430 MPU/GPU/CORE temperature sensor */
 static struct temp_sensor_data omap5430_temp_sensor_data = {
 	.tshut_hot = OMAP5430_TSHUT_HOT,
@@ -124,7 +123,6 @@ struct temp_sensor_registers
 	.min_freq = OMAP5430_MIN_FREQ,
 	.max_freq = OMAP5430_MAX_FREQ,
 };
-#endif /* CONFIG_OMAP5_THERMAL */
 
 /*
  * OMAP54xx ES2.0 : Temperature values in milli degree celsius
@@ -216,7 +214,6 @@ struct temp_sensor_registers
 	1238, 1242, 1246, 1249, 1250, 1250,
 };
 
-#ifdef CONFIG_OMAP5_THERMAL
 /* OMAP54xx ES2.0 data */
 const struct ti_bandgap_data omap5430_data = {
 	.features = TI_BANDGAP_FEATURE_TSHUT_CONFIG |
@@ -254,4 +251,3 @@ struct temp_sensor_registers
 	},
 	.sensor_count = 3,
 };
-#endif /* CONFIG_OMAP5_THERMAL */
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 6b5a45f..3bba232 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1219,7 +1219,6 @@ static SIMPLE_DEV_PM_OPS(ti_bandgap_dev_pm_ops, ti_bandgap_suspend,
 #endif
 
 static const struct of_device_id of_ti_bandgap_match[] = {
-#ifdef CONFIG_OMAP3_THERMAL
 	{
 		.compatible = "ti,omap34xx-bandgap",
 		.data = (void *)&omap34xx_data,
@@ -1228,8 +1227,6 @@ static SIMPLE_DEV_PM_OPS(ti_bandgap_dev_pm_ops, ti_bandgap_suspend,
 		.compatible = "ti,omap36xx-bandgap",
 		.data = (void *)&omap36xx_data,
 	},
-#endif
-#ifdef CONFIG_OMAP4_THERMAL
 	{
 		.compatible = "ti,omap4430-bandgap",
 		.data = (void *)&omap4430_data,
@@ -1242,19 +1239,14 @@ static SIMPLE_DEV_PM_OPS(ti_bandgap_dev_pm_ops, ti_bandgap_suspend,
 		.compatible = "ti,omap4470-bandgap",
 		.data = (void *)&omap4470_data,
 	},
-#endif
-#ifdef CONFIG_OMAP5_THERMAL
 	{
 		.compatible = "ti,omap5430-bandgap",
 		.data = (void *)&omap5430_data,
 	},
-#endif
-#ifdef CONFIG_DRA752_THERMAL
 	{
 		.compatible = "ti,dra752-bandgap",
 		.data = (void *)&dra752_data,
 	},
-#endif
 	/* Sentinel */
 	{ },
 };
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 0a53458..8e6d4cb 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -350,33 +350,14 @@ int ti_bandgap_read_temperature(struct ti_bandgap *bgp, int id,
 void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id);
 int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend);
 
-#ifdef CONFIG_OMAP3_THERMAL
 extern const struct ti_bandgap_data omap34xx_data;
 extern const struct ti_bandgap_data omap36xx_data;
-#else
-#define omap34xx_data					NULL
-#define omap36xx_data					NULL
-#endif
 
-#ifdef CONFIG_OMAP4_THERMAL
 extern const struct ti_bandgap_data omap4430_data;
 extern const struct ti_bandgap_data omap4460_data;
 extern const struct ti_bandgap_data omap4470_data;
-#else
-#define omap4430_data					NULL
-#define omap4460_data					NULL
-#define omap4470_data					NULL
-#endif
 
-#ifdef CONFIG_OMAP5_THERMAL
 extern const struct ti_bandgap_data omap5430_data;
-#else
-#define omap5430_data					NULL
-#endif
 
-#ifdef CONFIG_DRA752_THERMAL
 extern const struct ti_bandgap_data dra752_data;
-#else
-#define dra752_data					NULL
-#endif
 #endif
-- 
1.9.1
