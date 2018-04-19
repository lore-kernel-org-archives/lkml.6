Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeDSJo5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:44:57 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:46124 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeDSJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:44:55 -0400
Subject: Re: [PATCH v8 1/2] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, <architt@codeaurora.org>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <airlied@linux.ie>, <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <geert@linux-m68k.org>, <niklas.soderlund@ragnatech.se>,
        <sergei.shtylyov@cogentembedded.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
References: <1523357590-3841-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523357590-3841-2-git-send-email-jacopo+renesas@jmondi.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <29caaf6f-1783-9b01-5304-8748398d41c6@mentor.com>
Date: Thu, 19 Apr 2018 12:44:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <1523357590-3841-2-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo, Laurent,

On 04/10/2018 01:53 PM, Jacopo Mondi wrote:
> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

> ---
>  .../bindings/display/bridge/thine,thc63lvd1024.txt | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> new file mode 100644
> index 0000000..0b23e70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> @@ -0,0 +1,60 @@
> +Thine Electronics THC63LVD1024 LVDS decoder
> +-------------------------------------------
> +
> +The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS streams
> +to parallel data outputs. The chip supports single/dual input/output modes,
> +handling up to two LVDS input streams and up to two digital CMOS/TTL outputs.
> +
> +Single or dual operation mode, output data mapping and DDR output modes are
> +configured through input signals and the chip does not expose any control bus.
> +
> +Required properties:
> +- compatible: Shall be "thine,thc63lvd1024"
> +- vcc-supply: Power supply for TTL output, TTL CLOCKOUT signal, LVDS input,
> +  PPL and digital circuitry
> +
> +Optional properties:
> +- powerdown-gpios: Power down GPIO signal, pin name "/PDWN". Active low

Thank you for the change.

I would suggest to rename 'pwdn-gpios' property of THC63LVDM83D as well,
as far as I understand it is only described in DT bindings documentation,
and the property is unused in the driver or board DTS files at the moment.

> +- oe-gpios: Output enable GPIO signal, pin name "OE". Active high

Okay :)

--
With best wishes,
Vladimir
