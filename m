Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968106AbeE2X2A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:28:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965499AbeE2X15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:27:57 -0400
Subject: Re: [PATCH v7 2/7] drivers/i2c: Add FSI-attached I2C master algorithm
To: Eddie James <eajames@linux.vnet.ibm.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        "Edward A. James" <eajames@us.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-3-git-send-email-eajames@linux.vnet.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e7ca95e5-580b-d88d-ed22-09299c76ce8e@infradead.org>
Date: Tue, 29 May 2018 16:27:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527632665-25707-3-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 03:24 PM, Eddie James wrote:
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4f8df2e..ebba369 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1330,4 +1330,15 @@ config I2C_ZX2967
>  	  This driver can also be built as a module. If so, the module will be
>  	  called i2c-zx2967.
>  
> +config I2C_FSI
> +	tristate "FSI I2C driver"
> +	depends on FSI
> +	help
> +	  Driver for FSI bus attached I2C masters. These are I2C masters that
> +	  are connected to the system over a FSI bus, instead of the more

	                              over an FSI bus,

> +	  common PCI or MMIO interface.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called as i2c-fsi.
> +
>  endmenu


-- 
~Randy
