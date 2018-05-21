Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeEUOmN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:42:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38860 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752712AbeEUOmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:42:08 -0400
Date: Mon, 21 May 2018 16:42:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <vokac.m@gmail.com>
Cc: netdev@vger.kernel.org, michal.vokac@ysoft.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        mark.rutland@arm.com, robh+dt@kernel.org, davem@davemloft.net
Subject: Re: [PATCH net-next 4/7] net: dsa: qca8k: Force CPU port to its
 highest bandwidth
Message-ID: <20180521144205.GC8077@lunn.ch>
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
 <1526909293-56377-5-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526909293-56377-5-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:28:10PM +0200, Michal Vokáč wrote:
> By default autonegotiation is enabled to configure MAC on all ports.
> For the CPU port autonegotiation can not be used so we need to set
> some sensible defaults manually.
> 
> This patch forces the default setting of the CPU port to 1000Mbps/full
> duplex which is the chip maximum capability.
> 
> Also correct size of the bit field used to configure link speed.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
