Return-Path: <sabin.rapan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526495258; cv=none;
        d=google.com; s=arc-20160816;
        b=M+NRcPB4q/g5g/XIDL3CPuZsHtF6IGuxwzq1Q55k/jA3Y0HDJWBVpOinCqSDvG18L9
         20lPp6gvEGfWcsj0uvxwYUV7VhbPdZhPyUjvm2gPl9HhlAS4ae920U53zvBY6NcV2Q8j
         eZMOHsaub7i612F3zpSRWC3FUHBAcXsXSrhVb1Ps8VmiBMHSKToSeWvFWTODgqXcTVd6
         fZ3lFjWIl7/Chk7w6Pc4Dixtwb4xwlfeNRQ9XXBOp1upIuQcbNiMMm/Cx/yHy3jIe/tW
         7Gpail/RYjk7Nksw44JdRCo6BNbu8DdYpoNCWC1PkJTjv6SqPV9RAOKqYeitSEHfRa5l
         /F+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=iUZS/Ozdt4s6aS/Vf0nZpFWDc97QLoSiXKJPDI/tmP4=;
        b=lEk/NbZKxIm6fg5X09ivIQSXVpcK1qAQkisFY/2fFAl1WCRW0YPyalA265+xbRcswN
         zjcYN/2KB/t5/if9fBCfBSFlp/m+c/oNE1LrUzxwgAYW1DUa5oPg9ePV8qTNIxhPJ7rO
         qMhjcXpDSUoRqT7IAyKpsGEQJX147BRdQHy/RzM4W6ktMrnReOVelVTR0cJ2hrIJjVNJ
         kbhuIuVpcs5BydUTY97YRKNSrCj1oX9Cd4ivllLwVzaka9XvejFXmnzvVtHmHtpmjXQY
         YLgHrlj2VtonEvHR7+UKkraEu6Ltmajz3NL3Gdqx0TzH9XH8PYdznn+Lj9+UnlOe+GN8
         /P8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KV7K7dtA;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KV7K7dtA;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZq8UNoo8lbzRqMTFFiTCPHtr+Tn8ltJe0AWfj6iKNWHWMz/XhuhBDHKxZB7Q0DbxGYn4DI6Lw==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org,
	jsimmons@infradead.org,
	andreas.dilger@intel.com,
	oleg.drokin@intel.com,
	lustre-devel@lists.lustre.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 4/5] staging: lustre: Fix "Possible intergrate"->"Possibly integrate"
Date: Wed, 16 May 2018 20:27:33 +0200
Message-Id: <20180516182733.5337-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600646292625767216?=
X-GMAIL-MSGID: =?utf-8?q?1600646292625767216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Trivial fix to spelling mistake in TODO file.

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/lustre/TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/TODO b/drivers/staging/lustre/TODO
index 94446487748a..5332cdb19bfa 100644
--- a/drivers/staging/lustre/TODO
+++ b/drivers/staging/lustre/TODO
@@ -12,7 +12,7 @@ addressed:
 * https://jira.hpdd.intel.com/browse/LU-9859
 *
 * Track all the cleanups and simplification of the libcfs module. Remove
-* functions the kernel provides. Possible intergrate some of the functionality
+* functions the kernel provides. Possibly integrate some of the functionality
 * into the kernel proper.
 *
 ******************************************************************************
-- 
2.17.0
