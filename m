Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071218-1526316727-2-13212036353158287225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526316726; b=mU88QXbRoZdfnZMGgOCbZqsqbPSOSQ8Z6LktsT5laf/N7kM8OE
    WqB2gvWfn+hLYj/RUlvzTnDUbX7m22ZJUr7/DgCSnc30QO2/SXBuQOvfOz3eDwa9
    tDe7cDd9cg3oKr1Qn1kGzlFbZ+nTY2EO4G69gqhSGjSLQSKmwjbMgluGhGLp/Ten
    izPdueunoLFVy5b7PAQhBpO9dsApPuJEBVbMyQkPF9KeN2pPFENoHq27Zrl2ozn2
    sSvZ/kiyVl/7mPRgYmTq7KJhnBwJibx2N9ZLNKj21GtzvMPK/nD2Qyq8xNckgpRC
    Y5O6pF4j6Ih/XJ+jPyTGcFPK+K1WLCakgibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526316726; bh=FIkNNO4cZ6dyzu9n4LQDU5Aqva6/XP
    8FotwHO1PFMFk=; b=chbS9rCeKNTHOepQV5rcOLZsLHiEPQLoOMuxmm9GjfCrK9
    mQaW30t27RBtsHrGfdMkLv+gAQGTqSXSXDVnDfMWP+RjX/D/a59fotEt0WBxxsfS
    UJlHgkozj5u9xRwBa59TBEdEH0fXpHq3YapupFFdBfEgUpdEKtfg8m2EqcnVI3FN
    kz/2l1kS6ipMtH1JhH8usS6LcLFBIgbpCOCM3QgRKNDFoqXvS75vEbSvqQ3Q73w0
    xv4kygrJ6z6IPg/HdaoIxh/8BG+mfkncw3lCl3cbUGdyfqK+kll7id5dOZkRDxqI
    +/Uc93584d1mFRdYCdZVxacucUYDTcq2nrfzKfig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SIPySUW0 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=SIPySUW0 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCv61RJwB1/D3KdUwTIwVr/3jClzb/W1CYYgv3fyhpImOGCo7nDx1bVdZZ+5NvwvpGetGFvFvD6BJ5id7OnNZMp+5ZusWXIjNke3pu5VNkKTVnUPfsqR
    K4k4gxXXJ8+/P0FfV3qBNH8bvMTvyHdRWcufVakiVhsOT+NCGX5WudLC4PM3V8n32i21DXwSKjaYHikpUGAms+LT5d4Zj3rqU/k0Qt+Onb4D4vp1M73byIsB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=9wKpNP2GB4IA:10
    a=VUJBJC2UJ8kA:10 a=Sa7_cZkHc4GODgtWD58A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932552AbeENQwF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932550AbeENQwE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 12:52:04 -0400
Date: Mon, 14 May 2018 18:51:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/72] 4.16.9-stable review
Message-ID: <20180514165147.GB30141@kroah.com>
References: <20180514064823.033169170@linuxfoundation.org>
 <20180514162758.GE31622@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514162758.GE31622@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 09:27:58AM -0700, Guenter Roeck wrote:
> On Mon, May 14, 2018 at 08:48:17AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.9 release.
> > There are 72 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed May 16 06:47:58 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 143 pass: 142 fail: 1
> Failed builds: 
> 	m68k:allmodconfig
> Qemu test results:
> 	total: 139 pass: 139 fail: 0
> 
> Building m68k:allmodconfig ... failed:
> 
> ERROR: "__udivdi3" [drivers/mtd/nand/nand.ko] undefined!
> ERROR: "__divdi3" [drivers/mtd/nand/nand.ko] undefined!
> 
> The problem is caused by upstream commit 3057fcef3853 ("mtd: rawnand: Make
> sure we wait tWB before polling the STATUS reg"). This is one of the "bug
> for bug compatible with upstream" situations, meaning the upstream build
> is broken as well.

I've dropped the offending patch for now, and pushed out a -rc2.

Thanks for testing all of these and letting me know.

greg k-h
