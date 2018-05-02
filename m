Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeEBSgt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:36:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34880 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeEBSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:36:47 -0400
X-Google-Smtp-Source: AB8JxZp0rL3zQeyZhQiDtmaYlPsPThspFtxRg1KlaQO963b7zHP/oBqiCsW3ZKxVkWu8SEgpf7GSQA==
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - add missing compatible strings
 to OF device table
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-input@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Dyer <nick@shmanahar.org>, Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <20180410095340.24074-1-javierm@redhat.com>
 <20180501184853.GB52077@dtor-ws>
 <CAL_JsqJ-UTGrPm2tiS1yVFweWB_LH2JSBpOpMtogTYFi7pCsGA@mail.gmail.com>
 <20180501205713.GA130399@dtor-ws>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <79d51c87-65c8-8cb6-039c-933b114e86cb@redhat.com>
Date: Wed, 2 May 2018 20:36:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501205713.GA130399@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 05/01/2018 10:57 PM, Dmitry Torokhov wrote:
> From: Javier Martinez Canillas <javierm@redhat.com>
> 
> Commit af503716ac14 ("i2c: core: report OF style module alias for devices
> registered via OF") fixed how the I2C core reports the module alias when
> devices are registered via OF.
> 
> But the atmel_mxt_ts driver only has an "atmel,maxtouch" compatible in its
> OF device ID table, so if a Device Tree is using a different one, autoload
> won't be working for the module (the matching works because the I2C device
> ID table is used as a fallback).
> 
> So add compatible strings for each of the entries in the I2C device table.
> 
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [dtor: document which compatibles are deprecated and should not be used]
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks for taking care of this. Yes, I should had added as deprecated indeed.

Best regards,
Javier
