Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeB1JoI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:44:08 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37419 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751631AbeB1JoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:44:07 -0500
From: Erez.Alfasi.ereza@mellanox.com
To: pombredanne@nexb.com
Cc: kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH] elfcore.c: Fix coding style issue
Date: Wed, 28 Feb 2018 11:43:55 +0200
Message-Id: <1519811035-11177-1-git-send-email-ereza@mellanox.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

Fix over 80 characters line issue.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
---
 kernel/elfcore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/elfcore.c b/kernel/elfcore.c
index fc482c8..c2f7ac6 100644
--- a/kernel/elfcore.c
+++ b/kernel/elfcore.c
@@ -9,7 +9,8 @@ Elf_Half __weak elf_core_extra_phdrs(void)
 	return 0;
 }
 
-int __weak elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset)
+int __weak elf_core_write_extra_phdrs(struct coredump_params *cprm,
+				      loff_t offset)
 {
 	return 1;
 }
-- 
2.7.5
