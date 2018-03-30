Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4+YbWZZbAmwKhMNHOjCzqoO3P2PJ4EUmzQY1pLyvO2zzKdoH9LAyHLbiJIcr6aZs0oFDaTB
ARC-Seal: i=1; a=rsa-sha256; t=1522436278; cv=none;
        d=google.com; s=arc-20160816;
        b=hE5X0tIgWW4RqKaQXnkt8JLkvT8/uoSrabJIWA0ZxM0Kiovt/lAm7p2IS+KrcUw8cs
         FIERIx4bx4bJf66Ill5vDZB5oEy+lM7iKVmLEml5GHpRNo3c1yJc0pvCxGjMsoB6056M
         m4iZQY7iDFY9YUmZj1XsZk0MbxsJTEW533Q25Onsnr8ZZko/qT0KOc7CpA0ksTmyzCo4
         V+tkBr9JpqarQ78MNtRgmemobMZcyZTYRqnrL6WvmGjPX+CfZlP1h7bx8iczR8NM5sT0
         JRdu9SB5+FTstyguqtAY3F8Z3wfii7ZbTkqcoOvqQmyyf3EzwAnVQJIhbKG6oFITpwMZ
         kZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=6wip//RiiH6banRNf9NpFkakIwqMGc+ZhXb0035ndIc=;
        b=zeRb/68QAtPTp2A3DxIAbOeJMe3V/l0H2kfx7/tzbSqzFloSJ4WhAQc92vmShnvJKT
         kda0orZMM2zj2h/8NMvAyXBVt+i/XK4zQWXkw+1J+7Dv1Alb1nsyeW+Ourk2/3ribizM
         VP0AwPZRGZbl0p5ojroAX6Yc8+RxrWPg8DLWgPeR1tbvWnn15CFh5jdebHIcIse4DRGh
         bWpDIeV/qioYMnwCu5T67E3CVmt330V7PxIXL8hd8vayU0e/Naq5LDb0b2lyZSkQJota
         YKzosRN9A0Ap4ssSrS7S7rBS34Wk9j74y11X01jgACWvyH7xuH5LZazoeOns6mxwndiy
         qalw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=cOmA3Y5E;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=cOmA3Y5E;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 19:57:54 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 05/17] staging: lustre: remove unneeded include.
In-Reply-To: <152229760838.27689.7863544405084944270.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803301957470.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760838.27689.7863544405084944270.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_195754_668341_0A81508C 
X-CRM114-Status: GOOD (  11.82  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244795912178480?=
X-GMAIL-MSGID: =?utf-8?q?1596390143453157110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> cfs_hash usage was removed from cl_object.c
> some time ago, so remove the #include as well.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/staging/lustre/lustre/obdclass/cl_object.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lustre/obdclass/cl_object.c b/drivers/staging/lustre/lustre/obdclass/cl_object.c
> index 7809f6ae1809..f1641645acae 100644
> --- a/drivers/staging/lustre/lustre/obdclass/cl_object.c
> +++ b/drivers/staging/lustre/lustre/obdclass/cl_object.c
> @@ -53,7 +53,6 @@
>  #include <obd_support.h>
>  #include <lustre_fid.h>
>  #include <linux/list.h>
> -#include <linux/libcfs/libcfs_hash.h>	/* for cfs_hash stuff */
>  #include <cl_object.h>
>  #include <lu_object.h>
>  #include "cl_internal.h"
> 
> 
> 
