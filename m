Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx48l0uR0DdHU2YjOyNFs5B8EI8t+rNM7nZXUNXp2NScXL6YmZktWhFyfITGcwGfmpkgcPYkz
ARC-Seal: i=1; a=rsa-sha256; t=1524435139; cv=none;
        d=google.com; s=arc-20160816;
        b=tONDFPtQ3mmPqKkvcLCuhOn1rkkHa/vdiNFboQiHNCgrj1UkAn9sUIGFXxY8YBkkz9
         qut+AVjeeltDWMMRMkqg/oLwRl583JlOY83XCPE8U5aS6fAZE7se5N73gvlPEUGTaPGG
         QbjnwxuZ/1JhRNfgPDYLsoitsddBD1MEHv6yOlfUZqIGF9g+a7bK0fY8uqD3Q8VGrU01
         rs60mv99ySZJ0+AULyc0L9F5Mx3Rsa2oNk854k1g4dGCc5FpMANpfegPDJtzIrb3Tw1H
         4k3FyZgZEYvZgxw9oVDHxzfC+hlOyVoTUlx/oG1vuTHIbTS5trL9lhTi/Ue9q/xg92Io
         ymkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=aWs6uULarfTlHhTTMU9UYVUlzpb6aUM8PVEwlUrU0IE=;
        b=LlupZEcbXwVMDl/1VxuAS2p0t7df6QRtK4rjyosCUV1jIaQt+1EUf6LRyJPgdEVT0r
         gDquqXl0pFk+wVKJ/qaY66zjnmv7tzzS/6mVkekqJn4S/U7mDPMKNn2V0GVeifpfCNp+
         lAJEolH/x3wRn5COJVTFwATpDQOpzsAWnTIjhOhBE+0q5qc5aZTnYSsnXAh5oEwO5zAy
         nwMzIMfd2wkfAY8kIj2lb42OtQ5hXYI5cIu/hjiOuCmNJ0XwQsV6OARgleMLedk3nFzu
         75T/EqIGmA77RW41GQSovfrblsBAsrDl4aj/AEufv0zU+pTN185qhp4ityrFFoV42djm
         stUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422220833.520289916@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 00:02:17 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [patch 9/9] LICENSES: Add Linux-OpenIB license text
References: <20180422220208.772527041@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=LICENSES--Add-Linux-OpenIB-license-text.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486101082357549?=
X-GMAIL-MSGID: =?utf-8?q?1598486101082357549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The infiniband code uses a variant of the OpenIB license. This license is
BSD-2-Clause with the MIT disclaimer. The linux kernel uses this license
extensively throughout the driver subsystem since 2005. Note that the
OpenIB.org license is a true match to BSD-2-Clause.

The license text was copied from:

    https://spdx.org/licenses/Linux-OpenIB.html#licenseText

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 LICENSES/other/Linux-OpenIB |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- /dev/null
+++ b/LICENSES/other/Linux-OpenIB
@@ -0,0 +1,26 @@
+Valid-License-Identifier: Linux-OpenIB
+SPDX-URL: https://spdx.org/licenses/Linux-OpenIB.html
+Usage-Guide:
+  To use the Linux Kernel Variant of OpenIB.org license put the following
+  SPDX tag/value pair into a comment according to the placement guidelines
+  in the licensing rules documentation:
+    SPDX-License-Identifier: Linux-OpenIB
+License-Text:
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are met:
+
+    - Redistributions of source code must retain the above copyright
+      notice, this list of conditions and the following disclaimer.
+    
+    - Redistributions in binary form must reproduce the above copyright
+      notice, this list of conditions and the following disclaimer in the
+      documentation and/or other materials provided with the distribution.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+DEALINGS IN THE SOFTWARE.
