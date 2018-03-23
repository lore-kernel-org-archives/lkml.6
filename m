Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeCWDBT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:01:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46927 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCWDBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:01:17 -0400
X-Google-Smtp-Source: AG47ELvvv747N++gHSHYjyGU3hkozgLGJgdg2ivArBcJPHhGNYVF1u5V+aJsNmJ0hjUifEDGYYzTq6RYA2zQMIxIv5Q=
MIME-Version: 1.0
In-Reply-To: <1519077427-30165-1-git-send-email-david@lechnology.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Mar 2018 04:01:16 +0100
Message-ID: <CACRpkdanFFwPBhkDNRTdns9cPebH3drBZNhqZLBzF78U3XdRgw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
To: David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:

> This fixes pcs_request_gpio() in the pinctrl-single driver when
> bits_per_mux != 0. It appears this was overlooked when the multiple
> pins per register feature was added.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>
> v2 changes:
> - don't wrap Fixes: line in commit message since it is a special machine-
>   readable line.

Tony/Haojian: are you OK with this change?

Yours,
Linus Walleij
