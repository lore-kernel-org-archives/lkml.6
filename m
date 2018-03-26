Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeCZLKh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:10:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:36769 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeCZLKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:10:36 -0400
Date: Mon, 26 Mar 2018 13:10:34 +0200
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH] quota: Kill an unused extern entry form quota.h
Message-ID: <20180326111034.3ydmd44c2doheg4f@quack2.suse.cz>
References: <1521207782-14372-1-git-send-email-riteshh@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521207782-14372-1-git-send-email-riteshh@codeaurora.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-03-18 19:13:02, Ritesh Harjani wrote:
> Kill an unused extern entry from quota.h
> which is leftover of below patch.
> 
> [f32764bd2: quota: Convert quota statistics to generic percpu_counter]
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Thanks. Added to my tree.

								Honza


> ---
>  include/linux/quota.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/quota.h b/include/linux/quota.h
> index 5ac9de4..ca9772c 100644
> --- a/include/linux/quota.h
> +++ b/include/linux/quota.h
> @@ -267,7 +267,6 @@ struct dqstats {
>  	struct percpu_counter counter[_DQST_DQSTAT_LAST];
>  };
>  
> -extern struct dqstats *dqstats_pcpu;
>  extern struct dqstats dqstats;
>  
>  static inline void dqstats_inc(unsigned int type)
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
