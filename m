Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx482lqcWVpkYfle+RhOnYfVdtuuV709g0D04WqZU3sr9rgxhhR7ejd3x3VHT7ISyAZP5fpAT
ARC-Seal: i=1; a=rsa-sha256; t=1524414705; cv=none;
        d=google.com; s=arc-20160816;
        b=TS1GXDL8iPphRkBAcAOLilgn+ddT564VTQAvJ9CKcBgE3qlqrkWAOKtrDRjxgVD+H9
         IicVPkjPkcBn8tXocxGqKXoWMr2pZXEZGq5ApsDhurpkf1QE6sKI1wtZaVRjLBLOCizH
         kALyj3YR+5J4Yt3MD3YjAvOClUG2lt1slLC8Yx7R6TMG4lxuXYVjPnImb1yQ6hcURP+K
         ybyLfBMpD0QsGVSBbK0LafR2eLkqttNRob619PYUHZGCdr69diBKme4OdnyK6YWLmQNf
         yPRKX2qEHkTR2pecw3iCWmJ2ROVvInJZNa4qYw5Q8RypyPGUGlcapiR2f2IZmC2W0HUC
         KhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=djwAqhk40wnRJLOb8rghiyLnmN7j8ii0n6T8TDi6APU=;
        b=tSDH/d4GiGKvKtLYQXILkkMUC9zxf2pXNis46LHWpEoKfpL16fADm9e6wyhuvMoZj7
         mM+ztSc28k6G9gYlJqMUUHO9KQSfSp/HVctO/0jaZS4HzbS9gMj0FkVhp/NxYeekeudb
         wCqGF7iyPrVs1vMRMaS+ANB0Iih9PdrUDimsn9W4gcomx4LXLUOh3Rifc2RUHfDhvJxx
         E0lFQ2vaVxnQB0qlVesQb4SdPS01FBHG78VjpDaUshTccoNUukgMrPtQHV9O0Jzv4Bmz
         5UtSZfCo7o+WdSgElfbek6hmX0QIqzHPk5PqfKACtjcE2+DOasNx2lUaUQeG3hXBh8Jd
         WI/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422162512.747021175@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:50 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch V3 05/10] rslib: Add SPDX identifiers
References: <20180422162345.004292133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Add_SPDX_identifiers.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464674826803354?=
X-GMAIL-MSGID: =?utf-8?q?1598464674826803354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

The Reed-Solomon library is based on code from Phil Karn who granted
permission to import it into the kernel under the GPL V2.

See commit 15b5423757a7 ("Shared Reed-Solomon ECC library") in the history
git tree at: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

  ...
  The encoder/decoder code is lifted from the GPL'd userspace RS-library
  written by Phil Karn. I modified/wrapped it to provide the different
  functions which we need in the MTD/NAND code.
  ...    
  Signed-Off-By: Thomas Gleixner <tglx@linutronix.de>
  Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
  "No objections at all. Just keep the authorship notices." -- Phil Karn

Add the proper SPDX identifiers according to
Documentation/process/license-rules.rst.


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Alasdair Kergon <agk@redhat.com>

---
 include/linux/rslib.h           |    1 +
 lib/reed_solomon/decode_rs.c    |    1 +
 lib/reed_solomon/encode_rs.c    |    1 +
 lib/reed_solomon/reed_solomon.c |    1 +
 4 files changed, 4 insertions(+)

--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic Reed Solomon encoder / decoder library
  *
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic Reed Solomon encoder / decoder library
  *
--- a/lib/reed_solomon/encode_rs.c
+++ b/lib/reed_solomon/encode_rs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic Reed Solomon encoder / decoder library
  *
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic Reed Solomon encoder / decoder library
  *
