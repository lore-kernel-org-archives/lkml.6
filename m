Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933656AbeCSOlG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:41:06 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:38562 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933327AbeCSOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:41:04 -0400
X-Google-Smtp-Source: AG47ELvCL4y4ZVWIhpK3+RE3VOW8gVfwrwILPAWazZIdGiO2sWMGcBmnymGFbN7Qo3DYPN1dcVQV1A==
Date: Mon, 19 Mar 2018 07:41:01 -0700
From: Tejun Heo <tj@kernel.org>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ata: add Amiga Gayle PATA controller driver
Message-ID: <20180319144101.GH2943022@devbig577.frc2.facebook.com>
References: <CGME20180316161549epcas1p23166605ea9922198486e0c07bd184ed8@epcas1p2.samsung.com>
 <24149929.AaKeg4hYhL@amdc3058>
 <CAOFm3uEb6r33V9=Maxd72pM6vdwfMkvhap01+zEd6bnDuEAVKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uEb6r33V9=Maxd72pM6vdwfMkvhap01+zEd6bnDuEAVKw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Mar 17, 2018 at 10:24:18PM -0700, Philippe Ombredanne wrote:
> > v2:
> > - clarify license version (it should be GPL 2.0)
> > - use SPDX header
> 
> For the use of SPDX ids, you have my ack: (I am not qualified for the rest)
> 
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

I don't think it's a good idea to add this acked-by when it's purely
based on a single liner license tag.  I understand that you want to
encourage use of the new tags but this can be misleading and it'd be
great if you reconsider sending out acks like this.

Thanks.

-- 
tejun
