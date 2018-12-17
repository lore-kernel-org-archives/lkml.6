Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D44C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2190206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeLQTgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:36:55 -0500
Received: from namei.org ([65.99.196.166]:52224 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeLQTgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:36:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBHJaovd029954;
        Mon, 17 Dec 2018 19:36:50 GMT
Date:   Tue, 18 Dec 2018 06:36:50 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] seccomp updates for next (part2)
In-Reply-To: <CAGXu5jKw8sZp8PjkSG+KZVaMdb3ryLPOAgRdOxBRPiZJF3PGtQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1812180636390.29218@namei.org>
References: <20181214162556.GA7944@beast> <CAGXu5jKw8sZp8PjkSG+KZVaMdb3ryLPOAgRdOxBRPiZJF3PGtQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Kees Cook wrote:

> On Fri, Dec 14, 2018 at 8:26 AM Kees Cook <keescook@chromium.org> wrote:
> >
> >
> > Hi James,
> >
> > Please pull these seccomp fixes for -next.
> >
> > Thanks!
> 
> Friendly ping: James, can you pick this up for -next?
> 

Pulled to next-seccomp and next-testing.


> -Kees
> 
> >
> > -Kees
> >
> > The following changes since commit fec7b6690541b8128663a13c9586b1daf42b0a6c:
> >
> >   samples: add an example of seccomp user trap (2018-12-11 16:32:11 -0800)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-next-part2
> >
> > for you to fetch changes up to 4fc96ee9085d39ceeaa7b60cd475d0a474e7062f:
> >
> >   seccomp, s390: fix build for syscall type change (2018-12-13 16:51:01 -0800)
> >
> > ----------------------------------------------------------------
> > seccomp fixes for sparse warnings and s390 build (Tycho)
> >
> > ----------------------------------------------------------------
> > Tycho Andersen (2):
> >       seccomp: fix poor type promotion
> >       seccomp, s390: fix build for syscall type change
> >
> >  arch/s390/kernel/compat_wrapper.c | 2 +-
> >  kernel/seccomp.c                  | 3 +--
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > --
> > Kees Cook
> 
> 
> 
> 

-- 
James Morris
<jmorris@namei.org>

