Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x227Dk41XtaJxs8iSF+xfwPY5UdOCWZ0Z+pLR13WTH8RuVhOQn5mvqTBB20FIMVoSJ6f/0wVR
ARC-Seal: i=1; a=rsa-sha256; t=1519839086; cv=none;
        d=google.com; s=arc-20160816;
        b=IhjWPsKpo+0e8gCUvsKJbukIgLuKXooi6cFcgsav8CmRff/qBsZ0usBLlmBAzEexDF
         BEertnuf0qABhQFymciwjnc2wqkQd3Izx/i9RLwP1dqVLqYcn2ZSV5d8wosUlIxXr9KY
         JiCPOrN4UnpwoSQNxsYBdrKBtQ7SN48rDokVWAhyfG2sOq96G3mCQUPWVT7kUsiGXqPC
         6pm+qh1hPFLV2sPA5ueFL9KGXL+tdeque0wPkTvxFMHYDDI9SLFrmiBrrL4vRwtzOn0m
         CauZxofuibjLiONhK8qpoqtpZDN3d+LZ2qkkUhXRpQAW6yNrg0/aol6HhD9PWZw/cfVG
         fmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=JE6V1rQ8CQ/51irj38Ox1tmv9IQOSV/zJr5VkFbupTw=;
        b=LpwtFPwxAIL5lcCjaginUG3L24SvOJJbSeaU/cKSSlxf+7m9MQzcEVszPcPM+CobeV
         KOuYmlSUmnXQCYeQMLi7RavG57wG8ddo8leobQO7dl0njxymrBnn7OWyGmzIUJkNFoFR
         z0uatHUFPLGzOUsNrZicvhNxqS5Dz2HtKZMFbDPRY6l0YCbOMjabVhhhwWqX4HPKkyYQ
         wQsIG7JguhiCuU7o+Te8ST/lCW5PWxRmZbsHydAXqwaAdNDn45ecema8+7DP/vx1KLgo
         s5kzvRTXN2HZur+hph3dtG/nsfrYgdqyM9Wg+bFkIx/o3XMyo5GnPfVHxJbsWyBwMxl4
         lm/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=LsTI03rY;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=LsTI03rY;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] Documentation: Update ncurses package names for
 menuconfig
To: Arvind Prasanna <arvindprasanna@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43a91eb4-646a-b4d8-5b3d-b0bfde0019d9@infradead.org>
Date: Wed, 28 Feb 2018 09:31:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593666790272565809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
> The package name is ncurses-devel for Redhat based distros
> and libncurses-devel for Debian based distros.

      ^^^^^^^^^^^^^^^^ That's not what the patch says. Please clarify.

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
>  	    echo " *** required header files."                            1>&2
>  	    echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
>  	    echo " *** "                                                  1>&2
> -	    echo " *** Install ncurses (ncurses-devel) and try again."    1>&2
> +	    echo " *** Install ncurses (ncurses-devel or libncurses-dev   1>&2
> +	           *** depending on your distribution) and try again."    1>&2
>  	    echo " *** "                                                  1>&2
>  	    exit 1
>  	fi
> 

thanks,
-- 
~Randy
