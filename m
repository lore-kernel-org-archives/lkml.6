Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A0CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264B52081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264B52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeKAWgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:36:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeKAWgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:36:48 -0400
Received: from excalibur.cnev.de ([213.196.202.171]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MowT0-1flxxB3QII-00qQn4; Thu, 01 Nov 2018 14:32:55 +0100
Received: from excalibur.cnev.de ([213.196.202.171]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MowT0-1flxxB3QII-00qQn4; Thu, 01 Nov 2018 14:32:55 +0100
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1gID5f-0002wh-T1; Thu, 01 Nov 2018 14:32:51 +0100
Date:   Thu, 1 Nov 2018 14:32:51 +0100
From:   Karsten Merker <merker@debian.org>
To:     Olof Johansson <olof@lixom.net>, Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, anup@brainfault.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, atish.patra@wdc.com,
        davem@sunset.davemloft.net, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: defconfig: Enable printk timestamps
Message-ID: <20181101133249.g4ieomqb3wrawwvj@excalibur.cnev.de>
References: <CAOesGMjXZNURZ4SdKjssYCcFv3=4MYLBpBpzvvb1rNM-fo=QHQ@mail.gmail.com>
 <mhng-111820e6-59c0-479a-a10f-f3729007ba70@palmer-si-x1c4>
 <CAOesGMj+wXcN_7yvakC=SvtYjO=TTqrs8YiVX1xT7-4p1pC_Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOesGMj+wXcN_7yvakC=SvtYjO=TTqrs8YiVX1xT7-4p1pC_Mg@mail.gmail.com>
X-No-Archive: yes
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ptvvzb8zboLO6w2D/RqbhYNL3pbgI9sqtqHkQ3f55+WyGix5YSE
 mT2KaM2YUXaHPjLtXvIeVpqQ2cGqJ+B2mfgjQ9FK6s8JjmE/Y4KMTMXqvIKYJV3Y65SoKQu
 hBxpx2usr0hRAH70cKiHtXXsjOUhcFoOggH/jL9yjDq9XUpigKI6iCi18k6bNRQg9gHCaMY
 VqI0c5yzlnDDRTIak4qMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d87MbgMKuLI=:cgD6xAVYZKv8qIBJLNT73Q
 dkc1W9VdCA9wrcZeouzfAt0Io0xrZvVr1zNKNxG/QxJta+B7jljOtyqse3ZZY+HdS5RjXRPC8
 OqMwjPM19oyP+CpYSPtg6tOdp+4IKCFaLPX2p4eI6gbEmvEwl2BffNdmziTJI29FTE6SFzHmW
 AtUJ9cZUWTkBDus3MTuI+HhWTudyhh5n4/7cRJRDt1xmvaEV8FCVcoLiYi7cIT3gXlDYTklIF
 y5XKr6hv9mPwzfniFBzkv6h2vk+R3O+7TpCPEtxhYYu3SEGb30+IkGA6CQ/xDgt9xjWHW2B2e
 m/cHF9PcraVGpVaGIgWkR8KSWZ1HEGmptHfu2ZsvkUNDboDDJAY0eqJ+/T/QYSxUBPiw6PcHU
 5v0FtSFxhQJ9vSnxjqQ7hkJXVLesyeBa5v40ZldyGYWb8SUzITGxhfijMcu7nk0uo2v693Jt1
 8ZPj69rmYWrVHJaqQsjZyzBj8wjkcAIn+/cSPmgSLmBzN9EMtpGsPV7Kf/L1kacvQY73Cmv45
 auPZrRnaFC8riBIfQPlM8UVqWxNoCSxZJ28YlWbP+dgwKn7Pj5joqjaSGci1nomj/NEtToP4m
 TQSkB/TcMXJX0SWf1+qoX1hyWC42Ksu0mjmyDIR/G7xolj+j8s+Nr3ajzpeEYqI7B0acOEglm
 kB6R4ZUFlRF9FS3pRo5UIGTJZGPfpyyJqPChsfd4fe8pvqEtlVp7XciKpIzZwM9R6vCA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 03:50:38PM -0700, Olof Johansson wrote:
> On Wed, Oct 31, 2018 at 1:42 PM Palmer Dabbelt <palmer@sifive.com> wrote:
[...]
> > When we first submitted out port upstream we had an empty defconfig, with the
> > theory being that we should just pick whatever the default in Kconfig is for
> > everything.  That's obviously the wrong thing to do because most of those
> > options are bogus.  At the time I didn't care enough to look because I just
> > wanted something to work, but now I find myself asking the question "what goes
> > in a defconfig?"  Is it:
> >
> > * What I, as the maintainer of arch/riscv, want?  That's essentially what it is
> >   now, as we have things like "CONFIG_R8169=y" in there because I happened to
> >   have one sitting around when we needed to plug in an Ethernet card to test
> >   out PCIe.
> > * What distributions expect?  There's a major element of this in there right
> >   now, as half this stuff was just selected because the Debian and Fedora guys
> >   suggested we do so because adding things to the RISC-V defconfig made it
> >   easier to put together their build scripts.  For example, we ended up with
> >   "CONFIG_EXPERT=y" because some setting necessary for the distros was hidden
> >   behind it -- that seems like an odd default.
> > * What users expect?  I'm not even sure who users are in this case, as from my
> >   understating most people use distro kernels and don't twiddle Kconfig
> >   options.
> > * What is necessary to work on RISC-V hardware?  This seems like the most
> >   reasonable use for an arch-specific defconfig, and subsumes things like
> >   "CONFIG_SIFIVE_PLIC=y" because without the PLIC driver nothing will work (but
> >   the PLIC driver shouldn't be enabled by default for all architectures, as
> >   it's useless everywhere else).
> >
> > Maybe I've opened up a big can of worms here...  It just seems silly to have
> > most of our current defconfig be RISC-V specific.
> 
> So, on 32-bit ARM we have heavy defconfig proliferation, and for arm64
> there was a push to only have one defconfig. I'm heavily in favor of
> the latter.

ACK.

> On ARM64, the options turned on, are more or less "what makes the
> kernel useful on systems". Anything that would be needed to boot to a
> rootfs tends to be =y, while some other things that might be optional
> and not used everywhere tends to go in as modules.

ACK.

> Beyond that, for the most part it is maintainer preference. I've
> normally turned on platforms and drivers I need for my boot farm on
> the multi*defconfig configs on 32-bit ARM, and the same has been going
> for 64-bit.
> 
> Distros will always want something different, for policy reasons or
> otherwise. Main purpose of mainline defconfigs is to make mainline
> kernels useful and bootable, so having more of a superset approach
> makes a lot of sense in my mind.

My personal approach to defconfigs is that they should try to
provide the minimum hardware-related options required to boot on
existing hardware or virtual machines for the corresponding
architecture, and the minimum non-hardware related kernel options
that are required to run a typical disto userland, but not more. 
This "minimum" can still be a rather long list, though.  On the
hardware side that can include lots of low-level drivers (e.g. 
various PMICs, USB and AHCI PHYs, the various platform-specifc
frontends for (more or less) generic drivers such as
OHCI/EHCI/XHCI/AHCI/DWMAC/MUSB, etc.).  On the software side,
that minimum includes common filesystems (ext*, FAT, NFS),
everything required for systemd as the latter is nowadays used to
boot a significant proportion of all Linux distros, and basic
network support, but not much more.  I don't think that a
defconfig should follow the "everything and the kitchen sink"
approach that the distros use for their kernel builds (and which
of course makes sense for their userbase) - the defconfig is
usually used for development builds and should be small to keep
build times down.  The typical "I want it all" distro user
usually doesn't build a defconfig but either uses a pre-built
distro kernel or re-builds with an existing distro kernel config,
so the primary criterion for a defconfig should IMHO be the needs
of developers.

The "CONFIG_EXPERT=y" mentioned above was IIRC necessary to
enable some feature required by systemd, so unfortunately it is
quasi-essential to run common distro userlands nowadays.

Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten für Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
