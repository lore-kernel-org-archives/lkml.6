Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeDQMyf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:54:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59256 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbeDQMyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:54:33 -0400
Date: Tue, 17 Apr 2018 14:54:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
Cc: robh@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, marcel@holtmann.org,
        devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
        madalin.bucur@nxp.com
Subject: Re: [PATCH net-next 2/3] net: phy: Change the array size to 32 for
 device_ids
Message-ID: <20180417125429.GE2591@lunn.ch>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
 <20180417090233.21548-3-vicentiu.galanopulo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417090233.21548-3-vicentiu.galanopulo@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 04:02:32AM -0500, Vicentiu Galanopulo wrote:
> In the context of enabling the discovery of the PHYs
> which have the C45 MDIO address space in a non-standard
> address:  num_ids in get_phy_c45_ids, has the
> value 8 (ARRAY_SIZE(c45_ids->device_ids)), but the
> u32 *devs can store 32 devices in the bitfield.
> 
> If a device is stored in *devs, in bits 32 to 9
> (bit counting in lookup loop starts from 1), it will
> not be found.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
