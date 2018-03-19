Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030263AbeCSRxZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:53:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55259 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965702AbeCSRxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:53:17 -0400
X-Google-Smtp-Source: AG47ELv8sh+BXFNQYNdL/QOnJpZWfT4efe32pEUf5bWKA1KKDeznM7GIQgWXccGoAPFv+xTTBebtxw==
Date: Mon, 19 Mar 2018 11:53:12 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Honggang LI <honli@redhat.com>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org, noaos@mellanox.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] IB/core: Set speed string to SDR for invalid active
 rates
Message-ID: <20180319175312.GE1225@ziepe.ca>
References: <20180315090214.21706-1-honli@redhat.com>
 <20180315090214.21706-2-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315090214.21706-2-honli@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 05:02:13PM +0800, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
> 
> commit f1b65df5a232 ("IB/mlx5: Add support for active_width and
> active_speed in RoCE"). Before this patch applied, the mlx5_ib
> driver set default active_width and active_speed to IB_WIDTH_4X
> and IB_SPEED_QDR.
> 
> Now, the active_width and active_speed are zeros if the RoCE port
> is in DOWN state. The speed string should be set to " SDR" instead of
> a blank string when active_speed is zero.
> 
> Signed-off-by: Honggang Li <honli@redhat.com>
>  drivers/infiniband/core/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
