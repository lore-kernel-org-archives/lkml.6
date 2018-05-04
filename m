Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeEDLiJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:38:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59716 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeEDLiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:38:08 -0400
From: Colin King <colin.king@canonical.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: fix spelling mistake: "redundacy" -> "redundancy"
Date: Fri,  4 May 2018 12:38:04 +0100
Message-Id: <20180504113804.17103-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in err string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/edac/i7core_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 8c5540160a23..4d0ea3563d47 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1743,7 +1743,7 @@ static void i7core_mce_output_error(struct mem_ctl_info *mci,
 		err = "write parity error";
 		break;
 	case 19:
-		err = "redundacy loss";
+		err = "redundancy loss";
 		break;
 	case 20:
 		err = "reserved";
-- 
2.17.0
