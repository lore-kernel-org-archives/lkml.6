Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeC1XHI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 19:07:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55034 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeC1XHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 19:07:07 -0400
From: Colin King <colin.king@canonical.com>
To: Boaz Harrosh <ooo@electrozaur.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ore: fix spelling mistake: "Multples" -> "multiples"
Date: Thu, 29 Mar 2018 00:07:05 +0100
Message-Id: <20180328230705.28145-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in ORE_ERR error message text and
make it all lowercase.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/exofs/ore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
index 3c6a9c156b7a..0df0b6d25d06 100644
--- a/fs/exofs/ore.c
+++ b/fs/exofs/ore.c
@@ -68,7 +68,7 @@ int ore_verify_layout(unsigned total_comps, struct ore_layout *layout)
 	}
 	if (0 != (layout->stripe_unit & ~PAGE_MASK)) {
 		ORE_ERR("Stripe Unit(0x%llx)"
-			  " must be Multples of PAGE_SIZE(0x%lx)\n",
+			  " must be multiples of PAGE_SIZE(0x%lx)\n",
 			  _LLU(layout->stripe_unit), PAGE_SIZE);
 		return -EINVAL;
 	}
-- 
2.15.1
