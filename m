Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeB0JgU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:36:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:34448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751838AbeB0JgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:36:17 -0500
Date: Tue, 27 Feb 2018 10:36:15 +0100
From: Jan Kara <jack@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the ext3
 tree
Message-ID: <20180227093615.rjdlert2bd5smurb@quack2.suse.cz>
References: <20180227141153.417a520e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227141153.417a520e@canb.auug.org.au>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen!

On Tue 27-02-18 14:11:53, Stephen Rothwell wrote:
> Today's linux-next merge of the akpm-current tree got conflicts in:
> 
>   fs/notify/fanotify/fanotify.c
>   fs/notify/fanotify/fanotify.h
>   fs/notify/fanotify/fanotify_user.c
>   fs/notify/inotify/inotify_fsnotify.c
> 
> between commits:
> 
>   1e301852d657 ("fanotify: Avoid lost events due to ENOMEM for unlimited queues")
>   b900420e4109 ("fsnotify: Let userspace know about lost events due to ENOMEM")
> 
> from the ext3 tree and commit:
> 
>   d519ceef2ad6 ("fs: fsnotify: account fsnotify metadata to kmemcg")
> 
> from the akpm-current tree.
> 
> I fixed it up (see below - I simplified the obvious resolution a bit) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Thanks for the conflict resolution. It looks good!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
