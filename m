Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbeBIMNp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:13:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33828 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeBIMNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:13:43 -0500
Subject: NAK: [PATCH] CIFS: SMBD: fix spelling mistake: "faield" -> "failed"
From: Colin Ian King <colin.king@canonical.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180209115936.32569-1-colin.king@canonical.com>
Message-ID: <280fa85a-a5f8-bc89-447b-c97886f3bc23@canonical.com>
Date: Fri, 9 Feb 2018 12:13:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209115936.32569-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 11:59, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in log_rdma_mr message text.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/cifs/smbdirect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 91710eb571fb..5405856a4c8e 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -2295,7 +2295,7 @@ static void smbd_mr_recovery_work(struct work_struct *work)
>  				rc = ib_dereg_mr(smbdirect_mr->mr);
>  				if (rc) {
>  					log_rdma_mr(ERR,
> -						"ib_dereg_mr faield rc=%x\n",
> +						"ib_dereg_mr failed rc=%x\n",
>  						rc);
>  					smbd_disconnect_rdma_connection(info);
>  				}
> 

Ignore this, I found another typo in the source, will re-send a V2.
