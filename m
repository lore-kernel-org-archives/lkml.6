Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBRQSO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 11:18:14 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:42257 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbeBRQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 11:18:10 -0500
Subject: Re: [PATCH] ata: add Amiga Gayle PATA controller driver
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3@epcas2p3.samsung.com>
 <2188399.T539WJDZNr@amdc3058>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <19df19ad-47e8-1f17-6b7f-39365cd0d4df@physik.fu-berlin.de>
Date: Sun, 18 Feb 2018 17:18:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2188399.T539WJDZNr@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 93.193.85.66
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02/12/2018 02:49 PM, Bartlomiej Zolnierkiewicz wrote:
> Add Amiga Gayle PATA controller driver. It enables libata support
> for the on-board IDE interfaces on some Amiga models (A600, A1200,
> A4000 and A4000T) and also for IDE interfaces on the Zorro expansion
> bus (M-Tech E-Matrix 530 expansion card).
> 
> Thanks to John Paul Adrian Glaubitz and Michael Schmitz for help
> with testing the driver.

Is there any progress on this? Is it just the SDPX headers now that
are missing?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
