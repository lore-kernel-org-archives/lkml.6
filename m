Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4/zw1OZaOR78lVMyqj0/QRBupqgkY5F63oCBhRwUU/tCUxo9cIhBeYDpcYHtkqIm6QoB66I
ARC-Seal: i=1; a=rsa-sha256; t=1522270645; cv=none;
        d=google.com; s=arc-20160816;
        b=TfpgZNgdtFwW1kbzraJ4iwDOhpphsiGEMTYzr0VZK4Kt8oZHX/vW/iBNuqE0F9AQUH
         j6kieOjxjXcY8Xgm3ABOS3fbMLRY1EcTBGm1xpZcQ6pobkrc71mPaJaYvJnNa4svOdGr
         uEiRpIVCMVvZDqqxpEdDnUEbSHjBWIdVrbSmEd4EPUJSD2SVL6JnSbqkpazBo2YMjacn
         WSnNqqHRogoJUSev3qIUI3gzBEeESpq3rMMH1bdathVA7Y2bTofNT/GLgWzhzV7oagJ/
         K74sRdO3WNLG5QGiVxedhJXnIXaPUWo/5QefghnmBUnqWUHEcIK0g6kagEFpRQtN3uwI
         SQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=Fw6dB00LPBQr6TvyhwOPYv+5KVMcEZrgsRtWVRMAtKE=;
        b=JkyFM7E3t5aGLr9vfY2a7C10mKjzybu/2lsdrdPu6fEBU+I+B0vncPQlH0bjZ6NmbB
         004ecSKZbreuJcHwxPam+mQDPzOG1ksjd5/gkPnw0LLYPFGXpfwtG9VtWVFzkq9NGlSx
         2zav/ivDGZtMK/Qjn+c3ttzSj6eht/odj/3ecs8sAxssssh+jiqN34IEkb+wqskQBQcG
         tbmo1EuoiY9FbOT/Vhia6JRA4LB3nzknBDM4d/+1/FFwWbHC5yMOyuFs/h+rnwCoi2TW
         HQ0mkjmgv8ipdhYtOVGpXAubMVbCUnehMCMEA4/PvqO1eEKUTTzIHyqNu3P5FGgCmc7F
         5k3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180328205554.496966175@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 28 Mar 2018 22:51:41 +0200
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
Subject: [patch 3/8] rslib: Add SPDX identifiers
References: <20180328205138.301218351@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Add-SPDX-identifiers.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216464368610748?=
X-GMAIL-MSGID: =?utf-8?q?1596216464368610748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
