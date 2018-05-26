Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031922AbeEZPPr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:15:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031790AbeEZPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:15:46 -0400
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc-opal: fix spelling mistake "Uniterrupted" -> "Uninterrupted"
Date: Sat, 26 May 2018 16:15:31 +0100
Message-Id: <20180526151531.10920-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in hmi_error_types text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/platforms/powernv/opal-hmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index 4efc95b4c7d4..586ec71a4e17 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -177,7 +177,7 @@ static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
 		"Processor recovery occurred for masked error",
 		"Timer facility experienced an error",
 		"TFMR SPR is corrupted",
-		"UPS (Uniterrupted Power System) Overflow indication",
+		"UPS (Uninterrupted Power System) Overflow indication",
 		"An XSCOM operation failure",
 		"An XSCOM operation completed",
 		"SCOM has set a reserved FIR bit to cause recovery",
-- 
2.17.0
