Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeEaGEH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:04:07 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:44953 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeEaGEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:04:04 -0400
X-Google-Smtp-Source: ADUXVKJAsLKE97CBROwh66IciY0JYEkxiPneIZVboMtyA//BXnI0qCGd9bif374Dui9G5mrwePGY/nHvBnxwdvKzpOg=
MIME-Version: 1.0
In-Reply-To: <20180530214938.1073749-1-arnd@arndb.de>
References: <20180530214938.1073749-1-arnd@arndb.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 09:04:01 +0300
Message-ID: <CAHp75VcP=RBpfqN1c0M4Uy639t80sCQ+YidweFmRZSt0J5i37g@mail.gmail.com>
Subject: Re: [PATCH] fb_omap: add gpiolib dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 12:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c: In function 'hdmi_probe_of':
> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c:584:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c: In function 'hdmi_probe_of':
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:554:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]

> Rather than fixing up each one individually, this just marks all of it
> as depending on GPIOLIB.

Hmm... But the OF stuff is not part of GPIOLIB.

-- 
With Best Regards,
Andy Shevchenko
