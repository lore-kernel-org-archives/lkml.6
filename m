Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeBERm1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:42:27 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:39913 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeBERmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:42:22 -0500
X-Google-Smtp-Source: AH8x224nKVhts2AYTlVqtqK0b8O+25BwEDWp20EIv5tPwh5hSS45E+DrtpoLtA/qRhOUwNsP9CODWBALetAezF7/aCg=
MIME-Version: 1.0
In-Reply-To: <20180205125436.24005-1-thierry.reding@gmail.com>
References: <20180205124750.19305-1-thierry.reding@gmail.com> <20180205125436.24005-1-thierry.reding@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 09:42:21 -0800
X-Google-Sender-Auth: kjSyS7ms78kqZVA3vy87K7TsRTc
Message-ID: <CA+55aFy--bQRDZEUsBfiWhyP+Of3+s4zEcKo1T8cCoAMXBrwsw@mail.gmail.com>
Subject: Re: [PATCH] net: mediatek: Explicitly include pinctrl headers
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:54 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> Include these headers explicitly to avoid the build failure.

I don't think you need to include *both*.

<linux/device.h> used to include just <linux/pinctrl/devinfo.h>.

I'll edit your patches to include just that.
<linux/pinctrl/consumer.h> will come in automatically through it.

             Linus
