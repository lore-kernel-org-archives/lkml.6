Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933141AbeEHQtu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:49:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52589 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932606AbeEHQts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:49:48 -0400
Date: Tue, 8 May 2018 18:49:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Murphy <dmurphy@ti.com>
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: DP83811: Add support for the phy
Message-ID: <20180508164944.GE2888@lunn.ch>
References: <20180508141105.23867-1-dmurphy@ti.com>
 <1b6877db-61cf-101a-054e-9c1fbe95a813@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b6877db-61cf-101a-054e-9c1fbe95a813@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 10:56:55AM -0500, Dan Murphy wrote:
> All
> 
> On 05/08/2018 09:11 AM, Dan Murphy wrote:
> > Add support for the DP83811 phy by extending
> > the DP83822 driver to recognize the PHY IDs.
> > 
> > The DP83811 supports both rgmii and sgmii interfaces.
> > There are 2 part numbers for this the DP83811R does not
> > reliably support the SGMII interface but the DP83811S will.
> > 
> > There is not a way to differentiate these parts from the
> > hardware or register set.  So this is controlled via the DT
> > to indicate which phy mode is required.  Or the part can be
> > strapped to a certain interface.
> > 
> > Data sheet can be found here:
> > http://www.ti.com/product/DP83TC811S-Q1/description
> > http://www.ti.com/product/DP83TC811R-Q1/description
> > 
> 
> I am withdrawing this patch for comment.
> Some of the future features have varying register definitions between the DP83811
> and DP83822

Hi Dan

It might be worth talking to the ASIC engineers and the
test/qualification engineers. There are sometime undocumented
registers for testing. You might be able to identify the exact device
from these registers.

     Andrew
