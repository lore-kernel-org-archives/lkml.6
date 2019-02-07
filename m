Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23904C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C283F21908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iYyPBYBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfBGNOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:14:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38900 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfBGNOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:14:45 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17DEGOr119510;
        Thu, 7 Feb 2019 07:14:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549545256;
        bh=TX1Zk8+x0qFV+UFcshZ5j4A7MCu1ghz39Z6e36rQ7uw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iYyPBYBn0TGe7IgzeDZWZTkqVTf9DMfL/3wCd03fGsMzyxAizakYR5G+NRsJoOnPh
         BZeaIrd3RsnSqkS8duWlsjo0dFgIsdREAqlkra/qdfnykWtg4t/mW5ft+NH/4LvqR/
         pWhwcdg1nQMjFCOuv0FjyshaLeNO4WLW2odFiycQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17DEG9h118698
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 07:14:16 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 07:14:16 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 07:14:16 -0600
Received: from [172.22.96.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17DEFnq026845;
        Thu, 7 Feb 2019 07:14:15 -0600
Subject: Re: [PATCH] iio: adc: ads124s08: fix spelling mistake "converions" ->
 "conversions"
To:     Colin King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190207093902.7081-1-colin.king@canonical.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e083e2af-a00d-fb1f-a860-26c369ac5932@ti.com>
Date:   Thu, 7 Feb 2019 07:14:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207093902.7081-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin

Thanks for the patch

On 2/7/19 3:39 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in several dev_err messages. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/iio/adc/ti-ads124s08.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index c2cf58908fc8..53f17e4f2f23 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -232,7 +232,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
>  		if (ret) {
> -			dev_err(&priv->spi->dev, "Start converions failed\n");
> +			dev_err(&priv->spi->dev, "Start conversions failed\n");
>  			goto out;
>  		}
>  
> @@ -246,7 +246,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
>  		if (ret) {
> -			dev_err(&priv->spi->dev, "Stop converions failed\n");
> +			dev_err(&priv->spi->dev, "Stop conversions failed\n");
>  			goto out;
>  		}
>  
> @@ -283,12 +283,12 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
>  
>  		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
>  		if (ret)
> -			dev_err(&priv->spi->dev, "Start ADC converions failed\n");
> +			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
>  
>  		buffer[j] = ads124s_read(indio_dev, scan_index);
>  		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
>  		if (ret)
> -			dev_err(&priv->spi->dev, "Stop ADC converions failed\n");
> +			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
>  
>  		j++;
>  	}
> 

Acked-by: Dan Murphy <dmurphy@ti.com>

-- 
------------------
Dan Murphy
