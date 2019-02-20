Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64685C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407DF205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfBTLQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:16:36 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:54160 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfBTLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:16:36 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 32EF49E74A9;
        Wed, 20 Feb 2019 11:16:34 +0000 (GMT)
Date:   Wed, 20 Feb 2019 11:16:32 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sps30: fix attribute kernel version
Message-ID: <20190220111632.4e523380@archlinux>
In-Reply-To: <20190215195759.31304-1-tduszyns@gmail.com>
References: <20190215195759.31304-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 20:57:59 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> 4.22 has never existed and this change was actually added to 4.21
> hence fix the numbering.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
4.21 isn't going to exist either.

Current is targeting 5.0.
https://elixir.bootlin.com/linux/v5.0-rc7/source/Makefile

Hmm. Shy Crocodile :)

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-sps30 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> index 143df8e89d08..bef52f3e47bc 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-sps30
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> @@ -1,6 +1,6 @@
>  What:		/sys/bus/iio/devices/iio:deviceX/start_cleaning
>  Date:		December 2018
> -KernelVersion:	4.22
> +KernelVersion:	4.21
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Writing 1 starts sensor self cleaning. Internal fan accelerates
> --
> 2.20.1
> 

