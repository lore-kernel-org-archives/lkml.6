Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161499AbeCAULm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:11:42 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42251 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161467AbeCAULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:11:41 -0500
Date: Thu, 1 Mar 2018 21:11:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        davem@davemloft.net
Subject: Re: [RESEND PATCH v4 2/2] net: ethernet: nixge: Add support for
 National Instruments XGE netdev
Message-ID: <20180301201135.GA343@lunn.ch>
References: <20180301191547.2816-1-mdf@kernel.org>
 <20180301191547.2816-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301191547.2816-2-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz

> - Consistency for NIXGE_MDIO_CXX_READ constants

> +#define NIXGE_MDIO_CLAUSE45	BIT(12)
> +#define NIXGE_MDIO_CLAUSE22	0
> +#define NIXGE_MDIO_OP(n)     (((n) & 0x3) << 10)
> +#define NIXGE_MDIO_OP_ADDRESS	0
> +#define NIXGE_MDIO_OP_WRITE	BIT(0)
> +#define NIXGE_MDIO_C45_READ	(BIT(1) | BIT(0))
> +#define NIXGE_MDIO_C22_WRITE	BIT(0)
> +#define NIXGE_MDIO_C22_READ	BIT(1)

Thanks for making READ consistent. But what about WRITE?  I'd suggest
you don't just blindly follow comments, but think about them.

    Andrew
