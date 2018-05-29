Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965598AbeE2RiP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:38:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37950 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965416AbeE2RiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:38:03 -0400
X-Google-Smtp-Source: AB8JxZpSvjh2Y2qUmZjaIy+sNpMzh+69RlEEOuyVu/oP0a5a1FOEY6YeXgD28PJhxkq7w8Dsqc/7aw==
Date: Tue, 29 May 2018 23:07:57 +0530
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: NeilBrown <neil@brown.name>, Sankalp Negi <sankalpnegi2310@gmail.com>
Subject: [PATCH] staging: mt7621-mmc: Fix line size exceeding 80 columns.
Message-ID: <20180529173757.nmw46a6xbrgh35wd@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: line over 80 characters

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index d897b1216348..0b007e060ddc 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -229,7 +229,7 @@ static int msdc_debug_proc_read(struct seq_file *s, void *p)
 }
 
 static ssize_t msdc_debug_proc_write(struct file *file,
-				const char __user *buf, size_t count, loff_t *data)
+			const char __user *buf, size_t count, loff_t *data)
 {
 	int ret;
 
-- 
2.11.0
