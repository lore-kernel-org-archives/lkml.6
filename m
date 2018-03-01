Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967249AbeCAJxI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:53:08 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:56453 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967059AbeCAJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:53:05 -0500
Date: Thu, 1 Mar 2018 10:53:00 +0100
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, sergei.shtylyov@cogentembedded.com,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] R-Car M3-N: Enable EtherAVB device node
Message-ID: <20180301095300.egvxwzpiuhwabwzg@verge.net.au>
References: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 11:22:44AM +0100, Jacopo Mondi wrote:
> Hi Simon, Geert,
>    in this second iteration I have dropped iommu dependencies for EtherAVB
> and have changed "phy-mode" for all mainlines Gen-3 boards, this time including
> ULCB, Draak, Eagle and V3MSK.
> 
> The series add phy-mode as a board property to the following board files:
> - salvator-common.dtsi
> - ulcb.dtsi
> - r8a77995-draak.dts
> - r8a77970-eagle.dts
> - r8a77970-v3msk.dts
> 
> And reset the EtherAVB phy-mode to "rgmii" in the following SoC DTSI:
> - r8a7795.dtsi
> - r8a7796.dtsi
> - r8a77995.dtsi
> - r8a77970.dtsi
> 
> And finally, I added EtherAVB device node for M3-N on top.

Thanks for the test report, applied.
