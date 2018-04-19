Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeDSLdV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:33:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33681 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbeDSLdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:33:20 -0400
Date: Thu, 19 Apr 2018 13:33:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bhadram Varka <vbhadram@nvidia.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180419113312.GA17888@lunn.ch>
References: <20180419160232.519d15be@xhacker.debian>
 <96e77eac86794bef9a5b772147527c67@bgmail102.nvidia.com>
 <20180419165351.5388021e@xhacker.debian>
 <e1409c9493f64188a71b44f69ccb24cf@bgmail102.nvidia.com>
 <20180419170932.7a0b88fb@xhacker.debian>
 <1c3a4b66-b10c-adc9-b7e4-57b46f5c86e5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c3a4b66-b10c-adc9-b7e4-57b46f5c86e5@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >IIRC, the phy irq isn't necessary for WOL. The phy interrupt pin isn't
> >necessarily taken as "interrupt"
> Please correct me if I am wrong. In this case how the system will wake up
> from the SC7.There has to be wake capable irq/gpio pin to do this operation.
> 
Hi Bhadram

I've seem implementations where the line from the PHY is connected to
the power supply. It simply turns the power on. No interrupt needed.

    Andrew
