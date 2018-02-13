Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513162-2-8456191655434601104
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES roenda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.65', Host='mail-pl0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513161; b=bZLM6R9JHkrwErTWm/GOO7RFzaJDyJKRJx3s2ntTPIEnAdH
    MV7s2Y/oZpAm4zAaXow+C8yTslpnSCMvQ3NXkTt1H0PtWSWliwmjHYli9Jca/1v4
    dFFhN95J/HJ4sr90NgPfTM3zYTg3IADUfE8SzKRHHfaj9ydJe7QkDiIZ7wQnyPgH
    3KoUtLIGFAQBz+1r38iLH7cP9oiTwm+Lfs/9gRrl40GEYiyJoCfNtcvCt4LEBLcC
    dEapIx7p81ew4o+4NTgNJeMW9xlQvxzU/obSxCpvpvypG0by4FU6jIiclIzQTu0E
    zQZLS90xgOuC/VEJHsv8hhPsWhHLRPO+df/BJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513161; bh=SZCPMzS5MIZ5BNh4/NILcL1jznXIRDK/lgYDOGd6jvU=; b=O
    FKKeVZI/Gnlm/NyXBHi1uxDPSRc4KdHRFbPb5NiDSco+vB4CG/Od7zYAX/DZAsNz
    o3fKEikadb38iDoENO9CoetDz3AJcx3hv0BSvF9eM+gZMERfVKIDkr46xFPdkTB+
    2CkWqoJimoQO1WBFiuVcgW6LbUJh5M129n4RJbIFuqRGdRCWCv+/0loyLpyVQO92
    3U29rlLdBTNKqHDwIuBJFuspiCYpUVzVV2S9y0voiNxi3rmr0Cfb4+QS4yibUc6H
    0okX1mnyX72S9UA+/Iga+44IChlKNTBpYRoXN+zgFCP7HHyrpLOAFiq25+cCx8Yq
    ZOE6xCKBJCtXFTSJR3X9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rZOBr4fK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.65 (mail-pl0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zbm+xQr4;
    x-ptr=pass x-ptr-helo=mail-pl0-f65.google.com x-ptr-lookup=mail-pl0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rZOBr4fK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.65 (mail-pl0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zbm+xQr4;
    x-ptr=pass x-ptr-helo=mail-pl0-f65.google.com x-ptr-lookup=mail-pl0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225YkZRMA3RUy8ZwNRFYvM6aU9xRkWoKSuaD/6pP1o2mdiK+E2sLvI2dM1RejsF4nG+wI05SEw==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com,
	Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v7 25/37] nds32: Loadable modules
Date: Tue, 13 Feb 2018 17:09:29 +0800
Message-Id: <98491aedcde94c63418e6b50c0d8807cd31ad175.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support for loadable modules.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by:  Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/module.h |  11 ++
 arch/nds32/kernel/module.c      | 278 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100644 arch/nds32/include/asm/module.h
 create mode 100644 arch/nds32/kernel/module.c

diff --git a/arch/nds32/include/asm/module.h b/arch/nds32/include/asm/module.h
new file mode 100644
index 000000000000..16cf9c7237ad
--- /dev/null
+++ b/arch/nds32/include/asm/module.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef _ASM_NDS32_MODULE_H
+#define _ASM_NDS32_MODULE_H
+
+#include <asm-generic/module.h>
+
+#define MODULE_ARCH_VERMAGIC	"NDS32v3"
+
+#endif /* _ASM_NDS32_MODULE_H */
diff --git a/arch/nds32/kernel/module.c b/arch/nds32/kernel/module.c
new file mode 100644
index 000000000000..4167283d8293
--- /dev/null
+++ b/arch/nds32/kernel/module.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/module.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/moduleloader.h>
+#include <asm/pgtable.h>
+
+void *module_alloc(unsigned long size)
+{
+	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+				    GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+void module_free(struct module *module, void *region)
+{
+	vfree(region);
+}
+
+int module_frob_arch_sections(Elf_Ehdr * hdr,
+			      Elf_Shdr * sechdrs,
+			      char *secstrings, struct module *mod)
+{
+	return 0;
+}
+
+void do_reloc16(unsigned int val, unsigned int *loc, unsigned int val_mask,
+		unsigned int val_shift, unsigned int loc_mask,
+		unsigned int partial_in_place, unsigned int swap)
+{
+	unsigned int tmp = 0, tmp2 = 0;
+
+	__asm__ __volatile__("\tlhi.bi\t%0, [%2], 0\n"
+			     "\tbeqz\t%3, 1f\n"
+			     "\twsbh\t%0, %1\n"
+			     "1:\n":"=r"(tmp):"0"(tmp), "r"(loc), "r"(swap)
+	    );
+
+	tmp2 = tmp & loc_mask;
+	if (partial_in_place) {
+		tmp &= (!loc_mask);
+		tmp =
+		    tmp2 | ((tmp + ((val & val_mask) >> val_shift)) & val_mask);
+	} else {
+		tmp = tmp2 | ((val & val_mask) >> val_shift);
+	}
+
+	__asm__ __volatile__("\tbeqz\t%3, 2f\n"
+			     "\twsbh\t%0, %1\n"
+			     "2:\n"
+			     "\tshi.bi\t%0, [%2], 0\n":"=r"(tmp):"0"(tmp),
+			     "r"(loc), "r"(swap)
+	    );
+}
+
+void do_reloc32(unsigned int val, unsigned int *loc, unsigned int val_mask,
+		unsigned int val_shift, unsigned int loc_mask,
+		unsigned int partial_in_place, unsigned int swap)
+{
+	unsigned int tmp = 0, tmp2 = 0;
+
+	__asm__ __volatile__("\tlmw.bi\t%0, [%2], %0, 0\n"
+			     "\tbeqz\t%3, 1f\n"
+			     "\twsbh\t%0, %1\n"
+			     "\trotri\t%0, %1, 16\n"
+			     "1:\n":"=r"(tmp):"0"(tmp), "r"(loc), "r"(swap)
+	    );
+
+	tmp2 = tmp & loc_mask;
+	if (partial_in_place) {
+		tmp &= (!loc_mask);
+		tmp =
+		    tmp2 | ((tmp + ((val & val_mask) >> val_shift)) & val_mask);
+	} else {
+		tmp = tmp2 | ((val & val_mask) >> val_shift);
+	}
+
+	__asm__ __volatile__("\tbeqz\t%3, 2f\n"
+			     "\twsbh\t%0, %1\n"
+			     "\trotri\t%0, %1, 16\n"
+			     "2:\n"
+			     "\tsmw.bi\t%0, [%2], %0, 0\n":"=r"(tmp):"0"(tmp),
+			     "r"(loc), "r"(swap)
+	    );
+}
+
+static inline int exceed_limit(int offset, unsigned int val_mask,
+			       struct module *module, Elf32_Rela * rel,
+			       unsigned int relindex, unsigned int reloc_order)
+{
+	int abs_off = offset < 0 ? ~offset : offset;
+
+	if (abs_off & (~val_mask)) {
+		pr_err("\n%s: relocation type %d out of range.\n"
+		       "please rebuild the kernel module with gcc option \"-Wa,-mno-small-text\".\n",
+		       module->name, ELF32_R_TYPE(rel->r_info));
+		pr_err("section %d reloc %d offset 0x%x relative 0x%x.\n",
+		       relindex, reloc_order, rel->r_offset, offset);
+		return true;
+	}
+	return false;
+}
+
+#ifdef __NDS32_EL__
+#define NEED_SWAP 1
+#else
+#define NEED_SWAP 0
+#endif
+
+int
+apply_relocate_add(Elf32_Shdr * sechdrs, const char *strtab,
+		   unsigned int symindex, unsigned int relindex,
+		   struct module *module)
+{
+	Elf32_Shdr *symsec = sechdrs + symindex;
+	Elf32_Shdr *relsec = sechdrs + relindex;
+	Elf32_Shdr *dstsec = sechdrs + relsec->sh_info;
+	Elf32_Rela *rel = (void *)relsec->sh_addr;
+	unsigned int i;
+
+	for (i = 0; i < relsec->sh_size / sizeof(Elf32_Rela); i++, rel++) {
+		Elf32_Addr *loc;
+		Elf32_Sym *sym;
+		Elf32_Addr v;
+		s32 offset;
+
+		offset = ELF32_R_SYM(rel->r_info);
+		if (offset < 0
+		    || offset > (symsec->sh_size / sizeof(Elf32_Sym))) {
+			pr_err("%s: bad relocation\n", module->name);
+			pr_err("section %d reloc %d\n", relindex, i);
+			return -ENOEXEC;
+		}
+
+		sym = ((Elf32_Sym *) symsec->sh_addr) + offset;
+
+		if (rel->r_offset < 0
+		    || rel->r_offset > dstsec->sh_size - sizeof(u16)) {
+			pr_err("%s: out of bounds relocation\n", module->name);
+			pr_err("section %d reloc %d offset 0x%0x size %d\n",
+			       relindex, i, rel->r_offset, dstsec->sh_size);
+			return -ENOEXEC;
+		}
+
+		loc = (Elf32_Addr *) (dstsec->sh_addr + rel->r_offset);
+		v = sym->st_value + rel->r_addend;
+
+		switch (ELF32_R_TYPE(rel->r_info)) {
+		case R_NDS32_NONE:
+		case R_NDS32_INSN16:
+		case R_NDS32_LABEL:
+		case R_NDS32_LONGCALL1:
+		case R_NDS32_LONGCALL2:
+		case R_NDS32_LONGCALL3:
+		case R_NDS32_LONGCALL4:
+		case R_NDS32_LONGJUMP1:
+		case R_NDS32_LONGJUMP2:
+		case R_NDS32_LONGJUMP3:
+		case R_NDS32_9_FIXED_RELA:
+		case R_NDS32_15_FIXED_RELA:
+		case R_NDS32_17_FIXED_RELA:
+		case R_NDS32_25_FIXED_RELA:
+		case R_NDS32_LOADSTORE:
+		case R_NDS32_DWARF2_OP1_RELA:
+		case R_NDS32_DWARF2_OP2_RELA:
+		case R_NDS32_DWARF2_LEB_RELA:
+		case R_NDS32_RELA_NOP_MIX ... R_NDS32_RELA_NOP_MAX:
+			break;
+
+		case R_NDS32_32_RELA:
+			do_reloc32(v, loc, 0xffffffff, 0, 0, 0, 0);
+			break;
+
+		case R_NDS32_HI20_RELA:
+			do_reloc32(v, loc, 0xfffff000, 12, 0xfff00000, 0,
+				   NEED_SWAP);
+			break;
+
+		case R_NDS32_LO12S3_RELA:
+			do_reloc32(v, loc, 0x00000fff, 3, 0xfffff000, 0,
+				   NEED_SWAP);
+			break;
+
+		case R_NDS32_LO12S2_RELA:
+			do_reloc32(v, loc, 0x00000fff, 2, 0xfffff000, 0,
+				   NEED_SWAP);
+			break;
+
+		case R_NDS32_LO12S1_RELA:
+			do_reloc32(v, loc, 0x00000fff, 1, 0xfffff000, 0,
+				   NEED_SWAP);
+			break;
+
+		case R_NDS32_LO12S0_RELA:
+		case R_NDS32_LO12S0_ORI_RELA:
+			do_reloc32(v, loc, 0x00000fff, 0, 0xfffff000, 0,
+				   NEED_SWAP);
+			break;
+
+		case R_NDS32_9_PCREL_RELA:
+			if (exceed_limit
+			    ((v - (Elf32_Addr) loc), 0x000000ff, module, rel,
+			     relindex, i))
+				return -ENOEXEC;
+			do_reloc16(v - (Elf32_Addr) loc, loc, 0x000001ff, 1,
+				   0xffffff00, 0, NEED_SWAP);
+			break;
+
+		case R_NDS32_15_PCREL_RELA:
+			if (exceed_limit
+			    ((v - (Elf32_Addr) loc), 0x00003fff, module, rel,
+			     relindex, i))
+				return -ENOEXEC;
+			do_reloc32(v - (Elf32_Addr) loc, loc, 0x00007fff, 1,
+				   0xffffc000, 0, NEED_SWAP);
+			break;
+
+		case R_NDS32_17_PCREL_RELA:
+			if (exceed_limit
+			    ((v - (Elf32_Addr) loc), 0x0000ffff, module, rel,
+			     relindex, i))
+				return -ENOEXEC;
+			do_reloc32(v - (Elf32_Addr) loc, loc, 0x0001ffff, 1,
+				   0xffff0000, 0, NEED_SWAP);
+			break;
+
+		case R_NDS32_25_PCREL_RELA:
+			if (exceed_limit
+			    ((v - (Elf32_Addr) loc), 0x00ffffff, module, rel,
+			     relindex, i))
+				return -ENOEXEC;
+			do_reloc32(v - (Elf32_Addr) loc, loc, 0x01ffffff, 1,
+				   0xff000000, 0, NEED_SWAP);
+			break;
+		case R_NDS32_WORD_9_PCREL_RELA:
+			if (exceed_limit
+			    ((v - (Elf32_Addr) loc), 0x000000ff, module, rel,
+			     relindex, i))
+				return -ENOEXEC;
+			do_reloc32(v - (Elf32_Addr) loc, loc, 0x000001ff, 1,
+				   0xffffff00, 0, NEED_SWAP);
+			break;
+
+		case R_NDS32_SDA15S3_RELA:
+		case R_NDS32_SDA15S2_RELA:
+		case R_NDS32_SDA15S1_RELA:
+		case R_NDS32_SDA15S0_RELA:
+			pr_err("%s: unsupported relocation type %d.\n",
+			       module->name, ELF32_R_TYPE(rel->r_info));
+			pr_err
+			    ("Small data section access doesn't work in the kernel space; "
+			     "please rebuild the kernel module with gcc option -mcmodel=large.\n");
+			pr_err("section %d reloc %d offset 0x%x size %d\n",
+			       relindex, i, rel->r_offset, dstsec->sh_size);
+			break;
+
+		default:
+			pr_err("%s: unsupported relocation type %d.\n",
+			       module->name, ELF32_R_TYPE(rel->r_info));
+			pr_err("section %d reloc %d offset 0x%x size %d\n",
+			       relindex, i, rel->r_offset, dstsec->sh_size);
+		}
+	}
+	return 0;
+}
+
+int
+module_finalize(const Elf32_Ehdr * hdr, const Elf_Shdr * sechdrs,
+		struct module *module)
+{
+	return 0;
+}
+
+void module_arch_cleanup(struct module *mod)
+{
+}
-- 
2.16.1
