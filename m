Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeCHUr1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:47:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:52027 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeCHUr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:47:26 -0500
Date: Thu, 8 Mar 2018 21:47:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Brad Mouring <brad.mouring@ni.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] net: phy: Tell caller result of phy_change()
Message-ID: <20180308204723.GA26248@lunn.ch>
References: <20180307225042.2205-1-brad.mouring@ni.com>
 <20180308203157.10855-1-brad.mouring@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308203157.10855-1-brad.mouring@ni.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/net/phy/phy.c
> @@ -617,6 +617,8 @@ static void phy_error(struct phy_device *phydev)
>  	phy_trigger_machine(phydev, false);
>  }
>  
> +static irqreturn_t phy_change(struct phy_device *phydev);
> +

Hi Brad

Rather than add a forward declaration, please move phy_change().

       Thanks
              Andrew
