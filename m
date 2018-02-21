Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeBUTJv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:09:51 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38989 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeBUTJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:09:49 -0500
X-Google-Smtp-Source: AH8x227Q/01w30W4sRPPYD4CQWmLdUiVT8/v6pWd7Rxu6V8jrxcBUHOPWRnGA3V164pL96ZIT8VqB+/T8oaIkDCaZZM=
MIME-Version: 1.0
In-Reply-To: <20180221144909.13461-1-enric.balletbo@collabora.com>
References: <20180221144909.13461-1-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 21:09:48 +0200
Message-ID: <CAHp75VdbEYRZvm_xbrwH4+9VQYbJ9MooJ53fLqE7927b2eS7pw@mail.gmail.com>
Subject: Re: [PATCH 0/3] platform/chrome: cros_ec debugfs and sysfs updates
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 4:49 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Hi,
>
> This patchset is another recopilation of some patches that were send
> before but never merged.
>
> First patch was already sent [1] but did not receive feedback so I am
> resending it. Needs to go throught platform/chrome tree and can be
> picked without dependencies.
>
> The second patch is new, like the first needs to go throught
> platform/chrome tree and can be picked without dependecies.
>
> Finally, the third patch was already sent [2] but now needed to be
> reworked due the split of the cros_ec_devs in 2 parts [3]. This patch
> touches platform/chrome and mfd so we will probably need an immutable
> branch when is ok.
>

New patches should have a tag, but there is, I hope, no need to resend
and maintainers would add them as I posted.

The rest looks good to me, FWIW,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Best regards,
>   Enric
>
> [1] https://patchwork.kernel.org/patch/9894655/
> [2] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1488891.html
> [3] https://lkml.org/lkml/2017/11/20/408
>
> Gwendal Grignou (2):
>   platform/chrome: cros_ec_sysfs: Modify error handling
>   platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wake
>     lid angle
>
> Shawn Nematbakhsh (1):
>   platform/chrome: cros_ec_debugfs: Add PD port info to debugfs
>
>  drivers/mfd/cros_ec_dev.c                 |  19 +++---
>  drivers/platform/chrome/cros_ec_debugfs.c |  86 ++++++++++++++++++++++--
>  drivers/platform/chrome/cros_ec_sysfs.c   | 108 ++++++++++++++++++++++++------
>  include/linux/mfd/cros_ec.h               |   1 +
>  4 files changed, 180 insertions(+), 34 deletions(-)
>
> --
> 2.16.1
>



-- 
With Best Regards,
Andy Shevchenko
