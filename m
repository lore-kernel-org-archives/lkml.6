Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4/2csVn9xm9wXt73FibMw1DaAHyPF1UqvbhF66CzxnT3y4FRIKvpJzwjrNVx0pI4mSdhCZ2
ARC-Seal: i=1; a=rsa-sha256; t=1524132635; cv=none;
        d=google.com; s=arc-20160816;
        b=cm9aFd5N06h9u9OIt1/5SCU8M8UqZo2WiHPHsI2ZfmmQeA188ovYTScW7QgsWZvgOc
         hE7qCU0FdNRPnuSieE9Kf7Iq91uA1btwFueBhQfOaa7y0iMBb92AOXcHqGAGDXsSTl0Y
         8oKnHwPJ1FPZJhfoqzyDMjjpbxag3v7U1iWIa2+VUbi1jSf/vw0lCVRg78bIXI7/HLsD
         2LVQnSgb/8AARelG+VJXvaTrq8qoV74N3n1sWUQTAkY7TFqqpF7+NMOQFVHVtwiT5UfA
         0FLnLgG38HAU2HDNnhCqkpiMfqrYRrjlQ7Nk1ktUE3INjegQFlLc2FLrEq85AEZAc5Xz
         YHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=o8ppcUoSamjFUcrwiRlgpyCkFiYDnPUnEE/2pOPQx1o=;
        b=jb2atiS7+mDZIvhcvsYLworR16phRFM4UgUQQ/H0Y+VoyQBd1o1W08Bo8jv3V0obK4
         e4Cn7zgnyEg3CNeim+xcqgUnYyUAHY2URDTc3WIeffs96wdmdtJR5y/tqdwn6woxztYp
         hQZIa6NZXKq6pU7NBXNbD+WXZRM2eL1WCnxYxuZtGHPEILA4QHab5xbYW3fqGSdMOxwN
         s7zpfHcs/Jywvsw23Y6U3AXO5DTKhtW3fiwwYTkTig6O8TYDsTEdYq8mxFWPxyN0Aq1J
         O1OmodTnHu6D/q6/0itti5+8rWI0pza5hlVnIu1erm/30AxbigJsl55tZncqrFTM71Ea
         aE3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180419100935.011090923@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 19 Apr 2018 12:04:44 +0200
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
Subject: [patch V2 3/8] rslib: Add SPDX identifiers
References: <20180419100441.548834519@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Add_SPDX_identifiers.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168902175743568?=
X-GMAIL-MSGID: =?utf-8?q?1598168902175743568?=
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
