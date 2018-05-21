Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeEULg6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:36:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33845 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753108AbeEULgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:36:54 -0400
X-Google-Smtp-Source: AB8JxZoh7dmSAsmoQnd2Y/sHdlWDqILpAzAXvBp5ZC0+SC6t6Z4RHXCDSAPUaBrEniPGDoqcdHPcTeCMoUSl70wr1gU=
MIME-Version: 1.0
In-Reply-To: <1526681037-2074-2-git-send-email-scott.branden@broadcom.com>
References: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com> <1526681037-2074-2-git-send-email-scott.branden@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 21 May 2018 13:36:53 +0200
Message-ID: <CAPDyKFqLtGTSscPEtuBOro0iXdWNByzmrzn_NafKQkX9nt9w1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-iproc: remove hard coded mmc cap 1.8v
To: Scott Branden <scott.branden@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2018 at 00:03, Scott Branden <scott.branden@broadcom.com> wrote:
> From: Srinath Mannam <srinath.mannam@broadcom.com>
>
> Remove hard coded mmc cap 1.8v from platform data as it is board specific.
> The 1.8v DDR mmc caps can be enabled using DTS property for those
> boards that support it.
>
> Fixes: b17b4ab8ce38 ("mmc: sdhci-iproc: define MMC caps in platform data")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>

Thanks, applied for and by adding a stable tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-iproc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 0ef741b..6f430da 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -206,7 +206,6 @@ static const struct sdhci_iproc_data iproc_data = {
>         .caps1 = SDHCI_DRIVER_TYPE_C |
>                  SDHCI_DRIVER_TYPE_D |
>                  SDHCI_SUPPORT_DDR50,
> -       .mmc_caps = MMC_CAP_1_8V_DDR,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
> --
> 2.5.0
>
