Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030863AbeBNOfG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:35:06 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37164 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030600AbeBNOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:35:05 -0500
X-Google-Smtp-Source: AH8x2251hdPBtbc5x6ghArvIDmruQRDfKpbw45rA2aNS3i7TewRcoIEeZKX2a+laHyspifGSpoXNHOIi6nRgNU8lFX8=
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1802141628110.25362@math.ut.ee>
References: <alpine.LRH.2.21.1802132200260.24929@math.ut.ee> <alpine.LRH.2.21.1802141628110.25362@math.ut.ee>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Wed, 14 Feb 2018 09:35:04 -0500
X-Google-Sender-Auth: wbuMz4ENAgPi6oeosW8f3YA1xJo
Message-ID: <CAKb7Uvj3MKGzNNcrc=-JA5GN4jt9+TU7ZjWDZpccmYJLDo76WQ@mail.gmail.com>
Subject: Re: [Nouveau] 4.16-rc1: UBSAN warning in nouveau/nvkm/subdev/therm/base.c
 + oops in nvkm_therm_clkgate_fini
To: Meelis Roos <mroos@linux.ee>
Cc: nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 9:29 AM, Meelis Roos <mroos@linux.ee> wrote:
>> This is 4.16-rc1+todays git on a lowly P4 with NV5, worked fine in 4.15:
>
> NV5 in another PC (secondary card in x86-64) made the systrem crash on
> boot, in nvkm_therm_clkgate_fini.

Mind booting with nouveau.debug=trace? That should hopefully tell us
more exactly which thing is dying. If you have a cross-compile/distcc
setup handy, a bisect may be even more useful.

It's funny, I had a NV5 plugged into my desktop for testing, and
*just* took it out (because the box wouldn't even get to BIOS anymore
... although it was unrelated to the NV5, probably just something
mis-seated.)

  -ilia
