Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513115-2-17180049603078165727
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.66', Host='mail-pg0-f66.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513114; b=WKI4/bxqfRdc8H+i4N8UQoI+HSIDGZgQ+r5xPIqx6h1a3Ps
    2Cw6rpr2z4hie3ro6Z2+Q9nVh+Vx/DO4RKD11UYR4sn4yJkgc+8WtbUDqDyeCBoq
    MVmjgn5xUo8IxU7Mw2dnVFOxptFoeZtJNfYAvKUU8UgyjROyuLiszkvBxxJMaPN5
    8RZfbLR+Joj8naS3EwP+5I1+nvzUypPeAHAHTsqSOPV5hbMU94akXXXrxkGYpTyz
    25pXy13vJBYBuGl4HBW/r474vHLL6Q3OsGMfXmWjIiEviDOPV9wZuD/rL153iMjs
    6s8s8PFspX2DJOkOkKrjrIoKbnX921ab6jdbapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513114; bh=zVDEEZYW5642IoICkYbIVdLryWivzYIj+OtHOh9R/Ms=; b=R
    mnT9j7txV2CvB5iIO4d6h4LaTVBk3l+dxpKQ/618FuiiDc3bM18AwH5/aZw0iZjW
    17N+p0Rowf1ssqfSYB/6rezxivDQFwOpiu5CcZQekDNUPD2WX54A3QpymtrQ2uPK
    9i7GskGmMZUXirNCXuB91Wi0aGKkZbBgXmOFKlwg7cy7iWPyMNJDs/TPn5zQJgDg
    BcW2Wlnz/yluihZ2GjO/CgIQj5cUtMX4ZibAArMHemeSuzO2+e6grCgQr4iDsHY3
    ZZuyiu3oBYCvPwrBoqm68DBaDL5iEN0WR3mNoxe1dVGDwwIyCVVb/c29WKk9JpOB
    EpM6q0IywEHVCMo+RPWTA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=G63oB89u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fmOsiiPa;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=G63oB89u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fmOsiiPa;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226E8Fwh8neAOAKowgB+zDwlmaP1NWItCj2V3AXCvkz+EkKeJ+mZNXLTIjry0qkYcL2Ddv4n2w==
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
Subject: [PATCH v7 15/37] nds32: Atomic operations
Date: Tue, 13 Feb 2018 17:09:19 +0800
Message-Id: <e8a50d786be63fe293c9eec6a531d6e6e6577805.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch includes the atomic and futex operations. Many atomic operations use
the load-lock word(llw) and store-condition word(scw) operations.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/barrier.h |  15 ++++++
 arch/nds32/include/asm/futex.h   | 103 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 arch/nds32/include/asm/barrier.h
 create mode 100644 arch/nds32/include/asm/futex.h

diff --git a/arch/nds32/include/asm/barrier.h b/arch/nds32/include/asm/barrier.h
new file mode 100644
index 000000000000..faafc373ea6c
--- /dev/null
+++ b/arch/nds32/include/asm/barrier.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_ASM_BARRIER_H
+#define __NDS32_ASM_BARRIER_H
+
+#ifndef __ASSEMBLY__
+#define mb()		asm volatile("msync all":::"memory")
+#define rmb()		asm volatile("msync all":::"memory")
+#define wmb()		asm volatile("msync store":::"memory")
+#include <asm-generic/barrier.h>
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __NDS32_ASM_BARRIER_H */
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
new file mode 100644
index 000000000000..eab5e84bd991
--- /dev/null
+++ b/arch/nds32/include/asm/futex.h
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_FUTEX_H__
+#define __NDS32_FUTEX_H__
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <asm/errno.h>
+
+#define __futex_atomic_ex_table(err_reg)			\
+	"	.pushsection __ex_table,\"a\"\n"		\
+	"	.align	3\n"					\
+	"	.long	1b, 4f\n"				\
+	"	.long	2b, 4f\n"				\
+	"	.popsection\n"					\
+	"	.pushsection .fixup,\"ax\"\n"			\
+	"4:	move	%0, " err_reg "\n"			\
+	"	j	3b\n"					\
+	"	.popsection"
+
+#define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
+	smp_mb();						\
+	asm volatile(					\
+	"	movi	$ta, #0\n"				\
+	"1:	llw	%1, [%2+$ta]\n"				\
+	"	" insn "\n"					\
+	"2:	scw	%0, [%2+$ta]\n"				\
+	"	beqz	%0, 1b\n"				\
+	"	movi	%0, #0\n"				\
+	"3:\n"							\
+	__futex_atomic_ex_table("%4")				\
+	: "=&r" (ret), "=&r" (oldval)				\
+	: "r" (uaddr), "r" (oparg), "i" (-EFAULT)		\
+	: "cc", "memory")
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 * uval, u32 __user * uaddr,
+			      u32 oldval, u32 newval)
+{
+	int ret = 0;
+	u32 val, tmp, flags;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	smp_mb();
+	asm volatile ("       movi    $ta, #0\n"
+		      "1:     llw     %1, [%6 + $ta]\n"
+		      "       sub     %3, %1, %4\n"
+		      "       cmovz   %2, %5, %3\n"
+		      "       cmovn   %2, %1, %3\n"
+		      "2:     scw     %2, [%6 + $ta]\n"
+		      "       beqz    %2, 1b\n"
+		      "3:\n                   " __futex_atomic_ex_table("%7")
+		      :"+&r"(ret), "=&r"(val), "=&r"(tmp), "=&r"(flags)
+		      :"r"(oldval), "r"(newval), "r"(uaddr), "i"(-EFAULT)
+		      :"$ta", "memory");
+	smp_mb();
+
+	*uval = val;
+	return ret;
+}
+
+static inline int
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval = 0, ret;
+
+
+	pagefault_disable();
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("move	%0, %3", ret, oldval, tmp, uaddr,
+				  oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add	%0, %1, %3", ret, oldval, tmp, uaddr,
+				  oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("or	%0, %1, %3", ret, oldval, tmp, uaddr,
+				  oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("and	%0, %1, %3", ret, oldval, tmp, uaddr,
+				  ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xor	%0, %1, %3", ret, oldval, tmp, uaddr,
+				  oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	pagefault_enable();
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+#endif /* __NDS32_FUTEX_H__ */
-- 
2.16.1
