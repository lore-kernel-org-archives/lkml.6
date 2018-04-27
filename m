Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935005AbeD0OdL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:33:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33286 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934356AbeD0Ocu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:32:50 -0400
X-Google-Smtp-Source: AB8JxZq71tQBPLaVkMY73KNyGBd57d7UyGBePY5z+mkplwrsoJ3ddh78wstrhYwk61Xbf7+P7NAyWg==
Date: Fri, 27 Apr 2018 09:32:49 -0500
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v4 3/5] dt-bindings: remoteproc: Add Q6v5 Modem PIL
 binding for SDM845
Message-ID: <20180427143249.pti7rbcildf5772h@rob-hp-laptop>
References: <20180425150843.26657-1-sibis@codeaurora.org>
 <20180425150843.26657-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425150843.26657-4-sibis@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 08:38:41PM +0530, Sibi Sankar wrote:
> Add new compatible string for Qualcomm SDM845 SoCs
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
