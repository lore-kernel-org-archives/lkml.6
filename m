Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC00CC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D20F21A7E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500294;
	bh=PvLOGNzUUydT5IbRkFjXGQoF+cji0Lu/HYXKNWkHjiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ageXZN6YFcmw1EZ4TRnBQfjuq/3EIUiQMIpaLkAt5ofU0oCWjETtVKNVI49faaYjg
	 Lsry4wAKi+IBS4c+wv2z8ghqPGE1v+SmplR4zWeyk9hBphw8jfuaN1wVwruaSOlpkq
	 J/4iztpdly8HkeIA/kZah0vEoP5xURZjuo+AwnVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392584AbeLVRiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:38:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389286AbeLVRiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:38:13 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8EC21A4E;
        Sat, 22 Dec 2018 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545500292;
        bh=PvLOGNzUUydT5IbRkFjXGQoF+cji0Lu/HYXKNWkHjiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=isyNorE4j6fszE0DzQlrGjiKBM5zuD1uI2WqlvHFAPOGB2uFib3MvQIo7qYv3HjoR
         4UhZcqq3hIze6i750fmFfl7sbsp7Zq/qpBEF0nV2PiQrs5AyHJiwApPYzolwYwtWjs
         XNpS84BLvhLyysv1Yb1x7BPB+bAmqhPMt/wvZVfM=
Date:   Sat, 22 Dec 2018 17:38:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] Staging: iio: adis16240: fixed a SPDX identifier tag
 mistake
Message-ID: <20181222173807.0284c33a@archlinux>
In-Reply-To: <1545253651-13891-1-git-send-email-indigoomega021@gmail.com>
References: <1545253651-13891-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 13:07:31 -0800
Amir Mahdi Ghorbanian <indigoomega021@gmail.com> wrote:

> Fixed a coding style mistake by adding the SPDX identifier tag to the
> first line of the code.
> 
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
*groans*  Another one where the MODULE_LICENSE is different.
Michael, Analog copyright, so if you want to express a view on
the intent that would be great.

My feeling would be that the MODULE_LICENSE is the wrong one given it's
easier to get that wrong than to add an 'or later' to the text..

On these I generally want an ack from the copyright holder anyway
just to be sure everything is in order.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16240.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index 24e525f..2c40189 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -1,9 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * ADIS16240 Programmable Impact Sensor and Recorder driver
>   *
>   * Copyright 2010 Analog Devices Inc.
>   *
> - * Licensed under the GPL-2 or later.
>   */
>  
>  #include <linux/interrupt.h>

