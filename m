Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-694244-1519972400-2-2640265868822304644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519972399; b=CuwWQGqBITW4h9H0QyO1El7X1dZrT4XvtCnmzXuT2rbG44s
    QxQYQFoYev56qAbO9sVodalZXgU5WGoe9ld0542E14YbuW7LdRM9Zfq5I1DEp65E
    s6qI4ezbONG0gbyIpsFjqgYtqNxOhIDMRWIoX1+ImSvNw8pp4ECJU0P2ikLpF+Qa
    FhXLWPfwA4JTukBRyuTH8y9bSArpCWOsYt1SbnwLxcB9BGLCSSv9eQ1iGc1GUtts
    xDVOmfGH0G2MtG+NGD+bNkqQFe3ZTI3iW5HNTNQTUWvJSusyA+UF76fl0EexSZDs
    Z0/E/X9R/i6hv4MxBFDKIp10U2IAbYkhjFibsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519972399; bh=W
    Bofu0NYZUGZsjYSVri/H2VPAJbBsoGo8tizDHt26Tc=; b=KmTld2ofDoBIAN7dX
    oc2SwRFl9DZ/ZHHd0C2fywjUICPYk/vNUgZxFZZq+u1QPwFF8o07lgFvKBeMC72R
    R2ofhiFUeklunk6D8nWro5jgO0leVDyLgDHX7AA0x5reGMh68DOJUBrGfUbTNvDI
    uwudfoFkxEVNBf1NxP93MSTNenU+XO2OeOSPN3pgZ/hdDDhkN3UVtMxuJOIk/Xog
    Q9MeMotYcVyKEdat26pYS8PSbqndpPXTM9IVzBVKl+VWYu3cPgRER+8Ya0By8uyD
    fjBH5EZDtpYrhoIdD5UzyRtoCxE3KfUWJqZKga3DceUsZd4paIU5r6LjXX8RgJe+
    ySFxQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
X-IronPort-AV: E=Sophos;i="5.47,411,1515452400"; d="scan'208";a="315991140"
Date: Fri, 2 Mar 2018 07:33:07 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8712: Fixed 'tabstop'
 coding style warning
In-Reply-To: <20180302024749.GA16440@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803020732170.2214@hadrien>
References: <20180302024749.GA16440@seema-Inspiron-15-3567>
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
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Fri, 2 Mar 2018, Arushi Singhal wrote:

> Replace a mix of tabs and spaces indentation by tabs only.
>
> Fixed checkpatch warning "Statements should start on a tabstop" in
> rtl8712 module.

There is no need to say "in rtl8712 module".  That is apparent from the
subject line and the diffstat just below.

>
> Signed-off-by: Arushi Singhal <arushisinghal@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  drivers/staging/rtl8712/drv_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> index ae79047..ede99e9 100644
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ b/drivers/staging/rtl8712/drv_types.h
> @@ -161,7 +161,7 @@ struct _adapter {
>  	u8	EepromAddressSize;
>  	u8	hw_init_completed;
>  	struct task_struct *cmdThread;
> -	 pid_t evtThread;
> +	pid_t evtThread;
>  	struct task_struct *xmitThread;
>  	pid_t recvThread;
>  	uint (*dvobj_init)(struct _adapter *adapter);
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180302024749.GA16440%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
