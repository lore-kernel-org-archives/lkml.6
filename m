Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AG47ELvfO2TYXovR8YYi8v0W6umiHRCgBHUQFtcrbL/jHHmvRFciQDNLKi4dyTDdeXCd0RJ5EFFs
ARC-Seal: i=1; a=rsa-sha256; t=1519851224; cv=none;
        d=google.com; s=arc-20160816;
        b=jEP2VVWKP0EfkCaEjiOgxOm4Em1sR8OKoA2ZHoDkqMwFyVpt2nSo5BEnnSRIYMl94I
         ZzDBNoBKa0szwraOCYk2zIgLTqEC5jJre6jeMJ2Jkh6EoVgksD3lnwvXY8BzJsvCiKF4
         ynFyNMek2w1Kg1lhNHHmrzlRT5AKFzgsyXMiEPDVeSSVNtf51oWUKDe0MC0Eq8QWijAb
         nkok0e1LVP63hHr3DQRBlpF2imlXgEf0jV2xzySmARcUSwvfTwIKyNnSO7Mu3LgjbPgt
         gVeQDn4ZvR8FCHVpOAPZOWmjGj36fscVV5Fe9Ze8Yk1O0mDTzOzmcL5+9Fyn7SLPPOKX
         g7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=vTtH92IMaCRQOSJTc4I+O0LJxjNjVCVVLw7uWlmodYA=;
        b=ps62W03ZWjMFCQqiueVyUQw7t3jW6wQexHYTOaEshjIV42Do6XmyihO4x/NRY1lR8f
         cSNgvRMAy5OZ7bx+6pmMJ2SmRBaS6eOi2Rm+rH2Apl5V3ZuMTkzgNx+BQGogMzNl2kfA
         sJbVdUfXlRBJw/ovnrWNTFyMzhcZEyInogsKQU93hlEmuPXaSzPVmm/KzzPzY4kWAqnU
         3Y2eg7pCe2+ftLlQUkteo4i5DHsDcTPXZV5QiQAlkon9l2MVJ9ctITqxWIF+7yFZ00no
         s4F26wej2vapBoM4cI+VcWt5TDjnYnyaYkWZd48HWfPCStbUlGXzhgXQyu114FeACduF
         Ddww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=OU8C7CoQ;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=OU8C7CoQ;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] Documentation: Update ncurses package names for
 menuconfig
To: Arvind Prasanna <arvindprasanna@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
 <43a91eb4-646a-b4d8-5b3d-b0bfde0019d9@infradead.org>
 <CAK-=9LoNfYP_-tm+W2GvUWjWgs=BZ-VRFmVNzTCadzQWaee9yg@mail.gmail.com>
 <e484c42f-4fe6-10f5-dab8-cfd749911486@infradead.org>
 <CAK-=9Lph+GXzEsRf+2L2T1W4fJx-wo0HahPxfi6vPKSSxKxmqQ@mail.gmail.com>
 <CAK-=9LpTkTtQqqAL+NZEGL53s-vpzic0+3Q+ocrvL9pCwjb9KQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <80562d48-0524-eea2-947c-4fba0cb36b7a@infradead.org>
Date: Wed, 28 Feb 2018 12:53:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK-=9LpTkTtQqqAL+NZEGL53s-vpzic0+3Q+ocrvL9pCwjb9KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593679517484293156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

I think that you are missing my point, so let me start over and try to
clarify it.

In the patch description, it says "libncurses-devel" (not libncurses-dev).

In the patch itself, it says libncurses-dev (not libncurses-devel).

I suspect that one of these is incorrect.  Which one is it?

Thanks.
~~~~~~~~~~~~~~

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
~Randy
