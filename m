Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeDRIDu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:03:50 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37903 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeDRIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:03:47 -0400
X-Google-Smtp-Source: AB8JxZpE12T6mc0kercuDA414O7FFTYnaDhdGYHFBgLFKYrlfWjJ9DVvMGOWOjgzwDwVmf9h6Qx6wiRNd1vL5l5UgJ0=
MIME-Version: 1.0
In-Reply-To: <a0c390ae-53fe-5d17-1ebf-d55e805f4118@ti.com>
References: <20180417173038.25510-1-brgl@bgdev.pl> <20180417173038.25510-5-brgl@bgdev.pl>
 <a0c390ae-53fe-5d17-1ebf-d55e805f4118@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Apr 2018 10:03:46 +0200
Message-ID: <CAMRc=Md_BaaV1UedisxnvXx0eopEAOj5zF3rox775NUHcf5qJg@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] remoteproc/davinci: prepare and unprepare the
 clock where needed
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

2018-04-18 7:27 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 17 April 2018 11:00 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We're currently switching the platform to using the common clock
>> framework. We need to explicitly prepare and unprepare the rproc
>> clock.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Acked-by: Suman Anna <s-anna@ti.com>
>> Reviewed-by: David Lechner <david@lechnology.com>
>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>
> This should be safe to apply to v4.17-rc1 as well (for inclusion in v4.18).
>
> Bartosz, I noticed that CONFIG_REMOTEPROC and the DA8XX driver is not
> enabled in davinci_all_defconfig. Can you please send a patch enabling
> that too?
>
> Thanks,
> Sekhar

Sure, will do.

Bart
