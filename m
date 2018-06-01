Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeFAKwL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:52:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:17417 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbeFAKwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:52:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="233779874"
Date: Fri, 1 Jun 2018 18:52:14 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] [PATCH] virtio: update the comments for transport
 features
Message-ID: <20180601105214.GA9250@debian>
References: <20180601102217.21628-1-tiwei.bie@intel.com>
 <20180601124552.6a188454.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601124552.6a188454.cohuck@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 12:45:52PM +0200, Cornelia Huck wrote:
> On Fri,  1 Jun 2018 18:22:17 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> > This patch is generated on top of below patch:
> > https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html
> > 
> >  include/uapi/linux/virtio_config.h | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index b7c1f4e7d59e..479affd903e9 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -45,9 +45,12 @@
> >  /* We've given up on this device. */
> >  #define VIRTIO_CONFIG_S_FAILED		0x80
> >  
> > -/* Some virtio feature bits (currently bits 28 through 32) are reserved for the
> > - * transport being used (eg. virtio_ring), the rest are per-device feature
> > - * bits. */
> > +/*
> > + * Some virtio feature bits (currently bits VIRTIO_TRANSPORT_F_START
> > + * through VIRTIO_TRANSPORT_F_END) are reserved for the transport being
> 
> It will always be bits up to VIRTIO_TRANSPORT_F_END, no? So you can drop
> the "currently"?
> 
> Or reword as "Virtio feature bits VIRTIO_TRANSPORT_F_START through
> VIRTIO_TRANSPORT_F_END are reserved..."?

I will do it. Thanks for the suggestion!

Best regards,
Tiwei Bie
