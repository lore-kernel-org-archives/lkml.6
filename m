Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeDIS7o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:59:44 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43207 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeDIS7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:59:41 -0400
X-Google-Smtp-Source: AIpwx4+s62mzpJkhku56QT1fgsJaAzxNu2FXVRoA7RDay/DcDERvoPawjOf31qYktSEuAECqO77sKA==
Date: Mon, 9 Apr 2018 13:59:40 -0500
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smd-rpm: Add msm8998 compatible
Message-ID: <20180409185940.mecthzl2tdyz3hb3@rob-hp-laptop>
References: <20180327155515.32077-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327155515.32077-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 08:55:15AM -0700, Bjorn Andersson wrote:
> Add the compatible for the RPM in MSM8998, so that rpm resources can be
> made available.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
>  drivers/soc/qcom/smd-rpm.c                                  | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
