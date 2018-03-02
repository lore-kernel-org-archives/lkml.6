Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422844AbeCBIPk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:15:40 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:52628 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164765AbeCBIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:15:37 -0500
Subject: Re: [PATCH 1/2] phy: rcar-gen3-usb2: Add support for r8a77965
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1519710747-26435-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <046ceb88-56a1-56d3-5945-026597822aa0@ti.com>
Date: Fri, 2 Mar 2018 13:45:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1519710747-26435-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 27 February 2018 11:22 AM, Yoshihiro Shimoda wrote:
> This patch adds support for r8a77965 (R-Car M3-N). This SoC has
> dedicated pins.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c                     | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> index 99b651b..dbd137c 100644
> --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> @@ -8,6 +8,8 @@ Required properties:
>  	      SoC.
>  	      "renesas,usb2-phy-r8a7796" if the device is a part of an R8A7796
>  	      SoC.
> +	      "renesas,usb2-phy-r8a77965" if the device is a part of an
> +	      R8A77965 SoC.

have dt-binding Documentation as a separate patch.

Thanks
Kishon
