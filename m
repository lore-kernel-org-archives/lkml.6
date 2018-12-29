Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADBCC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82379218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeL2FFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:05:45 -0500
Received: from namei.org ([65.99.196.166]:53574 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeL2FFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:05:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBT49gYT031789;
        Sat, 29 Dec 2018 04:09:43 GMT
Date:   Sat, 29 Dec 2018 15:09:42 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [GIT PULL] security: general updates for v4.21
In-Reply-To: <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1812291505480.31477@namei.org>
References: <alpine.LRH.2.21.1812250652420.2714@namei.org> <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com> <alpine.LRH.2.21.1812291406530.29722@namei.org> <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018, Linus Torvalds wrote:

> On Fri, Dec 28, 2018 at 7:11 PM James Morris <jmorris@namei.org> wrote:
> >
> > I do this every development cycle, after requests from security subsystem
> > maintainers to sync to -rc kernels.
> 
> Why?
> 
> A merge should have a *reason*.

Yep, I understand what you mean. I can't find the discussion from several 
years ago, but developers asked to be able to work with more current 
kernels, and I recall you saying that if you want to do this, merge to a 
specific -rc tag at least.

I'm not personally fussed either way, and if anyone cc'd has an opinion, 
please comment. Otherwise, I'll go back to merging to Linus only as 
necessary.


-- 
James Morris
<jmorris@namei.org>

