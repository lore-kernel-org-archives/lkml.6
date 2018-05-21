Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeEUVfI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:35:08 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38085 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbeEUVfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:35:05 -0400
X-Google-Smtp-Source: AB8JxZosZWTZ2NWcAN23ZuJlhOA5yiGEXvSeG5XCmQmXoJSqVfKRhaYGwbo8HkS/3n8Rp1NW3IupU9q1ZVErPX8JK3U=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-4-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-4-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 00:35:04 +0300
Message-ID: <CAHp75VcN1nppGrZUpTM2QphiaVkWSkXv2V5P6Vnjo4+H46sDiw@mail.gmail.com>
Subject: Re: [PATCH 03/33] Staging: gdm724x: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.


> +       ret = match_string((const char **)DRIVER_STRING,
> +                          TTY_MAX_COUNT, tty->driver->driver_name);

It looks like DRIVER_STRING should be converted to const * const.

-- 
With Best Regards,
Andy Shevchenko
