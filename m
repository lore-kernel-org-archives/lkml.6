Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeDPSsj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:48:39 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:47080 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbeDPSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:48:37 -0400
X-Google-Smtp-Source: AIpwx4+ngR3u+nuVmSoN8ap+dEEXIYDkyb7XIECHv4mlbOKDC7MfwABrfq262ajAVexCIeQyNd4jLw==
Date: Mon, 16 Apr 2018 13:48:35 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: afaerber@suse.de, liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        manivannanece23@gmail.com
Subject: Re: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
Message-ID: <20180416184835.paip4cerjemyqcwn@rob-hp-laptop>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:10:33PM +0530, Manivannan Sadhasivam wrote:
> Define power domains for Actions Semi S900 SoC Smart Power System (SPS).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/power/actions,owl-sps.txt  |  2 ++
>  include/dt-bindings/power/owl-s900-powergate.h     | 23 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/power/owl-s900-powergate.h

Reviewed-by: Rob Herring <robh@kernel.org>
