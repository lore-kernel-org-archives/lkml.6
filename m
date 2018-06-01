Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeFAJP6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:15:58 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.134]:9548 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeFAJPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:15:54 -0400
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PDYc9ZbLQuBYnGyPFydOVsjnssucaVzia+6/AK6"
X-RZG-CLASS-ID: mo05
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB2838F1DE06025F231537DD68996C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180530162439.7b5eec2b@bbrezillon>
From: Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <a2f96430-d880-dea1-436c-191cddac431e@exceet.de>
Date: Fri, 1 Jun 2018 11:14:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530162439.7b5eec2b@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On 30.05.2018 16:24, Boris Brezillon wrote:
> Hi Yogesh,
> 
> On Wed, 30 May 2018 13:50:51 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>> Hi Frieder,
>>
>> Thanks for migrating the fsl-quadspi.c driver on the new SPI
>> framework. This patch is using dynamic LUT approach to create the LUT
>> at run time instead of fixed static LUT as being used in current
>> driver present at mtd/spi-nor/fsl-quadspi.c. I have pushed the
>> changes for dynamic LUT on mtd/spi-nor/fsl-quadspi.c and v10 has been
>> in review stage.
>>
>> Request you to please add 'signed-off' mentioned in those patches in
>> this patch, patchwork link is
>> https://patchwork.ozlabs.org/patch/896534/

So for reasons already given by Boris, I won't add your S-o-b tags. But 
I can add your name (and that of Suresh Gupta?) to the file header and 
as MODULE_AUTHOR in the next version.

Regards,

Frieder

> 
> First, I'd like to state that this work has not been based on your
> dynamic LUT code, and I actually asked you to adapt your code to match
> the way we were handling it in the new driver (which at that time was
> still under development). Then, even if you want to be cited as one of
> the author of the new code, SoB tag is not the right way to do it (see
> [1] for an explanation on when SoB should be added). Instead, you
> should add your name in the copyright header and maybe be add a
> MODULE_AUTHOR():
> 
> /*
>   * Copyright ...
>   * ...
>   * Authors:
>   *	...
>   *	Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>   */
> 
> ...
> 
> MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");
> 
> Regards,
> 
> Boris
> 
> [1]https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L429
> 
