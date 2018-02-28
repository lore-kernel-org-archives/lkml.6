Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519801257; cv=none;
        d=google.com; s=arc-20160816;
        b=RvwOcAiAA0baUIh5jI9NSCnj9dwS1GFZNSKOHNYni4M8EODqtu2Zez2FWjviVYTW0I
         sU5qoKK7K9TrIWnM7zcY344byhvVZ3qlxkDts+vreX6xn90jq+37JlqS8REpqQ7J2Ecz
         WtoHttpyPaBqYP0upa5vn9caNz0NZIWdk8Dhk6uWHccTPYkfnZHYhZtrDCtClkW3FT5r
         Mv2wGQhAKD8IxCtPKR7g4PyNj61f8ZKUonEMhwSPEDcAoJwmYpoIrEx9sejrDKg2X2WQ
         3so8I/6IceqqtiOIk3y9LrpkFP2HDR3utxFlcjpKGKLXopEMFaVqQtK6OVditrYA1ecG
         kYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=0WmfroH9aNX1j8ok9I7+T7bqaLKfmCXI+V8pMqDb2SE=;
        b=ESyFFQHSkC4dqr+hLqLsqp+vo1kxRXqjxOyndThItRL1RPakuVRYegEiXOusra4adq
         DU/u4dm6aalmtmugrUFBMP14/NN1m/Xpg1eFQeDY9EhpVZzm0aqgILjz1o3EbIsp2K0o
         o1+t67UvuSLUlCvoIZmEPgY9jlW/vEDuEA1ItO5eXWrK33RgpYs2M4JY8Ry1sWS/zFWu
         PFJ3/Xme0pJc36rJas8QlqwVgy1OELuwW5SW/iUHx/a/OPIuBnW/yu/SqVBuhsHwzh6s
         3HdPqlT0RoARzJ8bQkb6zu867oqEwX4Pd0IbkzE6tDZjVQwKKghjw6gO173gtvP/xowZ
         HCuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vdLOTmuQ;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vdLOTmuQ;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvA/nGmi4H0DJHXM4iEaLxyXXU0Fohh4DxJ1a82R9n7e8d5NX9actFrt8LP/xvjslq5aWgT3g==
From: Arvind Prasanna <arvindprasanna@gmail.com>
To: 
Cc: Arvind Prasanna <arvindprasanna@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Update ncurses package names for menuconfig
Date: Wed, 28 Feb 2018 01:59:50 -0500
Message-Id: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593627124178304067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The package name is ncurses-devel for Redhat based distros
and libncurses-devel for Debian based distros.

Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
---
 scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
index a10bd9d..4353e40 100755
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -55,7 +55,8 @@ EOF
 	    echo " *** required header files."                            1>&2
 	    echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
 	    echo " *** "                                                  1>&2
-	    echo " *** Install ncurses (ncurses-devel) and try again."    1>&2
+	    echo " *** Install ncurses (ncurses-devel or libncurses-dev   1>&2
+	           *** depending on your distribution) and try again."    1>&2
 	    echo " *** "                                                  1>&2
 	    exit 1
 	fi
-- 
2.7.4
