Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeEaDp3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:45:29 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46389 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeEaDp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:45:26 -0400
X-Google-Smtp-Source: ADUXVKJauWNTIvshvJ1KLGdkm7taSva/Q5zk5vXY+amXqzRRBd09msvFR0Jy0JGC2/ek9EHJBuM9UA==
Date: Wed, 30 May 2018 22:45:23 -0500
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
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
Message-ID: <20180531034523.GA5417@rob-hp-laptop>
References: <20180527215442.14760-3-stefan@agner.ch>
 <20180528002354.45025afd@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528002354.45025afd@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 12:23:54AM +0200, Miquel Raynal wrote:
> Hi Stefan,
> 
> On Sun, 27 May 2018 23:54:38 +0200, Stefan Agner <stefan@agner.ch>
> wrote:
> 
> > From: Lucas Stach <dev@lynxeye.de>
> > 
> > This adds the devicetree binding for the Tegra 2 NAND flash
> > controller.
> > 
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  .../bindings/mtd/nvidia,tegra20-nand.txt      | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > new file mode 100644
> > index 000000000000..49e472af1b39
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > @@ -0,0 +1,62 @@
> > +NVIDIA Tegra NAND Flash controller
> > +
> > +Required properties:
> > +- compatible: Must be one of:
> 
> Nitpick: just put the compatible here as there is only one?

No, this is how I ask people to format it.

Rob
