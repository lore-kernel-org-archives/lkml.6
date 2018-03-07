Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754885AbeCGV00 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 16:26:26 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38462 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754497AbeCGV0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 16:26:24 -0500
X-Google-Smtp-Source: AG47ELvwhpSOhcH+gE/Nhz6PsdEWoPdNtk2s5v4W88MhZuN0FcfNBfrlly9+0S9pOhoFwFmRVeCGGQ==
Date: Wed, 7 Mar 2018 15:26:23 -0600
From: Rob Herring <robh@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: kishon@ti.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: rcar-gen3-phy-usb3: Add bindings for
 r8a77965
Message-ID: <20180307212623.uunrinyhl22adfan@rob-hp-laptop>
References: <1520227965-4471-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1520227965-4471-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520227965-4471-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 02:32:45PM +0900, Yoshihiro Shimoda wrote:
> This patch adds bindings for r8a77965 (R-Car M3-N).
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
