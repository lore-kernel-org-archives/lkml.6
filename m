Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C979DC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 03:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7DB21902
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 03:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbeL2DLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 22:11:05 -0500
Received: from namei.org ([65.99.196.166]:53548 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbeL2DLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 22:11:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBT3B4Ei029968;
        Sat, 29 Dec 2018 03:11:04 GMT
Date:   Sat, 29 Dec 2018 14:11:04 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] security: general updates for v4.21
In-Reply-To: <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1812291406530.29722@namei.org>
References: <alpine.LRH.2.21.1812250652420.2714@namei.org> <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2018, Linus Torvalds wrote:

> On Mon, Dec 24, 2018 at 11:55 AM James Morris <jmorris@namei.org> wrote:
> >
> > The main changes here are Paul Gortmaker's removal of unneccesary module.h
> > infrastructure.
> 
> I will point out a merge with a horrible commit message:
> 
>     "Sync to Linux 4.20-rc2 for downstream developers"
> 
> that tells nobody anything.
> 
> Why was that merge done? If you can't explain the merge, just don't do
> the merge.

I do this every development cycle, after requests from security subsystem 
maintainers to sync to -rc kernels. 


-- 
James Morris
<jmorris@namei.org>

