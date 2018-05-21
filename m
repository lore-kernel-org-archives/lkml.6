Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeEUOjq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:39:46 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38842 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbeEUOjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:39:44 -0400
Date: Mon, 21 May 2018 16:39:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <vokac.m@gmail.com>
Cc: netdev@vger.kernel.org, michal.vokac@ysoft.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        mark.rutland@arm.com, robh+dt@kernel.org, davem@davemloft.net
Subject: Re: [PATCH net-next 1/7] net: dsa: qca8k: Add QCA8334 binding
 documentation
Message-ID: <20180521143939.GA8077@lunn.ch>
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
 <1526909293-56377-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526909293-56377-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:28:07PM +0200, Michal Vokáč wrote:

Hi Michal

It is normal to have some commit message, even if it is the subject
said differently.

     Andrew

> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/qca8k.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.txt b/Documentation/devicetree/bindings/net/dsa/qca8k.txt
> index 9c67ee4..3d73cd0 100644
> --- a/Documentation/devicetree/bindings/net/dsa/qca8k.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/qca8k.txt
> @@ -2,7 +2,10 @@
>  
>  Required properties:
>  
> -- compatible: should be "qca,qca8337"
> +- compatible: should be one of:
> +    "qca,qca8334"
> +    "qca,qca8337"
> +
>  - #size-cells: must be 0
>  - #address-cells: must be 1
>  
> -- 
> 2.1.4
> 
