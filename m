Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeCGOkd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:40:33 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:32996 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCGOkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:40:31 -0500
Date: Wed, 7 Mar 2018 15:40:28 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm-soc <arm@kernel.org>, linux-arm-kernel@axis.com,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] ARTPEC-6 ARM SoC device tree updates
Message-ID: <20180307144027.GA17727@axis.com>
References: <20180221090000.18091-1-niklas.cassel@axis.com>
 <CAK8P3a0ykwsO40w49TL9xgVKv3wrvx7KXz1o6XD5+qXQ6n8YUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0ykwsO40w49TL9xgVKv3wrvx7KXz1o6XD5+qXQ6n8YUA@mail.gmail.com>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 05:45:30PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 21, 2018 at 9:59 AM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> > Hello,
> >
> > Here comes some ARTPEC-6 ARM SoC device tree updates.
> >
> > Niklas Cassel (8):
> >   ARM: dts: artpec: disable Accelerator Coherency Port
> >   ARM: dts: artpec: use 1 GiB RAM
> >   ARM: dts: artpec: remove 0x prefix from clkctrl unit address
> >   ARM: dts: artpec: migrate ethernet to stmmac binding
> >   ARM: dts: artpec: add and utilize artpec6 pin controller
> >   ARM: dts: artpec: add and utilize nbpfaxi DMA controllers
> >   ARM: dts: artpec: add disabled node for PCIe endpoint mode
> >   ARM: dts: artpec: add node for hardware crypto accelerator
> 
> For a series eight patches, a pull request would save me some work, but
> I applied it anyway.

Thank you Arnd.
You will receive pull requests in the future.

> 
> Are you sure that the first three patches shouldn't be applied to stable
> backports?

The only DTS available upstream is for the ARTPEC-6 devboard.
Considering that ARTPEC-6 devboards are only used in-house,
I don't see a reason to backport anything from this series.


Best regards,
Niklas
