Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AG47ELvewUDwx6jeRE7umNos/5Z2Y5SVwtnRTJ+Gz+hyPm78lsQm0o2+8PG/bG0e1rsDd/RbTALP
ARC-Seal: i=1; a=rsa-sha256; t=1521712465; cv=none;
        d=google.com; s=arc-20160816;
        b=JndGgepn6arR90dFiFOiy/o/G6WE/0B7g9x3C+hVbUBinU/6vfCy2L7NAZXacQ1T2Z
         yPdY9lkdGVnXTJEUpAJI0zawYlLgkN1HZvOGYLw+eZFNiHUXsx9/YCr+CjL0fh3eh40r
         EVGfjiBDRLNPNpqTPTP+IMissqob+ET2dkV7OxWdfXmzYyR3kpRJ+a8e9XxAOeaOL7BT
         fJsFkBF9YXVGYClIIK33dYqUKs4AIw0ManD8kW16y/SfCBdRDYZZvofY9SAL7MH/syHF
         LqgOmOjdlXMQkmpOePShDgM6li3rd9n16Nenvw/BofjpeEX2Eq90qMVjrLwnlF5cwl5P
         WsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=e7WeGvlKY2hiNQHk0Icm3lCtd+F1B5H6LmxCxWQZUcI=;
        b=T5jybT+FxhoTf4je7bpOS8uB2kVUUrRBaXpL8N9jg/Bnn7JRfxujDg/x2UoL/2Sho5
         PAXyQwNrlHdLzYX8zqoLqJNGc4QyzuitUoxf7GK3tlcGmSLYjsL1GEQKOMjPOLE45Dhu
         fIvc850NqUOIAjFyEZf+GtqqXdkX1kCTIg6OKxsZ7iysHXXODrmR5ZLZa4oU/nbB2vP7
         Pa658+Mmruii57RssXNt3qoKYdoNUvxjmZ91phTMcoKyKYEXM9hlBHLOdfPurOxO+Jcm
         yznT1+FZ/+iSHTbshBnPQXg04b1f+Eucnd7R2uGILAmYs06GyDByVNFlTPrHQdlq7m6M
         3oZA==
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
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 0/2] COPYING: create a new file with points to the Kernel license files
Date: Thu, 22 Mar 2018 06:54:12 -0300
Message-Id: <20180322095414.24019-1-mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595631169729056837?=
X-GMAIL-MSGID: =?utf-8?q?1595631171171983405?=
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
