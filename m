Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5287FC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322FD20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322FD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeJWCoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:44:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJWCoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:44:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 584DB36807;
        Mon, 22 Oct 2018 18:25:18 +0000 (UTC)
Received: from redhat.com (ovpn-125-212.rdu2.redhat.com [10.10.125.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id E498960162;
        Mon, 22 Oct 2018 18:25:14 +0000 (UTC)
Date:   Mon, 22 Oct 2018 14:25:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Joe Perches <joe@perches.com>, stefanha@redhat.com
Subject: Re: [PATCH] MAINTAINERS: remove reference to bogus vsock file
Message-ID: <20181022142504-mutt-send-email-mst@kernel.org>
References: <20181012154637.13242-1-stefanha@redhat.com>
 <20181022123950.GA4857@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022123950.GA4857@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 22 Oct 2018 18:25:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:39:50PM +0100, Stefan Hajnoczi wrote:
> On Fri, Oct 12, 2018 at 04:46:37PM +0100, Stefan Hajnoczi wrote:
> > The file drivers/vhost/vsock.h never existed.  Remove the bogus
> > MAINTAINERS reference.
> > 
> > Fixes: 433fc58e6bf2c8bd97e57153ed28e64fd78207b8 ("VSOCK: Introduce vhost_vsock.ko")
> > Reported-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Michael: Can this patch go through your tree, it's related to a vhost
> vsock file?
> 
> Thanks!

I'll merge it, thanks!

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 40082e45b3da..05191d706bb8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15529,7 +15529,6 @@ F:	net/vmw_vsock/virtio_transport_common.c
> >  F:	net/vmw_vsock/virtio_transport.c
> >  F:	drivers/net/vsockmon.c
> >  F:	drivers/vhost/vsock.c
> > -F:	drivers/vhost/vsock.h
> >  F:	tools/testing/vsock/
> >  
> >  VIRTIO CONSOLE DRIVER
> > -- 
> > 2.17.2
> > 


