Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E964AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C084A222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbfBNK5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:57:38 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:38349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfBNK5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:57:38 -0500
Received: from [192.168.1.110] ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MfpGL-1hZu2m0dGT-00gDfe; Thu, 14 Feb 2019 11:57:33 +0100
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
 <39fe843d-feba-c871-7b2d-407ab3a35082@metux.net>
 <CACRpkdajLnMY3w40xx6jNEPqr-DYg2FjNgipt6tNBPgRoTx__w@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <4662508c-01cc-ca84-7241-d28c2719dc63@metux.net>
Date:   Thu, 14 Feb 2019 11:57:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdajLnMY3w40xx6jNEPqr-DYg2FjNgipt6tNBPgRoTx__w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u7Ci8es+0sg8FiwdIHwmmiByBzqU09Y2U5Gc3AaC5oELfqYscTe
 p8qoFsm7Pn6FODvEibzIJFtbX55Nycpz6fNh1fN3yDX5LbJMMJW2gpg7xCya+URglfdFykI
 m1qn8ZSh9PIo41flFijSiFihxD0FAtUF7S2p8qXgJ6cIj16esS/4hJpFNKgvSP0cX64/FpX
 +tmcjlI/f3KSj+2nEYOTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sicNOErR0yY=:+bL76hIvkAZJci3xem4PYB
 sBCwd9dGWLxvtBT6z4mIwj9jJRrqcgm3BR6t3zTK3sTx4U5kkvgXGur9dgiCV0SeuZjQhvm/Y
 zvnNPGdYS+K80tEMN0pwG/ya6sa1Z04medc/f/XDWdM4zI/t/9zFU/vJCZM0M5bZT6TU7Fi7T
 o2jIg8xcmIcGrKNj478sMYQ7ifsdb2oNNCKtZ7yGAalXwJI3gWeSWKrFa2pat2j/1690rrlLb
 nI7DEJiQKROWlNNI/QDmkBiBSE6+9yiMZ/WPjmo+1s41+fFgPRMU34ma0ts/y0trN5kso0yL8
 D4rDJq6/agU+cpeEo/VXbfHN8rWSywRcHEMrdL1cLby9L5TsmAyaLlZIeUC0gUwlVTwX6eLjs
 PcLslia4gfYtIMI7VtRoboT3pjqG7wKUmnQj+GuxOaBskCZl8cV1elcQ4R2tpbteKb6SdEu/r
 3LQTcSZQppX3KobXiC8ka52Wtd0RNijQdUYDnXT+F2xwnM5Ylir9tAuv3wh6iltuUX2xjIUna
 yQxd561wEO8lZ/e8/276JtLc7jRhMhVibfHcQct/3ucp1F2tK/WfyuRqTqNUlEEydMqU+UF6O
 QjY7vtTWGgdsWRxXlHFhFx+i5HdBadR+A8q7RWSKj29YpStP0Ejw+AoyIxJpJFGyH+ASAgniX
 ehE622gEdDN1keD4knI2o8S1XhPT2byzILYiwi93FvNu5dYvs9AEKfPLTtZmQo+y3k+EOpLy4
 ECICma3hbrT7dTlFE/ml3vWn+f4cduf98y6B2oqSHejX4ecccElqNXoJU5U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.19 10:35, Linus Walleij wrote:

> For the dev_id you need to be aware of the following from> <linux/platform_device.h>:> #define PLATFORM_DEVID_NONE     (-1)>
#define PLATFORM_DEVID_AUTO     (-2)>> If the platform device has .id
set to -1 it will be just "leds-gpio",> if it is -2 it will be whatever,
take a chance on .0 or ideally fix> it up. Any positive number like .id
= 4 becomes "leds-gpio.4".> > So figure out the .id field on the
platform device.

Hacked up some debuging into the lookup code and found that it's
just "leds-gpio" and "gpio-keys-polled" in my case. I've just got one
instance of each right now and used PLATFORM_DEVID_NONE.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
