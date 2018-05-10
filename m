Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966419AbeEJQCr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:02:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51639 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965030AbeEJQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:02:46 -0400
From: Colin King <colin.king@canonical.com>
To: Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: kprobes: fix spelling mistake: "undefeined" -> "undefined"
Date: Thu, 10 May 2018 17:02:39 +0100
Message-Id: <20180510160239.21091-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/probes/kprobes/test-thumb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/test-thumb.c b/arch/arm/probes/kprobes/test-thumb.c
index b683b4517458..6841909757cd 100644
--- a/arch/arm/probes/kprobes/test-thumb.c
+++ b/arch/arm/probes/kprobes/test-thumb.c
@@ -787,7 +787,7 @@ CONDITION_INSTRUCTIONS(22,
 
 	TEST_UNSUPPORTED(__inst_thumb32(0xf7f08000) " @ smc #0")
 
-	TEST_UNSUPPORTED(__inst_thumb32(0xf7f0a000) " @ undefeined")
+	TEST_UNSUPPORTED(__inst_thumb32(0xf7f0a000) " @ undefined")
 
 	TEST_BF(  "b.w	2f")
 	TEST_BB(  "b.w	2b")
-- 
2.17.0
