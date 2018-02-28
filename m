Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AG47ELu4+tDWoqlPGKHBti2ivP/trYCVa8t6p7sd2fjiacM7tx9WJpk9RduvFCKhXdC4/syjYA+U
ARC-Seal: i=1; a=rsa-sha256; t=1519854447; cv=none;
        d=google.com; s=arc-20160816;
        b=uH3PHxM9aVcNUK5L/4aPwi6iWitilgzUNuZwFuSfvzpfyn4UXFBPdho/hbWXoYp0dz
         k6RTnwcGgc6I9eGuxinsp5YshSxJF3wY5DeWPEUGM2T3VaTNAZuO08Dpng4//SLpUldk
         giESUYgvRkczsMpc/jxDXX/3bp79Y4hxQTeWi9RRk6h9fm0AXjl7l914UGxNlMgOqAdI
         6O3kky/wy5XrJPfEapH5O6Z5ppqvNR5GnTkcUC0Anc4nK/SCfPKn3M5H9savRgnLnubM
         DE3lv9H1aBVRy+94yrFnpjbnyFidskmzG5mWIxCTbyYaiF4SKM47Jk43rG8/hs2jcNyO
         JDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=tD3XRQt5gmy9VSyc1X+KqNlcqEvvEE1QVNUoL5tRaEQ=;
        b=w5RUVWwVZ4NsQCGygaVh4aFqe5J3XajAK7ajho1JETBUU/2mCdxjhuPd6+xCHDRSpL
         4WIWyKZ5Fc7/6rHg+0+TzrawKw5gHDKbjgXHtkF5EKdyUsJOgba120VUwyUo/wVA3hid
         c7KVbGLWT/Y1NlXquBDOdLdWQk7r4T6a5DGMKRCpl3ZGdaD4Gkn/0MP1jJuPQ7RVo41f
         P/y/f9FtlZDuudEv6OM7ns5//sH7fFTZYIr7ZtjXF7JBRz/dZeWswC8b/ShvGP/iwjxO
         z9VfzJs7VvmgNw5N9joycZk/xlgZzRwjvIgyWXuBGadtK41SP/M6hWZid4HdGhMxXIJJ
         n32Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=FohsyaAn;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=FohsyaAn;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v3] Documentation: Update ncurses package names for
 menuconfig
To: Arvind Prasanna <arvindprasanna@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAK-=9LoRtOjN9_jCxtHf_fLeh3NpW6KOgYNuD09PKbDkCaCajg@mail.gmail.com>
 <1519853553-10626-1-git-send-email-arvindprasanna@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a83b79e2-3db1-efb4-9122-46708b36b58a@infradead.org>
Date: Wed, 28 Feb 2018 13:47:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519853553-10626-1-git-send-email-arvindprasanna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593682897120769975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/28/2018 01:32 PM, Arvind Prasanna wrote:
> The package name is ncurses-devel for Redhat based distros
> and libncurses-dev for Debian based distros.
> 
> Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>

Thanks. Looks good to me.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> 
> Changes in v3:
> - Fix a package name in the commit message.
> 
> Changes in v2:
> - Add a missing echo as pointed out by one of the reviewers.
> 
>  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
>  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
> index a10bd9d..6c0bcd9 100755
> --- a/scripts/kconfig/lxdialog/check-lxdialog.sh
> +++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
> @@ -55,7 +55,8 @@ EOF
>  	    echo " *** required header files."                            1>&2
>  	    echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
>  	    echo " *** "                                                  1>&2
> -	    echo " *** Install ncurses (ncurses-devel) and try again."    1>&2
> +	    echo " *** Install ncurses (ncurses-devel or libncurses-dev " 1>&2
> +	    echo " *** depending on your distribution) and try again."    1>&2
>  	    echo " *** "                                                  1>&2
>  	    exit 1
>  	fi
> 


-- 
~Randy
