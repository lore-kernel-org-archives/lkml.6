Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE466C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49C820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49C820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030504AbeFRIny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:43:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38739 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967373AbeFRInu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:43:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so13905889wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b3LfgRVy7Ae1MXE0yBu/v+r8JFv3worF2ojP2tPV5+g=;
        b=V0AWKSjgrza1AeMhnCKjtOfBYtYuAP5xVwgFxJffrVDHVZHlfzBBahlhYz09LHXiZz
         +aPvnRaq4I3QCJdAF3NE79tLl8pcCtJfEtp3RJw6iZ5JfIqq13Ul5M3bnlgG5yvkP9Dm
         xNlgxJ9EzfbTIfbEpaVuHCHPZTzJaZpUKliJw5iOTCALmYxjuGKsODKqcPmLzAByM/Pe
         KochuSr1FYG9ADCYw5kBy9S+ZQmf/7OHKCi1/sU7eBEe6EkcuhNEOKbdzPJSU4E/Gtx9
         0pcbDLAEamWrN/QbSTgs8tUI59EpQuIAG4BkBLpZJwzqSoQrVPr1co2008lia9bTj1zC
         nqYQ==
X-Gm-Message-State: APt69E3NPwz1ffHt0w4DswwVLWOjAlxvbd0ipvcvITw5DTOWeNW8wM1s
        MlTk535g+Bor9BIpSYl19dGYCw==
X-Google-Smtp-Source: ADUXVKKS+tgZVXCVk4nHm4AKOo1qN5VPFjIaUlAcncqpNxzWJ+JmGdmk01bCiTMJdAESQYWjTixhGQ==
X-Received: by 2002:a50:9eac:: with SMTP id a41-v6mr10482053edf.92.1529311429353;
        Mon, 18 Jun 2018 01:43:49 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a12-v6sm5690096edr.89.2018.06.18.01.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 01:43:48 -0700 (PDT)
Subject: Re: [PATCH v4] platform/x86: touchscreen_dmi: Add info for the ONDA
 V891W Dual OS tablet
To:     youling257 <youling257@gmail.com>, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org
References: <20180617235812.18596-1-youling257@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <342c314e-6e9f-aefc-3ec0-300b53071089@redhat.com>
Date:   Mon, 18 Jun 2018 10:43:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617235812.18596-1-youling257@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-06-18 01:58, youling257 wrote:
> Add touchscreen info for the ONDA V891W Dual OS tablet

Nitpick: still missing a period '.' at the end, this should be:

Add touchscreen info for the ONDA V891W Dual OS tablet.

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: youling257 <youling257@gmail.com>

As Andy indicated you need to use your real name when submitting
kernel patches, not an internet alias (or a nick).

So you need to re-submit this with something like this:

Signed-off-by: FirstName LastName <youling257@gmail.com>

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
