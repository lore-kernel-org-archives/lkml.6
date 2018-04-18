Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDRI4e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:56:34 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:38087 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeDRI4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:56:31 -0400
X-Google-Smtp-Source: AIpwx4+40K2aXcfz+faZPpyRgd6BQzkrcQIjqjd6kl1bSFjTd1x5SWn4STxM1nDCPWhkcsS1jYQP8n3YLGnK+1PNOF8=
MIME-Version: 1.0
In-Reply-To: <14b8384d-707d-42b7-b3ac-1ad914997a2e@ti.com>
References: <20180417173038.25510-1-brgl@bgdev.pl> <20180417173038.25510-7-brgl@bgdev.pl>
 <14b8384d-707d-42b7-b3ac-1ad914997a2e@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Apr 2018 10:56:30 +0200
Message-ID: <CAMRc=Mfj=M2a8Dw1SCzc4DBG6B+B8gbkr9DKaaSKiEs9hN6Bag@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] remoteproc/davinci: use the reset framework
To: Sekhar Nori <nsekhar@ti.com>
Cc: Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-18 7:44 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 17 April 2018 11:00 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Switch to using the reset framework instead of handcoded reset routines
>> we used so far.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Looks good!
>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>
> This depends on DaVinci gaining common clock / reset framework support
> though. I am guessing remoteproc maintainers will have to be reminded
> when its safe to apply.
>
> Thanks,
> Sekhar

Right, I assume you plan to apply the platform & DT patches from David
for 4.18? We can then provide an immutable branch to remoteproc
maintainers.

Bart
