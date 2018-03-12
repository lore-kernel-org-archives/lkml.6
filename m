Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtO2sWeAKAJj747Rh3IpEM6wCDiLhr+Tms9ACowOpQ04D0/LbhwG49PCptBTFz2LXkpMT/w
ARC-Seal: i=1; a=rsa-sha256; t=1520824084; cv=none;
        d=google.com; s=arc-20160816;
        b=nyU4G1QihL36G3Q5mzvZ/D4RtqEHWpF+C0iL2mUICMvduxiTMd5IGHJj2R2LtYri6P
         aNyuV83W73hO29UA+i71JuMGxJU0KqbtmNWPceE3mmNvXQZnsvsCDtC6y7J7EFNP5a1J
         Uc8CH2thhd4ADLxRC4FWoDW0zvBvCmB+lWNo4lUgbTDRrqWytUbPgoTsU1/Hf4e9YPnG
         NR7GfWlTrH6pjv4HMFQLeRyNlr4GF/i21/Xs5HhK++4yEf88MbtZqjcOciTw2iLQGFeR
         W/IKA09mcFUKUxRWVpG8d9wUU+5LZ7bQcxGHuw+Y8t+i72Lq1beo0PsUQpA6Yy9AlRMM
         QWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=AxuETRLGCgCtIud3SRqCs3nRJLcqzdP+B/IgbJl0kiU=;
        b=EcNEJKoV+wWEpxpDMJPu10bCaP7r9+bcU8QIM4gXt6AQSGfqIiHBJYU9QSHAvUqAhW
         RbE8azT+Ae2382KXrkAPq/IQepc+n7Q7nqSc71JKNdWbzi7utOvTBQ4jWo8bE+GgFHlx
         gLdLrHYcx+NSNfSklK6VxiSoa/THI/aDmrqPZrUeCosmxJeO2kzOmc9RaDQzq9YY31fx
         9Q0X8+AqFqWwdj7i8n3LYJRFYxo1FG0oVyYR70Q4JsvtZmn5ZniS/5Wox72IeSkTv+7G
         jAIfH4mKgwwsp7uE28K9icdw2YOaK1j9B85BMivgpL3TF+qIn2yoAgbOpjuHvMZSrGCs
         F8TQ==
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
CC: akpm@linux-foundation.org, luto@amacapital.net, dave.hansen@intel.com,
 keescook@google.com, ak@linux.intel.com, torvalds@linux-foundation.org,
 tim.c.chen@linux.intel.com, peterz@infradead.org,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 jikos@kernel.org, gregkh@linux-foundation.org, riel@redhat.com,
 "Borislav Petkov" <bp@suse.de>,
 pjt@google.com,
 "David Woodhouse" <dwmw2@infradead.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.896941249@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 47/76] x86/nospec: Fix header guards names
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699632692841359?=
X-GMAIL-MSGID: =?utf-8?q?1594699634805695661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
