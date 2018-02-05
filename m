Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeBECdc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 21:33:32 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44891 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeBECd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 21:33:26 -0500
X-Google-Smtp-Source: AH8x2254efJfVEsnRCqrSkjV+wkZ2J9Vw9Hl+jZN3HR2OhYARtNUAzNbpjFxV55ixGr9gWQzAqOBRg==
From: Alexandre Courbot <acourbot@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] media: v4l2_fh.h: add missing kconfig.h include
Date: Mon,  5 Feb 2018 11:33:04 +0900
Message-Id: <20180205023304.157171-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2_fh.h uses the IS_ENABLED() macro and thus should include kconfig.h.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 include/media/v4l2-fh.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/media/v4l2-fh.h b/include/media/v4l2-fh.h
index 62633e7d2630..ea73fef8bdc0 100644
--- a/include/media/v4l2-fh.h
+++ b/include/media/v4l2-fh.h
@@ -22,6 +22,7 @@
 #define V4L2_FH_H
 
 #include <linux/fs.h>
+#include <linux/kconfig.h>
 #include <linux/list.h>
 #include <linux/videodev2.h>
 
-- 
2.16.0.rc1.238.g530d649a79-goog
