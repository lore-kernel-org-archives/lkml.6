Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeDOSN7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 14:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752524AbeDOSN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 14:13:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BB32176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 19:13:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] iio:dac:ad5686: Change license description
Message-ID: <20180415191353.49caf603@archlinux>
In-Reply-To: <1523447532-13170-1-git-send-email-stefan.popa@analog.com>
References: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
        <1523447532-13170-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 14:52:12 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Add GPLv2+ SPDX identifier and remove license notice to keep the whole
> purpose of using an SPDx id.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v3:
> 	- Created a new patch to use the SPDx identifier
> 
>  drivers/iio/dac/ad5686.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index f7f975c..e328513 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/interrupt.h>
