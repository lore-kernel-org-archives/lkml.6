Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCCPVJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751940AbeCCPVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:21:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DCB2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:21:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, daniel.baluta@nxp.com,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: dummy: Add correct tabs and spaces to
 Kconfig
Message-ID: <20180303152103.5b7061af@archlinux>
In-Reply-To: <fc453a92429d06d769aa71072c5c0cbaa1c8d57a.1519738995.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
        <fc453a92429d06d769aa71072c5c0cbaa1c8d57a.1519738995.git.rodrigosiqueiramelo@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 10:46:51 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> Kconfig from iio/dummy does not follow the coding style recommendations.
> According to the coding-style, Lines under a config definition are
> indented with one tab, while help text is indented an additional two
> spaces. This patch adds the proper tabulation and space.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dummy/Kconfig | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
> index 5a29fbd3c531..85e13b2e35bf 100644
> --- a/drivers/iio/dummy/Kconfig
> +++ b/drivers/iio/dummy/Kconfig
> @@ -9,20 +9,20 @@ config IIO_DUMMY_EVGEN
>  	tristate
>  
>  config IIO_SIMPLE_DUMMY
> -       tristate "An example driver with no hardware requirements"
> -       depends on IIO_SW_DEVICE
> -       help
> -	 Driver intended mainly as documentation for how to write
> -	 a driver. May also be useful for testing userspace code
> -	 without hardware.
> +	tristate "An example driver with no hardware requirements"
> +	depends on IIO_SW_DEVICE
> +	help
> +	  Driver intended mainly as documentation for how to write
> +	  a driver. May also be useful for testing userspace code
> +	  without hardware.
>  
>  if IIO_SIMPLE_DUMMY
>  
>  config IIO_SIMPLE_DUMMY_EVENTS
> -       bool "Event generation support"
> -       select IIO_DUMMY_EVGEN
> -       help
> -         Add some dummy events to the simple dummy driver.
> +	bool "Event generation support"
> +	select IIO_DUMMY_EVGEN
> +	help
> +	  Add some dummy events to the simple dummy driver.
>  
>  config IIO_SIMPLE_DUMMY_BUFFER
>  	bool "Buffered capture support"
