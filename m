Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeEGHIp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:08:45 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:34787 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeEGHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:08:44 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Linux/m68k <linux-m68k@vger.kernel.org>,
        Debian m68k <debian-68k@lists.debian.org>
Subject: Re: moving affs + RDB partition support to staging?
Date: Mon, 07 May 2018 09:08:41 +0200
Message-ID: <4217788.NhxQeTpgEt@merkaba>
In-Reply-To: <CAOmrzkLAm99UTkzV0n+rtLg4XTrxHrCkR1ccitsyhf6XLztkpA@mail.gmail.com>
References: <20180425154602.GA8546@bombadil.infradead.org> <20180507021554.GN30522@ZenIV.linux.org.uk> <CAOmrzkLAm99UTkzV0n+rtLg4XTrxHrCkR1ccitsyhf6XLztkpA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Schmitz - 07.05.18, 04:40:
> Al,
> 
> I don't think there is USB sticks with affs on them as yet. There
> isn't even USB host controller support for Amiga hardware (yet).
> 
> Last I tried USB on m68k (Atari, 060 accelerator) the desktop
> experience was such that I'd rather not repeat that in a hurry (and
> that was a simple FAT USB stick).

There is USB support available on Amiga since a long time.

On "Classic" Amigas AmigaOS 3.x with Poseidon USB stack + some USB card.

On AmigaOS 4.x built-in. AmigaOS 4.x hardware like Sam boards from Acube 
Systems have USB controllers that work out of the bux.

And I am pretty sure, you can also tell it to use Amiga Fast Filesystem 
(on Linux affs) on an USB stick. Also you can plug in an external 
harddisk with RDB partitions and whatever filesystems you wish.

Thanks,
-- 
Martin
