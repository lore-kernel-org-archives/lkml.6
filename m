Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932444AbeE2IiI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:38:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52208 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932270AbeE2IiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:38:05 -0400
X-Google-Smtp-Source: ADUXVKKKMHHqCkRCsk57i6FWKXuEIdRQkrNysVumE6mNZphBV/wIaq2n1H/jArNfurSRyvi6tbn0tQ==
Date: Tue, 29 May 2018 09:38:02 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] mfd: qcom-spmi-pmic: Add support for
 pm8005,pm8998,pmi8998
Message-ID: <20180529083802.GA8038@dell>
References: <20180502163535.208548-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502163535.208548-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 May 2018, Stephen Boyd wrote:

> Add the compatibles and PMIC ids for the pm8005, pm8998, and pmi8998
> PMICS found on MSM8998 and SDM845 based platforms.
> 
> Cc: <devicetree@vger.kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v1:
>  * Picked up review tags
>  * Reordered lists to be based on id numbers
> 
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 3 +++
>  drivers/mfd/qcom-spmi-pmic.c                             | 6 ++++++
>  2 files changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
