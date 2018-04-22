Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4+/aWYb/GhHuCwgRDSvuSjbOS6Q2qYQ+1MZ4H69X34384+JYGRbUKyvLkp9Eq28tgk8WwhI
ARC-Seal: i=1; a=rsa-sha256; t=1524435133; cv=none;
        d=google.com; s=arc-20160816;
        b=0Rb5ix8V+bupSm0qCM4G4Qh0mWdm6iTib9mrP2wjkM6euP9yu7vyuU18bLUt9jf1n8
         kFFhy1BZPLDqRKY0vDnvnfbrUnjMDpE3TLQ2IMfau9fLUms1k5B4GiMnlQYSTa2wyQZV
         q7ggtqR+5Naxi7WajXoSMpHgmKqGxEpZ1oDhRlCxyp6a7nn8gvVWO89xVjymXBwlTJSA
         LJUcyLl7Zlfq9c6kxfJxuQpngLMr3BzBMvENf71yTACz+upd7FCGzhSjl3G3KU5kG5p5
         aYHKmHuqLonCqm3dAVFt9kljL4VRnQtAR7H4LMZ/cVtiILpXwbVJRw5/nxwJ80XZ2Yas
         Oreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=7n8PVSv7r9wCGK60cABqiiaDjHzS0pPPhGC049UcS/s=;
        b=iS2ryAxLtas7MLiz5Y6lndfI5azRklcVE7i1RUW9MHyfkp6CA5CPAP7+OgcmokIoTJ
         Mb+3lBmLqofD8Frz7MkSiV90oEp+ntI6oyvwzaTx2SVB1WgGqARzlRQzVAmHA+/jImcE
         Q0rhLODqKpE5RreAG9xPY3ApYIrijoP9MxXi+3R566ZmouDZRpXvW1s0MibNNZM3YX6L
         z5jI4ZGDqdGYDu9gDHpX9jxanYrpDdaYfKttqlmPo4otNEGNQgNKxyvUAnYVcga1ucGD
         y5KdCFsY3/CfdKsdO29t8FsLTODSjAOfi2jvmLEjzoDITf6XTxoAEi7ModoHYF5Uuy5P
         cqqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422220832.899282023@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 00:02:10 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Jacopo Mondi <jacopo+renesas@jmondi.org>,
 Rob Herring <robh@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [patch 2/9] pinctrl: sh-pfc: r8a77965: Fixup incorrect SPDX identifier
References: <20180422220208.772527041@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=pinctrl--sh-pfc--r8a77965--Fixup-incorrect-SPDX-identifier.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486094497167491?=
X-GMAIL-MSGID: =?utf-8?q?1598486094497167491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GPL-2. is not a valid SPDX identifier. Make it GPL-2.0

Fixes: 490e687eb8b2 ("pinctrl: sh-pfc: Initial R-Car M3-N support")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.
+// SPDX-License-Identifier: GPL-2.0
 /*
  * R8A77965 processor support - PFC hardware block.
  *
