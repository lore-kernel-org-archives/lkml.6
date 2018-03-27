Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeC0PCF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:02:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39935 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeC0PCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:02:02 -0400
X-Google-Smtp-Source: AIpwx48hsEfC+/MCBEyw4wNhiENzmtwDbrCPbx3GOA3kfTx+AZ+c9ghFGHAzgJ31m0iQID/V5KkC/A==
Date: Tue, 27 Mar 2018 10:01:56 -0500
From: Rob Herring <robh@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 5/6] dt-bindings: phy-qcom-usb2: Update bindings for
 sdm845
Message-ID: <20180327150156.d3vy5bf7mliso7pt@rob-hp-laptop>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org>
 <1521785487-29866-6-git-send-email-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521785487-29866-6-git-send-email-mgautam@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 11:41:26AM +0530, Manu Gautam wrote:
> Update compatible strings for USB2 PHYs on sdm845.
> There are two QUSB2 PHYs present on sdm845. Few PHY registers
> programming is different for these PHYs related to electrical
> parameters, otherwise both are same.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
