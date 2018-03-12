Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeCLMVP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:21:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeCLMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:21:13 -0400
Date: Mon, 12 Mar 2018 05:20:50 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-1da961d72ab0cfbe8b7c26cba731dc2bb6b9494b@git.kernel.org>
Cc: peterz@infradead.org, kai.huang@linux.intel.com,
        thomas.lendacky@amd.com, mingo@kernel.org, dave.hansen@intel.com,
        torvalds@linux-foundation.org, kirill.shutemov@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: peterz@infradead.org, kai.huang@linux.intel.com,
        thomas.lendacky@amd.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, mingo@kernel.org,
        dave.hansen@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180305162610.37510-2-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/cpufeatures: Add Intel Total Memory Encryption
 cpufeature
Git-Commit-ID: 1da961d72ab0cfbe8b7c26cba731dc2bb6b9494b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1da961d72ab0cfbe8b7c26cba731dc2bb6b9494b
Gitweb:     https://git.kernel.org/tip/1da961d72ab0cfbe8b7c26cba731dc2bb6b9494b
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 5 Mar 2018 19:25:49 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:09:53 +0100

x86/cpufeatures: Add Intel Total Memory Encryption cpufeature

CPUID.0x7.0x0:ECX[13] indicates whether CPU supports Intel Total Memory
Encryption.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180305162610.37510-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f41079da38c5..16898eb813f5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -316,6 +316,7 @@
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
 #define X86_FEATURE_AVX512_VNNI		(16*32+11) /* Vector Neural Network Instructions */
 #define X86_FEATURE_AVX512_BITALG	(16*32+12) /* Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
+#define X86_FEATURE_TME			(16*32+13) /* Intel Total Memory Encryption */
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
