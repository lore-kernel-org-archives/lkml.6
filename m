Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBHXvD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:51:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:38255 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeBHXvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:51:02 -0500
Date: Fri, 9 Feb 2018 00:48:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: linux-next: build failure after merge of the btrfs-kdave tree
Message-ID: <20180208234846.GF3003@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
References: <20180209104057.0e999c19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209104057.0e999c19@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 10:40:57AM +1100, Stephen Rothwell wrote:
> Hi David,
> 
> [Seems I somehow failed to actually send the following message a couple
> of days ago, sorry.]
> 
> After merging the btrfs-kdave tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> fs/btrfs/tree-checker.c:33:10: fatal error: hash.h: No such file or directory
>  #include "hash.h"
>           ^~~~~~~~
> 
> Caused by commit
> 
>   8bd2a9b19fd7 ("btrfs: Remove custom crc32c init code")
> 
> interacting with commit
> 
>   ad7b0368f33c ("btrfs: tree-checker: Add checker for dir item")
> 
> from Linus' tree.
> 
> It should have been fixed up in commit
> 
>   99ca8d38ea90 ("Merge branch 'ext/nikbor/libcrc32c' into for-next-next-v4.16-20180206")

Right, I had fixed it in my local branch but did not push the update,
sorry.  Current for-next, top commit 993b08a92e32 builds fine.
