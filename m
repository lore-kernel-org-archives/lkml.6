Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4+Hh5W0DNI7oB2Wrius7DyXVfywwbBpZxlHMNq61M/szN8TtSyXeeUviL9EsWWiYWHZCiBU
ARC-Seal: i=1; a=rsa-sha256; t=1524435135; cv=none;
        d=google.com; s=arc-20160816;
        b=gGAWs0fBimlNeWC1J0eogJ5ui+qY5UB1yPsh1tnx3JT2FysHSBvVcCZI5HK8UkSucc
         Rw69upP7F256wrm9evTDjGkWd3eqMeRG8i6R8vLnLxnUzeKG5XjfcAiebVw/cmdd78Os
         4i4oQ2rkircMKJFsRgFIYvryNOvRvWay/VSQNNSSvcv+wztEDWQTgVzJbnwfe69RUYi/
         9KW0snmEjvluWHbWhONjfPDTNstjK6fKfwDSorSzLW8UUhqyNyLSZ2XgbxZproUjQxOB
         vkem0IdLcmcxkg0hU8Jbgf7a7YaUl8oxgHLuCqJgxzWYC/lMrUC9SNK720aFSG5wZLQp
         kDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=x95jwWcTD98KYQIq06QKaclh8g+yuSSByMj7IAgwpUM=;
        b=w9ocme6GMWi8UioPiJql64jmT5pA3tHyX1RSlHBHF38H7y1hrmIWkD/X7cENIa26e9
         hIByp2WVK40oGhe9Jl5i866HKI6IYrqy+MFZ4uPKRHUwyGqY6lVlhyw7Mqt8/GP2PzKX
         W8Sj1UmdkneMyhigYJJL7Q2+QnPdrUuG9pTE5o5hTi1LuZUnHOsWmwPK1oMDpJrBeKnD
         69kKA/2NQeDsLxFykpIUECrdWTj67wcIwYHQSCcu0ElcrKwqmnl22pwyPoxtdNnWvm1/
         zIw+EhPVdXzgLRi2jJi9YoBRqaJexaBnKcahXmldEUPtrDIBNVh7eg8DvWIq7CkfgDSB
         Q2ZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422220833.162012319@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 00:02:13 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [patch 5/9] LICENSES: Add X11 license
References: <20180422220208.772527041@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=LICENSES--Add-X11-license.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486096791490415?=
X-GMAIL-MSGID: =?utf-8?q?1598486096791490415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the full text of the X11 to the kernel tree.  It was copied directly
from:
    
   https://spdx.org/licenses/X11.html#licenseText

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 LICENSES/other/X11 |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

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
