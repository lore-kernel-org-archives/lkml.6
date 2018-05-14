Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeENAhE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:37:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44186 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeENAhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:37:03 -0400
Date: Mon, 14 May 2018 01:36:59 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: linux-next: manual merge of the f2fs tree with the vfs-fixes tree
Message-ID: <20180514003659.GA30522@ZenIV.linux.org.uk>
References: <20180514102624.76a4097e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514102624.76a4097e@canb.auug.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:26:24AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the f2fs tree got a conflict in:
> 
>   fs/f2fs/namei.c
> 
> between commit:
> 
>   1e2e547a93a0 ("do d_instantiate/unlock_new_inode combinations safely")
> 
> from the vfs-fixes tree and commit:
> 
>   ab3835aae642 ("f2fs: call unlock_new_inode() before d_instantiate()")
> 
> from the f2fs tree.
> 
> I think that the vfs-fixes commit supercedes the f2fs tree one, so I
> used that.

Yes, it does.
