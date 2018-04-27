Date: Fri, 27 Apr 2018 09:23:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sujeev Dias <sdias@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
Subject: Re: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
Message-ID: <20180427072313.GB6735@kroah.com>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 07:23:28PM -0700, Sujeev Dias wrote:
> --- /dev/null
> +++ b/drivers/bus/mhi/core/mhi_boot.c
> @@ -0,0 +1,593 @@
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */

Also, please use the proper SPDX headers on all new files, and do not
put the "boiler-plate" license crud here either.

thanks,

greg k-h
