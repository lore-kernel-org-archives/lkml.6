Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754818AbeEHNDa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:03:30 -0400
Received: from mout.perfora.net ([74.208.4.196]:52909 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753678AbeEHND2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:03:28 -0400
Message-ID: <1525784582.6999.27.camel@ziswiler.com>
Subject: Re: [PATCH v2] ARM: dts: tegra: Add support for 256 MB Colibri-T20
 (plus such board on Iris)
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "stefan@agner.ch" <stefan@agner.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Date: Tue, 08 May 2018 15:03:02 +0200
In-Reply-To: <CAJKOXPetgqJgGHwdSzZeujM2KEDMWqffYMAJdBS3MXPd3Thb5w@mail.gmail.com>
References: <1525360112-9893-1-git-send-email-krzk@kernel.org>
         <c47c07b2c112219093b668c0b4d46ac8@agner.ch>
         <CAJKOXPeb+DmKVQ1uXkBOjaGMpxtPVFp54SBWm6h=+o30z9K3aQ@mail.gmail.com>
         <1525428885.6296.18.camel@toradex.com>
         <CAJKOXPetgqJgGHwdSzZeujM2KEDMWqffYMAJdBS3MXPd3Thb5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2fd3QXjPdHQnxBB8K44Llo+EAIrwxP0z8WWrJlRv+KEn0QVmsum
 hUw1Cpo0Q6e9eBhcNY0Mp6Ieu6EOs9HB1wPNB9K+rvedI2oazveWp4pF2PjDKJVsjwVwawo
 6+yIgIUolHNraOhXkVBG80kuldlUi70oxn+Pxidsn2HoqId0voEiNSPRKc5zZid7U+OS/C2
 ZDb3y8RjAswx7VAOeaITA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F2xCF09E9WE=:pNqqd7aOSz99zCpbJC5t/u
 30jbHw4L+vPqneOvPA713K6PZc0dDlZQwy81fsxbD6ExKvv1Er4MU0z04GEdcCBC/b2cHAr6q
 er9s6z7vCKBNeunBiwSlS9mu72Y0kSLzbcYHd5I+6pYda3lgQga5XvR8DX5L3m+iLjx94BUo2
 Swt7LpET9UckaNAUoRw1Z9OenwJCOdqXZDnMryxzEOrlnBvKzvpMhxbcLZdnlRH6UgFgPPRTt
 hVZYPA8pBLRE7x0qjGNME1hDrk8Bek8KdU5/fYTiRvpfCF+bOnQg2Q3NTgNJu1doUrxoYKmP1
 k+ocmzJEY4pIPxmhcRaPp328TeYXXaBSmDuxnM8MTZdUB6D5t4SCsGE8m6HZGt1LKXfAqqI2/
 3ADuAXwqX6wYuRDrs1fTMeqfyXcgXu4lV3Fct61fPJ9rEKU1srQOBSN/LjZIZFOfZjhBqNTk2
 y4v9MDfw7qqoOyswVwZqoFjyVFThdO1HOZ1m3wXkZRDSsAa00JzkjCxt960CwghwUuHvKoB4k
 5KsUlImPiEfybH4BcPJl1IIMhtTzVLm1LnrnCjVx7XeDEI1sjA1qxGE2AVQQQqmc2QnELgr5w
 HbJNi+dhxg3BDPHN8hPcRuBb4tibVj/hd9j00HTIqgKc+nnDeVsHEtIGuNxi7MQjmnG/Q+FLo
 AANAtkw4BaNUSCLJGJEWLsGt6ElU/l8GQ9W28GqRwe6hVasEzu2GlvgbrTFSTkIRh8NEE05bW
 qrgVpoTdQWq68DQi
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-08 at 14:35 +0200, Krzysztof Kozlowski wrote:
> On Fri, May 4, 2018 at 12:14 PM, Marcel Ziswiler
> <marcel.ziswiler@toradex.com> wrote:
> > Hi Krzysztof
> > 
> > On Fri, 2018-05-04 at 12:03 +0200, Krzysztof Kozlowski wrote:
> > > On Fri, May 4, 2018 at 11:19 AM, Stefan Agner <stefan@agner.ch>
> > > wrote:
> > > > On 03.05.2018 17:08, Krzysztof Kozlowski wrote:
> > > > > Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512
> > > > > MB
> > > > > RAM
> > > > > (with 1024 MB NAND) flavors.  Add support for the 256 MB
> > > > > version
> > > > > on Iris
> > > > > evaluation board.
> > > > 
> > > > To we really need to specify memory size these days? I think
> > > > all
> > > > common
> > > > boot loaders fill the memory node anyway.
> > > > 
> > > > arch/arm/boot/dts/imx6qdl-apalis.dtsi:
> > > >         /* Will be filled by the bootloader */
> > > >         memory@10000000 {
> > > >                 reg = <0x10000000 0>;
> > > >         };
> > > > 
> > > > 
> > > > I think we should just rename tegra20-colibri-512.dtsi =>
> > > > tegra20-colibri.dtsi and tegra20-iris-512.dts => tegra20-
> > > > iris.dts
> > > > to
> > > > avoid confusion and add such an empty node.
> > > 
> > > Having memory node is requirement of DeviceTree specification (at
> > > least one cpu and memory node). Of course if bootloader fills it,
> > > then
> > > we could assume that specification is satisfied... but what if
> > > some
> > > bootloader skips it? This creates quite specific dependency
> > > between
> > > kernel's DTS and bootloader.
> > 
> > Yes, no system boots without any boot loader e.g. initialising the
> > memory and what not. So there are obviously quite specific
> > dependencies.
> 
> Sorry for late reply, I missed your emails because unfortunately
> Google marks messages coming for Toradex as spam ("This message has a
> from address in toradex.com but has failed toradex.com's required
> tests for authentication.").

Argh, I guess that happens if you have stubborn IT departments which
still believe in M$. Sending via private email now.

> Therefore I did not include your comments
> and sent v3.

Yeah, I noticed that. It's forgiven, don't worry (;-p).

> > > One safe solution would be to specify 256 MB memory node for both
> > > boards and assume that bootloader will bump it to 512 MB for
> > > specific
> > > module.
> > 
> > Like I mentioned this actually used to be how it was done however
> > lately it has been agreed that any boot loader anyway needs to do
> > the
> > device tree dance (e.g. even just loading and passing it).
> 
> Then the safest way is to provide /memory node with 256 MB. If some
> bootloader omits it (e.g. because it is too old or by any mistake)
> the
> FDT will be still usable with reduced memory in case of 512 board.

Makes sense.

> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Changes since v1:
> > > > > 1. Fix memory size in tegra20-colibri-256.dtsi (was working
> > > > > fine
> > > > > because
> > > > >    my bootloader uses mem= argument).
> > > > 
> > > > What boot loader are you using? You even can omit mem= if your
> > > > boot
> > > > loader fills the memory node properly.
> > > 
> > > I use the one provided by vendor - Toradex. By default it passes
> > > both
> > > mem= and few other mem-like arguments (for FB and video
> > > processor) to
> > > command line. I believe it does not adjust the DTB itself because
> > > Toradex prepared this bootloader for... 3.1 kernel without DTB. 7
> > > years old kernel. :)
> > 
> > Remember our regular BSP is still based on NVIDIA's downstream
> > Linux
> > for Tegra aka L4T R16.5 based on Linux kernel 3.1.10 which does not
> > even use any device tree yet.
> 
> Yes, I noticed. I am trying to bring it fully on new kernels but no
> huge successes so far... I'm stuck on NAND trying Lucas Stach's old
> patchset.

Yeah, for a while I kept his patch set alive as well. I believe 4.4 was
still working fine passing all MTD tests. However, lately there were so
many changes it all fell apart. About a month ago I spend a couple
nights trying to get it running again but something is still not quite
right. Yet have to sync with Stefan in my team who is much more
knowledgeable about latest NAND development.

> Best regards,
> Krzysztof

Cheers

Marcel
