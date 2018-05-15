Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeEOFU7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:20:59 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33253 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeEOFU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:20:57 -0400
X-Google-Smtp-Source: AB8JxZquq4AFHUYVPCpRGw91puJNTRdYKWLfSMvgrwx3aYat37A2OqhVFjR97ViZgDk1K8lsn7GEbg==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: abbotti@mev.co.uk
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Pratik Jain <pratik.jain0509@gmail.com>
Subject: [PATCH] Staging:Comedi:comedi_compat32.c: Lindent changes
Date: Tue, 15 May 2018 10:50:39 +0530
Message-Id: <20180515052039.12828-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recommended indentation by Lindent on file comedi_compat32.c

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
---
 drivers/staging/comedi/comedi_compat32.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/comedi/comedi_compat32.c b/drivers/staging/comedi/comedi_compat32.c
index 97fb9388bc22..fa9d239474ee 100644
--- a/drivers/staging/comedi/comedi_compat32.c
+++ b/drivers/staging/comedi/comedi_compat32.c
@@ -34,7 +34,7 @@
 struct comedi32_chaninfo_struct {
 	unsigned int subdev;
 	compat_uptr_t maxdata_list;	/* 32-bit 'unsigned int *' */
-	compat_uptr_t flaglist;		/* 32-bit 'unsigned int *' */
+	compat_uptr_t flaglist;	/* 32-bit 'unsigned int *' */
 	compat_uptr_t rangelist;	/* 32-bit 'unsigned int *' */
 	unsigned int unused[4];
 };
@@ -57,16 +57,16 @@ struct comedi32_cmd_struct {
 	unsigned int scan_end_arg;
 	unsigned int stop_src;
 	unsigned int stop_arg;
-	compat_uptr_t chanlist;		/* 32-bit 'unsigned int *' */
+	compat_uptr_t chanlist;	/* 32-bit 'unsigned int *' */
 	unsigned int chanlist_len;
-	compat_uptr_t data;		/* 32-bit 'short *' */
+	compat_uptr_t data;	/* 32-bit 'short *' */
 	unsigned int data_len;
 };
 
 struct comedi32_insn_struct {
 	unsigned int insn;
 	unsigned int n;
-	compat_uptr_t data;		/* 32-bit 'unsigned int *' */
+	compat_uptr_t data;	/* 32-bit 'unsigned int *' */
 	unsigned int subdev;
 	unsigned int chanspec;
 	unsigned int unused[3];
@@ -74,7 +74,7 @@ struct comedi32_insn_struct {
 
 struct comedi32_insnlist_struct {
 	unsigned int n_insns;
-	compat_uptr_t insns;		/* 32-bit 'struct comedi_insn *' */
+	compat_uptr_t insns;	/* 32-bit 'struct comedi_insn *' */
 };
 
 /* Handle translated ioctl. */
@@ -194,7 +194,7 @@ static int get_compat_cmd(struct comedi_cmd __user *cmd,
 	err |= __put_user(temp.uint, &cmd->stop_arg);
 	err |= __get_user(temp.uptr, &cmd32->chanlist);
 	err |= __put_user((unsigned int __force *)compat_ptr(temp.uptr),
-			&cmd->chanlist);
+			  &cmd->chanlist);
 	err |= __get_user(temp.uint, &cmd32->chanlist_len);
 	err |= __put_user(temp.uint, &cmd->chanlist_len);
 	err |= __get_user(temp.uptr, &cmd32->data);
-- 
2.17.0
