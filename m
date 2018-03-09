Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3835922-1520575280-2-8428431660190283699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520575280; b=omRg5J2xAm893HTNh06DOE+jwvZ+r4hJJwhmnvdJEkkmYt0
    AAx0LVH5xDnAmXj12wZAn7BVY27fN79beT2eoKrfjCiT0RuchtvsDdIgM2cBMaJ2
    03CRORgZWlGWVuryXcGjl88gifkbITIofrUz3RMVY7NmiDvDzv+bnXB1c7VuFqLj
    I6dS+yfZhXrg8+GkUbuNG7rv1LExqXQ60LOyJd/L5KXt8+rB7PF1CLuqPSDJoivh
    2c8GQf2/BLZ1hI/BQsT85oVKueXKedlfOqv6r40FXMeHsMe8WWjdrh88O7jzadvQ
    f3euzmLg51RURIALkKak9XruketQSeNOxo37h/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520575280; bh=h
    GimWukTwSKfzPwezN14t1igy/TLlfpKrvhcMkcmGNw=; b=qHPXWOdXcYubIIQqD
    jDd+BbuYEmVCQVgeR5hI0kyYEnQkwTEC+q7cs28nwgtcmpGt55jb8a/QeGmFUKLe
    AT4nFF/1Vrb0FEfByiwI6WPDIVDZ+u8X3p8HT85v+l3nuNMBW+OsWukyuTwGPYVF
    lEPvq1eyvj3JBW1G8PJudJM+uqQsOGTxPbOSHfu53LntEVIF0xjoh3vN4moYsMqL
    XUDYZIu0PePRhLgdoCFFUfT5NuxF1BfA2/s2uL+VItD0GR677cyqYMPe3tvapr91
    4XSg5rGYHw9Ed67vg9dBwasE3p952PnyMOSHk74qutfyWVG94L5fzEZot8A4XNWW
    p8DJQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 26, 1.8, 0, , d41d8cd98f00b204, joe@perches.com,
 :::::::::::::::,
 RULES_HIT:41:355:379:541:599:857:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2505:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:4250:4321:5007:6117:8879:8957:10004:10400:10848:11026:11232:11657:11658:11914:12043:12740:12760:12895:13069:13311:13357:13439:14659:14721:21063:21080:21627:30029:30054:30070:30080:30091,
 0,
 RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:24,
 LUA_SUMMARY:none
X-HE-Tag: net41_2723a85229624
X-Filterd-Recvd-Size: 1935
Message-ID: <1520575267.11634.25.camel@perches.com>
Subject: Re: [PATCH 4/4] video: Remove stack VLA usage
From: Joe Perches <joe@perches.com>
To: "Tobin C. Harding" <me@tobin.cc>, Florian Tobias Schandinat
 <FlorianSchandinat@gmx.de>, Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>
Date: Thu, 08 Mar 2018 22:01:07 -0800
In-Reply-To: <1520574625-4225-1-git-send-email-me@tobin.cc>
References: <1520574625-4225-1-git-send-email-me@tobin.cc>
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
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
Cc: Tycho Andersen <tycho@tycho.ws>, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-09 at 16:50 +1100, Tobin C. Harding wrote:
> The kernel would like to have all stack VLA usage removed[1].  The
> arrays are fixed here (declared with a const variable) but they appear
> like VLAs to the compiler.  We can use a pre-processor define to fix the
> warning.  
[]
> diff --git a/drivers/video/fbdev/via/via_aux_sii164.c b/drivers/video/fbdev/via/via_aux_sii164.c
[]
> @@ -27,6 +27,9 @@
>  
>  static const char *name = "SiI 164 PanelLink Transmitter";
>  
> +/* check vendor id and device id */
> +const u8 id[] = {0x01, 0x00, 0x06, 0x00};

It seems id is now global in multiple places.
Perhaps these should be static.

> diff --git a/drivers/video/fbdev/via/via_aux_vt1631.c b/drivers/video/fbdev/via/via_aux_vt1631.c
[]
> @@ -27,16 +27,19 @@
>  
>  static const char *name = "VT1631 LVDS Transmitter";
>  
> +/* check vendor id and device id */
> +const u8 id[] = {0x06, 0x11, 0x91, 0x31}, len = ARRAY_SIZE(id);

etc...
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
