Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeCRFZC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 01:25:02 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35133 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeCRFY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 01:24:59 -0400
X-Google-Smtp-Source: AG47ELs3VJt3rKGskBjT47t/E/rVIaMiuif+Bi/56PKqQb6WsySqkoDJrUdyOWes3vPnsgfZmH1dxPOPPblGpo3sPjs=
MIME-Version: 1.0
In-Reply-To: <24149929.AaKeg4hYhL@amdc3058>
References: <CGME20180316161549epcas1p23166605ea9922198486e0c07bd184ed8@epcas1p2.samsung.com>
 <24149929.AaKeg4hYhL@amdc3058>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sat, 17 Mar 2018 22:24:18 -0700
Message-ID: <CAOFm3uEb6r33V9=Maxd72pM6vdwfMkvhap01+zEd6bnDuEAVKw@mail.gmail.com>
Subject: Re: [PATCH v3] ata: add Amiga Gayle PATA controller driver
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 9:15 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Add Amiga Gayle PATA controller driver. It enables libata support
> for the on-board IDE interfaces on some Amiga models (A600, A1200,
> A4000 and A4000T) and also for IDE interfaces on the Zorro expansion
> bus (M-Tech E-Matrix 530 expansion card).
>
> Thanks to John Paul Adrian Glaubitz and Michael Schmitz for help
> with testing the driver.
>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v3:
> - fix minor issues reported by Andy
>
> v2:
> - clarify license version (it should be GPL 2.0)
> - use SPDX header

For the use of SPDX ids, you have my ack: (I am not qualified for the rest)

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
