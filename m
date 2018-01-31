Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeAaW36 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:29:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeAaW35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:29:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B9221720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Wed, 31 Jan 2018 14:19:57 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>
Subject: Re: [PATCH v2 3/3] f2fs: Add the 'whint_mode' mount option to f2fs
 documentation
Message-ID: <20180131221957.GD12901@jaegeuk-macbookpro.roam.corp.google.com>
References: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
 <1517366219-22166-4-git-send-email-hyc.lee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517366219-22166-4-git-send-email-hyc.lee@gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyunchul,

I've added the policy in the Doc as wel.

Thanks,

On 01/31, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
> ---
>  Documentation/filesystems/f2fs.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 13c2ff0..414a160 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -174,6 +174,12 @@ offgrpjquota           Turn off group journelled quota.
>  offprjjquota           Turn off project journelled quota.
>  quota                  Enable plain user disk quota accounting.
>  noquota                Disable all plain disk quota option.
> +whint_mode=%s          Control which write hints are passed down to block
> +                       layer. This supports "off", "user-based", and
> +                       "fs-based".  In "off" mode (default), f2fs does not pass
> +                       down hints. In "user-based" mode, f2fs tries to pass
> +                       down hints given by users. And in "fs-based" mode, f2fs
> +                       passes down hints with its policy.
>  
>  ================================================================================
>  DEBUGFS ENTRIES
> -- 
> 1.9.1
