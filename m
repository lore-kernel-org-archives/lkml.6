Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754293AbeCRMy5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:54:57 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44421 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754575AbeCRMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:45 -0400
X-Google-Smtp-Source: AG47ELuo/kW9zq+c0UpcCsfyAHk+aLSzqB3z+JiS8XTSA0d1Geg2rPoczEc0Hcl0ueug2cxBq8k2bg==
Date: Sun, 18 Mar 2018 07:52:42 -0500
From: Rob Herring <robh@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: Re: [PATCH 1/3] dt-bindings: Add vendor prefix for Bticino
Message-ID: <20180318032412.dgjo73t3hxslmve6@rob-hp-laptop>
References: <20180315170710.9551-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315170710.9551-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 10:37:08PM +0530, Jagan Teki wrote:
> Added 'bticino' vendor prefix for Bticino International.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
> Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
