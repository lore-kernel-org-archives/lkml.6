Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeBIX51 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:57:27 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39864 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeBIX5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:57:25 -0500
X-Google-Smtp-Source: AH8x2261REVOADaZbJoHSo1/mjD+MEHcAKXwyd8mIBdvBsKLcg8N9A3Y5LPfOODsh5PBCEL6uSWEm8xYN2aFIcDQ2RI=
MIME-Version: 1.0
In-Reply-To: <20180209121415.564-1-colin.king@canonical.com>
References: <20180209121415.564-1-colin.king@canonical.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 9 Feb 2018 17:57:03 -0600
Message-ID: <CAH2r5muR7bKGxjQBgjLbrsDPKOLut_j71vTrq-QNKefNhiJB1w@mail.gmail.com>
Subject: Re: [PATCH][V2] CIFS: SMBD: fix spelling mistake: "faield" and "legnth"
To: Colin King <colin.king@canonical.com>
Cc: Steve French <sfrench@samba.org>, CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Fri, Feb 9, 2018 at 6:14 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in log_rdma_send and log_rdma_mr
> message text.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/cifs/smbdirect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 91710eb571fb..5aa0b54b32ce 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -1025,7 +1025,7 @@ static int smbd_post_send(struct smbd_connection *info,
>
>         for (i = 0; i < request->num_sge; i++) {
>                 log_rdma_send(INFO,
> -                       "rdma_request sge[%d] addr=%llu legnth=%u\n",
> +                       "rdma_request sge[%d] addr=%llu length=%u\n",
>                         i, request->sge[0].addr, request->sge[0].length);
>                 ib_dma_sync_single_for_device(
>                         info->id->device,
> @@ -2295,7 +2295,7 @@ static void smbd_mr_recovery_work(struct work_struct *work)
>                                 rc = ib_dereg_mr(smbdirect_mr->mr);
>                                 if (rc) {
>                                         log_rdma_mr(ERR,
> -                                               "ib_dereg_mr faield rc=%x\n",
> +                                               "ib_dereg_mr failed rc=%x\n",
>                                                 rc);
>                                         smbd_disconnect_rdma_connection(info);
>                                 }
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Steve
