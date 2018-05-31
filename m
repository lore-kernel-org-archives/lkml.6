Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeEaDwV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:52:21 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35745 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932689AbeEaDwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:52:18 -0400
X-Google-Smtp-Source: ADUXVKIaJxVQ6HXLsp+wHSgfPBsxEjYRHH410ikVALIrMPgk8UkH02JdDuBfn6pu8TrjH0CedMfuIw==
Date: Wed, 30 May 2018 22:52:16 -0500
From: Rob Herring <robh@kernel.org>
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
Subject: Re: [PATCH V2 3/4] Documentation: sdhci-msm: Add new compatible
 string for SDCC v5
Message-ID: <20180531035216.GA12320@rob-hp-laptop>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-4-git-send-email-vviswana@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527587561-27448-4-git-send-email-vviswana@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 03:22:40PM +0530, Vijay Viswanath wrote:
> From: Sayali Lokhande <sayalil@codeaurora.org>
> 
> For SDCC version 5.0.0 and higher, new compatible string
> "qcom,sdhci-msm-v5" is added.
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
