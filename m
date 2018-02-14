Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032226AbeBNQOS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:14:18 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55684 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030349AbeBNQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:14:17 -0500
Date: Wed, 14 Feb 2018 17:14:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
Subject: Re: [PATCH v3 1/2] net: phy: dp83867: Add binding for the CLK_OUT
 pin muxing option
Message-ID: <20180214161412.GG12307@lunn.ch>
References: <1518624432-15110-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518624432-15110-1-git-send-email-d.schultz@phytec.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 05:07:11PM +0100, Daniel Schultz wrote:
> From: Wadim Egorov <w.egorov@phytec.de>
> 
> The DP83867 has a muxing option for the CLK_OUT pin. It is possible
> to set CLK_OUT for different channels.
> Create a binding to select a specific clock for CLK_OUT pin.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
