Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932130AbeE1Jrg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:47:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54995 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754194AbeE1Jr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180528094724euoutp01866446e973e9ee02989115cd67d81f89~yxezc_QEg1912619126euoutp011
X-AuditID: cbfec7f2-1dbff70000011644-b1-5b0bd02bc827
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
Subject: [PATCH 01/12] drm/exynos: rename "bridge_node" to "mic_bridge_node"
Date: Mon, 28 May 2018 11:47:05 +0200
Message-id: <1527500833-16005-2-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0iTYRTGe7fv5mr2ORe+WQkNQlG0hIIXtBAy+krBoISYlq788rppm/eg
        xPJ+mXkhNVMxL7Wm1RRvoDS1hi3vpqWZlpaaiZUpiHRxfvrf7zznOeeBw6H4oiTcmgpWRLJK
        hSxMQgiwxldrfY4O/Tt9jjTOSdBYXS+Osnq7eSgxdRFHzwuf4qisa0MbXlkiUO5kDobmPg5g
        SD29wEd9fc9I1JP4nURpdytJpJsewdFQawmBCvvaeah8fgxDtV0TJKoaHeChpLYuEhXmzRNo
        rbUUc9vDaEu1gBnKzuIxLcUTJHM/tQhndJo0gmlancKZyQwDj6mvvMVkN2gAs6yzOSeQClwD
        2LDgaFZ5+IS/IOhToh6PeGkRqxl8DBLAlHk6MKMgfRS2rb8g0oGAEtGPAGx7OEKaGiJ6GcDZ
        Jw7bpsGJVsCZqgEcMWhwrvgHYKfxN5YOKIqg7aE2xc+ki2kNgPXvFjcn+HQBDvvLFnDTKkva
        E47lrxEmxuhDsKjOsBknpN1h5lIJycXZwPe9aXwTm9Gn4FBbMmEKgLSahOpQzuIO38yu8ji2
        hN8MDVuj++FQXgbGcThM+jq9pcfC9iwjzrEL7DQMbDKfNoe5jff43HohTE0WcRYGlo33bF2l
        EMDXq5W8HLC3HOzQACs2SiUPZFXOCjbGSSWTq6IUgU5Xw+U6sPEcxr+GX81gZfBKB6ApINkl
        tFsT+IhwWbQqTt4BIMWXiIUCxw1JGCCLi2eV4X7KqDBW1QH2UZjESnjZ7qZURAfKItlQlo1g
        ldtdHmVmnQAOnr0w49b0x1/KjLcMo/l1vfTH7tV+D2OUY0HIzIOTrmG++TUHPlheE3rHqFFF
        t61eTwmk2NsvKeLqGgtj8TEX2enrTHjtukfgaMVxFx9zH9uu+Ez0udRrIteodhMrPC5k357V
        0ZeSqpx8PX9W+98JubHira24eL6q2cvJM/SMBFMFyZzt+UqV7D+PtHdNGAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xy7paF7ijDW7e1bG4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsEroyHTQdZC44KVqy6tJKxgfEBXxcjJ4eEgInEpbu7GLsYuTiEBJYwStzoXMIG4TQy
        Sex9sQ0ow8HBJqAlsaY9HiQuIrCKUWLq3zvsIA6zwGxWiVePJjCCjBIW8JG4NeUnG4jNIqAq
        MXPdcXYQm1fARaLn/Rx2iHVyEjfPdTKD2JwCrhKX97aB1QsB1WxvnMUygZFnASPDKkaR1NLi
        3PTcYiO94sTc4tK8dL3k/NxNjMDQ33bs55YdjF3vgg8xCnAwKvHwavzkihZiTSwrrsw9xCjB
        wawkwsulCxTiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96gMkpIID2xJDU7NbUgtQgmy8TBKdXA
        KJJe+Cou9OjXF6UanO8zmpJjf858ep5HzPjpm458N75jk2brL70Y9kzS8dDpd/t2pb2dYKH1
        eKYYR6/qwgn6Syd6WZ2yveOyxvuUgL5J55+yuCYr2wxHf67TJ+N8t5xLLWH7vv672LMQO/YI
        buM7mtfVPuzSuvl7R+YJD7HNc5fGW061/birVImlOCPRUIu5qDgRAAG2vz95AgAA
X-CMS-MailID: 20180528094722eucas1p28c087e8b9174e0591bf3cb6526885777
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094722eucas1p28c087e8b9174e0591bf3cb6526885777
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094722eucas1p28c087e8b9174e0591bf3cb6526885777@eucas1p2.samsung.com>
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
