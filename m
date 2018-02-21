Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966081AbeBUPYi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:24:38 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36959 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936132AbeBUPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:24:35 -0500
X-Google-Smtp-Source: AG47ELt+I2LKvlGuiBx4Vv1ymReuE521lpMcZB2I3SXUFZoHXtZAe8YNlgiylafdnnpcqTSUGVWzmgXJKGFds8cAcEA=
MIME-Version: 1.0
In-Reply-To: <f5dd2db62302ce21ed3234125924dfd81e123749.1519225570.git.gdouezangrard@gmail.com>
References: <cover.1519225570.git.gdouezangrard@gmail.com> <f5dd2db62302ce21ed3234125924dfd81e123749.1519225570.git.gdouezangrard@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 17:24:34 +0200
Message-ID: <CAHp75VeMZc5M_a13gz6NJcMjvBzZsT_Lp5ubiMHDfjKX7SKfAw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] platform/x86: topstar-laptop: update copyright and
 fix some comments
To: =?UTF-8?Q?Guillaume_Dou=C3=A9zan=2DGrard?=
        <gdouezangrard@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LFOg8A021029

On Wed, Feb 21, 2018 at 5:13 PM, Guillaume Douézan-Grard
<gdouezangrard@gmail.com> wrote:

Commit message?

AFAICS,
"Add myself as an author of the driver."

> Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>

>  /*
> - * ACPI driver for Topstar notebooks (hotkeys support only)
> + * Topstar Laptop ACPI Extras driver

This should go to the patch which does the actual extension.


>   * Copyright (c) 2009 Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> + * Copyright (c) 2018 Guillaume Douézan-Grard
>   *
>   * Implementation inspired by existing x86 platform drivers, in special
> - * asus/eepc/fujitsu-laptop, thanks to their authors
> + * asus/eepc/fujitsu-laptop, thanks to their authors.
>   *

>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as

If you want, you can consider to do another one to switch to SDPX identifier.

>  MODULE_AUTHOR("Herton Ronaldo Krzesinski");
> +MODULE_AUTHOR("Guillaume Douézan-Grard");

-- 
With Best Regards,
Andy Shevchenko
