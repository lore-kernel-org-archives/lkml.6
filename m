Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C9DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE7F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfANLAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:00:50 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:54568 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfANLAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:00:49 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id QB0n1z0053XaVaC01B0ne0; Mon, 14 Jan 2019 12:00:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gizz5-00075s-0e; Mon, 14 Jan 2019 12:00:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gizz4-0002mb-V8; Mon, 14 Jan 2019 12:00:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ext4: Change debugging support help prefix from EXT4 to Ext4
Date:   Mon, 14 Jan 2019 12:00:45 +0100
Message-Id: <20190114110045.10013-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other configuration options for the ext* family of file systems use
"Ext%u" instead of "EXT%u".

Fixes: 6ba495e9259cd9a0 ("ext4: Add configurable run-time mballoc debugging")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/ext4/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 031e5a82d556dbe9..06f77ca7f36ee737 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -97,7 +97,7 @@ config EXT4_FS_SECURITY
 	  extended attributes for file security labels, say N.
 
 config EXT4_DEBUG
-	bool "EXT4 debugging support"
+	bool "Ext4 debugging support"
 	depends on EXT4_FS
 	help
 	  Enables run-time debugging support for the ext4 filesystem.
-- 
2.17.1

