Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDQMxw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:53:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59246 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeDQMxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:53:51 -0400
Date: Tue, 17 Apr 2018 14:53:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
Cc: robh@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, marcel@holtmann.org,
        devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
        madalin.bucur@nxp.com
Subject: Re: [PATCH net-next 1/3] net: phy: Add binding for vendor specific
 C45 MDIO address space
Message-ID: <20180417125343.GD2591@lunn.ch>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
 <20180417090233.21548-2-vicentiu.galanopulo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417090233.21548-2-vicentiu.galanopulo@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 04:02:31AM -0500, Vicentiu Galanopulo wrote:
> The extra property enables the discovery on the MDIO bus
> of the PHYs which have a vendor specific address space
> for accessing the C45 MDIO registers.
> 
> Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>

Hi Vicentiu

I think binding is O.K, but the implementation needs work. So 

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
