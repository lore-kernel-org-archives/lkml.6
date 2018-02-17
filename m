Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeBQMmg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 07:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeBQMme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 07:42:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DB8217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 12:42:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio:pressure:ms5611: Fix coding style in probe
 function
Message-ID: <20180217124229.18d335fe@archlinux>
In-Reply-To: <20180216194441.nep5zbb5sjf53cj6@smtp.gmail.com>
References: <20180216194441.nep5zbb5sjf53cj6@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 17:44:41 -0200
rodrigosiqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch fixes the checkpatch.pl warning and error:
> 
> iio/pressure/ms5611.h:66: ERROR: code indent should use tabs where possible
> iio/pressure/ms5611.h:66: WARNING: please, no spaces at the start of a line
> iio/pressure/ms5611.h:66: ERROR: "foo* bar" should be "foo *bar"
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks Daniel for your quick feedback on this.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Make the commit message more clearer.
> 
>  drivers/iio/pressure/ms5611.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index ccda63c5b3c3..ead9e9f85894 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -63,7 +63,7 @@ struct ms5611_state {
>  };
>  
>  int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
> -                 const char* name, int type);
> +		 const char *name, int type);
>  int ms5611_remove(struct iio_dev *indio_dev);
>  
>  #endif /* _MS5611_H */
