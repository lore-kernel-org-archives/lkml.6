Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967792AbeBNNHN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:07:13 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55418 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967706AbeBNNHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:07:12 -0500
Date: Wed, 14 Feb 2018 14:07:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
Subject: Re: [PATCH v2 2/2] net: phy: dp83867: Add documentation for CLK_OUT
 pin muxing
Message-ID: <20180214130707.GA22014@lunn.ch>
References: <1518611019-37098-1-git-send-email-d.schultz@phytec.de>
 <1518611019-37098-2-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518611019-37098-2-git-send-email-d.schultz@phytec.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 01:23:39PM +0100, Daniel Schultz wrote:
> From: Wadim Egorov <w.egorov@phytec.de>
> 
> Add documentation of ti,clk-output-sel which can be used to select
> a specific clock for CLK_OUT.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83867.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.txt b/Documentation/devicetree/bindings/net/ti,dp83867.txt
> index 02c4353..56060c0 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83867.txt
> +++ b/Documentation/devicetree/bindings/net/ti,dp83867.txt
> @@ -25,6 +25,8 @@ Optional property:
>  				    software needs to take when this pin is
>  				    strapped in these modes. See data manual
>  				    for details.
> +	- ti,clk-output-sel - Muxing option for CLK_OUT pin - see dt-bindings/net/ti-dp83867.h
> +		for applicable values.

Hi Daniel

Please use the same indentation as the other optional properties.

       Andrew
