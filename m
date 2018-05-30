Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932525AbeE3WXM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:23:12 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:45807 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753617AbeE3WXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:23:09 -0400
X-Google-Smtp-Source: ADUXVKIUigfxwFbpxQTUILIaDy6ABpegNz7tiNzaqI7sKATnTew7X9p6U+jttwj+GsuA+Exb+FrEOxa016TASaBf3pY=
MIME-Version: 1.0
References: <20180531072629.6e19241b@canb.auug.org.au>
In-Reply-To: <20180531072629.6e19241b@canb.auug.org.au>
From: Trond Myklebust <trondmy@gmail.com>
Date: Wed, 30 May 2018 18:22:57 -0400
Message-ID: <CAABAsM7VZcJvtSnbebOAWEAZ7oTkV6JXJF=GxOj=zLYgjSGQ_Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the nfs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: List Linux Next Mailing <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for noticing and apologies for missing that. I'll take that
patch out until Neil can update it.

Cheers
  Trond
On Wed, 30 May 2018 at 17:26, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Trond,
>
> Commit
>
>   f217ebf24480 ("NFS: slight optimization for walking list for delegations")
>
> is missing a Signed-off-by from its author.
>
> --
> Cheers,
> Stephen Rothwell
