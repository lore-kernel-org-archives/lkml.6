Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeEDRDe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:03:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38720 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeEDRDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:03:32 -0400
X-Google-Smtp-Source: AB8JxZpQ/YWB2qMsTpWDFKKe9Ke509wEZSFnmok/2gE50wwQMTU2p2lnZp0uUzhqknPCUSDukMeb+Q==
Subject: Re: [PATCH net-next v2 01/13] net: phy: sfp: make the i2c-bus
 property really optional
To: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, linux@armlinux.org.uk, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-2-antoine.tenart@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <fd91699d-c290-8821-b4a6-0789071cfba1@gmail.com>
Date: Fri, 4 May 2018 10:03:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504135643.23466-2-antoine.tenart@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 06:56 AM, Antoine Tenart wrote:
> The SFF,SFP documentation is clear about making all the DT properties,
> with the exception of the compatible, optional. In practice this is not
> the case and without an i2c-bus property provided the SFP code will
> throw NULL pointer exceptions.
> 
> This patch is an attempt to fix this.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/phy/sfp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 4ab6e9a50bbe..4686c443fc22 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -298,11 +298,17 @@ static void sfp_set_state(struct sfp *sfp, unsigned int state)
>  
>  static int sfp_read(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
>  {
> +	if (!sfp->read)
> +		return -EOPNOTSUPP;

-ENODEV would be closer to the intended meaning IMHO, those this could
be argue that this is yet another color to paint the bikeshed with.

> +
>  	return sfp->read(sfp, a2, addr, buf, len);
>  }
>  
>  static int sfp_write(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
>  {
> +	if (!sfp->write)
> +		return -EOPNOTSUPP;
> +
>  	return sfp->write(sfp, a2, addr, buf, len);
>  }
>  
> @@ -533,6 +539,8 @@ static int sfp_sm_mod_hpower(struct sfp *sfp)
>  		return 0;
>  
>  	err = sfp_read(sfp, true, SFP_EXT_STATUS, &val, sizeof(val));
> +	if (err == -EOPNOTSUPP)
> +		goto err;
>  	if (err != sizeof(val)) {
>  		dev_err(sfp->dev, "Failed to read EEPROM: %d\n", err);
>  		err = -EAGAIN;
> @@ -542,6 +550,8 @@ static int sfp_sm_mod_hpower(struct sfp *sfp)
>  	val |= BIT(0);
>  
>  	err = sfp_write(sfp, true, SFP_EXT_STATUS, &val, sizeof(val));
> +	if (err == -EOPNOTSUPP)
> +		goto err;
>  	if (err != sizeof(val)) {
>  		dev_err(sfp->dev, "Failed to write EEPROM: %d\n", err);
>  		err = -EAGAIN;
> @@ -565,6 +575,8 @@ static int sfp_sm_mod_probe(struct sfp *sfp)
>  	int ret;
>  
>  	ret = sfp_read(sfp, false, 0, &id, sizeof(id));
> +	if (ret == -EOPNOTSUPP)
> +		return ret;

Can you find a way such that only sfp_sm_mod_probe() needs to check
whether the sfp read/write operations returned failure and then we just
make sure the SFP state machine does not make any more progress? Having
to check the sfp_read()/sfp_write() operations all over the place sounds
error prone and won't scale in the future.
-- 
Florian
