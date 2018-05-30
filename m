Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeE3W0s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:26:48 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:43637 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbeE3W0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:26:46 -0400
X-Google-Smtp-Source: ADUXVKKn6iHYjnzTgUeAxnTB6hfdEmuahBU64GUo2KqfqANrd6Lnx+gc1SJf7+R/qI/WvJ+Tx+w8HKfDYXz5iBH0IH0=
MIME-Version: 1.0
References: <20180531072629.6e19241b@canb.auug.org.au> <CAABAsM7VZcJvtSnbebOAWEAZ7oTkV6JXJF=GxOj=zLYgjSGQ_Q@mail.gmail.com>
In-Reply-To: <CAABAsM7VZcJvtSnbebOAWEAZ7oTkV6JXJF=GxOj=zLYgjSGQ_Q@mail.gmail.com>
From: Trond Myklebust <trondmy@gmail.com>
Date: Wed, 30 May 2018 18:26:34 -0400
Message-ID: <CAABAsM5W+LsPD_+Fxi_3FePoCBThFjhx15seGA=iZFi-v0XtTA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the nfs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: List Linux Next Mailing <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that there is another known problem with that linux-next branch
with the patch "NFSv4: Fix sillyrename to return the delegation when
appropriate". You might therefore just want to drop that branch for
today. It will be fixed up later tonight.
On Wed, 30 May 2018 at 18:22, Trond Myklebust <trondmy@gmail.com> wrote:
>
> Hi Stephen,
>
> Thanks for noticing and apologies for missing that. I'll take that
> patch out until Neil can update it.
>
> Cheers
>   Trond
> On Wed, 30 May 2018 at 17:26, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Trond,
> >
> > Commit
> >
> >   f217ebf24480 ("NFS: slight optimization for walking list for delegations")
> >
> > is missing a Signed-off-by from its author.
> >
> > --
> > Cheers,
> > Stephen Rothwell
