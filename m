Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx48XWdr8OKkDFBAOlkjOtdxPiYgJNnGyKnqONOej/9zKEi9ZjPvlLFufHBWVg7N7sfFv3eN4
ARC-Seal: i=1; a=rsa-sha256; t=1524435133; cv=none;
        d=google.com; s=arc-20160816;
        b=CzPgw8LwhR2OiEG3pQ0Vk1HAp2x2/FXn3Bnf6oGkOQp8OxxfjBNkGJfZyczp6bDJU/
         bHVkgwamPGBZYUXaOAUYryn8IftCkUV9EPAyG6kTJ0TZQW0uP0iyTigDL3k9Qv3yoccQ
         dO0y8fkUVsCjqFBKhbc3lmgnQlu3A0DTDNQNRq1a/xAda03TKZiZ72vvASu+8k4qWmoS
         yLk8LAGfk2PKaurOFA9us57iEAnxWF7tEQ/QV7bXi0iKamQK6Zjx/cCQ1t/5hXWnSEFy
         KZzKgD7qt3t5LWVOEppDGIiQz/snGN7jzwLle2t29iWx59nCalmTDnMYdbUamdQjRtJU
         dp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=K5/Hfi04gUqvuundkqeQPVGLPslm1EsNAdx8lqgRW0k=;
        b=rCbaRx1BiWwxhLv6KefB7gjYhEAoKxC9S2G9ZKi015Fattk5ljAgJ/1AAyLzVeiOep
         GYTzOaaiwGGfHK3SJyIewSiyTAHL2qTkdPsPrSCNwbdaIgau/lVksA9Ceb3xPP5uV/BF
         QcbTAWOwsGlUBjK9sJ53DTsA/Q8NK8nKB3cxu5llfndiQdV62jLYQhNY39pvkvPMWLQn
         g35+MDrjV9Jl21wtNwWIKnMYeXOBKOvG/Iy8A3aC7WKkvVHkJmXHy+q+HpBaPVtK3KC2
         L0SZBUIzNW3YbNPI1YnDZg/C2G3T/Lr8V8u2DoLi/pb/2+zwXdG+WKUZGEXknlTvhKX1
         uYLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422220832.815346488@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 00:02:09 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: [patch 1/9] x86/jailhouse: Fix incorrect SPDX identifier
References: <20180422220208.772527041@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-jailhouse--Fix-incorrect-SPDX-identifier.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486095183282307?=
X-GMAIL-MSGID: =?utf-8?q?1598486095183282307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GPL2.0 is not a valid SPDX identiier. Replace it with GPL-2.0.

Fixes: 4a362601baa6 ("x86/jailhouse: Add infrastructure for running in non-root cell")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/include/asm/jailhouse_para.h |    2 +-
 arch/x86/kernel/jailhouse.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/jailhouse_para.h
+++ b/arch/x86/include/asm/jailhouse_para.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 /*
  * Jailhouse paravirt detection
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Jailhouse paravirt_ops implementation
  *
