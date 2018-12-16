Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321D1C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ACC2183E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544961632;
	bh=SWAbNpwmPxtSQZoG2LwOP88PTvgzJv0TFx7ot4Opzqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=veNS3kiW04A/S5DI5J7FOeU2BVSJN21J8bYKxTrh05N0p+/O6TAsMbUexSW5jyQ0B
	 m7SNoYDenWiD87krzshZFl45Xpq0oKSNeIfBvMXpde9NliCDLU5mrmWQoLC3B4/mNP
	 VjMxiXJgr7ZKsrB9QKlaHEyEbM/KUB8XrPGf3hSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeLPMAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:00:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbeLPMAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 07:00:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A618217FA;
        Sun, 16 Dec 2018 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544961630;
        bh=SWAbNpwmPxtSQZoG2LwOP88PTvgzJv0TFx7ot4Opzqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jWJnnyLFXFk++kKfI5rg1Uf5CC4yGx868DLYth3aVBsiJcU5ftTKtrNQun8KlKfI/
         W1EX/EGsj9sOPYFhfSjEHFma9Lxw+eBxDGTOmtQweQaePkzCtUhnQT7bwdpIgTKxBE
         Zl7X+8OwIqOMH2ZpY2bNzCxzN1h+/XIQRCBxKIfg=
Date:   Sun, 16 Dec 2018 12:00:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] staging: iio: adt7316: correct spelling of
 ADT7316_DA_EN_VIA_DAC_LDCA
Message-ID: <20181216120025.3dffee80@archlinux>
In-Reply-To: <20181212005503.28054-12-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-12-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:55:03 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> Change LDCA to LDAC.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Ah.  Here it is ;)  As commented on earlier.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 58b462ad0c83..020d695ded97 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -119,7 +119,7 @@
>   */
>  #define ADT7316_ADCLK_22_5		0x1
>  #define ADT7316_DA_HIGH_RESOLUTION	0x2
> -#define ADT7316_DA_EN_VIA_DAC_LDCA	0x8
> +#define ADT7316_DA_EN_VIA_DAC_LDAC	0x8
>  #define ADT7516_AIN_IN_VREF		0x10
>  #define ADT7316_EN_IN_TEMP_PROP_DACA	0x20
>  #define ADT7316_EN_EX_TEMP_PROP_DACB	0x40
> @@ -847,7 +847,7 @@ static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
> +	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC))
>  		return sprintf(buf, "manual\n");
>  
>  	switch (chip->dac_config & ADT7316_DA_EN_MODE_MASK) {
> @@ -876,7 +876,7 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
>  	u8 data;
>  	int ret;
>  
> -	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
> +	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC))
>  		return -EPERM;
>  
>  	ret = kstrtou8(buf, 10, &data);
> @@ -907,7 +907,7 @@ static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA)
> +	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC)
>  		return sprintf(buf, "0 - auto at any MSB DAC writing\n"
>  				"1 - auto at MSB DAC AB and CD writing\n"
>  				"2 - auto at MSB DAC ABCD writing\n"
> @@ -929,7 +929,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
>  	u8 data;
>  	int ret;
>  
> -	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA) {
> +	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC) {
>  		if ((chip->dac_config & ADT7316_DA_EN_MODE_MASK) !=
>  			ADT7316_DA_EN_MODE_LDAC)
>  			return -EPERM;
> @@ -2128,7 +2128,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	}
>  
>  	if (!chip->ldac_pin) {
> -		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
> +		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDAC;
>  		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
>  			chip->config1 |= ADT7516_SEL_AIN3;
>  	}

