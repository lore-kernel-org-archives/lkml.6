Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbeCGV0H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 16:26:07 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41462 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754497AbeCGV0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 16:26:04 -0500
X-Google-Smtp-Source: AG47ELuX0xCmo54lOWgALAza24BCfeZS5hi6g6Z3v08NGauG+4ZsEZ2Trt4P3Qy44OoFLFVI7HdGpQ==
Date: Wed, 7 Mar 2018 15:26:01 -0600
From: Rob Herring <robh@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: kishon@ti.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rcar-gen3-phy-usb2: Add bindings for
 r8a77965
Message-ID: <20180307212601.mxj3pxwayea53juv@rob-hp-laptop>
References: <1520227965-4471-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1520227965-4471-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520227965-4471-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 02:32:43PM +0900, Yoshihiro Shimoda wrote:
> This patch adds support for r8a77965 (R-Car M3-N).
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
