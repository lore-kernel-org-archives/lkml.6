Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB9BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995D32173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1nBqIyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995D32173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeHTVn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeHTVn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:43:26 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4D221473;
        Mon, 20 Aug 2018 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534789603;
        bh=C9iCujKqZsC5wHTPHxly4xEAla+66A+kaQdj20gY9MA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F1nBqIyL8rvex0pui0EtlMhjjBWu0wLQ6Nv3hHlKxog4mEccW8aGklTvnYwp3Rl+m
         OOuM+bx5LGo5kD8TDwJK5rQGUNcOmsbLWWaImT3fZS1V6RgsHPMreqOIrmtX07Vt30
         B/d0Q7E/FuNUnsxQML1+001MYfDnLlVYyc+cM9rM=
Date:   Mon, 20 Aug 2018 19:26:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: potentiometer: mcp4531: switch to SPDX license
 identifier
Message-ID: <20180820192640.7249b8eb@archlinux>
In-Reply-To: <20180820100114.22966-3-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
        <20180820100114.22966-3-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 12:01:11 +0200
Peter Rosin <peda@axentia.se> wrote:

> Drop the boilerplate license text and use the correct MODULE_LICENSE.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied.

thanks,

Jonathan
> ---
>  drivers/iio/potentiometer/mcp4531.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> index df894af6cccb..831ad3e7871c 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Industrial I/O driver for Microchip digital potentiometers
>   * Copyright (c) 2015  Axentia Technologies AB
> @@ -22,10 +23,6 @@
>   * mcp4652	2	257		5, 10, 50, 100          01011xx
>   * mcp4661	2	257		5, 10, 50, 100          0101xxx
>   * mcp4662	2	257		5, 10, 50, 100          01011xx
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
>   */
>  
>  #include <linux/module.h>
> @@ -403,4 +400,4 @@ module_i2c_driver(mcp4531_driver);
>  
>  MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
>  MODULE_DESCRIPTION("MCP4531 digital potentiometer");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");

