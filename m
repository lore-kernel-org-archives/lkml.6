Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeDIS7F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:59:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46636 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeDIS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:59:03 -0400
X-Google-Smtp-Source: AIpwx4+9pAY98VnLIPEFhtQIyXuq7ctnOn/VB/s5sDd9cgp3CnBvEwMblsJydojonRBp9EBOjRjZqg==
Date: Mon, 9 Apr 2018 13:59:02 -0500
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom: Add msm8998 hmss compatible
Message-ID: <20180409185902.sl2r5d5hfpxt4tyb@rob-hp-laptop>
References: <20180327155426.31998-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327155426.31998-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 08:54:26AM -0700, Bjorn Andersson wrote:
> The Qualcomm MSM8998 platform has a APCS HMSS GLOBAL block, add the
> compatible for this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt | 1 +
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c                             | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
