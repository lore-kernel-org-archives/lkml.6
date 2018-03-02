Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422801AbeCBIOv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:14:51 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:52603 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164765AbeCBIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:14:47 -0500
Subject: Re: [PATCH 2/2] phy: rcar-gen3-usb3: Add binding for r8a77965
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1519710747-26435-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6df55c1d-8855-7aff-af13-cf0f43cc5f8b@ti.com>
Date: Fri, 2 Mar 2018 13:44:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1519710747-26435-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 27 February 2018 11:22 AM, Yoshihiro Shimoda wrote:
> This patch adds binding for r8a77965 (R-Car M3-N).

$subject should be  dt-bindings: rcar-gen3-phy-usb3: Add binding for r8a77965

Thanks
Kishon
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
> index f94cea4..47dd296 100644
> --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
> +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
> @@ -11,6 +11,8 @@ Required properties:
>  	      SoC.
>  	      "renesas,r8a7796-usb3-phy" if the device is a part of an R8A7796
>  	      SoC.
> +	      "renesas,r8a77965-usb3-phy" if the device is a part of an
> +	      R8A77965 SoC.
>  	      "renesas,rcar-gen3-usb3-phy" for a generic R-Car Gen3 compatible
>  	      device.
>  
> 
