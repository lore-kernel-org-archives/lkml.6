Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeETOGG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 10:06:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37985 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751331AbeETOGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 10:06:04 -0400
Date: Sun, 20 May 2018 16:06:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, vivien.didelot@savoirfairelinux.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: b53: Extend platform data to include
 DSA ports
Message-ID: <20180520140602.GB24330@lunn.ch>
References: <20180519225510.23820-1-f.fainelli@gmail.com>
 <20180520014250.GB14906@lunn.ch>
 <051D2EF2-0B1E-4F03-B803-6A74E6E0BF44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051D2EF2-0B1E-4F03-B803-6A74E6E0BF44@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 08:14:41PM -0700, Florian Fainelli wrote:
> On May 19, 2018 6:42:50 PM PDT, Andrew Lunn <andrew@lunn.ch> wrote:
> >On Sat, May 19, 2018 at 03:55:10PM -0700, Florian Fainelli wrote:
> >> Provide a means for !OF platforms to supply their DSA platform data
> >> configuration using the dsa_platform_data structure.
> >
> >Hi Florian
> >
> >It seems a bit odd adding the header file, but no code. Yes, this will
> >help simplify the merge dependencies for the ZII boards next cycle,
> >but can we have the actual code as well?
> 
> The existing b53_common.c file already makes use of platform data the only thing that was missing was a dsa_chip_data structure correctly placed for the core DSA layer to obtain port information. This was present from day one in the b53 driver because it is also the mechanism used by the bus specific drivers to pass information to the core b53 driver file.

Ah. It would of been good to say that in the commit message.

    Andrew
