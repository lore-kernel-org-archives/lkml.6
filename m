Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-965109-1520110126-5-7765384860146542444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520110126; b=Av7ITNJptc3wC3jmXX08jeu5XFq18H95JGubjwu5EwfC9Nl
    CMjb6LtHxoES4nlnfL4CQfGIhQYovMKh0XcPZ1FvC+N471H0AEXVIdtqC96wWT85
    9BXjRbWQXk28IOu5XLmNMnvIb+7J5c6wjJAbfvbTK0gw39wrmITetXEzyAuorUUI
    +CHPzagfBFuvQKFDtTggvraqrzSnFBi0IvT6PWoEnUaOXgrt1iw1/18vBgshWrRj
    eLOo8k7TATLfS8TZUGyIST5mpWv9YJe7s8Iop3IXjW+bQAfR7sbTK2ui7XedhQSo
    NPNf0DSoIdNLePeOHLz0Z7VuLQlM9+pZPmyWh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520110126; bh=G
    MN802XfulRcOYva/uPAzOmXJSA63/qpotC+S9B7xOE=; b=TELE7HElD9NHEhbFT
    P4/4uOsjJkuFG/ADSTsn4Ti3TIGW9q/8HOraauVkEJnW6rPN8t1aj5hIdT9yjLEf
    cLbQe5KRUw9SyUZFJ8bJUiNw3kzzZcS3LYrbhrhMHpbHFSRwhlk6I9xsQcp0c1Oj
    yiGH1K4KwuAjnnOJKGAc4vjgPlGUf1igAEh68Hki4Srmiq4h2M+8/gOkNz/eQCsN
    BN5t/0E8p0T07AmT2Lad6S6Ao61Q10pw3O5jW1liroW5tPlXetAiJ23YycFEmT/l
    cZIhac3kC2rHDVR5GZD9iy2D2FzOkmrCc0qOXkFWABvTWUgsavZPR4YJVMtHPalO
    zHygA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,419,1515452400"; d="scan'208";a="316238434"
Date: Sat, 3 Mar 2018 21:48:36 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: media: Remove unnecessary
 semicolon
In-Reply-To: <20180303192629.GA5198@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803032148230.9544@hadrien>
References: <20180303192629.GA5198@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, alan@linux.intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 outreachy-kernel@googlegroups.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sun, 4 Mar 2018, Arushi Singhal wrote:

> Remove unnecessary semicolon found using semicolon.cocci Coccinelle
> script.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  .../media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c b/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c
> index 5faa89a..7562bea 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c
> @@ -196,7 +196,7 @@ enum ia_css_err ia_css_frame_map(struct ia_css_frame **frame,
>  						  attribute, context);
>  		if (me->data == mmgr_NULL)
>  			err = IA_CSS_ERR_INVALID_ARGUMENTS;
> -	};
> +	}
>
>  	if (err != IA_CSS_SUCCESS) {
>  		sh_css_free(me);
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303192629.GA5198%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
