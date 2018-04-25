Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4/5xcNtlkYgq1lVR+j9TY2PPn1PX4x1eaZT9bgTZ/VYgS7iC4S4nJ5OqyNWKkj1bfe/0k+V
ARC-Seal: i=1; a=rsa-sha256; t=1524689625; cv=none;
        d=google.com; s=arc-20160816;
        b=um2YvzebLpz9aBRBcZ3paGYJyhCdPpwQxyHGYh3VB3ODW8lGaReLzroJptc8Owt5cy
         36cEe+2e7JTjG4OMhqjzY5eX3IHL5Aw6g+q6Oh+Z1A+g4Y/WweSJZR90ULGmeAZsZkO+
         eLOOD0uBTstb0qP6y2pvNZd2MVsPslWE6MgkFKhSCfm8E1MkNh7OtGHlxbxZ0lssFPWM
         ugNAIEuSD3YiyPTVlLPGj6OVpiG//e3I4ffp5SIm7/rx+lw0bxzTSdrVw4UCoCAE/Uoa
         Ety3dc2Pm0GmBOP9XuvYffT30ZMC9POzWpFK0KlB9Kx5a0p6SoxvA3HbIJHQMWgvOvsk
         KwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=l6lrWsDVPkiXzKNJ4Vx2cXcK0Ww4o8wcMMc4NjWIp2o=;
        b=Ce5qzO3S54qVXo8fI8OFjffMtnc3ifg1wjah0w6TImxB1AZ62PSmV3g8i8GzdByJyl
         XtibNeg8I69psEQRWZyzQbe6kk8R7LJBF8DGtvHJVTPuRgiwBT9k7LTdam8jueZ1sqDY
         aWEVB77l5Drh3wfU3NIKg1huA8ef+QqG246hiNeyJLi7DECaH3VRXPlLSv/CLyDK83tS
         hrHhKSJUeFfuD1Cd89aPGyn1BM5jTgnHUF+hcqdQjziK6mS22xhpnxhbCcht2y8xBQp9
         3tWG0+gA2kw0bfbNPxnOtUjGawCqVYUUmFyIsrjX11m9xp92e4wOekIbAbnhmxFnhlp2
         a6TQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180425203703.137893509@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 25 Apr 2018 22:30:21 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 Christoph Hellwig <hch@lst.de>
Subject: [patch V2 1/7] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid
 identifiers
References: <20180425203020.594959448@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=LICENSESGPL2.0_Add_GPL-2.0-onlyor-later_as_valid_identifiers.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752949280430563?=
X-GMAIL-MSGID: =?utf-8?q?1598752949280430563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner tglx@linutronix.de

Quite some files have been flagged with the new GPL-2.0-only and
GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
GPL-2.0+ identifiers in the SPDX license identifier specification, but the
identifiers are not mentioned as valid in the GPL-2.0 license file.

Add them to the license file and to the Linux-syscall-note exception to
make everything consistent again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>

diff --git a/LICENSES/exceptions/Linux-syscall-note b/LICENSES/exceptions/Linux-syscall-note
index 6b60b61be4e9..9abdad71fafd 100644
--- a/LICENSES/exceptions/Linux-syscall-note
+++ b/LICENSES/exceptions/Linux-syscall-note
@@ -1,6 +1,6 @@
 SPDX-Exception-Identifier: Linux-syscall-note
 SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
-SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+
+SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
 Usage-Guide:
   This exception is used together with one of the above SPDX-Licenses
   to mark user space API (uapi) header files so they can be included
diff --git a/LICENSES/preferred/GPL-2.0 b/LICENSES/preferred/GPL-2.0
index b8db91d3a1cb..ff0812fd89cc 100644
--- a/LICENSES/preferred/GPL-2.0
+++ b/LICENSES/preferred/GPL-2.0
@@ -1,5 +1,7 @@
 Valid-License-Identifier: GPL-2.0
+Valid-License-Identifier: GPL-2.0-only
 Valid-License-Identifier: GPL-2.0+
+Valid-License-Identifier: GPL-2.0-or-later
 SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
@@ -7,8 +9,12 @@ Usage-Guide:
   guidelines in the licensing rules documentation.
   For 'GNU General Public License (GPL) version 2 only' use:
     SPDX-License-Identifier: GPL-2.0
+  or
+    SPDX-License-Identifier: GPL-2.0-only
   For 'GNU General Public License (GPL) version 2 or any later version' use:
     SPDX-License-Identifier: GPL-2.0+
+  or
+    SPDX-License-Identifier: GPL-2.0-or-later
 License-Text:
 
 		    GNU GENERAL PUBLIC LICENSE
