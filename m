Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D2C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFE5214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFE5214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeLEJtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:49:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:34966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727976AbeLEJtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:49:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA224B725;
        Wed,  5 Dec 2018 09:49:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B03741E0DBB; Wed,  5 Dec 2018 10:49:13 +0100 (CET)
Date:   Wed, 5 Dec 2018 10:49:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 12/15] inotify: replace **** with a hug
Message-ID: <20181205094913.GC22304@quack2.suse.cz>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-13-jarkko.sakkinen@linux.intel.com>
 <CAOQ4uxiXqt+r64mtJUejzq6JTMcH-DYPsd609SdqWj5UOfZUjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiXqt+r64mtJUejzq6JTMcH-DYPsd609SdqWj5UOfZUjw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 01-12-18 08:40:25, Amir Goldstein wrote:
> On Fri, Nov 30, 2018 at 9:27 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > In order to comply with the CoC, replace **** with a hug.
> >
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  fs/notify/inotify/inotify_user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > index 105576daca4a..db0b3b6d6a58 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -446,7 +446,7 @@ static void inotify_remove_from_idr(struct fsnotify_group *group,
> >         /*
> >          * We found an mark in the idr at the right wd, but it's
> >          * not the mark we were told to remove.  eparis seriously
> > -        * fucked up somewhere.
> > +        * hugged up somewhere.
> >          */
> >         if (unlikely(found_i_mark != i_mark)) {
> >                 WARN_ONCE(1, "%s: i_mark=%p i_mark->wd=%d i_mark->group=%p "
> 
> 
> LoL. doesn't shaming conflict with the CoC?
> Just remove this sentence - it adds no valuable information.
> While at it, please fix grammar "a mark".

Agreed, just send a patch to remove that sentence and fixup the article.
Btw, for the fun of it Eric has added this comment himself so I don't think
this would really qualify as a CoC violation ;)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
