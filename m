Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeC2NuP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:50:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeC2NuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:50:14 -0400
Date: Thu, 29 Mar 2018 16:49:57 +0300
From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To: Colin King <colin.king@canonical.com>
Cc: Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qedr: ix spelling mistake: "hanlde" -> "handle"
Message-ID: <20180329134957.GA29272@srabinov-linux.nl.oracle.com>
References: <20180329121107.27248-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329121107.27248-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=462
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803290140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 01:11:07PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in DP_ERR message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/qedr/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
> index 1f032fdbdb19..36d60d3c1630 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -708,7 +708,7 @@ static void qedr_affiliated_event(void *context, u8 e_code, void *fw_handle)
>  			     "Error: CQ event with NULL pointer ibcq. Handle=%llx\n",
>  			     roce_handle64);
>  		}
> -		DP_ERR(dev, "CQ event %d on hanlde %p\n", e_code, cq);
> +		DP_ERR(dev, "CQ event %d on handle %p\n", e_code, cq);
>  		break;
>  	case EVENT_TYPE_QP:
>  		qp = (struct qedr_qp *)(uintptr_t)roce_handle64;
> @@ -724,7 +724,7 @@ static void qedr_affiliated_event(void *context, u8 e_code, void *fw_handle)
>  			     "Error: QP event with NULL pointer ibqp. Handle=%llx\n",
>  			     roce_handle64);
>  		}
> -		DP_ERR(dev, "QP event %d on hanlde %p\n", e_code, qp);
> +		DP_ERR(dev, "QP event %d on handle %p\n", e_code, qp);
>  		break;
>  	default:
>  		break;
> -- 
> 2.15.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Reviewed-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
