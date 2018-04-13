Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeDMSFx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 14:05:53 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44533 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeDMSFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 14:05:51 -0400
X-Google-Smtp-Source: AIpwx49OkRvkq3mCqRDHb5wVb66MG0CXrGU2XzZRpgHU0t9g+ZFb1YCkuH99Pgq4lncJhO8LKywk0g==
Date: Fri, 13 Apr 2018 13:05:49 -0500
From: Rob Herring <robh@kernel.org>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        phil.edworthy@renesas.com, buserror+upstream@gmail.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/8] dt-bindings: mfd: renesas,rzn1-sysctrl: document
 RZ/N1 sysctrl node
Message-ID: <20180413180549.yjzkl2yf7osz7myt@rob-hp-laptop>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523349015-37985-4-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523349015-37985-4-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 09:30:03AM +0100, Michel Pollet wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function
> system controller. This documents the node used to encapsulate
> it's sub drivers.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  .../bindings/mfd/renesas,rzn1-sysctrl.txt          | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> new file mode 100644
> index 0000000..9897f8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> @@ -0,0 +1,23 @@
> +DT bindings for the Renesas RZ/N1 System Controller
> +
> +== System Controller Node ==
> +
> +The system controller node currently only hosts a single sub-node to handle
> +the rebooting of the CPU. Eventually it will host the clock driver, SMP
> +start handler, watchdog etc.

Please submit a complete binding for the h/w block.

Again, if the only reason you have sub nodes is to define compatible 
strings and in turn enumerate drivers, then you don't need the nodes in 
DT. DT is not the only way to instantiate drivers.

Rob
