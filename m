Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeC0LzR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:55:17 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:50790 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeC0LzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:55:15 -0400
X-Google-Smtp-Source: AIpwx49cR3DM23NF1udnxqBbnd5YPMXRQirYxsApMl0OI537to7qKEfnnOb0H0EdKFHsknOBhevCpy27WMAAjQm+tBw=
MIME-Version: 1.0
In-Reply-To: <20180315224202.96668-5-dmitry.torokhov@gmail.com>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com> <20180315224202.96668-5-dmitry.torokhov@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 13:55:13 +0200
Message-ID: <CACRpkdaUX8tga=Bt=gjKmxJJE=2_AqFrjow_AmyP_z=4MSK1hA@mail.gmail.com>
Subject: Re: [RFC 4/4] backlight: gpio_backlight: remove platform data support
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

On Thu, Mar 15, 2018 at 11:42 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Legacy boards can use static property sets/GPIO lookup tables to describe
> backlight connections, there is no need to maintain legacy platform data.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Good riddance, this is how all drivers should eventually end up
after full device property conversion I guess.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
