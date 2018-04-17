Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755071AbeDQQIP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:08:15 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43695 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754763AbeDQQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:08:12 -0400
X-Google-Smtp-Source: AIpwx49jyew33+6ZEAnRxz9OkVnV+mQNWUklogs9LL3b1lRBckay1y29EKGpbWRLe+OJ8vbhdN+mwA==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Ben.Gainey@arm.com
Subject: [PATCH v2 1/3] coresight: Remove obsolete reference to "owner" in CoreSight descriptor
Date: Tue, 17 Apr 2018 10:08:05 -0600
Message-Id: <1523981287-15370-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523981287-15370-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523981287-15370-1-git-send-email-mathieu.poirier@linaro.org>
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
