Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756304AbeDZLxI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:53:08 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48501 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755792AbeDZLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180426115244epoutp014d0c5db5a1c7039143c59fbceaf7fef2~o_jGkaiNW0415504155epoutp01W
X-AuditID: b6c32a46-145ff70000001024-e8-5ae1bd8ccbbe
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 18/18] thermal: exynos: remove trip reporting to user-space
Date: Thu, 26 Apr 2018 13:51:33 +0200
Message-id: <1524743493-28113-19-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmmW7P3odRBj1vNCw2zljPajH/yjVW
        i8u75rBZfO49wmgx4/w+JosnD/vYHNg8ds66y+6xeM9LJo++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKWPRsG1PBKb6Kye1XmBsYZ/J0MXJwSAiYSHw7wd7FyMUhJLCDUWLb+zZGCOc7o8TP
        huesXYycYEUPlpyFSmxglDj8aicrhPOLUWLlp2nsIFVsAlYSE9tXMYLYIgJaEicubWcCKWIW
        mMMoMathNwtIQljAW+Lo7/fMIDaLgKrEjmmTwVbwCnhKfHnyAWqdnMTJYxBxTqD4hSNNLCCD
        JAR+skq8/nCUCaLIRWLdzxssELawxKvjW9ghbGmJZ6s2MkI0NDNKfNuxhxkiMYFRYs96IQjb
        WuLw8YtgG5gF+CQ6Dv9lh4QGr0RHG1SJh8S1J+eZIMKOEqf2u0J8DPTMpQNrmCYwSi1gZFjF
        KJZaUJybnlpsVGCkV5yYW1yal66XnJ+7iREcg1puOxiXnPM5xCjAwajEwxuw8EGUEGtiWXFl
        7iFGCQ5mJRHe+NaHUUK8KYmVValF+fFFpTmpxYcYpTlYlMR5G3zPRAkJpCeWpGanphakFsFk
        mTg4pRoYF6/b+mTO1MWuXPYnWtkEvXd9u5ez5pnokSa7Rc4HC9Le7Ht+S/1XtcjXhADjtRef
        LuJ5yfiRTeVVo+s94/U3+3dMan+5aMIuN+s8L4V7nYfP8SU/1vlxZbu1SU+P2+Pio1P4y9Ue
        LqkvcAjm0/O/3vqsQIVXKVL33TlWvbk/28tVLTJX7+i0UGIpzkg01GIuKk4EAMr8UYK9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG7P3odRBptXsltsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsejZNqaCU3wVk9uvMDcwzuTpYuTkkBAwkXiw5CwjiC0ksI5R4u2noC5GLiD7F6PE
        gh8T2UESbAJWEhPbV4EViQhoSZy4tJ0JpIhZYA6jxPMVc5hAEsIC3hJHf79nBrFZBFQldkyb
        zApi8wp4Snx58oEVYpucxMljEHFOoPiFI00sEJs9JO73vWebwMizgJFhFaNkakFxbnpusVGB
        UV5quV5xYm5xaV66XnJ+7iZGYMhsO6zVv4Px8ZL4Q4wCHIxKPLwBCx9ECbEmlhVX5h5ilOBg
        VhLhjW99GCXEm5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpiSWp2ampBahFMlomDU6qB
        seHq9Uu39R25b2+S3xbRvopHZ8lUw0tqHOwv/jIr7p5vYjLZa9bSZI6eXI0phttVGv/0HmKV
        aJT44Wm59abMzjn/eaebbtglPPu1C0tRq+Ghz8tLVJaeskqymcu/dunDkp6avsVnl52fzM4q
        /lNJrV2iodit0dT3jKKvYLLhn9/F6ReU5R5HKLEUZyQaajEXFScCAE840KgVAgAA
X-CMS-MailID: 20180426115244epcas2p36d0d44d1a0b2c3c4edff33187046caac
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115244epcas2p36d0d44d1a0b2c3c4edff33187046caac
X-RootMTR: 20180426115244epcas2p36d0d44d1a0b2c3c4edff33187046caac
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115244epcas2p36d0d44d1a0b2c3c4edff33187046caac@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trip reporting to user-space - I'm not aware of any user-space
program which relies on it and there is a thermal user-space governor
which does it in proper way nowadays.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed02b40..f785e6a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -216,33 +216,6 @@ struct exynos_tmu_data {
 	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
 };
 
-static void exynos_report_trigger(struct exynos_tmu_data *p)
-{
-	char data[10], *envp[] = { data, NULL };
-	struct thermal_zone_device *tz = p->tzd;
-	int temp;
-	unsigned int i;
-
-	if (!tz) {
-		pr_err("No thermal zone device defined\n");
-		return;
-	}
-
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
-	mutex_lock(&tz->lock);
-	/* Find the level for which trip happened */
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		tz->ops->get_trip_temp(tz, i, &temp);
-		if (tz->last_temperature < temp)
-			break;
-	}
-
-	snprintf(data, sizeof(data), "%u", i);
-	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, envp);
-	mutex_unlock(&tz->lock);
-}
-
 /*
  * TMU treats temperature as a mapped temperature code.
  * The temperature is converted differently depending on the calibration type.
@@ -814,7 +787,8 @@ static void exynos_tmu_work(struct work_struct *work)
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
 
-	exynos_report_trigger(data);
+	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
+
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 
-- 
1.9.1
