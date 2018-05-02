Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeEBQTb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:19:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37492 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEBQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:19:28 -0400
MIME-Version: 1.0
X-Google-Smtp-Source: AB8JxZpriBwVwX0r7Zam+1sXcs7o5xw6N1cQoMcQBYMWcm3SiSuJGU4W7veyVKZniDFoSRsI+5rSmg==
From: DongDongJu <commisori@kookmin.ac.kr>
X-Google-Original-From: DongDongJu <commisori28@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: DongDongJu <commisori28@gmail.com>
Subject: [PATCH] modified: arch/x86/mm/pageattr.c
Date: Thu,  3 May 2018 01:19:21 +0900
Message-Id: <1525277961-6158-1-git-send-email-commisori28@gmail.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix mistypo

cehck -> check

Signed-off-by: DongJoo Seo <commisori28@gmail.com>
---
 arch/x86/mm/pageattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 3bded76e..3b4cf12 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1451,7 +1451,7 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	} else if (!(in_flag & CPA_PAGES_ARRAY)) {
 		/*
 		 * in_flag of CPA_PAGES_ARRAY implies it is aligned.
-		 * No need to cehck in that case
+		 * No need to check in that case
 		 */
 		if (*addr & ~PAGE_MASK) {
 			*addr &= PAGE_MASK;
-- 
2.7.4


-- 
