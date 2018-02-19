Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeBSOfQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:35:16 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35593 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeBSOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:35:13 -0500
X-Google-Smtp-Source: AH8x2248cY00tFOLfs+T1nPs6XSs3ruDhUKcdONF3meholqCBYuen/WuF6Rng0jJSCZxxa1H0bC22A==
Date: Mon, 19 Feb 2018 08:35:11 -0600
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org,
        mark.rutland@arm.com, david.brown@linaro.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        yanhe@quicinc.com, ramkri@qti.qualcomm.com, sdharia@quicinc.com
Subject: Re: [PATCH v3 2/5] dt-bindings: dmaengine: bam_dma: add remote
 controlled bindings
Message-ID: <20180219143511.2aei6ohteto4kjru@rob-hp-laptop>
References: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
 <20180215122511.13517-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215122511.13517-3-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 12:25:08PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds 2 new properties for remote controlled bam dt bindings.
> 1. num-channels to indicate number of dma channels.
> 2. qcom,num-ees to indicate number of Execution Environments.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
