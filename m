Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759184AbeD0UIK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:08:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40382 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758703AbeD0UII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:08:08 -0400
X-Google-Smtp-Source: AB8JxZrvacPPD8oRhZeXmhEtf+JU7G9OSI3MU2BGyaJwwcmP3IVISn4H/7URFHEdRj6Z96b8POKHng==
Date: Fri, 27 Apr 2018 15:08:06 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v2 1/7] dt-bindings: net: add DT bindings for
 Microsemi MIIM
Message-ID: <20180427200806.ga3xkift6kvc7sbv@rob-hp-laptop>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426195931.5393-2-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 09:59:25PM +0200, Alexandre Belloni wrote:
> DT bindings for the Microsemi MII Management Controller found on Microsemi
> SoCs
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-miim.txt     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt

Reviewed-by: Rob Herring <robh@kernel.org>
