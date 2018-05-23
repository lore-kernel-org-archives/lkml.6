Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeEWQNb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:13:31 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34300 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeEWQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:13:26 -0400
X-Google-Smtp-Source: AB8JxZry3V6qrCkqJ6Zzv4AvJpDmcNSomZVjNu6xnGSgRCJX5/AOs2jLkF9AbzZb9X9YnxQmdczQuw==
Date: Wed, 23 May 2018 11:13:23 -0500
From: Rob Herring <robh@kernel.org>
To: Can Guo <cang@codeaurora.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] dt-bindings: phy-qcom-qmp: Add UFS phy compatible
 string for sdm845
Message-ID: <20180523161323.GA28074@rob-hp-laptop>
References: <20180523034712.3420-1-cang@codeaurora.org>
 <20180523034712.3420-4-cang@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523034712.3420-4-cang@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:47:12AM +0800, Can Guo wrote:
> Update the compatible string for UFS QMP PHY on SDM845.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
