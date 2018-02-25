Return-Path: <kernel-hardening-return-11946-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu3G53uSRRrL7EZc/+Hf+xV6ZFuibbEbGnKZ1Pq8fPXdldNc91YzzJMegr0dX4/58HGdq+6
ARC-Seal: i=1; a=rsa-sha256; t=1519544202; cv=none;
        d=google.com; s=arc-20160816;
        b=Gspkigtoymks81c9L7eGh2A7FdePMYhWM+GbmqPxSHwk8J7MG+UG8lDodYOc1N1uSG
         A2lr1CX9RxNdMYIKbiwt4EjTkJfFEX7UPLZBDyY8Hd6qEIMdS/5zFmhYSD1T1cCvM5Zq
         HsKYVRdhbIgR5rwaT9cWUX6ZZD7qc6c2GuiHVg7td47aFOGsoTjEdjq658OSWRUpCXLW
         nGT3PuKL7+wSgUHGZLA0AU8r+Eur4EZkAcQBlAyoRM74RgYBMz0EDlSX8wkZzBoha/uR
         XChGhbaG+5hdBObW5WSBfrQDkKLyMXFkqLHSgVaQ7b3kDqXSf7jYegfHf1vHxqTF3EPK
         bQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=qEp+cDHalJIK47yzkOM8wlaSglFoj06qYlIY5ViCFi4=;
        b=GYmrCCsUpYcGzTZ7UXI9l4tsDjpUSc8AuZF6/gf7D88p1LxC6SfC4pxbLPIP22mHbf
         A9kI/B60mupXIyz1ZvqfCiKub+VlEHXY/d7Ibjqky0schjNHNonQmURN36n2UY2JZ58a
         SDXZrm7WQIyqYBGoli3mNNZpfL1m+4OhYzsg5UzlWqWzEWaSARtpL9U2UsTakHLFb5sh
         ZEiaOdbaDmhUy0ARvQtrVbqBgpdo7CFX/QDPxSqkFQhAzGNFzyjiZf3Ofhr04067jRrf
         JF05POSv7Z63oFKRB4e90I0mo9U1njysQzIIL9KPoFW3uS6eRx0w1BTi1dOiB3AnRdCG
         9EJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=ertDe0L1;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=H/l3hvXW;
       spf=pass (google.com: domain of kernel-hardening-return-11946-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11946-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=ertDe0L1;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=H/l3hvXW;
       spf=pass (google.com: domain of kernel-hardening-return-11946-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11946-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:dGeSWli3R8Wymhny-t55CgZcOgqhqER9LWwtCZfUZa6PdFMOQJPknA>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	LKML <linux-kernel@vger.kernel.org>,
	tycho@tycho.ws
Subject: [PATCH] MAINTAINERS: Add list, tree, and maintainer
Date: Sun, 25 Feb 2018 18:35:53 +1100
Message-Id: <1519544153-10360-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593357581130073785?=
X-GMAIL-MSGID: =?utf-8?q?1593357581130073785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

MAINTAINERS is out of date for leaking_addresses.pl. There is now a tree on
kernel.org for development of this script.  We have a second maintainer now,
thanks Tycho.  Development of this scripts was started on kernel-hardening
mailing list so let's keep it there.

Update maintainer details; Add mailing list, kernel.org hosted tree, and second
maintainer.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..e91b5ff1f5d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7905,8 +7905,11 @@ F:	drivers/scsi/53c700*
 
 LEAKING_ADDRESSES
 M:	Tobin C. Harding <me@tobin.cc>
+M:	Tycho Andersen <tycho@tycho.ws>
 S:	Maintained
 F:	scripts/leaking_addresses.pl
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
+L:	kernel-hardening@lists.openwall.com
 
 LED SUBSYSTEM
 M:	Richard Purdie <rpurdie@rpsys.net>
-- 
2.7.4
