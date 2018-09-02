Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B76C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B219620843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B219620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeICAuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 20:50:55 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56264 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeICAuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 20:50:55 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id E590A9E78DA;
        Sun,  2 Sep 2018 21:33:54 +0100 (BST)
Date:   Sun, 2 Sep 2018 21:33:53 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1750: switch to SPDX identifier
Message-ID: <20180902213353.1c21a78a@archlinux>
In-Reply-To: <20180901195144.11389-1-tduszyns@gmail.com>
References: <20180901195144.11389-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Sep 2018 21:51:44 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Drop boilerplate license text and use SPDX identifier instead.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/light/bh1750.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index a814828e69f5..493ca7420602 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensor driver
>   *
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * Data sheets:
>   *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1710fvc-e.pdf
>   *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1715fvc-e.pdf

