Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbeBSTea (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:34:30 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36605 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbeBSTe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:34:28 -0500
X-Google-Smtp-Source: AH8x225g+7LM2q5gJ32/exmD1Ps5+KF4EadVXzY8bAcdb10ZXssc0Z/4mPjsnoP1Qps86cpKVm1f7A==
Date: Mon, 19 Feb 2018 13:34:26 -0600
From: Rob Herring <robh@kernel.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, devicetree@vger.kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] dt-bindings: qcom: Add SDM845 bindings
Message-ID: <20180219193426.darxcui4g4oxyf32@rob-hp-laptop>
References: <20180216060503.22006-1-rnayak@codeaurora.org>
 <20180216060503.22006-3-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216060503.22006-3-rnayak@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:35:01AM +0530, Rajendra Nayak wrote:
> Add a SoC string 'sdm845' for the qualcomm SDM845 SoC
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
> index 0ed4d39d7fe1..ee532e705d6c 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.txt
> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
> @@ -26,6 +26,7 @@ The 'SoC' element must be one of the following strings:
>  	msm8996
>  	mdm9615
>  	ipq8074
> +	sdm845

These should really be the full string with 'qcom,', but you don't have 
to fix that now.

Reviewed-by: Rob Herring <robh@kernel.org>
