Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeEROd2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:33:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41671 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeEROdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:33:21 -0400
X-Google-Smtp-Source: AB8JxZoepljR2lZM2mxz7NBScGifCmEZO1LbFkbk4nEfN4UUGuAFB0S8EgNI/u5UgQtH5dafkC5VtQ==
Date: Fri, 18 May 2018 09:33:19 -0500
From: Rob Herring <robh@kernel.org>
To: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, evgreen@chromium.org
Subject: Re: [PATCH v7 1/2] dt-bindings: Documentation for qcom, llcc
Message-ID: <20180518143319.GA11439@rob-hp-laptop>
References: <1526492623-20527-1-git-send-email-rishabhb@codeaurora.org>
 <1526492623-20527-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526492623-20527-2-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 10:43:42AM -0700, Rishabh Bhatnagar wrote:
> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.
> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt

Other than the node name discussed in v6,

Reviewed-by: Rob Herring <robh@kernel.org>
