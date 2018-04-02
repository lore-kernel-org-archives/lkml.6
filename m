Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756682AbeDBUAp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:00:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43257 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbeDBUAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:00:41 -0400
X-Google-Smtp-Source: AIpwx48QgnFSIJ7Wmj9naVANQxgimbKcpEIa9KTp+vezYFjLh9nsQ2vlNd7buYRCs12zR8RN+96LjQ==
From: Nasser Afshin <afshin.nasser@gmail.com>
X-Google-Original-From: Nasser Afshin <Afshin.Nasser@gmail.com>
To: mchehab@kernel.org
Cc: Nasser Afshin <Afshin.Nasser@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] media: i2c: tvp5150: Use parentheses for sizeof
Date: Tue,  3 Apr 2018 00:29:05 +0430
Message-Id: <20180402195907.14368-4-Afshin.Nasser@gmail.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180402195907.14368-1-Afshin.Nasser@gmail.com>
References: <20180402195907.14368-1-Afshin.Nasser@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves a checkpatch.pl warning

Signed-off-by: Nasser Afshin <Afshin.Nasser@gmail.com>
---
 drivers/media/i2c/tvp5150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index d561d87d219a..d528fddbea16 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -625,7 +625,7 @@ static int tvp5150_g_sliced_vbi_cap(struct v4l2_subdev *sd,
 	int line, i;
 
 	dev_dbg_lvl(sd->dev, 1, debug, "g_sliced_vbi_cap\n");
-	memset(cap, 0, sizeof *cap);
+	memset(cap, 0, sizeof(*cap));
 
 	for (i = 0; i < ARRAY_SIZE(vbi_ram_default); i++) {
 		const struct i2c_vbi_ram_value *regs = &vbi_ram_default[i];
-- 
2.15.0
