Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4+vvyh+ObBRe0vYzDaLS/ClC8WVbSaUfAtv/jpwXPZTzJKMBnufKI5J296EbKrAZh0+dzI8
ARC-Seal: i=1; a=rsa-sha256; t=1524689625; cv=none;
        d=google.com; s=arc-20160816;
        b=cWq7WCgnILyOetBhxKSCK3Jh2U/6g+2q2NNHiLeLYUCiWZJRZIsU2YfEMwc+bqsxQw
         wIu9srUXn8Rs9Y755oQnG2YfYM/hzDZV7JWzcICdyKV6zMFuuMa2hpSK7bjNTDG9TpB3
         l2oc8TvmWzCu9eK7AR8Zix8gmo4r4BB30XcBVnmWm+0URDIlVNEo+0psMWttGH4UmVqI
         7QMeERDyR5RToq4Gpg4so0ScjyUQywt442shEQxiIztyQpRQqpDBySe+z6Yg3Fnkwio7
         I6LQHdQjk9uAldQN7a7YQpGcyIp0dNVGSmag51ovhcpRYhpsC3bU2gpfehR1+FzVaTOk
         nUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=BsXUfRiHFr/OdcITdJdVbBgMOfycXvfmuxo0JlQtAF0=;
        b=AHuC9OmpN39QiQlfowrRZ4jffCO+Z1SiJRwO47cft3iJuR3tV/JbiXUoZgivYl91Zo
         d1fMCSDyAaAEmiYQBZrtBjTuZjeUmFNIRI1OKsT7LtPstMt6FhCoi8u41O7XRoNMRuKM
         Jv69lAf554DnQAsH0CFyrZtRqBXFgxFbaSAPhka9MW9QiazpFcSrE4zjs6qSQkzJWgnq
         /jg/X2CY1Z8AH+u0jI/mMIj2NILDrJMueuvgQbB7P0lT/ZU7tF3+voc4/BpqFqfgNSP9
         VXA8dydSu0Xbn/lm1n95CP6J3wlr3K2dLeitMcaLngNHE7i1Om/wQmBVeuPvM9T7Pw3R
         lbEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180425203703.226977693@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 25 Apr 2018 22:30:22 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 Christoph Hellwig <hch@lst.de>
Subject: [patch V2 2/7] LICENSES: Add X11 license
References: <20180425203020.594959448@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=LICENSES_Add_X11_license.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752949361888864?=
X-GMAIL-MSGID: =?utf-8?q?1598752949361888864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the full text of the X11 to the kernel tree.  It was copied directly
from:
    
   https://spdx.org/licenses/X11.html#licenseText

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/LICENSES/other/X11 b/LICENSES/other/X11
new file mode 100644
index 000000000000..fe4353fd0000
--- /dev/null
+++ b/LICENSES/other/X11
@@ -0,0 +1,37 @@
+Valid-License-Identifier: X11
+SPDX-URL: https://spdx.org/licenses/X11.html
+Usage-Guide:
+  To use the X11 put the following SPDX tag/value pair into a comment
+  according to the placement guidelines in the licensing rules
+  documentation:
+    SPDX-License-Identifier: X11
+License-Text:
+
+
+X11 License
+
+Copyright (C) 1996 X Consortium
+
+Permission is hereby granted, free of charge, to any person obtaining a
+copy of this software and associated documentation files (the "Software"),
+to deal in the Software without restriction, including without limitation
+the rights to use, copy, modify, merge, publish, distribute, sublicense,
+and/or sell copies of the Software, and to permit persons to whom the
+Software is furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
+IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+
+Except as contained in this notice, the name of the X Consortium shall not
+be used in advertising or otherwise to promote the sale, use or other
+dealings in this Software without prior written authorization from the X
+Consortium.
+
+X Window System is a trademark of X Consortium, Inc.
