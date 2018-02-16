Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964866AbeBPLYd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:24:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47744 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935543AbeBPLX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:23:28 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180216112326euoutp02c6570f384f890e62e86b1b209507e577~Tyozy1I_l2415924159euoutp02f
X-AuditID: cbfec7f4-b4fc79c0000043e4-dd-5a86bf2b4fa8
From: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH 2/7 RESEND] arm64: uprobes - fix checkpatch.pl issues
Date: Fri, 16 Feb 2018 12:23:06 +0100
Message-id: <1518780191-31094-3-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfSyVURzHned57nMfV1enSzkhf1y1NSKiOa3WUmnP2oqy9cdtK7c8Q7no
        XkRtReXiIsUMU7LylrxerzPu9f4yS+kKSUwqYQuhZdPb9ei/z+98P+f8fr/tMKRklbJmgkLC
        OWWIPFhKi6i6rtVXTo56tcxldFmCNeMNNE7QZgtwVVaFAM8XJgPc+fIXgWO/PyaxdmpIgA2N
        j2jcltEMcFPqCxqXdXwQ4jcteQS+U1hL4Vp9HMDdKS0EnlnsoY5AtjS3FLCGoQGSrS52YLUl
        iTSb23uGrc6/zbZ+ayLYed1bmr1fUwLYJa2dj0gmOuTPBQdFcsq9h/1EgcNZlWRYoWNUUkol
        GQPU9hpgyiDojoruZtAaIGIksBggzZqO4oslgFI71AINYNat9DkRf14IULnuC+CLRYBaerNp
        41M09ED1nfcoI1vCE2gkNoEwSiQ0EMjQk0QYAwvohZL7eKbgLtRcnSw0shh6o/y1rzQ/kx16
        159IGtkU+qCJmpr1kRCco9HsQjzBS8fR0PSKgGcLNNtdI+TZFhnSkyieUwFqfW/DX84CqHb+
        40ZwEK2VPFzvRkJzlFaXSfJ7ilGCWsIrLHoys7Che6LV/pyNlZ8BpB/JAA+AdR4wKQFWXIRK
        EcCp9oVw151VcoUqIiTA+XKoQgv+fYi+393LDaBx7VIbgAyQbhJXpsTJJAJ5pCpa0QYQQ0ot
        xb46tUwi9pdH3+CUoReVEcGcqg3YMJTUSnxh9y2ZBAbIw7mrHBfGKf+nBGNqHQM0UG9C5Iil
        TkefjvYJ0oYnzSY/VQ3a77HMjI7K9SuFVe25xw6MNTjbRuAK30XXovI6jVvXea/tK2b2N38O
        ChU7fbeZW03oys7Jr12J957yY7J+DLtseV6eZLG54A98ffqk59YxfYGHe3tHh3Dg7LjbjlOf
        c9Lrp5j9ltPQKrB+WEqpAuWuDqRSJf8Lz/hB2AwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xa7qa+9uiDF4+M7LoureDzaJj00xW
        i40z1rNavF/Ww2hx9OxfJovGT3OZLTY9vsZqcXnXHDaLQ1P3Mlrs6V/NZrH2yF12i0sHFjBZ
        NC3bymKxdX8ro8Xx3gNMFi8/nmBxEPBYM28No8flaxeZPTav0PLYtKqTzWPeyUCPzUvqPQ6+
        28Pk8X7fVTaPvi2rGD0+b5IL4IrisklJzcksSy3St0vgyrg+YwNzwTLtiu7eDcwNjG3KXYwc
        HBICJhKTX3N1MXJxCAksYZT4s+EGM4TzmVGioekOkMPJwSZgLrH9aAsLiC0i4CZxo7GDCaSI
        WeAyk8TnBXtZQRLCAq4SPae7mUBsFgFVib2be9hBbF4Bf4klf16wgdgSAnISN891gg3lFAiQ
        uL9lC9hQIaCatYt+sUxg5FnAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMIS3Hfu5ZQdj
        17vgQ4wCHIxKPLwbelujhFgTy4orcw8xSnAwK4nwBu9rixLiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOe96gMkpIID2xJDU7NbUgtQgmy8TBKdXAWLdEJ3XbbN1NveZ/ruv+ijrVnV1xfWpm3fNX
        TJM4L6YL+1YXefmJXVF54c3S+2Qnm6P11JfNzx6p+zRmT5sVcfF2o2G0xX+nY8zvj0VvdvFJ
        7WUM0P+5J9lKqUM40Xfr86yHRxo35TufkX8z47V8m/r5FWFPX9xp/OsZJl/3+MOys7U5TF/1
        lViKMxINtZiLihMBJDGM110CAAA=
