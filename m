Return-Path: <marcel@holtmann.org>
X-Google-Smtp-Source: AH8x227+lSv4ShK8o5nSrcE8A++PrcYa5lLPGwf/YQQGViirVO3dx4puAP0EDL0zG8uxQ1GayDjd
ARC-Seal: i=1; a=rsa-sha256; t=1519755964; cv=none;
        d=google.com; s=arc-20160816;
        b=Lze9ykTZzW/JjJkNwoJ7TE6LZOIrz1JULW694V0hxS92JUqD7lVJQgr73E/TjxeBc+
         Pw8hkLbs5Khly3mf2/UtU5y1uA2PMyeFreWpYPwGs3zivEO25pbN4z8LAt2OGkkF7CwG
         9F82ZQhYt24iVmN/JhWHe64RO+LWaD9a8haL9xzDZ5YbP/XqgEFLv6MEFTNbrTGUXT4+
         b3XSUm58Amds9F4tf5whm0S6xQlyAi5xUViem0Ik9SW4h5HSRRNOakbkYuX3PTZIzuG1
         qHsNhsmr4Wq1qy3sC8fSH3VieFzYR+jFOFt1y6bmzfqyCvvlZl/Tx+POLS84RPhlrUdf
         hn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=H0AmjNCysQTRBq+bGwjFGwWc/3uKzWC3nNuT5SjgBPU=;
        b=T32vxnulhY2j5mj9BKdq8mlJ01/CYIly5Cpexz4mPeEQO03buqtAcr9DnQBUbUJLz5
         mQb6GzCHZZr6zJuNqXsLReKaHTYcjPGJWhWQzzwskCTNzVUWAvnTHBSmd8Ml3GXYo7A+
         bFq5UYRn1KdJrWEwlD5Xuvw5NN87a+e5iQfzAVacKaTXBLaW3SYsZZLpYErKEQMlcxmx
         aJzJ1snsB9H8gRhAKqiKaw4SFHqkeEYI0jcOcMtpN7qMu9/N2zhBL1HFdABesVnEYY1Z
         mCAvmNgYH1fWffp+/XhOLEB0YfiX6X+xsXlEY62PzXvkAUBno83zJvOfrXVrwDsDJHMT
         /BSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 3/3] btmrvl: support sysfs initiated firmware coredump
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1519210220-22437-4-git-send-email-arend.vanspriel@broadcom.com>
Date: Tue, 27 Feb 2018 19:26:02 +0100
Cc: Kalle Valo <kvalo@codeaurora.org>,
 linux-wireless@vger.kernel.org,
 Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F1346A83-77FD-42B9-8F36-ACA45381CF03@holtmann.org>
References: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
 <1519210220-22437-4-git-send-email-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007399539898108?=
X-GMAIL-MSGID: =?utf-8?q?1593579630085976353?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arend,

> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
> it is possible to initiate a device coredump from user-space. This
> patch adds support for it in btmrvl_sdio adding the .coredump()
> driver callback. This makes dump through debugfs obsolete so removing
> it.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> drivers/bluetooth/btmrvl_debugfs.c | 31 -------------------------------
> drivers/bluetooth/btmrvl_drv.h     |  2 --
> drivers/bluetooth/btmrvl_main.c    |  6 ------
> drivers/bluetooth/btmrvl_sdio.c    | 18 ++++++++++++------
> 4 files changed, 12 insertions(+), 45 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
