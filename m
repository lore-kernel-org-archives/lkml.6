Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934844AbeB1VN4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:13:56 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40562 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933074AbeB1VNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:13:55 -0500
X-Google-Smtp-Source: AG47ELvjS3HXIVPObjV1tUr6hSOHfeJOILY3uIC2TK6FjPpyimVeZo+vk2IjEBB9ugm+0Fovc1oqXA==
Date: Wed, 28 Feb 2018 14:13:47 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-rdma@vger.kernel.org, Christian Benvenuti <benve@cisco.com>,
        Dave Goodell <dgoodell@cisco.com>, Doug Ledford <dledford@redhat.com>,
        Roland Dreier <roland@purestorage.com>,
        Upinder Malhi <umalhi@cisco.com>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/usnic: Delete an error message for a failed memory
 allocation in usnic_transport_init()
Message-ID: <20180228211347.GA13394@ziepe.ca>
References: <d9b22086-13d0-b519-3126-937a531d93d2@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b22086-13d0-b519-3126-937a531d93d2@users.sourceforge.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2018 at 08:15:17PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 27 Jan 2018 20:06:59 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>  drivers/infiniband/hw/usnic/usnic_transport.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to for-next

Jason
