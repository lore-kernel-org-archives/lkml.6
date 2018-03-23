Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AG47ELsydbCBa+0IFHG0g/hJE/9Pew6IXvLCc+qgoTBUn6SROY2vaHG8D34+aI41UhClGXuL3kgG
ARC-Seal: i=1; a=rsa-sha256; t=1521798689; cv=none;
        d=google.com; s=arc-20160816;
        b=JZP5J2MEB/nSw/uM+Ubc63XwOudHU3vkA/AUijsw/2TLsvbEwu6kmskE3yZx68F8Ne
         C3laWToT/uCSEOxqDCj/VzWmsHwYDHMykF4WB44DmiUZVwGfhYHWdmqfWYYgcZVUeJ85
         FvP4sEbZzpx9Xtn47KxAAKMGMBxNAjdjSP9sgPbwCI9T3VkT0r38QDk8npjlohHri1M8
         Y7+xQWBO13OkM0lCJqjOC65fzAks4diX8RYaleYGLms88MVgZ/2V8/kGidLJlSlXE2kk
         AAudPmjaL964beyRzZ/4fs/QoRXx9jh4x3Xtk4BOsyNVjWoTeqTBjcJ+amMZZTR/2EnC
         xj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Zkz+RJ6QzFHiS9V42AsCLCVzB89jtm+JXrZ2XOFO9Yk=;
        b=z4kuL6ze0ThaWQv6WATXQnRzxY5etx30zTcgNWSAIbley5GNJW2W9xPSiS6DseiKm0
         jti8sGPhVU2GLE58oAJiowcrJKNo2mlxAZMODnBfeLZWYPuXf83JwrtsypHBuYUl5qfp
         ldOSC2uJE+L9mRn2mjbC3gOFVfngq7EMd19ZMtPuP6+3dhd1t/KzJjYqg1IIJjyGWjqR
         lxbbcTygLt3CejGM4Bcgu8DvwxsFm4RLtUuXIO0iOlTEzWeOGvi3kf6gNHNLJoKi3Nqc
         OyiSZVxKz1G82DZRQ43xyPrbADR4nuJqTJM9m9sDlXWVRuRRjnhHeQ3OSdLpklHbRyme
         BHLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-doc <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonas Oberg <jonas@fsfe.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 0/2] COPYING: create a new file with points to the Kernel license files
Date: Fri, 23 Mar 2018 06:51:04 -0300
Message-Id: <20180323095106.23108-1-mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595631169729056837?=
X-GMAIL-MSGID: =?utf-8?q?1595721582481127834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The contents of COPYING file is now duplicated at two other
files under LICENSE:
	LICENSES/preferred/GPL-2.0
	LICENSES/exceptions/Linux-syscall-note

Also, a new file was added, with describes how SPDX should work at
the Kernel source files:
	Documentation/process/license-rules.rst

Instead fo having it copying the contents of two files, and not
even mentioning the third one, replace it by a file whose content
points to the other tree files, preserving the Kernel's license.

Adjust license-rules.rst accordingly.

No license changes.

NOTE
====

In order to make the diff easier to read, I broke it into two patches.
Feel free to merge both when merging if you want.


Mauro Carvalho Chehab (2):
  COPYING: create a new file with points to the Kernel license files
  COPYING: use the new text with points to the license files

 COPYING                                 | 358 +-------------------------------
 Documentation/process/license-rules.rst |  20 +-
 2 files changed, 21 insertions(+), 357 deletions(-)

-- 
2.14.3
