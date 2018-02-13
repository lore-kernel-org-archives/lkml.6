Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934717AbeBMLoy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:44:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:34773 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934078AbeBMLov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:44:51 -0500
Date: Tue, 13 Feb 2018 12:42:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the btrfs-kdave
 tree
Message-ID: <20180213114233.GS3003@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20180209141152.774f1205@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209141152.774f1205@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 09, 2018 at 02:11:52PM +1100, Stephen Rothwell wrote:
> Commit
>   7f53a77da963 ("Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly")
> is missing a Signed-off-by from its committer.

thanks for the notice, this has been fixed.
