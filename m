Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5102C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCB02086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCB02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933389AbeFRMyl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:54:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39400 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754229AbeFRMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:54:39 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so16721166wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 05:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3OCswB0/mLez6zAI5hRvo5Vdh3mwW0opc1bYcn1Cpo=;
        b=b3B7aNeeIdit7c1CbFm5K9xM3cYGt2ab3QF3cmmrCD2cLz7H2hg2nO/wtyBhKiRgts
         uf5et/ktXaTr1WUbFb+2zQ7S5Q+uUshgSQWaLmty4SPhCupJ2okJOrpBTv4L5Thjw0Zd
         CPvkfooRX7VTc7d6rKQXQFCMPFXKCBqbc93p34hDvzQb9Hzr6zhOqZItvgnpf1SGMmmX
         lgWmiPN3fTQfWCwGjy86PInyX1HtruoQ3CE++wnWxSRQ+3zNrww+o5Ss+V8Vg5XrVB5e
         3xUJKGx9Ss4BBDxYfpau+2ewePJ45WZ5VePpVI2C1hJzAbwJ4OWVChsx36iuIGrN5SmC
         bfBg==
X-Gm-Message-State: APt69E3IuSxTzPEFXTnoYvlOK9AwRh/fVGohjd8Si5eGJ3Fj2fVOhfW7
        V0ULBPMmQlGJXgRu6jhEvxTFOQ==
X-Google-Smtp-Source: ADUXVKK/fomzM3d71WE8aXQbETJudLM69xHoADpikoHTO2vgV8+wgBu8Gka6jMjH5QUNcf+KyviwvA==
X-Received: by 2002:adf:c4b6:: with SMTP id m51-v6mr10305556wrf.103.1529326477940;
        Mon, 18 Jun 2018 05:54:37 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z13-v6sm13913994wrr.71.2018.06.18.05.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 05:54:37 -0700 (PDT)
Subject: Re: [PATCH v4] platform/x86: touchscreen_dmi: Add info for the ONDA
 V891W Dual OS tablet
From:   Hans de Goede <hdegoede@redhat.com>
To:     youling257 <youling257@gmail.com>, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org
References: <20180617235812.18596-1-youling257@gmail.com>
 <342c314e-6e9f-aefc-3ec0-300b53071089@redhat.com>
Message-ID: <32076294-07ac-7801-2220-7468e71c275e@redhat.com>
Date:   Mon, 18 Jun 2018 14:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <342c314e-6e9f-aefc-3ec0-300b53071089@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-06-18 10:43, Hans de Goede wrote:
> Hi,
> 
> On 18-06-18 01:58, youling257 wrote:
>> Add touchscreen info for the ONDA V891W Dual OS tablet
> 
> Nitpick: still missing a period '.' at the end, this should be:
> 
> Add touchscreen info for the ONDA V891W Dual OS tablet.
> 
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: youling257 <youling257@gmail.com>
> 
> As Andy indicated you need to use your real name when submitting
> kernel patches, not an internet alias (or a nick).
> 
> So you need to re-submit this with something like this:
> 
> Signed-off-by: FirstName LastName <youling257@gmail.com>

youling has indicated to me (off-list) that he does not
want to use his real name.

He has already provided me with the touchscreen details
and dmi strings for this tablet a while ago and I had
writing the exact same quirk on my TODO list already.

As such I've no doubt that he created this patch and
has the rights to Submit it under the GPL license.

So I'm going to resubmit this with his S-o-b removed
and replaced with mine. Where the intent of my
S-o-b is to certify point c. of the certificate
of origin, quoting from:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

"c. The contribution was provided directly to me by some other person who certified (a), (b) or (c) and I have not modified it."

This seems better then me re-creating the exact
same patch from scratch.

Regards,

Hans





>> ---
>>   drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
>> index 6284946cb0d1..2ad9327c8c0f 100644
>> --- a/drivers/platform/x86/touchscreen_dmi.c
>> +++ b/drivers/platform/x86/touchscreen_dmi.c
>> @@ -221,6 +221,24 @@ static const struct ts_dmi_data onda_v891w_v1_data = {
>>       .properties    = onda_v891w_v1_props,
>>   };
>> +static const struct property_entry onda_v891w_v3_props[] = {
>> +    PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
>> +    PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
>> +    PROPERTY_ENTRY_U32("touchscreen-size-x", 1625),
>> +    PROPERTY_ENTRY_U32("touchscreen-size-y", 1135),
>> +    PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
>> +    PROPERTY_ENTRY_STRING("firmware-name",
>> +                  "gsl3676-onda-v891w-v3.fw"),
>> +    PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>> +    PROPERTY_ENTRY_BOOL("silead,home-button"),
>> +    { }
>> +};
>> +
>> +static const struct ts_dmi_data onda_v891w_v3_data = {
>> +    .acpi_name    = "MSSL1680:00",
>> +    .properties    = onda_v891w_v3_props,
>> +};
>> +
>>   static const struct property_entry pipo_w2s_props[] = {
>>       PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
>>       PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
>> @@ -481,6 +499,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>>               DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
>>           },
>>       },
>> +    {
>> +        /* ONDA V891w Dual OS P891DCF2V1A01274 64GB */
>> +        .driver_data = (void *)&onda_v891w_v3_data,
>> +        .matches = {
>> +            DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
>> +            DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
>> +            DMI_MATCH(DMI_BIOS_VERSION, "ONDA.D890HBBNR0A"),
>> +        },
>> +    },
>>       {
>>           /* Pipo W2S */
>>           .driver_data = (void *)&pipo_w2s_data,
>>
