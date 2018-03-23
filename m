Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeCWVqn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:46:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42954 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbeCWVql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:46:41 -0400
X-Google-Smtp-Source: AG47ELsAUJmrXGDsZvVTAwdTfqgCZY0bgPi8togDAx8ggqBdkKTaezOLQpic5xxbsOPxUQvcT1gkJw==
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: add DT bindings for
 Microsemi MIIM
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-3-alexandre.belloni@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6cb618e9-0aa0-ba54-b556-d7a6823913d7@gmail.com>
Date: Fri, 23 Mar 2018 14:46:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-3-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> DT bindings for the Microsemi MII Management Controller found on Microsemi
> SoCs
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-miim.txt          | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-miim.txt b/Documentation/devicetree/bindings/net/mscc-miim.txt
> new file mode 100644
> index 000000000000..711ac9ab853c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mscc-miim.txt
> @@ -0,0 +1,25 @@
> +Microsemi MII Management Controller (MIIM) / MDIO
> +=================================================
> +
> +Properties:
> +- compatible: must be "mscc,ocelot-miim"
> +- reg: The base address of the MDIO bus controller register bank. Optionally, a
> +  second register bank can be defined if there is an associated reset register
> +  for internal PHYs
> +- #address-cells: Must be <1>.
> +- #size-cells: Must be <0>.  MDIO addresses have no size component.

Missing interrupt property documentation (sorry), other than that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
