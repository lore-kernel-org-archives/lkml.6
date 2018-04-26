Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756315AbeDZLzm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:55:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48668 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755522AbeDZLwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:22 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180426115220epoutp02ea03e94af2d6615023c1741da433c03e~o_ivu8ziB1582315823epoutp02U
X-AuditID: b6c32a46-145ff70000001024-ba-5ae1bd730cce
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 08/18] thermal: exynos: make ->tmu_initialize method void
Date: Thu, 26 Apr 2018 13:51:23 +0200
Message-id: <1524743493-28113-9-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmuW7x3odRBkdXSllsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcWpKP3vBZ4WK/3/OMzUwnpbuYuTkkBAwkdh6dQJzFyMXh5DADkaJh9t2skA43xkl
        Vi7fw97FyAFW9WOyB0R8A6PElknzGCGcX4wSl06sYwUZxSZgJTGxfRUjiC0ioCVx4tJ2JpAi
        ZoE5jBKzGnazgCSEBTwl9qzdygRiswioSkw/dw7M5hXwkLh0fCsbxE1yEiePTQYbyglUf+FI
        EwtEvJFN4swRRwjbReL3/ovMELawxKvjW9ghbGmJZ6s2gl0nIdDMKPFtxx6oogmMEnvWC0HY
        1hKHj18EW8AswCfRcfgv1Ju8Eh1tUCUeEk++PmGEsB0lHs35yArxMdAzV1pvsUxglFrAyLCK
        USy1oDg3PbXYqMBIrzgxt7g0L10vOT93EyM4BrXcdjAuOedziFGAg1GJhzdg4YMoIdbEsuLK
        3EOMEhzMSiK88a0Po4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzNvieiRISSE8sSc1OTS1ILYLJ
        MnFwSjUwXpeVTOLkztkowNxmlyv2eU6E+cep3VWd+6xXyz+I4uCpYAtzeJR2V5nxzvIiyzoX
        17nVDBr5svOs5ySrNOvwd66wEBB5+vVVcM7KZxdvVD8ouL35odrVmN5/8SbeIv62ov/tlUqm
        m+cJXv56eOf6bz7XnAT+/2D8G5koaCNluftWj4jH8xNKLMUZiYZazEXFiQDLQZF8vQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG7x3odRBn8WsVhsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcWpKP3vBZ4WK/3/OMzUwnpbuYuTgkBAwkfgx2aOLkYtDSGAdo8S3Wz9YIZxfjBLL
        d89n6WLk5GATsJKY2L6KEcQWEdCSOHFpOxNIEbPAHEaJ5yvmMIEkhAU8Jfas3QpmswioSkw/
        dw7M5hXwkLh0fCsbiC0hICdx8thkVhCbE6j+wpEmsAVCQDX3+96zTWDkWcDIsIpRMrWgODc9
        t9iowCgvtVyvODG3uDQvXS85P3cTIzBkth3W6t/B+HhJ/CFGAQ5GJR7egIUPooRYE8uKK3MP
        MUpwMCuJ8Ma3PowS4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1OzW1ILUIJsvE
        wSnVwJho4sOb/vvd5Yaf6zVjbs17bbJL7IRq+erFiW++e/5hNozSXCvQOveeiXwqb9yXu2o7
        XzqFMCRLS+TH2WcxBT+eprXw7A73FccOPOXbkLpMaemJomNtM89vaq565pE1YW3M0+d7bCZw
        xm1bKWnrt2B/vMDRl/qdl9edmV9uOVH9yE7D/msPfPSVWIozEg21mIuKEwEscoWZFQIAAA==
X-CMS-MailID: 20180426115219epcas2p48747814c37573e56473fe246955656fd
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115219epcas2p48747814c37573e56473fe246955656fd
X-RootMTR: 20180426115219epcas2p48747814c37573e56473fe246955656fd
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115219epcas2p48747814c37573e56473fe246955656fd@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All implementations of ->tmu_initialize always return 0 so make
the method void and convert all implementations accordingly.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 26a0cb9..44a426a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -220,7 +220,7 @@ struct exynos_tmu_data {
 	unsigned int ntrip;
 	bool enabled;
 
-	int (*tmu_initialize)(struct platform_device *pdev);
+	void (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
 	void (*tmu_set_emulation)(struct exynos_tmu_data *data, int temp);
@@ -369,7 +369,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	if (!status)
 		ret = -EBUSY;
 	else
-		ret = data->tmu_initialize(pdev);
+		data->tmu_initialize(pdev);
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
@@ -409,13 +409,13 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	mutex_unlock(&data->lock);
 }
 
-static int exynos4210_tmu_initialize(struct platform_device *pdev)
+static void exynos4210_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tz);
-	int ret = 0, threshold_code, i;
+	int threshold_code, i;
 	unsigned long reference, temp;
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
@@ -432,17 +432,15 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-
-	return ret;
 }
 
-static int exynos4412_tmu_initialize(struct platform_device *pdev)
+static void exynos4412_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(data->tzd);
 	unsigned int trim_info, con, ctrl, rising_threshold;
-	int ret = 0, threshold_code, i;
+	int threshold_code, i;
 	unsigned long crit_temp = 0;
 
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
@@ -490,18 +488,16 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 	con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
 	con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
-
-	return ret;
 }
 
-static int exynos5433_tmu_initialize(struct platform_device *pdev)
+static void exynos5433_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
 	int temp, temp_hist;
-	int ret = 0, threshold_code, i, sensor_id, cal_type;
+	int threshold_code, i, sensor_id, cal_type;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
@@ -577,17 +573,15 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-
-	return ret;
 }
 
-static int exynos7_tmu_initialize(struct platform_device *pdev)
+static void exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
-	int ret = 0, threshold_code, i;
+	int threshold_code, i;
 	int temp, temp_hist;
 	unsigned int reg_off, bit_off;
 
@@ -643,8 +637,6 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-
-	return ret;
 }
 
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
-- 
1.9.1
