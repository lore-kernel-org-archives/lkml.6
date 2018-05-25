Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966571AbeEYMQR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:16:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45156 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966243AbeEYMQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:16:16 -0400
Date: Fri, 25 May 2018 14:16:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: dsa_loop: Make dynamic debugging
 helpful
Message-ID: <20180525121609.GC20060@lunn.ch>
References: <20180525035215.19341-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525035215.19341-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 08:52:14PM -0700, Florian Fainelli wrote:
> Remove redundant debug prints from phy_read/write since we can trace those
> calls through trace events. Enhance dynamic debug prints to print arguments
> which helps figuring how what is going on at the driver level with higher level
> configuration interfaces.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
