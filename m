Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeBZLis (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:38:48 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:41553 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeBZLiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:38:46 -0500
X-Google-Smtp-Source: AG47ELsxGFRvOt/rHCGVJKoONHAu+uZanOivPDZvuEWr4QXbFr6FO0zQejRjjogB8UUAMpJxgIYD7jEkVG1+ovSf5bE=
MIME-Version: 1.0
In-Reply-To: <20180226102606.15093-8-enric.balletbo@collabora.com>
References: <20180226102606.15093-1-enric.balletbo@collabora.com> <20180226102606.15093-8-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 13:38:45 +0200
Message-ID: <CAHp75VfzCQf6JNk6v7iwoPq3g208zN=QT2-VydA3rJHtuQsjag@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mfd: cros_ec_i2c: add ACPI module device table
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, groeck@chromium.org,
        kernel@collabora.com, Gwendal Grignou <gwendal@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:26 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Wei-Ning Huang <wnhuang@google.com>
>
> Add ACPI module device table for matching cros-ec devices to load the
> cros_ec_i2c driver automatically.

> - [7/8] Avoid commas in terminator entries.

>         { /* sentinel */ },

Still comma.
Though this is minor and old code, I guess no need to resend b/c of this one.

-- 
With Best Regards,
Andy Shevchenko
