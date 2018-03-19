Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032214AbeCSV0I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:26:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44090 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933624AbeCSV0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:26:03 -0400
From: Stefan Agner <stefan@agner.ch>
To: thierry.reding@gmail.com, airlied@linux.ie
Cc: jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] drm/tegra: dc: use correct format array for Tegra124.
Date: Mon, 19 Mar 2018 22:25:58 +0100
Message-Id: <20180319212558.11119-1-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tegra124_(primary|overlay)_formats for Tegra124.

Fixes: 511c7023cf23 ("drm/tegra: dc: Support more formats")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/tegra/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index b8403ed48285..fdc3195557c4 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1999,9 +1999,9 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.coupled_pm = false,
 	.has_nvdisplay = false,
 	.num_primary_formats = ARRAY_SIZE(tegra124_primary_formats),
-	.primary_formats = tegra114_primary_formats,
+	.primary_formats = tegra124_primary_formats,
 	.num_overlay_formats = ARRAY_SIZE(tegra124_overlay_formats),
-	.overlay_formats = tegra114_overlay_formats,
+	.overlay_formats = tegra124_overlay_formats,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
-- 
2.16.2
