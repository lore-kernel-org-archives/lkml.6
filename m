Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754914AbeD3QkV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:40:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45151 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752939AbeD3QkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:40:19 -0400
Date: Mon, 30 Apr 2018 18:40:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        rmk@armlinux.org.uk, linux-kernel@vger.kernel.org, cphealy@gmail.com,
        nikita.yoush@cogentembedded.com, vivien.didelot@savoirfairelinux.com,
        Nisar.Sayed@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next 0/5] Support for PHY test modes
Message-ID: <20180430164012.GB16854@lunn.ch>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180429.225554.2165914401649980919.davem@davemloft.net>
 <eea70076-891c-5caa-a590-ef1b0421f3b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea70076-891c-5caa-a590-ef1b0421f3b2@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Turning these tests on will typically result in the link partner
> dropping the link with us, and the interface will be non-functional as
> far as the data path is concerned (similar to an isolation mode). This
> might warrant properly reporting that to user-space through e.g: a
> private IFF_* value maybe?

Hi Florian

I've not looked at the code yet....

Is it also necessary to kick off auto-neg again after the test has
finished, in order to reestablish the link?

	  Andrew
