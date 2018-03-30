Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeC3P4I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:56:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35192 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeC3P4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:56:07 -0400
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fix spelling mistake: "Usupported" -> "Unsupported"
Date: Fri, 30 Mar 2018 16:55:53 +0100
Message-Id: <20180330155553.7170-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in bootx_printf message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/platforms/powermac/bootx_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index c3c9bbb3573a..ca60f3ef7ef6 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -519,7 +519,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 			;
 	}
 	if (bi->architecture != BOOT_ARCH_PCI) {
-		bootx_printf(" !!! WARNING - Usupported machine"
+		bootx_printf(" !!! WARNING - Unsupported machine"
 			     " architecture !\n");
 		for (;;)
 			;
-- 
2.15.1
