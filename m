Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbeDPTgS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:36:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39246 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbeDPTfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:35:31 -0400
X-Google-Smtp-Source: AIpwx4/xCS7yHaKCC6rmheyU5PAS+FpT+1Wb2Dub8EicOwixHx97u9GX7IGLy5GlJDV1fYzA9BvJ8A==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Gainey@arm.com
Subject: [PATCH 1/3] coresight: Remove obsolete reference to "owner" in CoreSight descriptor
Date: Mon, 16 Apr 2018 13:35:25 -0600
Message-Id: <1523907327-20979-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Field "owner" of struct coresight_desc has been removed a while back but
the documentation was not updated to reflect the changes.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 6f0120c3a4f1..710c75b6c73f 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -187,9 +187,6 @@ that can be performed on them (see "struct coresight_ops").  The
 specific to that component only.  "Implementation defined" customisations are
 expected to be accessed and controlled using those entries.
 
-Last but not least, "struct module *owner" is expected to be set to reflect
-the information carried in "THIS_MODULE".
-
 How to use the tracer modules
 -----------------------------
 
-- 
2.7.4
