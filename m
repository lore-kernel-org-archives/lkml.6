Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeBWQ06 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:26:58 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35507 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeBWQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:26:56 -0500
X-Google-Smtp-Source: AG47ELsPQ9pFRWephbTL9yhYnqy/owIcVEMqfSxO0dHYpzR98+e+kb80wvHmhXudQCtdvxtRyBd+HycmDFDGYnwzbQI=
MIME-Version: 1.0
In-Reply-To: <20180223151122.11567-3-enric.balletbo@collabora.com>
References: <20180223151122.11567-1-enric.balletbo@collabora.com> <20180223151122.11567-3-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 18:26:54 +0200
Message-ID: <CAHp75Vd9DsYs7rLuxb6r+Jt7DcZ_6tD-XJVG6qL52XWGRszang@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] mfd: cros_ec_i2c: add ACPI module device table
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 5:11 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Wei-Ning Huang <wnhuang@google.com>
>
> Add ACPI module device table for matching cros-ec devices to load the
> cros_ec_i2c driver automatically.

> +static const struct acpi_device_id cros_ec_i2c_acpi_id[] = {
> +       { "GOOG0008", 0 },
> +       { },

Please, avoid commas in terminator entries.

> +};

-- 
With Best Regards,
Andy Shevchenko
