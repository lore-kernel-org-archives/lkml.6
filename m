Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeCZPAo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:00:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32842 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeCZPAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:00:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E13C60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v2 2/2] dt-bindings: phy-qcom-qmp: Add UFS phy compitable
 string for sdm845
To: Can Guo <cang@codeaurora.org>, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20180321053720.12780-1-cang@codeaurora.org>
 <20180321053720.12780-3-cang@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <20dcdb46-deda-def5-76d1-0ed5efb40a7a@codeaurora.org>
Date: Mon, 26 Mar 2018 20:30:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321053720.12780-3-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2018 11:07 AM, Can Guo wrote:
> Update the compatible string for UFS QMP PHY on SDM845.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>   Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index cef8765..6e68a6d 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -11,7 +11,8 @@ Required properties:
>   	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>   	       "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy,
>   	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
> -	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
> +	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
> +	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.

We also need an entry for 'ref_aux' clock in the clock names for this phy.
Please add that.
With that,
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Thanks
Vivek.

>   
>    - reg: offset and length of register set for PHY's common serdes block.
>   
