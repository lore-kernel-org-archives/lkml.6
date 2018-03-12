Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELscp/yq91xE9fIgUV0g4myZnQ+u0VlaMgWNIQcCFokFPdylhOCzESHngTuedPlCnUu3DWcR
ARC-Seal: i=1; a=rsa-sha256; t=1520824081; cv=none;
        d=google.com; s=arc-20160816;
        b=vrjE5GgJxX22SIcYjbh9a1Xq5rehETUCCeFKbJ/nepxSdP8csZlMC88oAGrnFkueUo
         STXkEejC8jTxJ8AUDVLzj7IkwWrI48PnYSkgLkKUL/ogN36bRDBBnWCHMt50ORZZcFF9
         ImYlwTeUKOOvhdvC6q/gS9S4Gcp87YfpJlOSdImVd0Mm43bJGqr6HIJJuJym5jACxHCv
         hpOxaE8LziVYkL4VJwaEE8Yy9/B5OzzLSAB/2YkNndMktsA5r4MH+QmY5qmRHKA9rftZ
         58vN8pO8jYdDj1Pq4Y+IrUsnJOt1QjIl8u9K/loPZ91824LjLu+CNTBJbPD1Bl9Uiyb0
         A1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=NNnL2arrPA37Z1nmULMVLI76Pk3JisLZY4M4a2H5Jvs=;
        b=kPSzKVBEc7DmbBmLs6MN2N1WrBk2fIZ/cjpGkbMuIAg36d+bv2XryI/Un28IpQGmOG
         b5yXOehSSXJ8m14PQsGN/H2PsIDI+f+OiBuZvuC/gGugQFY9cgfLsQJdEF9hzLGw4Z7V
         9dFsAjxfb6dS6/fzI62Vq9dBAtMk6LcwVGMduofgCevLQJQ3lHzOh8tMu0MbKU0txeD+
         C1cFGck9tS2eiwpXSFXWKacau0Ls7JWcsAYHmlRcSFDZF3aYyPgvH/Z6z/e7XdOrNfvu
         EbXVVtWM2h2Z2HDWG9Olt8mvhLc95WCitzIFnDjuCYXYH9/nk+5XptakIvIo20P/56HX
         GQyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Borislav Petkov" <bp@suse.de>,
 luto@amacapital.net, keescook@google.com, dave.hansen@intel.com,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 ak@linux.intel.com, riel@redhat.com, pjt@google.com,
 torvalds@linux-foundation.org, peterz@infradead.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 jikos@kernel.org, gregkh@linux-foundation.org, tim.c.chen@linux.intel.com,
 "David Woodhouse" <dwmw2@infradead.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.808048825@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 078/104] x86/nospec: Fix header guards names
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699632692841359?=
X-GMAIL-MSGID: =?utf-8?q?1594699632692841359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 7a32fc51ca938e67974cbb9db31e1a43f98345a9 upstream.

... to adhere to the _ASM_X86_ naming scheme.

No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-3-bp@alien8.de
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef __NOSPEC_BRANCH_H__
-#define __NOSPEC_BRANCH_H__
+#ifndef _ASM_X86_NOSPEC_BRANCH_H_
+#define _ASM_X86_NOSPEC_BRANCH_H_
 
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
@@ -195,4 +195,4 @@ static inline void vmexit_fill_RSB(void)
 }
 
 #endif /* __ASSEMBLY__ */
-#endif /* __NOSPEC_BRANCH_H__ */
+#endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
