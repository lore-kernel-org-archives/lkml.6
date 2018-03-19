Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeCSOmO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:42:14 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:45868 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755194AbeCSOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:42:09 -0400
X-Google-Smtp-Source: AG47ELvKw/4cgOhtvQe0zkeRupiftjqii8HlhuY4YlIFB1rfC0PC4+3+rDC2Jl8y9KTh85IYNPzSJQ==
Date: Mon, 19 Mar 2018 07:42:06 -0700
From: Tejun Heo <tj@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: add Amiga Gayle PATA controller driver
Message-ID: <20180319144206.GI2943022@devbig577.frc2.facebook.com>
References: <CGME20180316161549epcas1p23166605ea9922198486e0c07bd184ed8@epcas1p2.samsung.com>
 <24149929.AaKeg4hYhL@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24149929.AaKeg4hYhL@amdc3058>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 05:15:47PM +0100, Bartlomiej Zolnierkiewicz wrote:
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

Applied to libata/for-4.17.

Thanks, Bart.

-- 
tejun
