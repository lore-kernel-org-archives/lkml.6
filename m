Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524604967; cv=none;
        d=google.com; s=arc-20160816;
        b=mUIuZHuPtX3pDFvkOeJkpPp70t9yyO0Wcbv4u9n29P6img/9EiYoLG314LaMxSn1Mz
         9y3GOJaH6X2OYEK/ID0Zq4r6C8tr7SBn2ArE5CPTh80NS640PTSD7yZXyVnZh64MGpKE
         5wDgUl86RIdAnSOKBLd2Hbok6uEc1cUa+RGTK5VFvNTm/oaCLDPrZtRJ0Intip4FyrMW
         VwiprXYGsg1orO7p3RpSKBxslc4w4EzveKm4Y2AagEpQWKspox9DruKiWS8Hx8tI8kk+
         +yZGuY7Z2SlUq2sjWmR/h4RcySA3I/pw2lh8bi81VZVbveHQykiFXstLNd3tV75HbFD9
         6hAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=OTZJEvCtgoauQ56LxM4JhZ2KxUm2g8kUWOXrStAFFd0=;
        b=USFEsU3HvHH0KBBCVv2mLQnpTzOCts59siIPcPNNWUMNzbmb0p1STIS5vLMCZFSQwi
         Ks/Z/O0Mzfekaab/r2edOlKQA5MJ+O1oi1ouMixAx5Ltf9WH4y7/nFlgbsz28uhi5/lO
         /syFNLwm8VCAeHqX1F3bbjr72K4wB5LyH8E4TpvvlkiQudBdl1gtibTOEFNHN0JHJiMj
         9WyLz0bH7UoNU0QzXUQKx1nIG8gvphwES7TG7VRviJ2N36uLFzduF0gpCnrEC+6V/yto
         eF2UDCyrnln3TIw6QgoqLopi7ExxXU6GfuEBZYAKo7jxjkQaBE82TY6iUv/1wnExQE1p
         tNGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dPW7oBuf;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dPW7oBuf;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49xqZ6is7IrHfuHmwG3tg8ZwRcq5e9HhMN2IEl3Ky8gPbl5lBa+WEOEPcsnj5BILL014Ouc2w==
From: Wei Wang <wvw@google.com>
X-Google-Original-From: Wei Wang < wvw@google.com >
To: 
Cc: gregkh@linuxfoundation.org,
	wei.vince.wang@gmail.com,
	Wei Wang <wvw@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Crt Mori <cmo@melexis.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel.h: fix a typo in comment
Date: Tue, 24 Apr 2018 14:22:38 -0700
Message-Id: <20180424212241.16013-1-wvw@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598664178691069989?=
X-GMAIL-MSGID: =?utf-8?q?1598664178691069989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Wang <wvw@google.com>

Signed-off-by: Wei Wang <wvw@google.com>
---
 include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 6a1eb0b0aad96..e37e40ff14bba 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -664,7 +664,7 @@ do {									\
  * your code. (Extra memory is used for special buffers that are
  * allocated when trace_printk() is used.)
  *
- * A little optization trick is done here. If there's only one
+ * A little optimization trick is done here. If there's only one
  * argument, there's no need to scan the string for printf formats.
  * The trace_puts() will suffice. But how can we take advantage of
  * using trace_puts() when trace_printk() has only one argument?
-- 
2.17.0.484.g0c8726318c-goog
