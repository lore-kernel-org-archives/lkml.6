Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68554C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BD32075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBKKjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:39:04 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:59153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:39:04 -0500
Received: from [192.168.1.110] ([95.117.94.93]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkHd3-1hLeEh0Apd-00kfcj; Mon, 11 Feb 2019 11:38:54 +0100
Subject: Re: [PATCH 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <1549588593-4856-2-git-send-email-lkml@metux.net>
 <CACRpkdaFJyGYeDZ83LQBG4pr3tgtYPkDQ3RGrrGPM==Sw1vE2w@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <39fe843d-feba-c871-7b2d-407ab3a35082@metux.net>
Date:   Mon, 11 Feb 2019 11:38:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdaFJyGYeDZ83LQBG4pr3tgtYPkDQ3RGrrGPM==Sw1vE2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SlKm76ZLqPF73h/1K42IGrjadtw9MN7TYq/Tbv3tXwFDLiCJt+N
 emExgmoJNsQQu7o4IJykKZiCl40Y3CyYy1NoS7w+u6hsNZk+eAGJjoqpjjKNlW5YUs3TX+6
 /IV3tBibw0PaAzSJ8y05Jy1xeaDaH362S3Dq38lv5DZoC4iTUsflCLvlfOTgNekcsyjPGZc
 HQuVSO/0Yo7oZa6gB/kpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iAcHHGEJKRI=:+31aGUJH6M6JxrNe5gnKjG
 eeGcbArSWISI1OEwmNlej4h6SRA9WhdW1z1CBNyrHvxzVqpWwg7s5cPGAdVoPp4VMJtZ/edON
 aS9x5pnMnn2ULPXVSh2xY0f01xEmtLLe18f9Ul8Tf8Soet80mDaHRsOusf4iVBrnUGsFyz19Y
 d4mjTJ/j7Df5V3etl4qCabnpILTwn8OOKyH0qGmNkcny6+Ie0oCsWh3tW9vQVt2ZeENqYu0Sv
 tj57zuJU+Sup+PdlL5ckAj2tvzFvTZZBu62BAlXMfF0WbWH3Nuj6xBWOV/xPX9IPC6AD4J6cV
 CGxHvZL4ajlJPyTcY/TygZu0zevMbGfnx+2gzYmsJD1sLzTgDck8cxpWOWQ9AFvohMiUkceWz
 7QjWGJZDMUC+QD/tToh0r4xWqwCUvMBfC9hcF3E4qS7wgiulJmTUC0qf1L40ZI3CR6it8P8Qd
 TaI4hN/NTfSimOUL9U0QEAiChkHgPaLKcbBlXxhAM8ZF+Iqk4wAC6u4QD+QN2/uvmGrjornM2
 SELdv4rLcD+wZ4RdzIBCuox2QdArNPQIi7Z7EtrQwqCSHotw9hqQ86hndBnO2IjRyaAPVS0AH
 T6q4m1IYso0pLtgPKVlUZokKMXFLsKRbM8k3EIH76On5OTdcfCXutqe7qrGlRHHpSTwEjTY3Y
 I8FoSLmgdfsJciS2uUuoajtKLG6qJlVigtmkhZXDSW6JxeViMqPp7i0i8COIz7JEKUTjUA4xS
 ulBO7Qm5DFXZcy5hFKhffA+JLvcqROpsiMKH7+HDbq98nJm1FETUj7YsD/s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.19 15:30, Linus Walleij wrote:

Hi,

> Instead of hardcoding the GPIO base and offsets like this, use:
> 
> #include <linux/gpio/machine.h>
> 
> and define a descriptor table using the name of your gpiochip.
> There should be examples of other board quirks doing this.
> I have already patched gpio-leds.c to accept LEDs from
> descriptor tables, see commit
> commit 45d4c6de4e497e5b0026c77044ae5fcddf8fecd8
> "leds: gpio: Try to lookup gpiod from device"

Still trying to understand how that actually works ...

I'm now defining the leds pdata and gpio mapping this way:

static const struct gpio_led apu2_leds[] = {
    { .name = "apu:green:1" },
    { .name = "apu:green:2" },
    { .name = "apu:green:3" }
};

struct gpiod_lookup_table gpios_led_table[] = {
    .dev_id = "leds-gpio.0",
    .table = {
        GPIO_LOOKUP_IDX("gpio.0", 0, "led", 0, GPIO_ACTIVE_LOW),
        GPIO_LOOKUP_IDX("gpio.0", 1, "led", 1, GPIO_ACTIVE_LOW),
        GPIO_LOOKUP_IDX("gpio.0", 2, "led", 2, GPIO_ACTIVE_LOW),
    }
};

But unsure now to determine the correct names for dev_id (the
leds-gpio instance ?) and the gpio chip. In the example, these
seem to be autogenerated - how can I retrieve them from my
actual devices ?

By the way: does that also work with gpio-keys-polled ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
