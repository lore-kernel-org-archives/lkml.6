Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCIQ5q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:57:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751189AbeCIQ5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:57:44 -0500
Date: Fri, 9 Mar 2018 18:57:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        glider@google.com, dvyukov@google.com, davem@davemloft.net
Subject: Re: [PATCH net 0/3] Several fixes for vhost_net ptr_ring usage
Message-ID: <20180309185703-mutt-send-email-mst@kernel.org>
References: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 02:50:31PM +0800, Jason Wang wrote:
> Hi:
> 
> This small series try to fix several bugs of ptr_ring usage in
> vhost_net. Please review.
> 
> Thanks

ACK series, thanks Jason!

> Alexander Potapenko (1):
>   vhost_net: initialize rx_ring in vhost_net_open()
> 
> Jason Wang (2):
>   vhost_net: keep private_data and rx_ring synced
>   vhost_net: examine pointer types during un-producing
> 
>  drivers/net/tun.c      | 3 ++-
>  drivers/vhost/net.c    | 8 +++++---
>  include/linux/if_tun.h | 4 ++++
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.4
