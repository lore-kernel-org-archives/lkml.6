Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935819AbeCHLjy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:39:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933352AbeCHLjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:39:52 -0500
Date: Thu, 8 Mar 2018 03:39:46 -0800
From: tip-bot for Seunghun Han <tipbot@zytor.com>
Message-ID: <tip-c5b679f5c9e3851ee118d95961def374bb3b4ce6@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, kkamagui@gmail.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        kkamagui@gmail.com, mingo@kernel.org
In-Reply-To: <1520397135-132809-1-git-send-email-kkamagui@gmail.com>
References: <1520397135-132809-1-git-send-email-kkamagui@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Fix a comment typo
Git-Commit-ID: c5b679f5c9e3851ee118d95961def374bb3b4ce6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c5b679f5c9e3851ee118d95961def374bb3b4ce6
Gitweb:     https://git.kernel.org/tip/c5b679f5c9e3851ee118d95961def374bb3b4ce6
Author:     Seunghun Han <kkamagui@gmail.com>
AuthorDate: Wed, 7 Mar 2018 13:32:15 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:33:21 +0100

x86/pti: Fix a comment typo

s/visinble/visible/

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1520397135-132809-1-git-send-email-kkamagui@gmail.com

---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ce38f165489b..631507f0c198 100644
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
