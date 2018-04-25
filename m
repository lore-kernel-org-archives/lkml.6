Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4/v03oSYZNtjlzFxHnvpHTOmrjguNVXcIUa4/7U/yZQFz697RWb/cWGsHQhQSEaYyCaJLxc
ARC-Seal: i=1; a=rsa-sha256; t=1524689628; cv=none;
        d=google.com; s=arc-20160816;
        b=RHUnTa3IWaoQKcyxrXFiaamMCIOEy/gVwTnuMeejJhI7r4VlAxgBTeEmahKlXdqhti
         LkyKkQPvoL+MeWhDFzA5b3vdH/3LCMVsZHehQfS4utsIGIOVTB0M4j4K4If4FBq2DGHs
         QBeFPPyogkGt3ReQiqGOPcs2RWC8bqCJ1zQkshGpmHhIgCjSOisX7Og3qqSoUwhMrC7h
         FV7pbebVf1ZB2q4Ffw4ZmvA6KMhGcRc+/cjnWHQC69AgrjK0l6i9EkWuKVTcO/Q+cUpE
         C70u1Otk4ywZtCtEihEiqgjtis0HkZ6iKE+n/picpmPZD2/D/TBJFh9xl6v5K0BfDIXw
         OxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=YdFzxMvTDNlJHrHhJVK7uWoBsvXODJDgVSM4u5+b6g4=;
        b=eTO4Lmc/aOEs7d9Gs2obv4DUlZAy4iNutqke3jTzfRBECLRtTVkujxANdJR0cY+YSy
         DWmnYmRdJwRvhqEQdqoVy2aALp+R6oAH0oxxJ94nlNQuwq9UNnHnYxBWzHjBMR9r1oAq
         XHmw+azpfS1LhmXIVX4Rux+K+LFiCDvELAylUwbAHrT0w5nr5OQYIvKw9ayfmdiD50Hg
         aa8/op4TUbEUjjB6JeiotaOb5kSD0P0eUcr9lN0LujbwLFmBCNDU0j+oodHQPEraFvtR
         C+zMBwQ2fv51p0OE+TEbhKj2T+JWLKdx/4/pM0MrMFE9c5hzYICUYQQb+qG4QKSQYTNJ
         O0Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180425203703.568152337@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 25 Apr 2018 22:30:26 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 Christoph Hellwig <hch@lst.de>
Subject: [patch V2 6/7] LICENSES: Add Linux-OpenIB license text
References: <20180425203020.594959448@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=LICENSES_Add_Linux-OpenIB_license_text.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752951603652171?=
X-GMAIL-MSGID: =?utf-8?q?1598752951603652171?=
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
