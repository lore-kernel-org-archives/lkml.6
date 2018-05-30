Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeE3MQj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:16:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34116 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeE3MQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180530121625euoutp02a34ba9e588a9e04757b2653ecf85c5d9~zazej0X5Y0108401084euoutp02q
X-AuditID: cbfec7f2-5ffe19c000011644-34-5b0e96174ce9
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2 01/10] drm/exynos: rename "bridge_node" to
 "mic_bridge_node"
Date: Wed, 30 May 2018 14:15:52 +0200
Message-id: <1527682561-1386-2-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe3fO2Tkup8dp+GppsAxCyJTE3rA0Uuh8Cbp9CAVt6UGlbdqO
        8xKhInnPO17KUKEpuqzWFE1LyWmalzZ15q28YUhmUnkrkTTn9Nvv+T//5//wwENhojTCkYqQ
        R7MKuUQq5gvwxq4N/Un7YqtA95UibzTxQk+gbH0PDyWnLxHoVelLAlV07mjDaz/5qGA6D0ff
        pgZxlDu3iCGDQUOij8k/SJSRryKRdm6EQMaWJ3xUamjjocqFCRw975wkUdXoIA+ltHaSqLRw
        gY82WsrxC4eYuvI6wBhzsnlM8+NJkilLf0QwWnUGn2lanyGY6axuHlOvSmRyGtSAWdE6XxEE
        CM6FstKIGFZxyueWIHw2uZ2Iem8Tpx6qBUlgxioTWFCQ9oT1U40gEwgoEV0DYPJvPWEuVgAs
        3Oji7bs223WYuVEN4NDf/j3XNoBrJas7BUXxaVdYlxZs0u1oNYD1Y0u7uRhdRMCBikXCFGVL
        X4UNNWWYiXH6OOyd6eGbWEj7wV6DijCvc4bj+gzMFGpB+8Nnb31MOZAuJKFOVbvn8YcTmZ8x
        M9vC790NpJmPQGNhFm7mSJgyP7enx8G27L69WW/Y0T24yxhtBQsaS3Z3QVoI01NFZgsDN/8N
        kOYjSwAsrx8n8oBDJTigBvaskpOFsZyHnI114yQyTikPcwuJlGnBznv0bXUvvwZrQ7d1gKaA
        2FLoflMYKCIkMVy8TAcghYnthMpWy0CRMFQSf49VRAYrlFKW04HDFC62FwadSAgQ0WGSaPYO
        y0axiv0uj7JwTAIZW0cP5gbZtUYmRl/q8FWplUKXs9siVXGz1431PrlG6nmXuf5w+5ev4J2G
        n1/sRNRU/XlgE159f3WsjG2P1ZZ9uhY14O+Y59VmPZ9TfsxPb3RtmmUTnEaHRy4nLoc0aCS0
        kyHV5aL1V2Na6NP+N9SH2NOuk19qVZzt+dbMM8MOYpwLl3i4YgpO8h/UMxCxGgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xy7pi0/iiDf40GFjcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLSfcnsFi8uHeRxaL/8Wtmi/PnN7BbnG16w27ROXEJu8Wm
        x9dYLS7vmsNmMeP8PiaLBS9vsVisPXKX3WLp9YtMFq17j7BbzJj8ks3i5655LA6iHmvmrWH0
        uNzXy+Sxc9Zddo/ZHTNZPTat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAFcUl01Kak5m
        WWqRvl0CV8bDpoOsBUcFK1ZdWsnYwPiAr4uRk0NCwETi98FDzF2MXBxCAksYJQ6f+sQE4TQy
        SUxY2cDYxcjBwSagJbGmPR4kLiKwilFi6t877CAOs8BsVolXjyYwgowSFvCXWLD2PRuIzSKg
        KnHqwUkwm1fAWeLU+SWsEOvkJG6e62QGGcop4CKxeo8dSFgIqGRfSyfjBEaeBYwMqxhFUkuL
        c9Nzi430ihNzi0vz0vWS83M3MQIDf9uxn1t2MHa9Cz7EKMDBqMTDaxDBGy3EmlhWXJl7iFGC
        g1lJhLd0L0+0EG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp2ampBalFMFkmDk6p
        BkYx+VrxlEnbP82Sk/ujHnj0oOG7Q3t5gnIWThFnOjd1xjMOka/Lwr6lTnBZ3Pgj1CPrquVr
        Z9lMJin2EpPYM7+9/6yN/uIXws/DNH/2zSVN2/7KvJnNUvKy9FK77L6YZ3n3FSynPL0+TeuB
        q1Wsftqz8hbnlwufvxbZ/nTRt0wmr+SmIo+7PVuUWIozEg21mIuKEwGWdzwieAIAAA==
X-CMS-MailID: 20180530121623eucas1p27e08223bc5b04dbb0b0253c18a9f83d5
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121623eucas1p27e08223bc5b04dbb0b0253c18a9f83d5
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121623eucas1p27e08223bc5b04dbb0b0253c18a9f83d5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding support for peripheral out bridges, the "bridge" name
becomes imprecise as it refers to a different device than the
"out_bridge".

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index eae44fd..9599e6b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -279,7 +279,7 @@ struct exynos_dsi {
 	struct list_head transfer_list;
 
 	const struct exynos_dsi_driver_data *driver_data;
-	struct device_node *bridge_node;
+	struct device_node *mic_bridge_node;
 };
 
 #define host_to_dsi(host) container_of(host, struct exynos_dsi, dsi_host)
@@ -1631,7 +1631,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
 	if (ret < 0)
 		return ret;
 
-	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
+	dsi->mic_bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
 
 	return 0;
 }
@@ -1642,7 +1642,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 	struct drm_encoder *encoder = dev_get_drvdata(dev);
 	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
 	struct drm_device *drm_dev = data;
-	struct drm_bridge *bridge;
+	struct drm_bridge *mic_bridge;
 	int ret;
 
 	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
@@ -1661,10 +1661,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
-	if (dsi->bridge_node) {
-		bridge = of_drm_find_bridge(dsi->bridge_node);
-		if (bridge)
-			drm_bridge_attach(encoder, bridge, NULL);
+	if (dsi->mic_bridge_node) {
+		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
+		if (mic_bridge)
+			drm_bridge_attach(encoder, mic_bridge, NULL);
 	}
 
 	return mipi_dsi_host_register(&dsi->dsi_host);
@@ -1783,7 +1783,7 @@ static int exynos_dsi_remove(struct platform_device *pdev)
 {
 	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
 
-	of_node_put(dsi->bridge_node);
+	of_node_put(dsi->mic_bridge_node);
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.7.4
