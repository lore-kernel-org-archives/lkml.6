Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeEVUOV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:14:21 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38411 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeEVUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:14:20 -0400
X-Google-Smtp-Source: AB8JxZrZAf+X5LdPUVevGpNNli8fMtESRPkWz1mflUaMrYdNZNx4T2brR5pjRiYBei72MpE6iO9Jag==
Date: Tue, 22 May 2018 15:14:17 -0500
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom: tsens: Allow number of sensors to come
 from DT
Message-ID: <20180522201417.GA19576@rob-hp-laptop>
References: <20180507235339.8836-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507235339.8836-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 04:53:39PM -0700, Bjorn Andersson wrote:
> For platforms that has multiple copies of the TSENS hardware block it's
> necessary to be able to specify the number of sensors per block in DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt       |  1 +

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/thermal/qcom/tsens.c                         | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
