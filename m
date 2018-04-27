Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757339AbeD0DOw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 23:14:52 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:46101 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeD0DOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 23:14:51 -0400
X-Google-Smtp-Source: AB8JxZq5aNalYgqMEBYCCADjJbFufu966e3cs5fovkk6HGMwnXjvItqQiVauzaGm/FIITRuvButRow==
Date: Thu, 26 Apr 2018 22:14:49 -0500
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] mfd: qcom-spmi-pmic: Add support for
 pm8005,pm8998,pmi8998
Message-ID: <20180427031449.ift6o6w3feyef2py@rob-hp-laptop>
References: <20180419230032.13611-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419230032.13611-1-swboyd@chromium.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:00:32PM -0700, Stephen Boyd wrote:
> Add the compatibles and PMIC ids for the pm8005, pm8998, and pmi8998
> PMICS found on MSM8998 and SDM845 based platforms.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 3 +++
>  drivers/mfd/qcom-spmi-pmic.c                             | 6 ++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
