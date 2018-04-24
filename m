Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeDXQwv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:52:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50296 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeDXQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:52:46 -0400
X-Google-Smtp-Source: AIpwx48FmYaRMjceBEms+rEFl9HAMlJaa3D0tHriIDTc9p8x3Xr7W31ry8poCryI68fyOSWeJlgE5Q==
Subject: Re: [PATCH] net: phy: TLK10X initial driver submission
To: =?UTF-8?Q?M=c3=a5ns_Andersson?= <mans.andersson@nibe.se>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180419082816.109338-1-mans.andersson@nibe.se>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <03ddc0d5-85ff-feeb-259a-65ae89893d4e@gmail.com>
Date: Tue, 24 Apr 2018 09:52:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419082816.109338-1-mans.andersson@nibe.se>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/19/2018 01:28 AM, Måns Andersson wrote:
> From: Mans Andersson <mans.andersson@nibe.se>
> 
> Add suport for the TI TLK105 and TLK106 10/100Mbit ethernet phys.
> 
> In addition the TLK10X needs to be removed from DP83848 driver as the
> power back off support is added here for this device.

I would not think this is a compelling enough reason, you could very
well just adjust the dp83848.c driver just to account for these
properties that you are introducing. More comments below.

[snip]

> +#define TLK10X_INT_EN_MASK		\
> +	(TLK10X_MISR_ANC_INT_EN |	\
> +	 TLK10X_MISR_DUP_INT_EN |	\
> +	 TLK10X_MISR_SPD_INT_EN |	\
> +	 TLK10X_MISR_LINK_INT_EN)
> +
> +struct tlk10x_private {
> +	int pwrbo_level;

unsigned int

> +};
> +
> +static int tlk10x_read(struct phy_device *phydev, int reg)
> +{
> +	if (reg & ~0x1f) {
> +		/* Extended register */
> +		phy_write(phydev, TLK10X_REGCR, 0x001F);
> +		phy_write(phydev, TLK10X_ADDAR, reg);
> +		phy_write(phydev, TLK10X_REGCR, 0x401F);
> +		reg = TLK10X_ADDAR;
> +	}

Humm, this looks a bit fragile, you would likely want to create separate
helper functions for these extended registers and make sure you handle
write failures as well. Also consider making use of the page helpers
from include/linux/phy.h.

> +
> +	return phy_read(phydev, reg);
> +}
> +
> +static int tlk10x_write(struct phy_device *phydev, int reg, int val)
> +{
> +	if (reg & ~0x1f) {
> +		/* Extended register */
> +		phy_write(phydev, TLK10X_REGCR, 0x001F);
> +		phy_write(phydev, TLK10X_ADDAR, reg);
> +		phy_write(phydev, TLK10X_REGCR, 0x401F);
> +		reg = TLK10X_ADDAR;
> +	}

Same here.

> +
> +	return phy_write(phydev, reg, val);
> +}
> +
> +#ifdef CONFIG_OF_MDIO
> +static int tlk10x_of_init(struct phy_device *phydev)
> +{
> +	struct tlk10x_private *tlk10x = phydev->priv;
> +	struct device *dev = &phydev->mdio.dev;
> +	struct device_node *of_node = dev->of_node;
> +	int ret;
> +
> +	if (!of_node)
> +		return 0;
> +
> +	ret = of_property_read_u32(of_node, "ti,power-back-off",
> +				   &tlk10x->pwrbo_level);
> +	if (ret) {
> +		dev_err(dev, "missing ti,power-back-off property");
> +		tlk10x->pwrbo_level = 0;

This should not be necessary, that should be the default with a zero
initialized private data structure.

> +	}
> +
> +	return 0;
> +}
> +#else
> +static int tlk10x_of_init(struct phy_device *phydev)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_OF_MDIO */
> +
> +static int tlk10x_config_init(struct phy_device *phydev)
> +{
> +	int ret, reg;
> +	struct tlk10x_private *tlk10x;
> +
> +	ret = genphy_config_init(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!phydev->priv) {
> +		tlk10x = devm_kzalloc(&phydev->mdio.dev, sizeof(*tlk10x),
> +				      GFP_KERNEL);
> +		if (!tlk10x)
> +			return -ENOMEM;
> +
> +		phydev->priv = tlk10x;
> +		ret = tlk10x_of_init(phydev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		tlk10x = (struct tlk10x_private *)phydev->priv;
> +	}

You need to implement a probe() function that is responsible for
allocation private memory instead of doing this check.

> +
> +	// Power back off
> +	if (tlk10x->pwrbo_level < 0 || tlk10x->pwrbo_level > 3)
> +		tlk10x->pwrbo_level = 0;

How can you have pwrb_level < 0 when you use of_read_property_u32()?

> +	reg = tlk10x_read(phydev, TLK10X_PWRBOCR);
> +	reg = ((reg & ~TLK10X_PWRBOCR_MASK)
> +		| (tlk10x->pwrbo_level << 6));

One too many levels of parenthesis, the outer ones should not be necessary.

> +	ret = tlk10x_write(phydev, TLK10X_PWRBOCR, reg);
> +	if (ret < 0) {
> +		dev_err(&phydev->mdio.dev,
> +			"unable to set power back-off (err=%d)\n", ret);
> +		return ret;
> +	}
> +	dev_info(&phydev->mdio.dev, "power back-off set to level %d\n",
> +		 tlk10x->pwrbo_level);

config_init() is called often, consider making this a debugging statement.

-- 
Florian
