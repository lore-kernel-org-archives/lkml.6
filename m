Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeCZWcH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:32:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40956 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeCZWWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:22:50 -0400
X-Google-Smtp-Source: AIpwx49PRrU+HJvW5qihGEO7U5cD+QiI8Uo6y7CodQG47ohx6Wx1ukQnoYeldqrr/RXhYV3UUwAbSA==
Date: Mon, 26 Mar 2018 17:22:48 -0500
From: Rob Herring <robh@kernel.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: opp: Introduce qcom-opp bindings
Message-ID: <20180326222248.c6g2q2tmueyqkq2r@rob-hp-laptop>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-4-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316040824.21472-4-rnayak@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 09:38:20AM +0530, Rajendra Nayak wrote:
> On Qualcomm platforms, an OPP node needs to describe an
> additional level/corner value that is then communicated to
> a remote microprocessor by the CPU, which then takes some
> actions (like adjusting voltage values across various rails)
> based on the value passed.
> 
> Describe these bindings in the qcom-opp bindings document.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/opp/qcom-opp.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

Reviewed-by: Rob Herring <robh@kernel.org>
