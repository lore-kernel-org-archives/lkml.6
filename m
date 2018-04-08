Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2548284-1523200419-2-11662580457090425234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523200418; b=B4O3mSN7wgouXH+MgxpxIDWO5l09bgbKiBxZm6Ly5BHqv7w9ir
    FWlVMGlgjNzT1BhBGHw5HfYaNkrWlog9ar1kh29ayEB9qrzoIklIMXHcWaWjTSLE
    XyKW1TUDXbH7ba82UPythmrfWmHvjt8KtdUjzhJwpssO0pUFUre97uaZCsrRWUw3
    0stjo5JtO/IDH2a/5IOsvpce5mFZkPdX0GXkuHRCW29uZbW6BaJIv2aoUmmXlmVB
    3gzCPPTXCYbqCHspWRc7SEFDvIG16rNFWtod87ACJ1I39/j+0YoOKLlkX1BOEY03
    F9iRhX7LGr0uqL9CL1jiraNTuqLhgBSeanyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523200418; bh=7YcsOqvvjVbyXsz65gSnju7w0kMfe2
    qdphjYEgc6XuY=; b=BsZpiDrnb2CRhmKLQwQNL3QEDWmFjfHubisTt0P85D/sg4
    biJPmlZ3zfCRDm6Y7f8NROkS8xys+zG3539e6hUGceSZDLkUcA489cniKvzy8d9t
    DEB2cogvcvkX2PZUPAzbWdvV1qKqzdbVZmYQpEayM260Ifx++LbG48UEPkieCdRO
    PoV+8ZJNKtlvFZYYGAf73/4euA+WPjIJ/e94zShE0GDmTXqd+PXXeE96p8BlGyFn
    DC5iyJh/AehGiPxnt+JFIonG3G681nH13ogwKFX6+TgrZFNX3NS0GsrFjqUAztD3
    EIAznjJ6TSOa8x9Hju884eCWkeZq5s46XFB5TpWg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK4efFWCkTSDJUdc8nU652rLdeQOjc2Xbip2Dl1KKC7pxuOyXsYsFz7UpLnMneB6mdMgccCd7xe0Szh3xUmzcgEL1dmygaXhhFgiHxWYAxpXp5juvVdf
    vvHUCco+RQWULW8jxUx17sl3VixomtdSdLIHsHCIrVBZV/xw/kGeujh/IDS8AnBjjpC4u6/XCYVBlLMWB15bWgk6SjIEs56bHGjdlm5vQJS+YvQFrKIAArPA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=RRRRr2VPVCgA:10
    a=Kd1tUaAdevIA:10 a=OY8wpy5L3YNWhkQ83UYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeDHPNh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 11:13:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeDHPNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 11:13:37 -0400
Date: Sun, 8 Apr 2018 17:13:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/93] 3.18.103-stable review
Message-ID: <20180408151332.GD20010@kroah.com>
References: <20180406084224.918716300@linuxfoundation.org>
 <20180408140726.GB10391@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408140726.GB10391@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 07:07:26AM -0700, Guenter Roeck wrote:
> On Fri, Apr 06, 2018 at 03:22:29PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.103 release.
> > There are 93 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Apr  8 08:42:04 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Not full results this time, sorry (my build system is corrupted),

Ah, I was wondering what happened to your web results, sorry about this :(

> but there are various build failures in 3.18.y.
> 
> drivers/net/ethernet/freescale/fec_main.c: In function 'fec_drv_remove':
> drivers/net/ethernet/freescale/fec_main.c:3342:2: error: implicit declaration of function 'pm_runtime_put'

Gotta love how 0-day doesn't catch these :(

I thought I fixed this up for the 4.4.y tree already, let me dig...

greg k-h
