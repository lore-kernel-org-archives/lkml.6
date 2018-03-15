Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeCOIwj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:52:39 -0400
Received: from exmail.andestech.com ([59.124.169.137]:50164 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeCOIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:52:18 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH v2 11/11] RISC-V: Add definition of relocation types
Date: Thu, 15 Mar 2018 16:50:51 +0800
Message-ID: <6146832f0456fab33271f87fca2ef31b7d923188.1521103174.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1521103167.git.zong@andestech.com>
References: <cover.1521103167.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2F8mMCb081125
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/include/uapi/asm/elf.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index a510edfa8226..5cae4c30cd8e 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -79,5 +79,12 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_TPREL_I		49
 #define R_RISCV_TPREL_S		50
 #define R_RISCV_RELAX		51
+#define R_RISCV_SUB6		52
+#define R_RISCV_SET6		53
+#define R_RISCV_SET8		54
+#define R_RISCV_SET16		55
+#define R_RISCV_SET32		56
+#define R_RISCV_32_PCREL	57
+
 
 #endif /* _UAPI_ASM_ELF_H */
-- 
2.16.1
