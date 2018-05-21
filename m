Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeEUVg7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:36:59 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35475 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbeEUVgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:36:54 -0400
X-Google-Smtp-Source: AB8JxZoEVGGO3XDPyg1XDGN91n2H5kr/2DA0cdfBM4aEpjyWi6J9qnu7ujzpqeHRSbn6Hz4LaBXz9xXRbDdX0MM8OEo=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-5-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-5-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 00:36:53 +0300
Message-ID: <CAHp75Vcxh5kf=mivmWN4aWPJc+9e5VPRjKPtBWNatrYEYt_07g@mail.gmail.com>
Subject: Re: [PATCH 04/33] gpiolib-of: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>

https://patchwork.ozlabs.org/patch/908134/

> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>


-- 
With Best Regards,
Andy Shevchenko
