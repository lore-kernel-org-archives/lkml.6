Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-827400-1526099515-2-16449508229327032975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526099515; b=VC9vTtU5f118XwYiCi1hSD52MVZ98ebIEo6/6vL68cAKOGGfss
    ac954UhI0TX1xNxJw0m7azzipxcuMya3fAM/hJTkhg5P0lHZR204cfUx+XHdXNM4
    0+9SffTPmuEIuSNwwpvNiEpLmlitd1c4+yy0oahgFu8Zd6XYJSR5Ut3YZZGqqzqm
    LZlML9UxP2JDSbsbh8G/uUcCfouEqm2jqoVylEBPf5mloN+8AtahDWqY3zBxV3K7
    oC4fht7IonOrg96zLQOpgSh0PNr8xZ7U/GO8bnTWUtXdoiFpoKvcIDZ353YZdXFA
    ZeBhX7oBN6zl+Kb3EmVH/NSSfeRe+NesmRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526099515; bh=hXsus/pWhDT/xOemkthh1YV03Jy/wR
    Ag5U986FgNHuk=; b=hcNxUP0R8oQxYtCZpWAXBO0PbFwLs8ycOi7M7gcYHCYn4J
    5tE5WFxjdaFljtOLIUslT95r6eW5wlZZhZNQzGdeJdd5o1T5u3sA9ax2Ac1fcKVw
    tat0DXrZFXdG7V+XO9gREUNY13tNR6lI2NRaM6STLwCAIsmm3B51IjRdEPsVMwwG
    fj5fcYzgpTBup5tYaXRX8tWA2AEJabD/+x3eyj4KAFX3KhttiPHQrGi9ycGZaNKS
    CDKZuRfihyItR8SkP2XSO4aRuvTCSY114b1Eq/xp95ZsW+auLD30ODqKoJkcsbIn
    Vpgt7Uxii8UY7NLpjnoFaRvU5GazD4uRwIZ+xheg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
    header.i=@messagingengine.com header.b=hOd7eXA1 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
      header.i=@messagingengine.com header.b=hOd7eXA1 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIjvQTC3o6HqFAARm7vztvYB6J8IMx8Y2lgmc/VKz20UyWXQ2YPAs/Q8dDNYjFKL60BkZB3B2Xn7x59qYTOgDoRJOR0o/FlUVpcvCgymABafgP5HD8gj
    1mMfzVg/KtTfb1pNnvrfg24GYKxZb42+lAYEFgMamWUNpmnxadoybFO97Gra0HFfEMTbm0tykZBSWv/LD8xutGQeuEoIAuqhtUbdRBet4pBMBEKIG1Ah7JmN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=dEFX6dxTlXBHf4S_oHsA:9 a=CjuIK1q_8ugA:10 a=1R1Xb7_w0-cA:10
    a=OREKyDgYLcYA:10 a=pRQRx_yQ9a0A:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750736AbeELEbv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 00:31:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55059 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750731AbeELEbu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 May 2018 00:31:50 -0400
X-ME-Sender: <xms:NW72WhsuBcjrX0wMJfX0zzMU2yZKsvGznCZev3RqFlq2fDZp6A8RCg>
Date: Sat, 12 May 2018 06:31:35 +0200
From: Greg KH <gregkh@linux-foundation.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Long <dave.long@linaro.org>, stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
Message-ID: <20180512043135.GA23663@kroah.com>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
 <20180508112503.GD16141@n2100.armlinux.org.uk>
 <20180512094221.e911fa262d8ca9a70ab8869e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180512094221.e911fa262d8ca9a70ab8869e@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 09:42:21AM +0900, Masami Hiramatsu wrote:
> Hi Greg,
> 
> Could you pick this series to stable?

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

thanks,

greg k-h
