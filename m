Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeBELyq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:54:46 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:37598 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbeBELya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:54:30 -0500
X-Google-Smtp-Source: AH8x224JVSuze0HB1LrIpiXaeLMY1Lsr6QTWqox2w3BWETEFtO8SmiQq8VWnpHGmJnQqRs08ZwLnkV8o2GrEo14S4PU=
MIME-Version: 1.0
In-Reply-To: <20180205082335.5727-1-ludovic.desroches@microchip.com>
References: <20180205082335.5727-1-ludovic.desroches@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Feb 2018 12:54:29 +0100
Message-ID: <CACRpkdbg1gXJigiPp9Ee0D0gyif-crsuBf9R93e9jJ-mjDkLug@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: convert to use GPIO descriptors
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

On Mon, Feb 5, 2018 at 9:23 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Use GPIO descriptors instead of relying on the old method.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

The subject should probably indicate that you're patching the
Atmel driver. Anyways:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for doing this.
Linus Walleij
