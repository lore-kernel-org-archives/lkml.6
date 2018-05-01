Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEAUAE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:00:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46273 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbeEAUAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:00:03 -0400
Date: Tue, 1 May 2018 21:59:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        rmk@armlinux.org.uk, linux-kernel@vger.kernel.org, cphealy@gmail.com,
        nikita.yoush@cogentembedded.com, vivien.didelot@savoirfairelinux.com,
        Nisar.Sayed@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next 0/5] Support for PHY test modes
Message-ID: <20180501195956.GC1265@lunn.ch>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180429.225554.2165914401649980919.davem@davemloft.net>
 <eea70076-891c-5caa-a590-ef1b0421f3b2@gmail.com>
 <20180430232448.GB25602@lunn.ch>
 <19a6bf90-03d5-aa63-5f35-3b26801b79a9@gmail.com>
 <20180501174752.GA1265@lunn.ch>
 <cd910177-bff9-261a-78e7-aa0a2c6532b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd910177-bff9-261a-78e7-aa0a2c6532b5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> # echo 4 > /sys/class/net/gphy/operstate
> # ip link show gphy
> 4: gphy@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
> qdisc noqueue switchid 00000000 state TESTING mode DEFAULT group default
> qlen 1000
>     link/ether 00:10:18:de:38:1f brd ff:ff:ff:ff:ff:ff

This looks good.

I stopped using ifconfig years ago, so i personally don't care about
it. If you are using old tools, you have to expect some surprises and
missing information.

	Andrew
