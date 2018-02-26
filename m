Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeBZJp2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:45:28 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34094 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeBZJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:45:25 -0500
X-Google-Smtp-Source: AG47ELvub99D5U7VDrIs8vgOgs3coKPHsdJ4DrBlOcmLQzKZ6sgOY2GEiZfDvAymyPzcrvsEtv+B2siG4zDgDfUMgnE=
MIME-Version: 1.0
In-Reply-To: <20180127235140.D559728CE0@kvm5.telegraphics.com.au>
References: <20180127235140.D559728CE0@kvm5.telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 10:45:24 +0100
X-Google-Sender-Auth: Lsbh_L2VACDuzfFIKXhkj8L0440
Message-ID: <CAMuHMdWP60BhcUNBWBjJZ5o_zrNxxWEAXiJhbRj3iuM2-G4MMw@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Enable PDMA support for PowerBook 190
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2018 at 12:51 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Stan's tests showed that PDMA improves sequential read performance by
> a factor of 5 on a PowerBook 190. Last time I tried this on a
> PowerBook 520 it didn't work, so let's not enable it there until
> it can be tested with the present mac_scsi driver.
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queue for v4.17.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
