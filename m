Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FBAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8769222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406270AbfBNJ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:56:33 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:57755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392838AbfBNJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:56:31 -0500
Received: from [192.168.1.110] ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmU9R-1hKRlj2aLB-00iSKR; Thu, 14 Feb 2019 10:56:26 +0100
Subject: Re: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <55cfbefe-5ff7-9f8d-4507-a5a2f9c78d13@metux.net>
Date:   Thu, 14 Feb 2019 10:56:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QVjIZmEC5LhvtDgcf0tbHE85EyZi+yNtzMMffmBgpYa8/KlaKTO
 BvIQXebpAIu690HZFQCV4LYmQQ64krLJuOM2prvcEiQmgYYvOoS01eF5P5L33IpClFwYoX6
 5oMPq38bjvN/gdLlj3+2pus3ysqdNzWZiWv74iusfTEcc0pzQ5O36CKR/QuZvwJN8Yvyd3X
 aecHG6q0HQqeEw/HiYTFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5x4LPMm1YNs=:tSx3bYrocWKoevcmnOEyxl
 FQetDuBcy/6/o0B9EwDvhrgVYFMhP8R1D+J4iClPx9iA3UjllaBt2Q0+PEr8eWPhDj516vow/
 OUvifJ8VlNztr+UAVupaE7LisK8ZrBAex6PbpZ9z1RmaZYjfapLeErHwTt1cgwFKKO70qborX
 Lyu2kdDh/RmxykdBjrhtnneyCVlAI0/vaTdTk0/TRygquqST6uOml0cYx1qAxXTqmFOecvQlR
 xt24mJWdBqQQo3iC4h2cCwXXei+MrRcLyxREiH2GtJccHPOkoNDRvB3UTskMDdP5iPpvYGgIl
 ELp43LLeET6xorPTmLQzQaPSZSNiZzuyl1eEix+HY9v8kPSD81rid9FdZB9Ck4fK5a7c6mMLR
 nF3yVeMTiwY0tysnOGNTl9Ndhws84/3+PEByKXN5TbhFEQ3DY6YCQOi+e12hsj6/+4QB5YEG3
 HGnuSyvWa+v+jOM9/dFgpurMexoG79WIBQdNnH0v/bGgmhcXiBYKRTMC88j9tGeoTtTFHphef
 JizeBPgz5QH4VkrfK+dZghHG4uecvoK2+5IzqkYWMGPlWkH3T9R39Rg0fxkfIDGMlh+agp/S8
 ROnVxrRQz7L/yp5UC4rdHyY/oJYxi/UWDtc4y9DJY7HXDx8htKxXXVb/4jcnQ6QgLd3aaBa2b
 ZQzLf7JPtOL/57bMxtzPkyi2Xo6LnNBg5HJSj1pIhYMsAGR5ODAie3knhyrnl/z7gR54mRyek
 +Ocs9CNR5Qg+dGcS3IeiQbC4yow0ZzAGzo1B5nEV3Ieg9svdPcLKoRzvEz8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.19 15:25, Linus Walleij wrote:

Hi,

>> +config GPIO_AMD_FCH
>> +       tristate "GPIO support for AMD Fusion Controller Hub (G-series SOCs)"
>> +       select GPIO_GENERIC
> 
> You are selecting GPIO_GENERIC, is this necessary? I thought
> X86 was already selecting this.

Doesn't look so - at least haven't found anything where it's
automatically selected on x86. OTOH, that wouldn't make much
sense to me  - I somewhat doubt that x86 can't run w/o that.

Maybe ACPI selects it (haven't checked yet), but my driver is
completely independent from ACPI (the board's BIOS doesn't
provide any useful entries here), ACPI isn't x86 specific
(anymore), and I'd guess x86 boards can run w/o ACPI.
(actually, I'm considering hacking up a completely oftree
based bootup on x86 ;-)).

IMHO, dependencies should always be direct - indirect ones could
suddenly change in subtle ways.

> I think checkpatch will complain on that SPDX thing.
> Copy something from one of the other drivers, it should be
> on the first line of the file.

Yeah, that's a really helpful tool. Maybe I should do some more
automatisation on handling/editing whole patch queues ...
(unless somebody else already did it).

> Cut down the excessive newlines.

Is there some standard rule on this ? Maybe something that checkpatch.pl
could automatically catch ?

>> +static void amd_fch_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
>> +{
>> +       struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
>> +       (void)priv;
>> +
>> +       seq_printf(s, "debug info not implemented yet\n");
>> +}
> 
> I think you can just skip implementing this then.

Yep, forgot to clean that up.

>> +static int amd_fch_gpio_request(struct gpio_chip *chip, unsigned gpio_pin)
>> +{
>> +       if (gpio_pin < chip->ngpio)
>> +               return 0;
>> +
>> +       return -EINVAL;
>> +}
> 
> You can probably skip this too. The core already does this check.

Okay, wasn't sure about that, so I preferred defensive programming.

>> +       priv->gc.owner                  = THIS_MODULE;
>> +       priv->gc.parent                 = &pdev->dev;
>> +       priv->gc.label                  = dev_name(&pdev->dev);
>> +       priv->gc.base                   = priv->pdata->gpio_base;
> 
> No please, use priv->gc.base = -1;

Could I also leave that field untouched (IOW: =0) ?

>> +/*
>> + * struct amd_fch_gpio_reg - GPIO register definition
>> + * @reg: register index
>> + * @name: signal name
>> + */
>> +struct amd_fch_gpio_reg {
>> +    int         reg;
>> +    const char* name;
>> +};
> 
> Can't you put this in the driver file?

See other mails.
Need to pass in the board specific register assignments.

>> +struct amd_fch_gpio_pdata {
>> +    struct resource          res;
>> +    int                      gpio_num;
>> +    struct amd_fch_gpio_reg *gpio_reg;
>> +    int                      gpio_base;
>> +};
> 
> Drop gpio_base. We don't hardcode the GPIO base anymore.

Done. I had to patch gpio-keys-polled driver first.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
