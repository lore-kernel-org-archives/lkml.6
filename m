Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeENLnx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:43:53 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59568 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeENLnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:43:46 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180514114345epoutp04e2f6426aaa95b8de849a9f91fa290553~ugCYlXx6m0865708657epoutp04N
X-AuditID: b6c32a45-8f3ff70000001020-f2-5af97670249a
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 10/14] thermal: ti-soc-thermal: use OMAP5 defines for DRA752
Date: Mon, 14 May 2018 13:42:17 +0200
Message-id: <1526298141-14045-11-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCmhW5B2c8ogxmrdS02zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsEroyJBxcwFzzMrni4bzZjA+OzuC5GDg4JAROJ2Td0uxg5OYQEdjBK
        tB8T7WLkArK/M0pc+32CESQBUrN3wydmiMRuRonXc2dDOb8YJbZ1L2QCqWITsJKY2L4KrENE
        wE1i1pI/YDazwFRGiU0T6kFsYQEfiZ9d29lBbBYBVYm+TWdYQWxeAU+Jy5NOskBsk5M4eWwy
        WJwTKL6h/SUbRLyHTWLiPzEI20XiwtNJ7BC2sMSr41ugbGmJZ6s2MoIcJyHQzCjxbcceZojE
        BEaJPeuFIGxricPHL7JCHMcn0XH4LzskKHglOtqgSjwk/i67DrXXUaJl02RGiIfnMEocufCD
        ZQKj1AJGhlWMYqkFxbnpqcVGBYZ6xYm5xaV56XrJ+bmbGMExqeW6g3HGOZ9DjAIcjEo8vCtW
        /ogSYk0sK67MPcQowcGsJMK72+hnlBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeNUpfo4QE0hNL
        UrNTUwtSi2CyTBycUg2MR26pOZxxv+sdbu0Z2eRRHD717dWLdpeDHfNvhpoKvf028dXt43G9
        KUtvGc4KPn+x/VuT7z11nRzzU7M3Ss5VebncQZFV3yun+NzBd7+avj3fLBSt9S/cje9fhpD7
        VCGOI/tq9keEb7j1LqJi4p6Tpc1JK6XqpoeXM/x5Hfq2cdq8Wf91ThwOUWIpzkg01GIuKk4E
        AKuMA4fFAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e+xgG5+2c8og99PJC02zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsEroyJBxcwFzzMrni4bzZjA+OzuC5GTg4JAROJvRs+MXcxcnEICexk
        lOj91s4I4fxilJj26RQbSBWbgJXExPZVjCC2iICbxKwlf8CKmAWmMkpMhioSFvCR+Nm1nR3E
        ZhFQlejbdIYVxOYV8JS4POkkC8Q6OYmTxyaDxTmB4hvaX4L1Cgl4SNz+3cI2gZFnASPDKkbJ
        1ILi3PTcYqMCo7zUcr3ixNzi0rx0veT83E2MwEDadlirfwfj4yXxhxgFOBiVeHgDlv+IEmJN
        LCuuzD3EKMHBrCTCu9voZ5QQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZqakF
        qUUwWSYOTqkGxk6Lrb/jf6Sbn5n5g2FCXJaMKX+7h5T8avU6ZeGa5TtWCc+7vqqNy/HfhK4Z
        /jxCp6Of6ez69fz5nNXL10/dZfC/OHH+9pfHJgu5rHopX2W9vfmTTuaW1NWzngYXfFls+zt0
        jhoT03+P8rtaznvT/4qtlt6RkSrwzmGxbfBRhv2ul0sPn57J/FKJpTgj0VCLuag4EQAIrZiT
        IAIAAA==
X-CMS-MailID: 20180514114343epcas2p4280b4ff50611a223a1b3ae37dbe743ee
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180514114343epcas2p4280b4ff50611a223a1b3ae37dbe743ee
X-RootMTR: 20180514114343epcas2p4280b4ff50611a223a1b3ae37dbe743ee
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114343epcas2p4280b4ff50611a223a1b3ae37dbe743ee@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use defines from omap5xxx-bandgap.h in dra752-thermal-data.c
instead of defining duplicate ones in dra752-bandgap.h.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |  70 -----------
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 129 +++++++++++----------
 2 files changed, 65 insertions(+), 134 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index ac324b9..b9d65b4 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -45,18 +45,9 @@
 
 
 /* DRA752.common register offsets */
-#define DRA752_BANDGAP_CTRL_1_OFFSET		0x1a0
-#define DRA752_BANDGAP_STATUS_1_OFFSET		0x1c8
 #define DRA752_BANDGAP_CTRL_2_OFFSET		0x39c
 #define DRA752_BANDGAP_STATUS_2_OFFSET		0x3b8
 
