Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4636CC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83EE20870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/o6GO2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83EE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJ1Umm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 16:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeJ1Umm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 16:42:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D7520843;
        Sun, 28 Oct 2018 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540727895;
        bh=kNMTAEZ82gv7ru6NvgBPx8Qn5/7AVicKqx/3iVhriuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a/o6GO2YPAXxuvMHiBBM8zPFhvCbhQ7N6c2TA/mZ880PWqNWdUvfYUBSkETwAy1yC
         JefN+Tl9lPYmux4iTg3QqqvxUx7u2/v39VAkPa5+wOSy+uNa3HFyPik0KmcryphuYx
         +WV6zZqHbH4ww25MeMVuL1jGdPI3sJexRtshf/0M=
Date:   Sun, 28 Oct 2018 11:58:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v3 3/3] iio: adc128s052: use SPDX-License-Identifier
Message-ID: <20181028115810.1bcdaa5a@archlinux>
In-Reply-To: <1540481742-23596-4-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
        <1540481742-23596-1-git-send-email-dan@emutex.com>
        <1540481742-23596-4-git-send-email-dan@emutex.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 16:35:42 +0100
Dan O'Donovan <dan@emutex.com> wrote:

> This updates the ti-adc128s052.c file to use SPDX-License-Identifier
> instead of more verbose license text.
> 
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
Applied, 

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-adc128s052.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index c2d1453..7d2861f 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2014 Angelo Compagnucci <angelo.compagnucci@gmail.com>
>   *
> @@ -6,10 +7,6 @@
>   * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   * http://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   * http://www.ti.com/lit/ds/symlink/adc124s021.pdf
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #include <linux/acpi.h>

