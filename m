Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbeDSOud (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:50:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:45940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753406AbeDSOua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:50:30 -0400
Date: Thu, 19 Apr 2018 16:50:28 +0200
From: Jan Kara <jack@suse.cz>
To: "zhenwei.pi" <zhenwei.pi@youruncloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4 : fix comments in ext4_swap_extents
Message-ID: <20180419145028.44fqs4wy5ofhvn5z@quack2.suse.cz>
References: <1521448449-25916-1-git-send-email-zhenwei.pi@youruncloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521448449-25916-1-git-send-email-zhenwei.pi@youruncloud.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-03-18 16:34:09, zhenwei.pi wrote:
> "mark_unwritten" in comment and "unwritten" in variable
> argument lists is mismatch.
> 
> Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>

This seems to have fallen through cracks. The patch looks good to me. Ted,
can you please merge it? Thanks!

								Honza

> ---
>  fs/ext4/extents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 054416e..2fc4227 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5751,7 +5751,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>   * @lblk1:	Start block for first inode
>   * @lblk2:	Start block for second inode
>   * @count:	Number of blocks to swap
> - * @mark_unwritten: Mark second inode's extents as unwritten after swap
> + * @unwritten: Mark second inode's extents as unwritten after swap
>   * @erp:	Pointer to save error value
>   *
>   * This helper routine does exactly what is promise "swap extents". All other
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
