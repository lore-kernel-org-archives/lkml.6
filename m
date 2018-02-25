Return-Path: <kernel-hardening-return-11951-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu6oGNxp8jENFsDuXsr8fiu+4EbZpIECGHPCY/zJlhXmDifAS4BHKsM/3oHK8Ac77xXTd9L
ARC-Seal: i=1; a=rsa-sha256; t=1519597706; cv=none;
        d=google.com; s=arc-20160816;
        b=DB3jUfSYr1IO7bjuxmZ3g1IK2qVIrL7DQ6kMgRwPtlW/d3yNBmljCkK0E8ZA/0Cmm1
         UDnp887bzYRrKbKg591vkOXWt6v9nHBL9bO5E5LKJCL/lZrRj+25HyvjLtvm1O9MnqUB
         AM7Tgieoe7C9jhO8Ou1Mh2hhqTnjbI1v4tfp8dW/HtbWqc/WOKktMXibUT/q3PqEghff
         YjIk+ct1KMuUx28LVWyCg9qHSuzrWqehPuAMZ4qC4r0VsrQaZ1F5y7RBCpvhSy2y1hkb
         zr1xrvha1LfUzuKAHlVvdQIlHVQjg1Ef6P5M2PdojB7E0lgrZFBIZQSIr82psEDxlJ6I
         q/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=go8GiMsjOFMowvNHWHoH0XUF6mP8sfvGmJFtfSWV95g=;
        b=lUpRomMw7P15Qq/ODz3NfWVkmPzLGALcO3wxVuYyGhTU+tGPAD4lPgpK+Q2QaDGC+w
         xOrbnopnZ7gBN/p0VU6ChfIcc/OfdTW3uo1McIA7/ZC1lIQ5zGidn9skvNyzggsDxV6L
         u5vmA6s4wTLvfDKfUSOKA3iBg7zBj2N4oFZn7U0+cT8ZV2a0P2Q/NYFNfhXpHsejEVGP
         sExSt39kQcl94/E9y4c4BNFdKja8Wve7VpSh8J6YOb2cBzQcLUm3TNEKs8aGNZPg6hGs
         Df4WlpwnyNZke0dPLuSZhzlIPyrkoMsLETxSsxCXu+3qn8nxQkikJrXC3oImpiL2hgxj
         r1hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=FUlFcEhS;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=KRL9gkYt;
       spf=pass (google.com: domain of kernel-hardening-return-11951-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11951-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=FUlFcEhS;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=KRL9gkYt;
       spf=pass (google.com: domain of kernel-hardening-return-11951-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11951-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:dziTWrP9j8zkcVNklq-FC-rzqtdJMBxCzZ948WD1SrcWxkziMNJDLA>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	Joe Perches <joe@perches.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] MAINTAINERS: Update LEAKING_ADDRESSES
Date: Mon, 26 Feb 2018 09:27:59 +1100
Message-Id: <1519597679-6101-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593413684370606303?=
X-GMAIL-MSGID: =?utf-8?q?1593413684370606303?=
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

v1 subject line: [PATCH] MAINTAINERS: Add list, tree, and maintainer

v2
 - Improve subject line to include section
 - Re-order items to conform to standards (suggested by Joe Perches)

 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..80fbb7ab2460 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7905,9 +7905,13 @@ F:	drivers/scsi/53c700*
 
 LEAKING_ADDRESSES
 M:	Tobin C. Harding <me@tobin.cc>
+M:	Tycho Andersen <tycho@tycho.ws>
+L:	kernel-hardening@lists.openwall.com
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
 F:	scripts/leaking_addresses.pl
 
+
 LED SUBSYSTEM
 M:	Richard Purdie <rpurdie@rpsys.net>
 M:	Jacek Anaszewski <jacek.anaszewski@gmail.com>
-- 
2.7.4
