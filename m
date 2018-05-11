Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeEKSaN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:30:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56153 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeEKSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:30:12 -0400
Date: Fri, 11 May 2018 20:30:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Murphy <dmurphy@ti.com>
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: DP83TC811: Introduce support for the
 DP83TC811 phy
Message-ID: <20180511183006.GB12738@lunn.ch>
References: <20180511180819.5036-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511180819.5036-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 01:08:19PM -0500, Dan Murphy wrote:
> Add support for the DP83811 phy.
> 
> The DP83811 supports both rgmii and sgmii interfaces.
> There are 2 part numbers for this the DP83TC811R does not
> reliably support the SGMII interface but the DP83TC811S will.
> 
> There is not a way to differentiate these parts from the
> hardware or register set.  So this is controlled via the DT
> to indicate which phy mode is required.  Or the part can be
> strapped to a certain interface.
> 
> Data sheet can be found here:
> http://www.ti.com/product/DP83TC811S-Q1/description
> http://www.ti.com/product/DP83TC811R-Q1/description
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Hi Dan

It is normal to add any Reviewed-by, or Tested-by: tags you received,
so long as you don't make major changes.

    Andrew
