Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759903AbeD1MWd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 08:22:33 -0400
Received: from linode.aoot.com ([69.164.194.13]:58162 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759873AbeD1MWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 08:22:32 -0400
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'YueHaibing'" <yuehaibing@huawei.com>, <swise@chelsio.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <monis@mellanox.com>
Cc: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180428073106.14696-1-yuehaibing@huawei.com>
In-Reply-To: <20180428073106.14696-1-yuehaibing@huawei.com>
Subject: RE: [PATCH] IB/cxgb4: use skb_put_zero()/__skb_put_zero
Date: Sat, 28 Apr 2018 06:53:37 -0500
Message-ID: <004f01d3dee7$8b5c4cd0$a214e670$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGRfgu0UKgZ2PsiFduoNL3eEsI8TKSa0qsQ
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Saturday, April 28, 2018 2:31 AM
> To: swise@chelsio.com; dledford@redhat.com; jgg@ziepe.ca;
> monis@mellanox.com
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH] IB/cxgb4: use skb_put_zero()/__skb_put_zero
> 
> Use the recently introduced helper to replace the pattern of
> skb_put_zero/__skb_put() && memset().
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Looks ok.

Reviewed-by: Steve Wise <swise@opengridcomputing.com>
