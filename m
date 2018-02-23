Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu73M1L/O7lcfOgbEeqgdgaLEDXelWYwuwkOFxWPqLy3EnISYLAB/e5lAAasYeX87pg1ulp
ARC-Seal: i=1; a=rsa-sha256; t=1519411237; cv=none;
        d=google.com; s=arc-20160816;
        b=Ue0jKynTXIxOkOvj5hueQQrA6lCJAS9wmhovv5F49MYTlBt8iSQUo38i55XVwrr7Uz
         V0+XzFliRhBMdReGdbi+lwb9dx2GUBPJr7+g6keKkdE8avVchH/w0Z6tgrThZvwqMwid
         XSPN5nNhghh6xzXHIdDy37eAjuXU68kinQ3v4AorEDs5OMbBZFITiX0uTkqW6OoD5Gax
         mdnhL49vQrdVPirimOkWj/laP73rlmheMiyndL7AZPd1ajzAzGLCU5Qb9/3fXjEW9yAo
         tApjwq9E8UbHLNTkv2MRBPgwpEsuDbzrvWzRiEtrRw95yfcXoyRnzMHCsFsJQCTFgGLk
         R2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4WFgdWFGLrNGxpOYK1Z7MLw7pHkborYLWFR/FnHn+t0=;
        b=VFeQcMi2WqkGPE5IDjrcmdLb67Dkxt0hgX2cYTe+BpYghFOLwUWhmi6uXiQqfqYrs6
         1TN3mwiy445Ie8K7G5ydrM9tJyJQTiEaT0QfUZwuqjapZibOjvT+xADi6kci7ibHmqxx
         D0HEkIatadeF/y+Ed374M7j2fF42MEYkOBIpz8KqIPUwgG6mEhp5A6IAqtJPF0k+uCPw
         A7mM/hdJok9Huw4j30EmsbM42vQxGpBwKULD1Ub3tCwmIILE9p/A4qUTp2nZUG/e/h5E
         DHwaGMoRgjmAlGZNMcu0iE3UG2IV5RcrfIQmP+b/JY0vERvksIjmaHBllNLmgXvgcys6
         NiRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	riel@redhat.com,
	ak@linux.intel.com,
	peterz@infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	jikos@kernel.org,
	luto@amacapital.net,
	dave.hansen@intel.com,
	torvalds@linux-foundation.org,
	keescook@google.com,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	tim.c.chen@linux.intel.com,
	pjt@google.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>,
	gregkh@linux-foundation.org
Subject: [PATCH 4.4 169/193] x86/nospec: Fix header guards names
Date: Fri, 23 Feb 2018 19:26:42 +0100
Message-Id: <20180223170352.503332691@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218158118132121?=
X-GMAIL-MSGID: =?utf-8?q?1593218158118132121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

(cherry picked from commit 7a32fc51ca938e67974cbb9db31e1a43f98345a9)

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[cherry-pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    6 +++---
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
