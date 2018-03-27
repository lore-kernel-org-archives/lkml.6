Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeC0Lx2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:53:28 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:37753 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeC0Lx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:53:26 -0400
X-Google-Smtp-Source: AG47ELuz2UA7k/HypSGBp5rQEV4dokUNQoQVXjfE2sq/3U8ZP2rSrVwbLn6AiGFxdzDah+8sWjWk2OzAtfWlb/0kBG8=
MIME-Version: 1.0
In-Reply-To: <20180315224202.96668-2-dmitry.torokhov@gmail.com>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com> <20180315224202.96668-2-dmitry.torokhov@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 13:53:25 +0200
Message-ID: <CACRpkdaUk-x3tFrrONhVT0opHgkWW_-yyz1165o22=tQ48uS5g@mail.gmail.com>
Subject: Re: [RFC 1/4] backlight: gpio_backlight: use generic device properties
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Instead of using of_property_read_bool() switch to using
> device_property_read_bool() This will allow switching from platform data to
> device properties everywhere.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
