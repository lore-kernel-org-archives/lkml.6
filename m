Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeEaGmV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:42:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39350 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753803AbeEaGmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:42:19 -0400
Date: Thu, 31 May 2018 08:42:05 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, dev@lynxeye.de,
        richard@nod.at, marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mtd: rawnand: tegra: add devicetree binding
Message-ID: <20180531084205.38bfe90f@xps13>
In-Reply-To: <20180531034523.GA5417@rob-hp-laptop>
References: <20180527215442.14760-3-stefan@agner.ch>
        <20180528002354.45025afd@xps13>
        <20180531034523.GA5417@rob-hp-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 30 May 2018 22:45:23 -0500, Rob Herring <robh@kernel.org> wrote:

> On Mon, May 28, 2018 at 12:23:54AM +0200, Miquel Raynal wrote:
> > Hi Stefan,
> > 
> > On Sun, 27 May 2018 23:54:38 +0200, Stefan Agner <stefan@agner.ch>
> > wrote:
> >   
> > > From: Lucas Stach <dev@lynxeye.de>
> > > 
> > > This adds the devicetree binding for the Tegra 2 NAND flash
> > > controller.
> > > 
> > > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > ---
> > >  .../bindings/mtd/nvidia,tegra20-nand.txt      | 62 +++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > > new file mode 100644
> > > index 000000000000..49e472af1b39
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > > @@ -0,0 +1,62 @@
> > > +NVIDIA Tegra NAND Flash controller
> > > +
> > > +Required properties:
> > > +- compatible: Must be one of:  
> > 
> > Nitpick: just put the compatible here as there is only one?  
> 
> No, this is how I ask people to format it.

Oh, ok, I'll remember it for my own DT patches then :)

Thanks,
Miquèl
