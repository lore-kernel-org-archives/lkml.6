Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeDFR3g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:29:36 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52601 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeDFR3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:29:35 -0400
Date: Fri, 6 Apr 2018 19:29:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: netdev@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: phy: marvell: Enable interrupt function on LED2
 pin
Message-ID: <20180406172928.GS17495@lunn.ch>
References: <20180405133504.12257-1-esben.haabendal@gmail.com>
 <20180405204029.665-1-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405204029.665-1-esben.haabendal@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 10:40:29PM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> The LED2[2]/INTn pin on Marvell 88E1318S as well as 88E1510/12/14/18 needs
> to be configured to be usable as interrupt not only when WOL is enabled,
> but whenever we rely on interrupts from the PHY.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
