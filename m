Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbeCFF5E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:57:04 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43175 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeCFF5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:57:02 -0500
X-Google-Smtp-Source: AG47ELu89Q1m7gpftePC2dZkTXijulD1kUX098S9vv1BmOlNYPf9IBWSUVrn3PD/MqtyVzLyw9M+/hE5QkvmKIRszhQ=
MIME-Version: 1.0
In-Reply-To: <20180305233647.GA30787@embeddedgus>
References: <20180305233647.GA30787@embeddedgus>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 6 Mar 2018 11:26:41 +0530
Message-ID: <CA+sbYW1xzCLsA8sQ2mMnujFDTeDLTHS+O9psr03ZLEDo0Aieyw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re/qplib_sp: Use true and false for boolean values
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 5:06 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Assign true or false to boolean variables instead of an integer value.
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks.

Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> index ee98e5e..2f3f32ea 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> @@ -154,7 +154,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
>                 attr->tqm_alloc_reqs[i * 4 + 3] = *(++tqm_alloc);
>         }
>
> -       attr->is_atomic = 0;
> +       attr->is_atomic = false;
>  bail:
>         bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
>         return rc;
> --
> 2.7.4
>
