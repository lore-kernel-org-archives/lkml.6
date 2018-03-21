Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCUCjF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:39:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeCUCjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:39:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Mar 2018 10:39:01 +0800
From: cang@codeaurora.org
To: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: phy-qcom-qmp: Update UFS phy binding
 for sdm845
In-Reply-To: <20180320113051.14444-3-cang@codeaurora.org>
References: <20180320113051.14444-1-cang@codeaurora.org>
 <20180320113051.14444-3-cang@codeaurora.org>
Message-ID: <bf4a048c379d4e0dd6e4d99e49cb1a15@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 19:30, Can Guo wrote:
> Update the compatible string for UFS QMP PHY on SDM845.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index cef8765..6e68a6d 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -11,7 +11,8 @@ Required properties:
>  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>  	       "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy,
>  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
> -	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on 
> sdm845.
> +	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on 
> sdm845,
> +	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> 
>   - reg: offset and length of register set for PHY's common serdes 
> block.
