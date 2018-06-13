Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EFF47C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A613F208D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQv51sC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A613F208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935758AbeFMSVF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935494AbeFMSVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:21:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48EC1208C3;
        Wed, 13 Jun 2018 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528914063;
        bh=/tcBABKXe5dTf1kT5IhNAy+qQJykYlAGqVe0j2BRl98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQv51sC0FeEbFQKBrp9L6eGX65u+0nsXSQ6v+AkRbwn4b6SgpY5rsiTE9VRoY8Toa
         KznCPm0GvO+Jy62NlM9pK5HHLcmgmQq2mZX/6L2zs7yGWc+fE1gc6pSsDYSehYfZjq
         TCVSiTLNLynmXqVj2QAN38f/JsJ1I0lABdZi4lEI=
Date:   Wed, 13 Jun 2018 20:20:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Xavier Deguillard <xdeguillard@vmware.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 1/7] vmw_balloon: update copyright message
Message-ID: <20180613182041.GB29631@kroah.com>
References: <20180613110359.109033-1-namit@vmware.com>
 <20180613110359.109033-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613110359.109033-2-namit@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:03:53AM -0700, Nadav Amit wrote:
> Removing the paragraph about writing to the Free Software Foundation's
> mailing address from the sample GPL notice according to checkpatch
> request.
> 
> In addition, updating the year and adding a license tag.
> 
> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
> Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
> ---
>  drivers/misc/vmw_balloon.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index efd733472a35..1d50ed630d30 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1,7 +1,7 @@
>  /*
>   * VMware Balloon driver.
>   *
> - * Copyright (C) 2000-2014, VMware, Inc. All Rights Reserved.
> + * Copyright (C) 2000-2018, VMware, Inc. All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> @@ -13,9 +13,7 @@
>   * NON INFRINGEMENT.  See the GNU General Public License for more
>   * details.
>   *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
> + * SPDX-License-Identifier: GPL-2.0

This goes as the first line of the file, please see the documentation
files that describes how to do this properly.

Thanks,

greg k-h
