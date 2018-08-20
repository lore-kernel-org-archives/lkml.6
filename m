Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58CFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E592173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI8Wuzwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E592173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeHTVp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTVp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:45:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0048B21473;
        Mon, 20 Aug 2018 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534789724;
        bh=MSj8Zk0ZxEu5eR3b2sbEwItXzDcRjszk/rC6eLBd4Rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dI8Wuzwi22kHELBHiydHfvI/CHq2l5iL8wAjbo0PmzQoSDrgl/tZqnkKvyfZPHGnc
         v5BIuNGfeB5xCWPFm+/nPl0GRE2SnifU4zI/QfAk8ty1kdHz+VNJQimachlt/B8haO
         dKEpnf3q+fMAWHcWQPIENF6BD2UKk0fggp9/o5s0=
Date:   Mon, 20 Aug 2018 19:28:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: multiplexer: switch to SPDX license identifier
Message-ID: <20180820192841.708a2604@archlinux>
In-Reply-To: <20180820100114.22966-6-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
        <20180820100114.22966-6-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 12:01:14 +0200
Peter Rosin <peda@axentia.se> wrote:

> Drop the boilerplate license text.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/multiplexer/iio-mux.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index e1f44cecdef4..0422ef57914c 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * IIO multiplexer driver
>   *
>   * Copyright (C) 2017 Axentia Technologies AB
>   *
>   * Author: Peter Rosin <peda@axentia.se>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #include <linux/err.h>

