Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeEGGyi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:54:38 -0400
Received: from exmail.andestech.com ([59.124.169.137]:45930 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeEGGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:54:34 -0400
From: Nickhu <nickhu@andestech.com>
To: <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <green.hu@gmail.com>, <vincentc@andestech.com>
CC: Nickhu <nickhu@andestech.com>
Subject: [PATCH 1/2] nds32: Renaming the file for unaligned access
Date: Mon, 7 May 2018 14:45:01 +0800
Message-ID: <e49ea6d0dbe30b7b8654fc731d2aa8ab98be5c78.1525673368.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525673368.git.nickhu@andestech.com>
References: <cover.1525673368.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w476bTVN068175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the name of the file '/proc/sys/nds32/unaligned_acess'
to '/proc/sys/nds32/unaligned_access'

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/mm/alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index b96a01b10ca7..e515f6f3d247 100644
--- a/arch/nds32/mm/alignment.c
+++ b/arch/nds32/mm/alignment.c
@@ -552,7 +552,7 @@ static struct ctl_table alignment_tbl[3] = {
 
 static struct ctl_table nds32_sysctl_table[2] = {
 	{
-	 .procname = "unaligned_acess",
+	 .procname = "unaligned_access",
 	 .mode = 0555,
 	 .child = alignment_tbl},
 	{}
-- 
2.17.0
