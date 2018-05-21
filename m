Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeEUMEL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:04:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38601 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeEUMEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:04:10 -0400
Date: Mon, 21 May 2018 14:03:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Moritz Fischer <mdf@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ethernet: Sort Kconfig sourcing
 alphabetically
Message-ID: <20180521120357.GC27140@lunn.ch>
References: <20180521035830.7897-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521035830.7897-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 08:58:28PM -0700, Florian Fainelli wrote:
> A number of entries were not alphabetically sorted, remedy that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Hi Florian

The Makefile could do with the same treatment.

    Andrew
