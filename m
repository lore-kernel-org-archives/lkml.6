Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZp3i7Jg7OZs/v0obPx4rtypiZ06YKxBQVybx5N6T3nnyePki2p4/zcF899DFMfK3UCpnHO4
ARC-Seal: i=1; a=rsa-sha256; t=1525982953; cv=none;
        d=google.com; s=arc-20160816;
        b=HWuo9QTQDiR1uitVLrutJughxzarGwRdDX5J/5zrIiALMW4tMZwgwqZWc4rjwB/puR
         u1CLEOn8uVD67OwlspKTZ0HE+1Zy0qZmTLKJqcumr3etKV9X/iAyHyhq1nxzma73xO9j
         LzaQQtTrsLI5TFKk6rJ0YpZ2QWvfwrIp2Eub5J+a7VqbJE3HmU7qmR+eSLCHnDiFltPO
         CymeSQlTeKhUNsNESS4yyUSpx3vIkNBtwxIa26RN8WDwBeyqM1YuNWrwxAzd2PEE+oUT
         d6y9U9yaVvqzH+JIVj4vmgUbmfxxMy4Yy90Yo4lP20od2MIi9r9RXG9yDrw/ufKkhPDP
         PBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RHlzmKAJdsM8McFzm03lD/uXlX/LK45CsUVcrk7a45I=;
        b=yorBvCAxsqNLqZB394/hrwB8056ubUAsJoTaOHUZbzXt8qqUhR6r4WZIG6asms8RnJ
         PX5DrD/FKtQGKBAp4PxMC9REpbPzOmF3XkFmBUnNDAusXWPGj8XwI6EwecaZhp+62lim
         N+xWAYxWq/dSHnbh8P9Knii6uj63TWj3UXeay+0C5kxG+EJpW7j/KF8pQ5ev4LgTljZh
         EmgmcPzRsifll7cL9qU61FNcxFKFtycbmxxe4TB2wWoxDyE9RpkKL9pfUjZ6KQol7i0z
         zDLGWbbDZOyv3VsCDWa5T73hRUh8qg1mmqpXCBzQ5c/BfYqGKadMsfo1fCVexLZ/sddZ
         Bz9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pWcDl+Jf;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pWcDl+Jf;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 13/14] Documentation: remove stale firmware API reference
Date: Thu, 10 May 2018 13:08:49 -0700
Message-Id: <20180510200850.5958-14-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109101901764611?=
X-GMAIL-MSGID: =?utf-8?q?1600109101901764611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It refers to a pending patch, but this was merged eons ago.

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/dell_rbu.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
index 0fdb6aa2704c..5d1ce7bcd04d 100644
--- a/Documentation/dell_rbu.txt
+++ b/Documentation/dell_rbu.txt
@@ -121,10 +121,7 @@ read back the image downloaded.
 
 .. note::
 
-   This driver requires a patch for firmware_class.c which has the modified
-   request_firmware_nowait function.
-
-   Also after updating the BIOS image a user mode application needs to execute
+   After updating the BIOS image a user mode application needs to execute
    code which sends the BIOS update request to the BIOS. So on the next reboot
    the BIOS knows about the new image downloaded and it updates itself.
    Also don't unload the rbu driver if the image has to be updated.
-- 
2.17.0
