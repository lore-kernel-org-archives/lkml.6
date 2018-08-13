Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EDAC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A93F21770
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A93F21770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeHMMYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:24:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728313AbeHMMYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:24:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E1CA7CBBA;
        Mon, 13 Aug 2018 09:43:01 +0000 (UTC)
Received: from redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id A382D2142F20;
        Mon, 13 Aug 2018 09:42:58 +0000 (UTC)
Date:   Mon, 13 Aug 2018 12:42:57 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jasowang@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next] virtio_net: remove duplicated include from
 virtio_net.c
Message-ID: <20180813124251-mutt-send-email-mst@kernel.org>
References: <20180813061315.9084-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813061315.9084-1-yuehaibing@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 13 Aug 2018 09:43:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 13 Aug 2018 09:43:01 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 02:13:15PM +0800, YueHaibing wrote:
> Remove duplicated include linux/netdevice.h
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index eb00ae6..7659209 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -30,7 +30,6 @@
>  #include <linux/cpu.h>
>  #include <linux/average.h>
>  #include <linux/filter.h>
> -#include <linux/netdevice.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <net/route.h>
> -- 
> 2.7.0
> 
