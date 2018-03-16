Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbeCPS1s convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeCPS1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:27:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26CD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180314171330.1828-3-ilina@codeaurora.org>
Cc: linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>, devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180314171330.1828-1-ilina@codeaurora.org>
 <20180314171330.1828-3-ilina@codeaurora.org>
Message-ID: <152122486529.168459.15256316986315304276@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Date: Fri, 16 Mar 2018 11:27:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-03-14 10:13:30)
> +Properties:
> +- compatible:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Should be "qcom,cmd-db"
> +
> +- reg:
> +       Usage: required
> +       Value type: <prop encoded array>
> +       Definition: The register address that points to the location of the
> +                   Command DB in memory. Additionally, specify the address
> +                   and size of the actual lacation in memory.

s/lacation/location/ (seems this was missed from last round)

> +
> +Example:
> +
> +       reserved-memory {
> +               [...]
> +               qcom,cmd-db@c3f000c {
> +                       reg = <0x0 0xc3f000c 0x0 0x8>,
> +                             <0x0 0x85fe0000 0x0 0x20000>;

I agree with Bjorn and replied so on v4.

> +                       compatible = "qcom,cmd-db";
> +               };
> +       };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
