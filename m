Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034465AbeCBQxK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:53:10 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41769 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034452AbeCBQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:53:09 -0500
X-Google-Smtp-Source: AG47ELsfFnMkihNYI1fvXRnXWJI2iaN5t3cQbsPeGxKVeYAbtTB4KgJFKiN3De2gHIF8rrhzG+Y9+/MGuaoAgLZihmE=
MIME-Version: 1.0
In-Reply-To: <05da18fe-1e45-43db-f6d3-e4f6d50f3296@infradead.org>
References: <05da18fe-1e45-43db-f6d3-e4f6d50f3296@infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Mar 2018 17:52:48 +0100
Message-ID: <CANiq72n2nNuQaRPpWORBYEvocLE--KcTP2eTeMcDzRXCUOEKHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay: make PANEL a menuconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 3:33 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> This change makes xconfig present the PANEL drivers immediately
> following the AUXDISPLAY drivers instead of under the major menu
> item "Device Drivers". It also unclutters the Device Drivers menu in
> nconfig and menuconfig by moving the PANEL drivers to a sub-menu.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Picking it up.

Cheers,
Miguel

> ---
>  drivers/auxdisplay/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20180228.orig/drivers/auxdisplay/Kconfig
> +++ linux-next-20180228/drivers/auxdisplay/Kconfig
> @@ -166,7 +166,7 @@ config ARM_CHARLCD
>
>  endif # AUXDISPLAY
>
> -config PANEL
> +menuconfig PANEL
>         tristate "Parallel port LCD/Keypad Panel support"
>         depends on PARPORT
>         select CHARLCD
>
>
