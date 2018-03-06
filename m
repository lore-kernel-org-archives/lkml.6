Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeCFC1r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:27:47 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44526 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeCFC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:27:46 -0500
X-Google-Smtp-Source: AG47ELuHm9T/thMIfvoeL0A5ioFc/dXINFxoyluhH/luv6LHy8jNM03JhBDgG+hEXmkGrFPdFpdDvg==
Date: Mon, 5 Mar 2018 20:27:42 -0600
From: Rob Herring <robh@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, jcliang@chromium.org,
        robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v6 09/14] dt-bindings: iommu/rockchip: Add clock
 property
Message-ID: <20180306022742.yfx2ond45orzhqiy@rob-hp-laptop>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-10-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301101837.27969-10-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 06:18:32PM +0800, Jeffy Chen wrote:
> Add clock property, since we are going to control clocks in rockchip
> iommu driver.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v6: None

Really? There was a different number of clocks before.

> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>                                 