X-CMS-MailID: 20180216112321eucas1p1c51df50f06fa2f440fcd4735066d1e61
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180216112321eucas1p1c51df50f06fa2f440fcd4735066d1e61
X-RootMTR: 20180216112321eucas1p1c51df50f06fa2f440fcd4735066d1e61
References: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180216112321eucas1p1c51df50f06fa2f440fcd4735066d1e61@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl issues in moved arm uprobes code.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 lib/probes/arm/actions-arm.c | 4 ++--
 lib/probes/arm/decode-arm.c  | 1 +
 lib/probes/arm/decode-arm.h  | 4 ++--
 lib/probes/arm/decode.c      | 6 ++++++
 lib/probes/arm/decode.h      | 7 +++++--
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/probes/arm/actions-arm.c b/lib/probes/arm/actions-arm.c
index a25795a..db6017d 100644
--- a/lib/probes/arm/actions-arm.c
+++ b/lib/probes/arm/actions-arm.c
@@ -165,10 +165,10 @@ uprobe_decode_ldmstm(probes_opcode_t insn,
 {
 	struct arch_uprobe *auprobe = container_of(asi, struct arch_uprobe,
 						   asi);
-	unsigned reglist = insn & 0xffff;
+	unsigned int reglist = insn & 0xffff;
 	int rn = (insn >> 16) & 0xf;
 	int lbit = insn & (1 << 20);
-	unsigned used = reglist | (1 << rn);
+	unsigned int used = reglist | (1 << rn);
 
 	if (rn == 15)
 		return INSN_REJECTED;
diff --git a/lib/probes/arm/decode-arm.c b/lib/probes/arm/decode-arm.c
index f72c33a..3aa2e58 100644
--- a/lib/probes/arm/decode-arm.c
+++ b/lib/probes/arm/decode-arm.c
@@ -101,6 +101,7 @@ void __kprobes simulate_mrs(probes_opcode_t insn,
 {
 	int rd = (insn >> 12) & 0xf;
 	unsigned long mask = 0xf8ff03df; /* Mask out execution state */
+
 	regs->uregs[rd] = regs->ARM_cpsr & mask;
 }
 
diff --git a/lib/probes/arm/decode-arm.h b/lib/probes/arm/decode-arm.h
index b3b80f6..ed34f03 100644
--- a/lib/probes/arm/decode-arm.h
+++ b/lib/probes/arm/decode-arm.h
@@ -66,8 +66,8 @@ void __kprobes simulate_mov_ipsp(probes_opcode_t opcode,
 
 extern const union decode_item probes_decode_arm_table[];
 
-enum probes_insn arm_probes_decode_insn(probes_opcode_t,
-		struct arch_probes_insn *, bool emulate,
+enum probes_insn arm_probes_decode_insn(probes_opcode_t opcode,
+		struct arch_probes_insn *api, bool emulate,
 		const union decode_action *actions,
 		const struct decode_checker *checkers[]);
 
diff --git a/lib/probes/arm/decode.c b/lib/probes/arm/decode.c
index 880ebe0..6840054 100644
--- a/lib/probes/arm/decode.c
+++ b/lib/probes/arm/decode.c
@@ -55,6 +55,7 @@ bool load_write_pc_interworks;
 void __init test_load_write_pc_interworking(void)
 {
 	int arch = cpu_architecture();
+
 	BUG_ON(arch == CPU_ARCH_UNKNOWN);
 	load_write_pc_interworks = arch >= CPU_ARCH_ARMv5T;
 }
@@ -69,6 +70,7 @@ bool alu_write_pc_interworks;
 void __init test_alu_write_pc_interworking(void)
 {
 	int arch = cpu_architecture();
+
 	BUG_ON(arch == CPU_ARCH_UNKNOWN);
 	alu_write_pc_interworks = arch >= CPU_ARCH_ARMv7;
 }
@@ -151,6 +153,7 @@ static unsigned long __kprobes __check_lt(unsigned long cpsr)
 static unsigned long __kprobes __check_gt(unsigned long cpsr)
 {
 	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+
 	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
 	return (~temp) & PSR_N_BIT;
 }
@@ -158,6 +161,7 @@ static unsigned long __kprobes __check_gt(unsigned long cpsr)
 static unsigned long __kprobes __check_le(unsigned long cpsr)
 {
 	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+
 	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
 	return temp & PSR_N_BIT;
 }
@@ -228,6 +232,7 @@ set_emulated_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 #ifdef CONFIG_THUMB2_KERNEL
 	if (thumb) {
 		u16 *ip = (u16 *)asi->insn;
+
 		if (is_wide_instruction(insn))
 			*ip++ = __opcode_to_mem_thumb16(insn >> 16);
 		*ip++ = __opcode_to_mem_thumb16(insn);
@@ -465,6 +470,7 @@ probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 
 		case DECODE_TYPE_TABLE: {
 			struct decode_table *d = (struct decode_table *)h;
+
 			next = (struct decode_header *)d->table.table;
 			break;
 		}
diff --git a/lib/probes/arm/decode.h b/lib/probes/arm/decode.h
index 548d622..43b02fd 100644
--- a/lib/probes/arm/decode.h
+++ b/lib/probes/arm/decode.h
@@ -59,6 +59,7 @@ static inline unsigned long it_advance(unsigned long cpsr)
 		/* We need to shift left ITSTATE<4:0> */
 		const unsigned long mask = 0x06001c00;  /* Mask ITSTATE<4:0> */
 		unsigned long it = cpsr & mask;
+
 		it <<= 1;
 		it |= it >> (27 - 10);  /* Carry ITSTATE<2> to correct place */
 		it &= mask;
@@ -71,6 +72,7 @@ static inline unsigned long it_advance(unsigned long cpsr)
 static inline void __kprobes bx_write_pc(long pcv, struct pt_regs *regs)
 {
 	long cpsr = regs->ARM_cpsr;
+
 	if (pcv & 0x1) {
 		cpsr |= PSR_T_BIT;
 		pcv &= ~0x1;
@@ -253,7 +255,8 @@ static inline void __kprobes alu_write_pc(long pcv, struct pt_regs *regs)
  * instruction will be modified to "AND R0, R2, R3, ASL R1" and then placed into
  * the kprobes instruction slot. This can then be called later by the handler
  * function emulate_rd12rn16rm0rs8_rwflags (a pointer to which is retrieved from
- * the indicated slot in the action array), in order to simulate the instruction.
+ * the indicated slot in the action array), in order to simulate the
+ * instruction.
  */
 
 enum decode_type {
@@ -282,7 +285,7 @@ enum decode_reg_type {
 	REG_TYPE_NOPCWB,   /* No PC if load/store write-back flag also set */
 
 	/* The following types are used when the encoding for PC indicates
-	 * another instruction form. This distiction only matters for test
+	 * another instruction form. This distinction only matters for test
 	 * case coverage checks.
 	 */
 	REG_TYPE_NOPCX,	   /* Register must not be PC */
-- 
2.7.4
