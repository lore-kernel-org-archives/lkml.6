Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935572AbeE3GDZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:03:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36202 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934017AbeE3GDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:03:20 -0400
X-Google-Smtp-Source: ADUXVKJEr/JyJ1gM/EdQtohOEXcVxCqb+5gb5RRRtv4DSd0E+0996a7drlo6oP+JZI9vGgQoel6jZw==
From: Li Qiang <liq3ea@gmail.com>
To: tony.luck@intel.com, fenghua.yu@intel.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Qiang <liq3ea@gmail.com>
Subject: [PATCH] ia64: pgtable.h: fix a comment typo
Date: Tue, 29 May 2018 23:03:14 -0700
Message-Id: <1527660194-4265-1-git-send-email-liq3ea@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 arch/ia64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 165827774bea..2cccfbb23c2d 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -336,7 +336,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	if (pte_present_exec_user(pteval) &&
 	    (!pte_present(*ptep) ||
 		pte_pfn(*ptep) != pte_pfn(pteval)))
-		/* load_module() calles flush_icache_range() explicitly*/
+		/* load_module() calls flush_icache_range() explicitly*/
 		__ia64_sync_icache_dcache(pteval);
 	*ptep = pteval;
 }
-- 
2.11.0
