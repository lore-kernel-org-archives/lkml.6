Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C946CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840CD21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeLTF0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 00:26:39 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:55684 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbeLTF0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 00:26:39 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBK5QZBa019037;
        Thu, 20 Dec 2018 06:26:35 +0100
Date:   Thu, 20 Dec 2018 06:26:35 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Taking a break - time to look back
Message-ID: <20181220052635.GB18931@1wt.eu>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

[trimmed cc list]

On Thu, Dec 20, 2018 at 01:46:24AM +0100, Thomas Gleixner wrote:
>  1) Lack of code quality
> 
>     This is a problem which I observe increasing over many years.
> 
>     The feature driven duct tape engineering mode is progressing
>     massively. Proper root cause analysis has become the exception not the
>     rule.
> 
>     In our normal kernel development it's just annoying and eats up review
>     capacity unnecessarily, but in the face of a timeline or real bugs it's
>     worse. Aside of wasting time for review rounds, at some point other
>     people have to just drop everything else and get it fixed.
> 
>     Even if some people don't want to admit it, the increasing complexity
>     of the hardware technology and as a consequence the increasing
>     complexity of the kernel code base makes it mandatory to put
>     correctness and maintainability first and not to fall for the
>     featuritis and performance chants which are driving this
>     industry. We've learned painfully what that causes in the last year.

I totally agree on this point by having been hit by the same problem on
another project (haproxy). It turns out that everyone are interested in
features, reliability and performance. But these ones cannot come without
maintainability, and in practice only these 3 former ones can improve over
time. Maintainability only gets worse and is never ever addressed "later"
by incremental code updates. Now I tend to be a bastard on this point and
to demand properly documented patches, properly named functions/variables
and everything that helps other people quickly figure why the code works
or doesn't work, knowing that performance/features/reliability area easily
addressed afterwards by many other contributors when the code is maintainable.

> That said, I'm going to vanish into vacation until Jan. 7th and I'm not
> going to read any (LKML) mails until then. As I predict from experience
> that my (filtered) inbox will be a untameable beast by then, don't expect
> me to actually go through it mail by mail. If your mail will unfortunately
> end up in the 'lkml/done' folder without being read, I'm sure you'll notice
> and find a way to resend it.

Take your well deserved vacation with your family, ignore e-mails and don't
read the news, it will only make you relax better, and you'll come back
fully recharged.

Willy
