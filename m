Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeCRMxH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:53:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39575 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754354AbeCRMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:53 -0400
X-Google-Smtp-Source: AG47ELsDHYQtqr3KA8hPmZ7hMHkmowpwuUrNwq93y2fBfT67tU5yG2XV5B1XFLmvm3S+gftQ9NY9eQ==
Date: Sun, 18 Mar 2018 07:52:50 -0500
From: Rob Herring <robh@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: phy-qcom-qmp: Update bindings for sdm845
Message-ID: <20180318033246.5zwwhamrspaedbbf@rob-hp-laptop>
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
 <1521193500-4696-4-git-send-email-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521193500-4696-4-git-send-email-mgautam@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 03:14:56PM +0530, Manu Gautam wrote:
> Update compatible strings for USB3 PHYs on SDM845.
> One is QMPv3 DisplayPort-USB combo PHY and other one
> is USB UNI PHY which is single lane USB3 PHY without
> DP capability.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
