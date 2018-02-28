Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224TTKKG5k4aYQMw3iY72nbIaEd2y1V5ec1tDhHsFuP6WK2ZfFBSwIBnIK8yEisjBEap6JTF
ARC-Seal: i=1; a=rsa-sha256; t=1519830330; cv=none;
        d=google.com; s=arc-20160816;
        b=sC+omdyY7qIE3t+kAYgs76ViuChnKLHGsuDAkaJuOlxsuT99RXFKokN/rfDLyS8rTP
         GZ6m2HDgKJgcvSbt+5r6y8sO4Gw/VVJQ8KxTdqvK67HG7fYVNJPQe0v2UoUeMVbZYo7v
         4u2NGFcsID36kmyc3yDow3itApcWssFFW1bQtccFSqqED3to/DhCAljqUbMGq/NcuuSe
         hBslc/PohDn6sXo8yM1Zi1Y6hS5bVTpfMQvWstMxe3iwNqb4lScdY4j4eAh4tR6SjMT7
         plLdYDn8//EepOpR30q8uQjnfdbwKAS12WjYgXQafPXb58R3nQwSyBoE4gZ2IUcPLhNf
         Wm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=/yfea2aQc23HgpiHaGL1mmLrEQriOFJfWW60bRMO+8w=;
        b=XBbm5U2+qdgJlmtUygz4HcXEYdyjU838a4IuyJ00X0lPfMRLJp/ahkHCnm037bBHW9
         Vh3VbAB2JdEpGq5NQsu9OAjS5asgv8wg6idVg17s7jUjxJazODXmILGjygS0H3gFtD6O
         k07g8PX8foyJojuvedHNSdfi96hq0+vD5dZClNUVZ1bxrrJ419+Nn5v5zWOpigBO16c4
         fl/SaXAXTlsiWdkMPxO/3SOX56neOzWSIJ2879odJ1XcDccQq58qfIMnIn63Ac/thA9r
         qiqixWDgDbikiTRv1GSBCqJ1jPQ0bpru/V6Bt2yY9BXbZvUG/z/SS8H/ComF6ABvOzUL
         MWxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=LosZMOc0;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=LosZMOc0;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1SF4x5H004800
X-Nifty-SrcIP: [209.85.213.51]
MIME-Version: 1.0
In-Reply-To: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
References: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 00:04:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATafNCOBMsNezrCT8j_N2kJiLt7S063wRtjGsaJTgxLvA@mail.gmail.com>
Message-ID: <CAK7LNATafNCOBMsNezrCT8j_N2kJiLt7S063wRtjGsaJTgxLvA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Update ncurses package names for menuconfig
To: Arvind Prasanna <arvindprasanna@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593657608135885634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-28 15:59 GMT+09:00 Arvind Prasanna <arvindprasanna@gmail.com>:
> The package name is ncurses-devel for Redhat based distros
> and libncurses-devel for Debian based distros.
>
> Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
> ---
>  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
> index a10bd9d..4353e40 100755
> --- a/scripts/kconfig/lxdialog/check-lxdialog.sh
> +++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
> @@ -55,7 +55,8 @@ EOF
>             echo " *** required header files."                            1>&2
>             echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
>             echo " *** "                                                  1>&2
> -           echo " *** Install ncurses (ncurses-devel) and try again."    1>&2
> +           echo " *** Install ncurses (ncurses-devel or libncurses-dev   1>&2
> +                  *** depending on your distribution) and try again."    1>&2
>             echo " *** "                                                  1>&2
>             exit 1
>         fi
> --
> 2.7.4


'echo' is missing in the line you added.
So, the error message will be displayed like follows:



 *** Unable to find the ncurses libraries or the
 *** required header files.
 *** 'make menuconfig' requires the ncurses libraries.
 ***
 *** Install ncurses (ncurses-devel or libncurses-dev   1>&2
           *** depending on your distribution) and try again.
 ***




I fixed it up locally, and applied to linux-kbuild/kconfig.
Thanks!





> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
