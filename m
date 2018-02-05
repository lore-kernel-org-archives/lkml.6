Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeBEL4L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:56:11 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:55857 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbeBEL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:56:05 -0500
X-Google-Smtp-Source: AH8x224L0S/OTfKANZBVUtuo6vXnHH3mHia5KujKHCQw2FXyWZU9tA5+9BAgfZlae6KsLrjnpFfYXAlXyGT5b2/l/ic=
MIME-Version: 1.0
In-Reply-To: <20180205084755.6011-1-ludovic.desroches@microchip.com>
References: <20180205084755.6011-1-ludovic.desroches@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Feb 2018 12:56:04 +0100
Message-ID: <CACRpkdajUDNkODAGU=6SHRJz-q5-+sFRy7Qi9=QLc-HF1NEHWQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO descriptors
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fbdev@vger.kernel.org,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 9:47 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Use GPIO descriptors instead of relying on the old method.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Ah there it is :D
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

PS: why not move it all over to use DRI/DRM/KMS? It's becoming
easier and easier.

Yours,
Linus Walleij
