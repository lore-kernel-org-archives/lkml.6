Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeCZP4o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:56:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35768 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeCZP4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:56:42 -0400
X-Google-Smtp-Source: AG47ELtsOxVmssba/SOljF5q4NfzGU/968EHoUw0QCmDzo2xdxnli601d0YehvGeTUTAIAGWZbgTLA==
Date: Mon, 26 Mar 2018 08:56:43 -0700
From: Moritz Fischer <mdf@kernel.org>
To: David Miller <davem@davemloft.net>
Cc: mdf@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org, robh+dt@kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com
Subject: Re: [PATCH v5 2/2] net: ethernet: nixge: Add support for National
 Instruments XGE netdev
Message-ID: <20180326155643.5drx7ckdlcpr73wu@us-sjc-wireless-10-16-34-47.amer.corp.natinst.com>
References: <20180323204128.29783-1-mdf@kernel.org>
 <20180323204128.29783-2-mdf@kernel.org>
 <20180326.113830.932262386304702367.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326.113830.932262386304702367.davem@davemloft.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Mar 26, 2018 at 11:38:30AM -0400, David Miller wrote:
> From: Moritz Fischer <mdf@kernel.org>
> Date: Fri, 23 Mar 2018 13:41:28 -0700
> 
> > +static void nixge_hw_dma_bd_release(struct net_device *ndev)
> > +{
> > +	int i;
> > +	struct nixge_priv *priv = netdev_priv(ndev);
> 
> Please order local variables from longest to shortest line (ie. reverse
> christmas tree layout).

Sure.
> 
> > +static int nixge_hw_dma_bd_init(struct net_device *ndev)
> > +{
> > +	u32 cr;
> > +	int i;
> > +	struct sk_buff *skb;
> > +	struct nixge_priv *priv = netdev_priv(ndev);
> 
> Likewise.

Sure.
> 
> > +static void __nixge_device_reset(struct nixge_priv *priv, off_t offset)
> > +{
> > +	u32 status;
> > +	int err;
> > +	/* Reset Axi DMA. This would reset NIXGE Ethernet core as well.
> > +	 * The reset process of Axi DMA takes a while to complete as all
> > +	 * pending commands/transfers will be flushed or completed during
> > +	 * this reset process.
> > +	 */
> 
> Please put an empty line between the local variable declarations
> and this comment.

Will do in v6

Thanks for your review!

Cheers Moritz
