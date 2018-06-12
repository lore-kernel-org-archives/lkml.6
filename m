Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB6ECC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6274D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6274D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933510AbeFLNEa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:04:30 -0400
Received: from gloria.sntech.de ([95.129.55.99]:54030 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932565AbeFLNE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:04:29 -0400
Received: from wd0830.dip.tu-dresden.de ([141.76.111.62] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fSiyH-0000P6-0G; Tue, 12 Jun 2018 15:04:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Olof Johansson <olof@lixom.net>, ARM SoC <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL 2/4] ARM: Device-tree updates
Date:   Tue, 12 Jun 2018 15:04:19 +0200
Message-ID: <1628804.nlB6U0QxHY@phil>
In-Reply-To: <CA+55aFy2sOHqcO-6LaKOZ5omyAow15gq+=Z7aOTZisrDihoecw@mail.gmail.com>
References: <20180612000142.28883-1-olof@lixom.net> <20180612000142.28883-3-olof@lixom.net> <CA+55aFy2sOHqcO-6LaKOZ5omyAow15gq+=Z7aOTZisrDihoecw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. Juni 2018, 03:04:34 CEST schrieb Linus Torvalds:
> On Mon, Jun 11, 2018 at 5:02 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > - Qualcomm:
> > + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
> > (Cortex-A75/A55 derivative) SoC that's one of the current high-end
> > mobile SoCs.
> >
> > It's great to see mainline support for it. So far, you
> > can't do much with it, since a lot of peripherals are not yet in the
> > DTs but driver support for USB, GPU and other pieces are starting to
> > trickle in. This might end up being a well-supported SoC upstream if
> > the momentum keeps up.
> 
> Isn't the Qualcomm 845 also the SoC in some of the new WARM laptops?
> 
> I asked one person that had an older one (ASUS NovaGo - Qualcomm 835),
> and apparently you can actually disable secure boot on that thing and
> boot from USB.
> 
> In other words, it might _actually_ act like a normal laptop.
> 
> I'd love to have something that is actually a real honest-to-goodness
> ARM laptop finally. Are we getting at all close to that?

I guess the Samsung Chromebook Plus (Rockchip RK3399-based [branded
OP1 though]) also is somewhat close to that target - even with a nice
high-res display and everything except the 32kb BootRom being replaceable.

Of course Qualcomm-based devices have the Adreno/Freedreno bonus,
but even in that area we're seeing some progress for Mali (Midgard)
this year [0].


[0] https://rosenzweig.io/blog/a-moving-mesa-midgard-cube.html


