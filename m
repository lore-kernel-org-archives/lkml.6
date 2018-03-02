Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2080671-1520013070-2-8362674252968602058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520013069; b=Cvs3VNsKZqvYjmi3Vc61dZTwYApybLe/pXhlEqLyPog770J
    o0MytSUCv8OwOFPERdBUwZ5+qvlYjgEl4O6adGxxsyM95ZJrZv34XLjY0ke47PaF
    aLDdyRx63eOgsrpefeEUpotIRxJky6mQwjuRFWFcJcuajhXpXm5fF7EgNG7CKYoA
    /qMTMOBPKP2Ujyi7+2aOJ9D2UrAyLmE1L2jB1oq72eEG6VgRYIg0TTTjsX4+XoEw
    kxkG3Hr0cw8G2PqyRd+TULGcHsXmiGyU/DHPefHtW1J0ZQ6j4amrQtgd1pdcQ90r
    /bK6WAafbPxOS1KqYr7PQ/zTNvhqbjAd6SZw0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520013069; bh=n
    gkw8oRE7y7hG+ySRNauqLNhkWGeiE432tZHgWNXObM=; b=j5JR5PKB5kFhFwtW3
    oTs2QxybGt5EaREtjpRvrBk3l4HdTiF9xduLxu5G1iybvUA46ydmIxt3f+1Pwp7I
    qpWWev5OaNp2FhogWFD6sW5LgvP4vdEMn2BhyLbRMMvFHQgVJ5nSVHGachJMEGgP
    FhqytGNkdOqBz22ik3iF4suK85CL2Lguicfzfo3k//sCnKdeXH3A86L7hZp112zi
    ZzNsYCH4hce+qFu+0jxbin4KnCYrK+3q7YY8TN0hb1WB6jDL27bjz29/6ZLw/7x8
    KyhocAJflTEPmYbn8ud/jIeJaB7K865ELR2f+UiFQ+eh+WK2M+5YsJFUts07e85v
    tdL9Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,413,1515452400"; d="scan'208";a="316116116"
Date: Fri, 2 Mar 2018 18:50:52 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8712: match alignment
 with open parenthesis
In-Reply-To: <20180302173619.GA8598@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803021849200.17455@hadrien>
References: <20180302173619.GA8598@seema-Inspiron-15-3567>
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
Cc: devel@driverdev.osuosl.org,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Fri, 2 Mar 2018, Arushi Singhal wrote:

> This patch fixes the checks reported by checkpatch.pl for alignment
> should match open parenthesis.
>
> Signed-off-by: Arushi Singhal <arushisinghal@gmail.com>

Your Signed-off-by email address should be the same as the one in the From
line.  You have arushisinghal19971997@gmail.com.

The commit log should be in the imperative and should explain what you did
and not just what you fixed.  Try to start the commit log message with
"Add".

The change looks fine.

julia

> ---
>  drivers/staging/rtl8712/mlme_linux.c | 2 +-
>  drivers/staging/rtl8712/os_intfs.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
> index 3c7c4a4..baaa52f 100644
> --- a/drivers/staging/rtl8712/mlme_linux.c
> +++ b/drivers/staging/rtl8712/mlme_linux.c
> @@ -36,7 +36,7 @@ static void sitesurvey_ctrl_handler(struct timer_list *t)
>  {
>  	struct _adapter *adapter =
>  		from_timer(adapter, t,
> -			mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
> +			   mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
>
>  	_r8712_sitesurvey_ctrl_handler(adapter);
>  	mod_timer(&adapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer,
> diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
> index e7df5d7..d6d27da 100644
> --- a/drivers/staging/rtl8712/os_intfs.c
> +++ b/drivers/staging/rtl8712/os_intfs.c
> @@ -230,7 +230,7 @@ struct net_device *r8712_init_netdev(void)
>  static u32 start_drv_threads(struct _adapter *padapter)
>  {
>  	padapter->cmdThread = kthread_run(r8712_cmd_thread, padapter, "%s",
> -			      padapter->pnetdev->name);
> +					  padapter->pnetdev->name);
>  	if (IS_ERR(padapter->cmdThread))
>  		return _FAIL;
>  	return _SUCCESS;
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180302173619.GA8598%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
