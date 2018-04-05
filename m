Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDEUky (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:40:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52014 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbeDEUkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:40:52 -0400
Date: Thu, 5 Apr 2018 22:40:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Esben Haabendal <esben@haabendal.dk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "open list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 2/2] net: phy: dp83640: Read strapped configuration
 settings
Message-ID: <20180405204049.GD17495@lunn.ch>
References: <20180405114424.8519-1-esben.haabendal@gmail.com>
 <20180405114424.8519-2-esben.haabendal@gmail.com>
 <95678797-bd17-ba3f-8a70-a00b4792a258@gmail.com>
 <87d0zdjszu.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0zdjszu.fsf@haabendal.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 10:30:45PM +0200, Esben Haabendal wrote:
> Florian Fainelli <f.fainelli@gmail.com> writes:
> 
> > On 04/05/2018 04:44 AM, esben.haabendal@gmail.com wrote:
> >> From: Esben Haabendal <eha@deif.com>
> >> 
> >> Read configration settings, to allow automatic forced speed/duplex setup
> >> by hardware strapping.
> >
> > OK but why? What problem is this solving for you?
> 
> It is ensuring that the PHY is configured according to the HW design.
> If the HW design has set the strap configuration to fx. fixed 100 Mbit
> full-duplex, this avoids Linux configuring it for auto-negotiation.

Hi Esben

Are you sure it contains the HW strapping? Is the driver hitting the
PHY with a hard reset to make it go back to the strapping defaults?
Or could it still contain whatever state the last boot of Linux, or
maybe the bootloader, left the PHY in?

      Andrew
