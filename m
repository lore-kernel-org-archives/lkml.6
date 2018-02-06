Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeBFSqz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:46:55 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:47249 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752851AbeBFSqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:46:47 -0500
Date: Tue, 6 Feb 2018 18:05:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Sven Van Asbroeck <svendev@arcx.com>, Woojung.Huh@microchip.com,
        Tristram.Ha@microchip.com, f.fainelli@gmail.com,
        helmut.buchsbaum@gmail.com, Maarten.Blomme@flir.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 0/1] spi_ks8995: use regmap to access chip registers.
Message-ID: <20180206170526.GK12679@lunn.ch>
References: <1517930036-17618-1-git-send-email-svendev@arcx.com>
 <20180206161447.GF12679@lunn.ch>
 <CAGngYiWYChnZmU7n9i1+nbY+1oWGXQGOopBhNiPHPUoYvTdgaw@mail.gmail.com>
 <20180206165009.GJ12679@lunn.ch>
 <CAGngYiWR-ayfg4KiH4yzoey+7P-jjV9MjEv8STmS65aC9JTX5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiWR-ayfg4KiH4yzoey+7P-jjV9MjEv8STmS65aC9JTX5Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:58:17AM -0500, Sven Van Asbroeck wrote:
> On Tue, Feb 6, 2018 at 11:50 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> > And a DSA driver does not need to be complex. You can start simple,
> > and add more features later.
> 
> I see. Would it be possible/practical to start with just phy_read/write,
> port_enable/disable in dsa_switch_ops ? And just add a sysfs bin file
> for userspace register access ?

I would NACK sysfs bin file. Do it right, or don't do it at all.

I think i would first want to know what Tristam/Microchip plans
are. Does he intend to keep on working on the patches from last year?

       Andrew
