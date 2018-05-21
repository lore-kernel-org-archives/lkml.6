Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeEUPEh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:04:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752817AbeEUPEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:04:33 -0400
Date: Mon, 21 May 2018 18:04:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] Fix several issues of virtio-net mergeable XDP
Message-ID: <20180521180405-mutt-send-email-mst@kernel.org>
References: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 04:35:02PM +0800, Jason Wang wrote:
> Hi:
> 
> Please review the patches that tries to fix sevreal issues of
> virtio-net mergeable XDP.
> 
> Thanks

I think we should do 3/4 differently.
The rest looks good, and probably needed on stable.

Thanks!

> Jason Wang (4):
>   virtio-net: correctly redirect linearized packet
>   virtio-net: correctly transmit XDP buff after linearizing
>   virtio-net: reset num_buf to 1 after linearizing packet
>   virito-net: fix leaking page for gso packet during mergeable XDP
> 
>  drivers/net/virtio_net.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> -- 
> 2.7.4
