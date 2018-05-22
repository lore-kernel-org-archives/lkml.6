Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeEVP4b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:56:31 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44694 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:56:28 -0400
X-Google-Smtp-Source: AB8JxZrvwMCheg5eQGAnuD+5eN8hclvchOxyUVnUA9PvPswW7DTu6HdS4SrYmlz6GJpStqKhRq6J8Q==
Date: Tue, 22 May 2018 10:56:26 -0500
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v5 5/8] dt-bindings: remoteproc: Add Q6v5 Modem PIL
 binding for SDM845
Message-ID: <20180522155626.GA2744@rob-hp-laptop>
References: <20180521172714.8551-1-sibis@codeaurora.org>
 <20180521172714.8551-6-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521172714.8551-6-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 10:57:11PM +0530, Sibi Sankar wrote:
> Add new compatible string for Qualcomm SDM845 SoCs
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 1 +
>  1 file changed, 1 insertion(+)

Please add acks/reviewed-bys when posting new versions.

Rob
