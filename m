Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519853566; cv=none;
        d=google.com; s=arc-20160816;
        b=QxikBy2VpT3mDDam/PojpmsB1PznbihrPLKX1WUfJqf9sbqZOoBltqe3a34Bq5IzrQ
         4VxvMeiu23ucaAv1nwePKe6s8EHq2T9SZ6P4nwIVeJnCwRxye/MAiXFLoyZyrdgH/NVB
         2aMQwH+N7e1OKLOhFcEGPzzwHJUBT6DMIbrYAO/QEO+lNudLF2wr9C6B/3//nwI52lwS
         YfIHjt8Zmb4Nr0i89Z4Z/RNpl4DZnhKX8tcxJBphijWcOHo8AsElpDots3mg6LO43xBZ
         kCG9dQE69aSEVdCVmer5gXnoTsa/7G+y55JimWvdOhNmAFbnkzKPhpLJsiE0XjY56KFQ
         +5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0zMsEEcMIx6l7FTGFk0tZSDKEOvMTMiXmQ1/8ZDEjno=;
        b=RCOv8aCPPY0vodATMGApVD9B/qLj1WiSipI65WYO8UHkw0VM61tTD4+xnQGjYbv935
         cBBc0HyVl7VB7smJFlX+53PzV22WFRreYH3Ic/KNpI2CH8Pn7jKSNziopK8PDn8nNELO
         oMqH7Mm3gHM7mH1LwdpXcgt9zVtTApyShASQLAgpBejtBDimSVjbju/FAFbst4HNVMIv
         pMb18pQ0TFge1sUNrnk5E+YkOOvXKg20WTmGMIhHgbDBPy69daGruH74V4dHBG7+KIu7
         QVdVhXSSDpUVgCn8mLfwTWplIDC/TJLvkL5+sgBGIV+hxmwz3Bagqx07pHctUZqOVmDY
         K5AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uTQ0f9oL;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uTQ0f9oL;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv0liNfqWzlJ3pZTs5QU5Y0toSt2NqyIq7wGdezuJ3vTuJZ4X0p7RMdoQjR4uN0YHT3t9bw7w==
From: Arvind Prasanna <arvindprasanna@gmail.com>
To: 
Cc: Arvind Prasanna <arvindprasanna@gmail.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Documentation: Update ncurses package names for menuconfig
Date: Wed, 28 Feb 2018 16:32:19 -0500
Message-Id: <1519853553-10626-1-git-send-email-arvindprasanna@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAK-=9LoRtOjN9_jCxtHf_fLeh3NpW6KOgYNuD09PKbDkCaCajg@mail.gmail.com>
References: <CAK-=9LoRtOjN9_jCxtHf_fLeh3NpW6KOgYNuD09PKbDkCaCajg@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593681973491110684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The package name is ncurses-devel for Redhat based distros
and libncurses-dev for Debian based distros.

Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
---

Changes in v3:
- Fix a package name in the commit message.

Changes in v2:
- Add a missing echo as pointed out by one of the reviewers.

 scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

 scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
index a10bd9d..6c0bcd9 100755
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -55,7 +55,8 @@ EOF
 	    echo " *** required header files."                            1>&2
 	    echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
 	    echo " *** "                                                  1>&2
-	    echo " *** Install ncurses (ncurses-devel) and try again."    1>&2
+	    echo " *** Install ncurses (ncurses-devel or libncurses-dev " 1>&2
+	    echo " *** depending on your distribution) and try again."    1>&2
 	    echo " *** "                                                  1>&2
 	    exit 1
 	fi
-- 
2.7.4
