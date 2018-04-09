Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeDISjk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:39:40 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46752 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeDISji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:39:38 -0400
X-Google-Smtp-Source: AIpwx4/0zaSiL8xa6i0DbJw/Mym4hu4vbNL2TytKkz02JIMLWxmvQOYT/mVsXJ4zBlfr7soVewtfdg==
Date: Mon, 9 Apr 2018 13:39:36 -0500
From: Rob Herring <robh@kernel.org>
To: Can Guo <cang@codeaurora.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: phy-qcom-qmp: Add UFS phy compatible
 string for sdm845
Message-ID: <20180409183936.5idm2qrhmgapjsd2@rob-hp-laptop>
References: <20180327071838.11168-1-cang@codeaurora.org>
 <20180327071838.11168-3-cang@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327071838.11168-3-cang@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 03:18:38PM +0800, Can Guo wrote:
> Update the compatible string for UFS QMP PHY on SDM845.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
