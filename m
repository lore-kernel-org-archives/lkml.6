Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427359AbeCBMLo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:11:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:45974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422674AbeCBMLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:11:38 -0500
Date: Fri, 2 Mar 2018 13:09:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the btrfs-kdave
 tree
Message-ID: <20180302120916.GA5942@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20180302073733.789343f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302073733.789343f2@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 07:37:33AM +1100, Stephen Rothwell wrote:
> Hi David,
> 
> Commit
> 
>   001cafe3c03c ("Btrfs: fix unexpected -EEXIST when creating new inode")
> 
> is missing a Signed-off-by from its committer.

Thanks for the notice, this is only temporary. The patch has been merged
to 4.16-rc2 but Filipe's branch is based on an older rc and the patch
was probably cherry-picked, without the SOB.

I'll add a pre-push check for the signed-off so it does not trigger the
warning in the future for the known cases.
