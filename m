Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeEKTKV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:10:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56177 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752249AbeEKTKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:10:14 -0400
Date: Fri, 11 May 2018 21:10:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Murphy <dmurphy@ti.com>
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: DP83TC811: Introduce support for the
 DP83TC811 phy
Message-ID: <20180511191011.GC12738@lunn.ch>
References: <20180511180819.5036-1-dmurphy@ti.com>
 <20180511183006.GB12738@lunn.ch>
 <56ca63ce-d609-5bb7-f38c-17d875496bd5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ca63ce-d609-5bb7-f38c-17d875496bd5@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 01:51:28PM -0500, Dan Murphy wrote:
> Andrew
> 
> On 05/11/2018 01:30 PM, Andrew Lunn wrote:
> > On Fri, May 11, 2018 at 01:08:19PM -0500, Dan Murphy wrote:
> >> Add support for the DP83811 phy.
> >>
> >> The DP83811 supports both rgmii and sgmii interfaces.
> >> There are 2 part numbers for this the DP83TC811R does not
> >> reliably support the SGMII interface but the DP83TC811S will.
> >>
> >> There is not a way to differentiate these parts from the
> >> hardware or register set.  So this is controlled via the DT
> >> to indicate which phy mode is required.  Or the part can be
> >> strapped to a certain interface.
> >>
> >> Data sheet can be found here:
> >> http://www.ti.com/product/DP83TC811S-Q1/description
> >> http://www.ti.com/product/DP83TC811R-Q1/description
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > 
> > Hi Dan
> > 
> > It is normal to add any Reviewed-by, or Tested-by: tags you received,
> > so long as you don't make major changes.
> > 
> 
> Thanks for the reminder.
> 
> I usually add them if I get them explicitly stated in the review.

Humm, i thought i had given one. But i cannot find it in the mail
archive. Going senile :-(

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
