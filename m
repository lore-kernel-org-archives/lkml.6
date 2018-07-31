Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE06208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE06208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeGaNdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:33:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51197 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbeGaNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:33:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so2767536wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gZk6LpZTGMYtPvq5oDxXMRxh0xCZqL08SRXI/CBtot4=;
        b=ir0Z6fulUyYq+MCYtVYzGWtL3JW7NnOImeAeOOFJ8QmOq5rcTNJnZieUIIe9QYrWeI
         2E9fOOEl4Pn0gpcRrPRHFsReJxogySsaTrjXUfWwpSQhxKosoOdJ6/ntlgdhV3EyHbow
         gDhMwP3Te1AMhWal2UCDooDv21C9HuKQEWYgqr2n6BR7lIzfrvnekKo3fc5WuucyhYux
         zk6IEmg1Yvhj4dRxjVwMkGC7IPMXIH37u7pwUoi5Rtp9vXsdTnfBDy4Plmf9LyQx7Ec8
         lQeuDoZOm358ojeXnlXZuMUhwT59YZqxW2DEbZ9qo6p4d0fBzjTvASkwOyX6/duQ7Jxn
         1VLg==
X-Gm-Message-State: AOUpUlEy08s6FHcu2UWRILHKF65CZQYqH+TBiZ8wq08jp9LQEutN1PoG
        RvlQavulsQwwRDpGXso3NCa8Tg==
X-Google-Smtp-Source: AAOMgpeS5B2+AmZRwhYRDTu14R3zqFoZ/AODgL98XAUJQx42NDepPes2dRvTvzavItrMZGtRyIUwaw==
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr2037287wmi.16.1533038033040;
        Tue, 31 Jul 2018 04:53:53 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r12-v6sm1905921wmc.27.2018.07.31.04.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:53:52 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Cube
 KNote i1101 tablet
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        youling257 <youling257@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
References: <20180731093256.30533-1-youling257@gmail.com>
 <CAHp75Vfp+EZjt_bg3iieKG0NPBvqzURXKh97D4=ULrKnbE4mvQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0cc13519-2a5d-e6a9-9fd0-17fd6bb119b0@redhat.com>
Date:   Tue, 31 Jul 2018 13:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfp+EZjt_bg3iieKG0NPBvqzURXKh97D4=ULrKnbE4mvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-07-18 13:32, Andy Shevchenko wrote:
> On Tue, Jul 31, 2018 at 12:32 PM, youling257 <youling257@gmail.com> wrote:
>> Add touchscreen info for the Cube KNote i1101 tablet.
>>
> 
> Thanks for the patch.
> Unfortunately I can't take it w/o SoB line. If Hans volunteering to
> give a such again, I guess we're fine.

Yes you can add my:

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Like last time, or do you want me to resend this with it added?

Regards,

Hans


> 
>> Reported-and-tested-by: lkongl <lkongl@163.com>
>> ---
>>   drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
>> index 85e425420da2..cb204f973491 100644
>> --- a/drivers/platform/x86/touchscreen_dmi.c
>> +++ b/drivers/platform/x86/touchscreen_dmi.c
>> @@ -117,6 +117,22 @@ static const struct ts_dmi_data cube_iwork8_air_data = {
>>          .properties     = cube_iwork8_air_props,
>>   };
>>
>> +static const struct property_entry cube_knote_i1101_props[] = {
>> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 20),
>> +       PROPERTY_ENTRY_U32("touchscreen-min-y",  22),
>> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1961),
>> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1513),
>> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-cube-knote-i1101.fw"),
>> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>> +       { }
>> +};
>> +
>> +static const struct ts_dmi_data cube_knote_i1101_data = {
>> +       .acpi_name      = "MSSL1680:00",
>> +       .properties     = cube_knote_i1101_props,
>> +};
>> +
>>   static const struct property_entry dexp_ursus_7w_props[] = {
>>          PROPERTY_ENTRY_U32("touchscreen-size-x", 890),
>>          PROPERTY_ENTRY_U32("touchscreen-size-y", 630),
>> @@ -458,6 +474,16 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>>                          DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>>                  },
>>          },
>> +       {
>> +               /* Cube KNote i1101 */
>> +               .driver_data = (void *)&cube_knote_i1101_data,
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
>> +                       DMI_MATCH(DMI_BOARD_NAME, "L1W6_I1101"),
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "ALLDOCUBE"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "i1101"),
>> +               },
>> +       },
>>          {
>>                  /* DEXP Ursus 7W */
>>                  .driver_data = (void *)&dexp_ursus_7w_data,
>> --
>> 2.18.0
>>
> 
> 
> 
