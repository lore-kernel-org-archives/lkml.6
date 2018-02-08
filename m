Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeBHO7G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:59:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40751 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750961AbeBHO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:59:05 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Philippe Cornu <philippe.cornu@st.com>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Sandy Huang" <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Philippe Ombredanne" <pombredanne@nexb.com>
Subject: [PATCH v2] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
Date: Thu, 8 Feb 2018 15:58:05 +0100
Message-ID: <20180208145805.24762-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
host controller driver.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
Changes in v2: Update to "GPL-2.0+" following comments from Laurent
Pinchart, Benjamin Gaignard & Philippe Ombredanne.

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 7bac101c285c..99f0e4f51716 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
  * Copyright (C) STMicroelectronics SA 2017
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * Modified by Philippe Cornu <philippe.cornu@st.com>
  * This generic Synopsys DesignWare MIPI DSI host driver is based on the
  * Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.
-- 
2.15.1
