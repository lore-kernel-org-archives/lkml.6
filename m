Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeEVQRa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:17:30 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40594 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:17:25 -0400
X-Google-Smtp-Source: AB8JxZqyOPQts82eWAsnuRSgvRnwLYdqYptUXHVTmL44q6sLx2XNcKVf/aNTm2f2+HJfDI2QAjVVdg==
Date: Tue, 22 May 2018 11:17:22 -0500
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v5 1/8] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
Message-ID: <20180522161722.GA18729@rob-hp-laptop>
References: <20180521172714.8551-1-sibis@codeaurora.org>
 <20180521172714.8551-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521172714.8551-2-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 10:57:07PM +0530, Sibi Sankar wrote:
> Add SDM845 AOSS (always on subsystem) reset controller binding
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/reset/qcom,aoss-reset.txt        | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-aoss.h  | 17 ++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h

Reviewed-by: Rob Herring <robh@kernel.org>
