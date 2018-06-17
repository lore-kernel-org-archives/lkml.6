Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A53CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50046208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50046208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeFQNeD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 09:34:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40981 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeFQNeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 09:34:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so14099669wrq.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 06:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qgd/pDt85XcoW6ZsDF+EyoXhhzWCqwIn76CVar4pUsg=;
        b=BxGb/96HXw8/VUheI+Y8YeVobmPaVsuz3T7wWW20k5WhYpvjOVRIZcQiCbGrvfK/by
         5McyzxHKcw5onpRL5iKTcckJlYL/9D21i7q7PQWX+QubPf9WvOnXOX4OfDv4/I5bKWCn
         CU+b0yywfMo0pUQvz/vjkjiL4ssrR0aFIm/PHhBlt3FRLq/NjDxZvDuI8aA5r0DZ1fjz
         jaFD6vVQOxRTx6Ofojyg3RQnCr9EDdqto9HsiSykZnvmFAWSObcKCgWKeLM1e2yqpvAg
         Kq07dZbRBSfbUx3TFQgqL1JgOPksr+3tugD86pIaDXBQpwBd1LIPr9A2ANeu/W+eo96e
         beTg==
X-Gm-Message-State: APt69E1ckoH6xfjaR2R0EfbhktveRe02f9iKJs77Px8pgEnF+SQ74sLg
        gLGSd6kHQ2mkcFal4kSacVAlbg==
X-Google-Smtp-Source: ADUXVKLIhlSi37voxHqcN+Q2QVq+af++5H04N1+PB7PEzinHKbfc/hVrwudB7LaQIcUGcSyu1T9lWg==
X-Received: by 2002:adf:9187:: with SMTP id 7-v6mr7902378wri.69.1529242440560;
        Sun, 17 Jun 2018 06:34:00 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k36-v6sm25088458wrc.20.2018.06.17.06.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 06:33:59 -0700 (PDT)
Subject: Re: [PATCH V2] platform/x86: touchscreen_dmi: Add info for ONDA V891W
 Dual OS
To:     youling257 <youling257@gmail.com>, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org
References: <20180617131216.6604-1-youling257@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5dae5777-4c17-f06f-1d6f-de6afd34b277@redhat.com>
Date:   Sun, 17 Jun 2018 15:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617131216.6604-1-youling257@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks.

On 17-06-18 15:12, youling257 wrote:

Some commit message here would be good.

> Signed-off-by: youling257 <youling257@gmail.com>

Otherwise looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 6284946cb0d1..2ad9327c8c0f 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -221,6 +221,24 @@ static const struct ts_dmi_data onda_v891w_v1_data = {
>   	.properties	= onda_v891w_v1_props,
>   };
>   
> +static const struct property_entry onda_v891w_v3_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1625),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1135),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name",
> +			      "gsl3676-onda-v891w-v3.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct ts_dmi_data onda_v891w_v3_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= onda_v891w_v3_props,
> +};
> +
>   static const struct property_entry pipo_w2s_props[] = {
>   	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
>   	PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
> @@ -481,6 +499,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>   			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
>   		},
>   	},
> +	{
> +		/* ONDA V891w Dual OS P891DCF2V1A01274 64GB */
> +		.driver_data = (void *)&onda_v891w_v3_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
> +			DMI_MATCH(DMI_BIOS_VERSION, "ONDA.D890HBBNR0A"),
> +		},
> +	},
>   	{
>   		/* Pipo W2S */
>   		.driver_data = (void *)&pipo_w2s_data,
> 
