Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeFALWi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:22:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:55371 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeFALWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:22:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="53980910"
Date: Fri, 1 Jun 2018 19:22:50 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v2] virtio: update the comments for transport features
Message-ID: <20180601112250.GA11839@debian>
References: <20180601105950.10632-1-tiwei.bie@intel.com>
 <20180601131647.5d02da18.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601131647.5d02da18.cohuck@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 01:16:47PM +0200, Cornelia Huck wrote:
> On Fri,  1 Jun 2018 18:59:50 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > The existing comments for transport features are out dated.
> 
> s/out dated/outdated/

Thanks for catching this typo!

> 
[...]
> > +/*
> > + * Virtio feature bits VIRTIO_TRANSPORT_F_START through
> > + * VIRTIO_TRANSPORT_F_END are reserved for the transport
> > + * being used (e.g. virtio_ring, virtio_pci etc.), the
> > + * rest are per-device feature bits.
> > + */
> >  #define VIRTIO_TRANSPORT_F_START	28
> >  #define VIRTIO_TRANSPORT_F_END		38
> >  
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks for your review!

Best regards,
Tiwei Bie
