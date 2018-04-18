Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105406-1524009935-2-7762826555389770934
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524009935; b=Duw7d2GDnRE2ilndvknfT6+pm0llaJ1j4PqwYO/xcORuiwV2DD
    J0YFd0VqocAEUVPRiSt0llJWrkuTWvozsMzWtT/9NdKtxnbDHrYN956oFW7o6L0r
    h49IBG/Nn/L+Md4VMnxNXujQ0CS95Sj4SLF9h5Vqu2HP3SQ7YUpK8P0oC7+00uJo
    dTrno6DlBcRl2IYxqgsclpD6nBIFT2IDdz+QND4H365X/dJktU+saQYWyFNEzaQj
    m1LOXK1lgeRhEW7moOYMrYESmX/9KKyHbldzq5cNeq9Ws4H4sxFNVs1nsbKIINxU
    lL1Md6pv8sINf55gKnyJVYDZ8PEzQentYVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1524009935; bh=pvyXYW9MoaF2KnLY/CnRLMT10Ormp701L8jWdSA
    H56M=; b=HUtWQepd64/MXLInB5dzXX8PmOZ/FEVIa6jK4tTfbjYttrAAOoa1kah
    HaQ3fOWXxo4MlXOJnq2HiMEUk0jVskb6aiiqBLPnNDL/RQR8HgqSOZOu0eIIDUL3
    SoeP/uU3tY+QIIclB3iQkZoIYIhydU/mvLqc2RC3QsWucPNWsbq6H09iu7d3mhAL
    OSuWQBHEB5L0kcQuM8rNoLfPArBC4BFxNM/NbDQCvEMo2MQEDMZlaFbZddIHtLrs
    r5n/2sZyzlcIyKtVJC8fUt3WAo1+zO8s38t3kKrZxP1k/HLHIDNe1LXz7PEsI+7b
    5CHiwf93u/IA7mXR6HuoUlE/Q2MjAkg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC41RpMDdpex45bAFzn/WLk55duaUCxIf3yaTOqFsgMbxSlZU70lFYWlCW8b57/pJ43GNNYzDM6wKiLzh7ChhaNYTuWX7bnGACGK3GUo3QDIwR6xBxAy
    mH4GejoeiO2vtVsb84QtELZU2TSpj0J/E8JyX8mpipG41bvWQ47jsnPLRhpnCldOGLNF+Fx0JMRoLEt204NcN0c1t2pl2dYhnfGgIJO9TZ6VWbOrjLtYJDnn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=KtfBT51wnLQyp84GPqsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeDRAFc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 20:05:32 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37996 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeDRAFb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 20:05:31 -0400
Date: Wed, 18 Apr 2018 10:05:17 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/10] SWIM driver fixes
In-Reply-To: <alpine.LNX.2.21.1804160904530.8@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1804180959170.8@nippy.intranet>
References: <cover.1523493475.git.fthain@telegraphics.com.au> <alpine.LNX.2.21.1804160904530.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Geert,

On Tue, 17 Apr 2018, I wrote:

> On Wed, 11 Apr 2018, I wrote:
> 
> > This patch series has fixes for bugs in the SWIM floppy disk 
> > controller driver, including an oops and a soft lockup.
> > 
> 
> Apparently no-one is authorized to push this series intact.
> 
> Geert, would you please take just the first two patches?

Please ignore patch 1/10. It was correct when it was part of the v1 
series, but it's not really appropriate now.

Please take patch 2/10.

Sorry for the confusion.

-- 
