Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755971AbeEAO3B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:29:01 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:45167 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755305AbeEAO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:28:59 -0400
X-Google-Smtp-Source: AB8JxZqP6pTfGwZbWSf7mqAUUj8K2fXMuyJecd8r+R8pEAMpQRQeDN0SW0iKMEtIZbkmvCeqzyWJvg==
Date: Tue, 1 May 2018 09:28:57 -0500
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: andy.gross@linaro.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jassisinghbrar@gmail.com,
        will.deacon@arm.com, catalin.marinas@arm.com
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: Add APSS shared binding for
 SDM845 SoCs
Message-ID: <20180501142857.GA16990@rob-hp-laptop>
References: <20180425143803.11260-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425143803.11260-1-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 08:08:01PM +0530, Sibi Sankar wrote:
> Include SDM845 APSS shared to the list of possible bindings
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt        | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
