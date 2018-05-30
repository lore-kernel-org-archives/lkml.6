Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeE3TF1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:05:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45689 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbeE3TFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:05:23 -0400
X-Google-Smtp-Source: ADUXVKKiFCpweUi8/792tzWNdHN3cjqf25p4tGFrXhRAHFBGzojexKNP+Kq/ccycE2Q+LTrkXi4S3A==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sankalpnegi2310@gmail.com
Subject: [PATCH v2] staging: mt7621-mmc: Fix line size exceeding 80 columns
Date: Thu, 31 May 2018 00:34:44 +0530
Message-Id: <20180530190444.23006-1-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <87vab6unv2.fsf@notabene.neil.brown.name>
References: <87vab6unv2.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes checkpatch.pl warning and check:
WARNING: line over 80 characters
CHECK: Alignment should match open parenthesis

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
Changes in v2:
  - Made alignments to match open parenthesis.
---
 drivers/staging/mt7621-mmc/dbg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index d897b1216348..6e4e223cddfb 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -229,7 +229,8 @@ static int msdc_debug_proc_read(struct seq_file *s, void *p)
 }
 
 static ssize_t msdc_debug_proc_write(struct file *file,
-				const char __user *buf, size_t count, loff_t *data)
+				     const char __user *buf,
+				     size_t count, loff_t *data)
 {
 	int ret;
 
-- 
2.11.0
