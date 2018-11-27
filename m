Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58945C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E702086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E702086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeK0UZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:25:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:46008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729147AbeK0UZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:25:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A531AF79;
        Tue, 27 Nov 2018 09:28:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD15C1E07ED; Tue, 27 Nov 2018 10:28:36 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:28:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: clean up indentation issues, remove extraneous tabs
Message-ID: <20181127092836.GD16301@quack2.suse.cz>
References: <20181123163043.14178-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123163043.14178-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 16:30:43, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several lines that are indented too far, clean these
> up by removing the tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

The patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/migrate.c | 12 ++++++------
>  fs/ext4/super.c   |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 61a9d1927817..5ae61cd8c5c9 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -535,22 +535,22 @@ int ext4_ext_migrate(struct inode *inode)
>  	if (i_data[EXT4_IND_BLOCK]) {
>  		retval = update_ind_extent_range(handle, tmp_inode,
>  				le32_to_cpu(i_data[EXT4_IND_BLOCK]), &lb);
> -			if (retval)
> -				goto err_out;
> +		if (retval)
> +			goto err_out;
>  	} else
>  		lb.curr_block += max_entries;
>  	if (i_data[EXT4_DIND_BLOCK]) {
>  		retval = update_dind_extent_range(handle, tmp_inode,
>  				le32_to_cpu(i_data[EXT4_DIND_BLOCK]), &lb);
> -			if (retval)
> -				goto err_out;
> +		if (retval)
> +			goto err_out;
>  	} else
>  		lb.curr_block += max_entries * max_entries;
>  	if (i_data[EXT4_TIND_BLOCK]) {
>  		retval = update_tind_extent_range(handle, tmp_inode,
>  				le32_to_cpu(i_data[EXT4_TIND_BLOCK]), &lb);
> -			if (retval)
> -				goto err_out;
> +		if (retval)
> +			goto err_out;
>  	}
>  	/*
>  	 * Build the last extent
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 5603a4a1a864..15fc71398747 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1940,7 +1940,7 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  #ifdef CONFIG_FS_DAX
>  		ext4_msg(sb, KERN_WARNING,
>  		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> -			sbi->s_mount_opt |= m->mount_opt;
> +		sbi->s_mount_opt |= m->mount_opt;
>  #else
>  		ext4_msg(sb, KERN_INFO, "dax option not supported");
>  		return -1;
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
