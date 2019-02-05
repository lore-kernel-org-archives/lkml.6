Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B2DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C028217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549392277;
	bh=fA5UuCH2DKb+XENmNnvGu5afXANQth5MGM4Z5bUj86w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GcSZZxD/uekNgcHToWXaS6amGA9e5bnzSatUTPz24pfN7/w0bLy9uYt22x5dYYPYP
	 TZ/wkzJJ8r7y86mNNV2EYPbHkAxMQQ9U+IefOddczWA1ShVhHfseVxBGLTeoxq3Tfc
	 33T1eOYV2vqpPB/LQGq7+7miGdtgX0fnE3asDqYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfBESof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:44:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBESof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:44:35 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C236217D6;
        Tue,  5 Feb 2019 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549392274;
        bh=fA5UuCH2DKb+XENmNnvGu5afXANQth5MGM4Z5bUj86w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knSoqKD3ISU7TBNbSdlLusA7pmLgN6D2PjSJOJzAVBzKKiR2tTSki7uw97bJnCFBN
         w/9UXfMvpeIdI40qthAEIhACH3lIiG1V7gZ2ZtWEsErrmgf8Zc1ZgzgIDt61saYx8o
         MsBo3epAlw6AlBGwWJXwUqOMcABZaIJhiOWrq/bI=
Date:   Tue, 5 Feb 2019 19:44:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use the correct style for SPDX license
 Identifier
Message-ID: <20190205184431.GD22198@kroah.com>
References: <20190205150620.GA17522@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205150620.GA17522@nishad>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 08:36:24PM +0530, Nishad Kamdar wrote:
> This patch corrects the style for SPDX license Identifier in mac.h
> by using "/* */" in place of "//" as per Linux kernel licensing rules.
> Issue found by checkpatch.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/vt6656/mac.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
> index 94e700fcd0b6..75166020f7c6 100644
> --- a/drivers/staging/vt6656/mac.h
> +++ b/drivers/staging/vt6656/mac.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> +/* SPDX-License-Identifier: GPL-2.0+

Should really be:

/* SPDX-License-Identifier: GPL-2.0+ */

thanks,

greg k-h
