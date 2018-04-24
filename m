Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDXRwo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:52:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39095 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbeDXRwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:52:40 -0400
Date: Tue, 24 Apr 2018 19:52:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: =?iso-8859-1?Q?M=E5ns?= Andersson <mans.andersson@nibe.se>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: TLK10X initial driver submission
Message-ID: <20180424175234.GC2360@lunn.ch>
References: <20180419082816.109338-1-mans.andersson@nibe.se>
 <20180424163455.vmftcg5xbj6svtcu@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424163455.vmftcg5xbj6svtcu@rob-hp-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +Required properties:
> > +	- reg - The ID number for the phy, usually a small integer
> 
> Isn't this the MDIO bus address?

Hi Rob

Yes. This text has been take direct from the generic PHY binding.
 
> This should have a compatible string too.

Please see Documentation/devicetree/bindings/net/phy.txt

compatible strings are optional. We know what device it is from its ID
registers, which are in a well known location.

	Andrew
