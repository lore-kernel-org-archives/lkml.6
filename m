Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeE1Hx6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:53:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35855 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753886AbeE1Hxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:53:43 -0400
X-Google-Smtp-Source: AB8JxZp0XYU5DmFrqD1qkdsos35AkIyqhD95ogiZeBHE5O20jL1MNpUy8HSBMFKHyGyo6wc9JTK18VqplYNlAyeEX7s=
MIME-Version: 1.0
In-Reply-To: <20180526144218.9891-1-colin.king@canonical.com>
References: <20180526144218.9891-1-colin.king@canonical.com>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Mon, 28 May 2018 09:53:22 +0200
Message-ID: <CAMGffEnSJciLOESLUZNfyPiguJpaOBxNp5-NGE81ihBY5275kA@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm80xx: fix spelling mistake "UNSORPORTED" -> "SUPPORTED"
To: Colin King <colin.king@canonical.com>
Cc: lindar_liu <lindar_liu@usish.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4S7s5rM003177

On Sat, May 26, 2018 at 4:42 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in pm8001_printk message text; also
> I believe NOT_UNSUPPORTED should probably be NOT_SUPPORTED. Also
> fix the indent of the pm8001_printk statement.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks, Colin.

Acked-by: Jack Wang <jinpu.wang@profitbricks.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index db88a8e7ee0e..4dd6cad330e8 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -3607,7 +3607,7 @@ int pm8001_mpi_reg_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 break;
>         default:
>                 PM8001_MSG_DBG(pm8001_ha,
> -                pm8001_printk("DEVREG_FAILURE_DEVICE_TYPE_NOT_UNSORPORTED\n"));
> +                       pm8001_printk("DEVREG_FAILURE_DEVICE_TYPE_NOT_SUPPORTED\n"));
>                 break;
>         }
>         complete(pm8001_dev->dcompletion);
> --
> 2.17.0
>



-- 
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Geschäftsführer: Achim Weiss, Matthias Steinberg, Christoph Steffens
