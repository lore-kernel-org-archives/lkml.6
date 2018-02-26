Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeBZPGl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:06:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51180 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753995AbeBZPFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:05:01 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH v2 06/12] arm64: fpsimd: include <linux/init.h> in fpsimd.h
Date: Mon, 26 Feb 2018 15:04:54 +0000
Message-Id: <1519657500-15094-7-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
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