-/* DRA752.core register offsets */
-#define DRA752_STD_FUSE_OPP_BGAP_CORE_OFFSET		0x8
-#define DRA752_TEMP_SENSOR_CORE_OFFSET			0x154
-#define DRA752_BANDGAP_THRESHOLD_CORE_OFFSET		0x1ac
-#define DRA752_DTEMP_CORE_1_OFFSET			0x20c
-#define DRA752_DTEMP_CORE_2_OFFSET			0x210
-
 /* DRA752.iva register offsets */
 #define DRA752_STD_FUSE_OPP_BGAP_IVA_OFFSET		0x388
 #define DRA752_TEMP_SENSOR_IVA_OFFSET			0x398
@@ -64,13 +55,6 @@
 #define DRA752_DTEMP_IVA_1_OFFSET			0x3d4
 #define DRA752_DTEMP_IVA_2_OFFSET			0x3d8
 
-/* DRA752.mpu register offsets */
-#define DRA752_STD_FUSE_OPP_BGAP_MPU_OFFSET		0x4
-#define DRA752_TEMP_SENSOR_MPU_OFFSET			0x14c
-#define DRA752_BANDGAP_THRESHOLD_MPU_OFFSET		0x1a4
-#define DRA752_DTEMP_MPU_1_OFFSET			0x1e4
-#define DRA752_DTEMP_MPU_2_OFFSET			0x1e8
-
 /* DRA752.dspeve register offsets */
 #define DRA752_STD_FUSE_OPP_BGAP_DSPEVE_OFFSET			0x384
 #define DRA752_TEMP_SENSOR_DSPEVE_OFFSET			0x394
@@ -78,13 +62,6 @@
 #define DRA752_DTEMP_DSPEVE_1_OFFSET				0x3c0
 #define DRA752_DTEMP_DSPEVE_2_OFFSET				0x3c4
 
-/* DRA752.gpu register offsets */
-#define DRA752_STD_FUSE_OPP_BGAP_GPU_OFFSET		0x0
-#define DRA752_TEMP_SENSOR_GPU_OFFSET			0x150
-#define DRA752_BANDGAP_THRESHOLD_GPU_OFFSET		0x1a8
-#define DRA752_DTEMP_GPU_1_OFFSET			0x1f8
-#define DRA752_DTEMP_GPU_2_OFFSET			0x1fc
-
 /**
  * Register bitfields for DRA752
  *
@@ -93,14 +70,6 @@
  * grouped by register.
  */
 
-/* DRA752.BANDGAP_STATUS_1 */
-#define DRA752_BANDGAP_STATUS_1_HOT_CORE_MASK		BIT(5)
-#define DRA752_BANDGAP_STATUS_1_COLD_CORE_MASK		BIT(4)
-#define DRA752_BANDGAP_STATUS_1_HOT_GPU_MASK		BIT(3)
-#define DRA752_BANDGAP_STATUS_1_COLD_GPU_MASK		BIT(2)
-#define DRA752_BANDGAP_STATUS_1_HOT_MPU_MASK		BIT(1)
-#define DRA752_BANDGAP_STATUS_1_COLD_MPU_MASK		BIT(0)
-
 /* DRA752.BANDGAP_CTRL_2 */
 #define DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK			BIT(22)
 #define DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK		BIT(21)
@@ -115,43 +84,4 @@
 #define DRA752_BANDGAP_STATUS_2_HOT_DSPEVE_MASK			BIT(1)
 #define DRA752_BANDGAP_STATUS_2_COLD_DSPEVE_MASK		BIT(0)
 
-/* DRA752.BANDGAP_CTRL_1 */
-#define DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK		(0x7 << 27)
-#define DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK			BIT(23)
-#define DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK			BIT(22)
-#define DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK			BIT(21)
-#define DRA752_BANDGAP_CTRL_1_MASK_HOT_CORE_MASK		BIT(5)
-#define DRA752_BANDGAP_CTRL_1_MASK_COLD_CORE_MASK		BIT(4)
-#define DRA752_BANDGAP_CTRL_1_MASK_HOT_GPU_MASK			BIT(3)
-#define DRA752_BANDGAP_CTRL_1_MASK_COLD_GPU_MASK		BIT(2)
-#define DRA752_BANDGAP_CTRL_1_MASK_HOT_MPU_MASK			BIT(1)
-#define DRA752_BANDGAP_CTRL_1_MASK_COLD_MPU_MASK		BIT(0)
-
-/* DRA752.TEMP_SENSOR */
-#define DRA752_TEMP_SENSOR_TMPSOFF_MASK		BIT(11)
-#define DRA752_TEMP_SENSOR_EOCZ_MASK		BIT(10)
-#define DRA752_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
-
-/**
- * Temperature limits and thresholds for DRA752
- *
- * All the macros bellow are definitions for handling the
- * ADC conversions and representation of temperature limits
- * and thresholds for DRA752. Definitions are grouped
- * by temperature domain.
- */
-
-/* DRA752.common temperature definitions */
-/* ADC conversion table limits */
-#define DRA752_ADC_START_VALUE		540
-#define DRA752_ADC_END_VALUE		945
-
-/* DRA752 GPU/MPU/CORE/DSPEVE/IVA temperature definitions */
-/* bandgap clock limits */
-#define DRA752_MAX_FREQ				1500000
-#define DRA752_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_T_HOT				800
-#define DRA752_T_COLD				795
-
 #endif /* __DRA752_BANDGAP_H */
diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index 3372cd7..de412a2 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -21,6 +21,7 @@
 
 #include "ti-thermal.h"
 #include "ti-bandgap.h"
+#include "omap5xxx-bandgap.h"
 #include "dra752-bandgap.h"
 
 /*
@@ -34,22 +35,22 @@
  */
 static struct temp_sensor_registers
 dra752_core_temp_sensor_registers = {
-	.temp_sensor_ctrl = DRA752_TEMP_SENSOR_CORE_OFFSET,
-	.bgap_tempsoff_mask = DRA752_TEMP_SENSOR_TMPSOFF_MASK,
-	.bgap_eocz_mask = DRA752_TEMP_SENSOR_EOCZ_MASK,
-	.bgap_dtemp_mask = DRA752_TEMP_SENSOR_DTEMP_MASK,
-	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_1_OFFSET,
-	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_CORE_MASK,
-	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_CORE_MASK,
-	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
-	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK,
-	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_CORE_OFFSET,
-	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
-	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_CORE_MASK,
-	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_CORE_MASK,
-	.ctrl_dtemp_1 = DRA752_DTEMP_CORE_1_OFFSET,
-	.ctrl_dtemp_2 = DRA752_DTEMP_CORE_2_OFFSET,
-	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_CORE_OFFSET,
+	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_CORE_OFFSET,
+	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
+	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
+	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
+	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
+	.mask_hot_mask = OMAP5430_MASK_HOT_CORE_MASK,
+	.mask_cold_mask = OMAP5430_MASK_COLD_CORE_MASK,
+	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
+	.mask_freeze_mask = OMAP5430_MASK_FREEZE_CORE_MASK,
+	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_CORE_OFFSET,
+	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
+	.status_hot_mask = OMAP5430_HOT_CORE_FLAG_MASK,
+	.status_cold_mask = OMAP5430_COLD_CORE_FLAG_MASK,
+	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_CORE_1_OFFSET,
+	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_CORE_2_OFFSET,
+	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_CORE,
 };
 
 /*
@@ -58,13 +59,13 @@
 static struct temp_sensor_registers
 dra752_iva_temp_sensor_registers = {
 	.temp_sensor_ctrl = DRA752_TEMP_SENSOR_IVA_OFFSET,
-	.bgap_tempsoff_mask = DRA752_TEMP_SENSOR_TMPSOFF_MASK,
-	.bgap_eocz_mask = DRA752_TEMP_SENSOR_EOCZ_MASK,
-	.bgap_dtemp_mask = DRA752_TEMP_SENSOR_DTEMP_MASK,
+	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
+	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
+	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
 	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_2_OFFSET,
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_2_MASK_HOT_IVA_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_2_MASK_COLD_IVA_MASK,
-	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
+	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_IVA_OFFSET,
 	.bgap_status = DRA752_BANDGAP_STATUS_2_OFFSET,
@@ -80,22 +81,22 @@
  */
 static struct temp_sensor_registers
 dra752_mpu_temp_sensor_registers = {
-	.temp_sensor_ctrl = DRA752_TEMP_SENSOR_MPU_OFFSET,
-	.bgap_tempsoff_mask = DRA752_TEMP_SENSOR_TMPSOFF_MASK,
-	.bgap_eocz_mask = DRA752_TEMP_SENSOR_EOCZ_MASK,
-	.bgap_dtemp_mask = DRA752_TEMP_SENSOR_DTEMP_MASK,
-	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_1_OFFSET,
-	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_MPU_MASK,
-	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_MPU_MASK,
-	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
-	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK,
-	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_MPU_OFFSET,
-	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
-	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_MPU_MASK,
-	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_MPU_MASK,
-	.ctrl_dtemp_1 = DRA752_DTEMP_MPU_1_OFFSET,
-	.ctrl_dtemp_2 = DRA752_DTEMP_MPU_2_OFFSET,
-	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_MPU_OFFSET,
+	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_MPU_OFFSET,
+	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
+	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
+	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
+	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
+	.mask_hot_mask = OMAP5430_MASK_HOT_MPU_MASK,
+	.mask_cold_mask = OMAP5430_MASK_COLD_MPU_MASK,
+	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
+	.mask_freeze_mask = OMAP5430_MASK_FREEZE_MPU_MASK,
+	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_MPU_OFFSET,
+	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
+	.status_hot_mask = OMAP5430_HOT_MPU_FLAG_MASK,
+	.status_cold_mask = OMAP5430_COLD_MPU_FLAG_MASK,
+	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_MPU_1_OFFSET,
+	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_MPU_2_OFFSET,
+	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_MPU,
 };
 
 /*
@@ -104,13 +105,13 @@
 static struct temp_sensor_registers
 dra752_dspeve_temp_sensor_registers = {
 	.temp_sensor_ctrl = DRA752_TEMP_SENSOR_DSPEVE_OFFSET,
-	.bgap_tempsoff_mask = DRA752_TEMP_SENSOR_TMPSOFF_MASK,
-	.bgap_eocz_mask = DRA752_TEMP_SENSOR_EOCZ_MASK,
-	.bgap_dtemp_mask = DRA752_TEMP_SENSOR_DTEMP_MASK,
+	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
+	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
+	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
 	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_2_OFFSET,
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_2_MASK_HOT_DSPEVE_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_2_MASK_COLD_DSPEVE_MASK,
-	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
+	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_DSPEVE_OFFSET,
 	.bgap_status = DRA752_BANDGAP_STATUS_2_OFFSET,
@@ -126,38 +127,38 @@
  */
 static struct temp_sensor_registers
 dra752_gpu_temp_sensor_registers = {
-	.temp_sensor_ctrl = DRA752_TEMP_SENSOR_GPU_OFFSET,
-	.bgap_tempsoff_mask = DRA752_TEMP_SENSOR_TMPSOFF_MASK,
-	.bgap_eocz_mask = DRA752_TEMP_SENSOR_EOCZ_MASK,
-	.bgap_dtemp_mask = DRA752_TEMP_SENSOR_DTEMP_MASK,
-	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_1_OFFSET,
-	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_GPU_MASK,
-	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_GPU_MASK,
-	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
-	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK,
-	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_GPU_OFFSET,
-	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
-	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_GPU_MASK,
-	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_GPU_MASK,
-	.ctrl_dtemp_1 = DRA752_DTEMP_GPU_1_OFFSET,
-	.ctrl_dtemp_2 = DRA752_DTEMP_GPU_2_OFFSET,
-	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_GPU_OFFSET,
+	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_GPU_OFFSET,
+	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
+	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
+	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
+	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
+	.mask_hot_mask = OMAP5430_MASK_HOT_GPU_MASK,
+	.mask_cold_mask = OMAP5430_MASK_COLD_GPU_MASK,
+	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
+	.mask_freeze_mask = OMAP5430_MASK_FREEZE_GPU_MASK,
+	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_GPU_OFFSET,
+	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
+	.status_hot_mask = OMAP5430_HOT_GPU_FLAG_MASK,
+	.status_cold_mask = OMAP5430_COLD_GPU_FLAG_MASK,
+	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_GPU_1_OFFSET,
+	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_GPU_2_OFFSET,
+	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_GPU,
 };
 
 /* Thresholds and limits for DRA752 temperature sensor */
 static struct temp_sensor_data dra752_temp_sensor_data = {
-	.t_hot = DRA752_T_HOT,
-	.t_cold = DRA752_T_COLD,
-	.min_freq = DRA752_MIN_FREQ,
-	.max_freq = DRA752_MAX_FREQ,
+	.t_hot = OMAP5430_T_HOT,
+	.t_cold = OMAP5430_T_COLD,
+	.min_freq = OMAP5430_MIN_FREQ,
+	.max_freq = OMAP5430_MAX_FREQ,
 };
 
 /*
  * DRA752 : Temperature values in milli degree celsius
  * ADC code values from 540 to 945
  */
-static
-int dra752_adc_to_temp[DRA752_ADC_END_VALUE - DRA752_ADC_START_VALUE + 1] = {
+static int
+dra752_adc_to_temp[OMAP5430_ADC_END_VALUE - OMAP5430_ADC_START_VALUE + 1] = {
 	/* Index 540 - 549 */
 	-40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
 	-37800,
@@ -292,8 +293,8 @@
 	.fclock_name = "l3instr_ts_gclk_div",
 	.div_ck_name = "l3instr_ts_gclk_div",
 	.conv_table = dra752_adc_to_temp,
-	.adc_start_val = DRA752_ADC_START_VALUE,
-	.adc_end_val = DRA752_ADC_END_VALUE,
+	.adc_start_val = OMAP5430_ADC_START_VALUE,
+	.adc_end_val = OMAP5430_ADC_END_VALUE,
 	.sensors = {
 		{
 		.registers = &dra752_mpu_temp_sensor_registers,
-- 
1.9.1
