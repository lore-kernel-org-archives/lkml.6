Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5AEF2C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A36208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcOTMXwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A36208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeFNFYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752807AbeFNFYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:24:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F78E208D7;
        Thu, 14 Jun 2018 05:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528953877;
        bh=ruBluPBNGLlCmKMlHk7yPA9xScjZe7GsQQjLzhCTK0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcOTMXwuXXoY9/dXht0peLcqFT4wEHXF3vtzmT6sxULnWkYGcRXJF58RzZdbzEL07
         2QoLg1450CPq9Ydjeyhp62EFcNmPwnz9vSL1Q+UvehXivrpGpJqL4y7sfCdNSAVDd2
         PtU0ow5oOdWJyQRPG8uAjOrz9lwxqyigfW9z5n2s=
Date:   Thu, 14 Jun 2018 07:24:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Xavier Deguillard <xdeguillard@vmware.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2 6/7] vmw_balloon: update copyright message
Message-ID: <20180614052413.GB29739@kroah.com>
References: <20180613135412.81660-1-namit@vmware.com>
 <20180613135412.81660-7-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613135412.81660-7-namit@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:54:11AM -0700, Nadav Amit wrote:
> Removing the paragraph about writing to the Free Software Foundation's
> mailing address from the sample GPL notice according to checkpatch
> request.
> 
> In addition, updating the year and adding a license tag.
> 
> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
> Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
> ---
>  drivers/misc/vmw_balloon.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 400a1ccefc8e..b982059ce7b7 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1,7 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * VMware Balloon driver.
>   *
> - * Copyright (C) 2000-2014, VMware, Inc. All Rights Reserved.
> + * Copyright (C) 2000-2018, VMware, Inc. All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> @@ -13,10 +14,6 @@
>   * NON INFRINGEMENT.  See the GNU General Public License for more
>   * details.

You still have a lot of boiler-plate text in here that can be removed.
Please do so.

thanks,

greg k-h
