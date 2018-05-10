Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966643AbeEJQ7E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:59:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52788 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966305AbeEJQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:59:02 -0400
From: Colin King <colin.king@canonical.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: VPE: fix spelling mistake: "uneeded" -> "unneeded"
Date: Thu, 10 May 2018 17:59:00 +0100
Message-Id: <20180510165900.13733-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in pr_warn message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/mips/kernel/vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 544ea21bfef9..0bef238d2c0c 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -872,7 +872,7 @@ static ssize_t vpe_write(struct file *file, const char __user *buffer,
 		return -ENODEV;
 
 	if ((count + v->len) > v->plen) {
-		pr_warn("VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
+		pr_warn("VPE loader: elf size too big. Perhaps strip unneeded symbols\n");
 		return -ENOMEM;
 	}
 
-- 
2.17.0
