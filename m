Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946166AbeBOR4E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:56:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164178AbeBOPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:30:14 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 1/5] arm64: fpsimd: include <linux/init.h> in fpsimd.h
Date: Thu, 15 Feb 2018 15:29:31 +0000
Message-Id: <1518708575-12284-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fpsimd.h uses the __init annotation, so pull in linux/init.h

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fpsimd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8857a0f0d0f7..fc3527b985ca 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -22,6 +22,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/cache.h>
+#include <linux/init.h>
 #include <linux/stddef.h>
 
 /*
-- 
2.1.4
