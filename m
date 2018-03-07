Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeCGEeY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 23:34:24 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38751 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbeCGEeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 23:34:22 -0500
X-Google-Smtp-Source: AG47ELstyCA1BgSbxoSZrAoYkNyvh4R3IDRjAq1JR9TJW344eLe2Jg2ZeDQyWu1llDF+a4chUe6vfQ==
From: Seunghun Han <kkamagui@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH] x86: mm: typo: fix a typo in a comment line
Date: Wed,  7 Mar 2018 13:32:15 +0900
Message-Id: <1520397135-132809-1-git-send-email-kkamagui@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in a comment line of pti.c.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ce38f16..631507f 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -332,7 +332,7 @@ static void __init pti_clone_user_shared(void)
 }
 
 /*
- * Clone the ESPFIX P4D into the user space visinble page table
+ * Clone the ESPFIX P4D into the user space visible page table
  */
 static void __init pti_setup_espfix64(void)
 {
-- 
2.1.4
