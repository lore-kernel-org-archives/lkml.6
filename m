Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeBWQ2p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:28:45 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44378 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeBWQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:28:39 -0500
X-Google-Smtp-Source: AG47ELsS+dWlSCdJHWhRQf7KNSRsuSxqDujpbV82TkBwfHPYXC6ySRZo0jBXH5/xVbtOfe9SKRc9Kib8MRlmOyY+9QM=
MIME-Version: 1.0
In-Reply-To: <20180223150605.10417-1-enric.balletbo@collabora.com>
References: <20180223150605.10417-1-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 18:28:38 +0200
Message-ID: <CAHp75VfJUkcSXrqiQ_E3Ti70GxTXO76COBgG7LehHy4N637dGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] mfd: cros_ec: add subdevices and fixes
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 5:05 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Hi,
>
> This is a second version of a patchset that collects some patches
> already send but that needed some rework due the patchset to split the
> cros_ec_devs modules in 2 parts [1]. This patchset contains some of
> imrpovements and also some fixes. They can be applied independently
> and I think that all can go through the MFD tree.

After addressing the minor issues I found, feel free to add

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Best regards,
>  Enric
>
> Changes in v2:
> - [2/8] Remove the free_irq in cros_ec_remove.
> - [3/8] That patch is new in this series.
> - [4/8] Add the Reviewed-by Gwendal.
> - [5/8] Add the Reviewed-by Gwendal.
> - [6/8] This patch is new in this series.
> - [7/8] Add the Reviewed-by Gwendal.
> - [8/8] This patch is new in this series replacing [5/6] of v1.
>
> Daniel Hung-yu Wu (1):
>   mfd: cros_ec_dev: register shutdown function for debugfs
>
> Douglas Anderson (1):
>   mfd: cros_ec: Don't try to grab log when suspended
>
> Enric Balletbo i Serra (1):
>   mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice.
>
> Joseph Lo (1):
>   mfd: cros_ec_i2c: moving the system sleep pm ops to late
>
> Thierry Escande (1):
>   mfd: cros_ec_dev: Register cros_ec_accel_legacy driver as a subdevice.
>
> Vincent Palatin (2):
>   mfd: cros_ec: fail early if we cannot identify the EC
>   mfd: cros_ec: free IRQ automatically
>
> Wei-Ning Huang (1):
>   mfd: cros_ec_i2c: add ACPI module device table
>
>  drivers/mfd/cros_ec.c                     | 26 ++++-----
>  drivers/mfd/cros_ec_dev.c                 | 87 +++++++++++++++++++++++++++++++
>  drivers/mfd/cros_ec_i2c.c                 | 17 +++++-
>  drivers/platform/chrome/cros_ec_debugfs.c | 20 +++++++
>  include/linux/mfd/cros_ec.h               |  2 +
>  5 files changed, 135 insertions(+), 17 deletions(-)
>
> --
> 2.16.1
>



-- 
With Best Regards,
Andy Shevchenko
