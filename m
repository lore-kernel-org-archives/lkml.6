Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeFAHh0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:37:26 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39581 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750729AbeFAHhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:37:24 -0400
X-ME-Proxy: <xmx:sfcQW3aHl5Odi1YSqYuMtPTQ_ctUkJZ-CR2ULnyFPOnTyrIQ9KUGuA>
X-ME-Proxy: <xmx:sfcQW-TL1YLY-0n3iai-7SbOSKbtOpJbvzYTvuI5rSn_rWbpUapc8w>
X-ME-Proxy: <xmx:sfcQW4wSfEWy7JOSLWo1c_PpBN35Lx_sweWo5b0kNPb_E3TzuUaW7Q>
X-ME-Proxy: <xmx:sfcQWzv7Y8zmdJ1qH5j-0LPyCsrEgu0YKnD0gjey00uAKARKWFJe3Q>
X-ME-Proxy: <xmx:sfcQW31OsCv4YB1eXmIBnZdk-v97t2X6ZIGQp7slQLQiTJb-M7Nrig>
X-ME-Proxy: <xmx:sfcQWzsZ8FESvwo4qspJ1vB-lmgzCWNAfPHgYdktS5ugHeomHNwvVw>
X-ME-Sender: <xms:sfcQW85ErIS1Y7mpjU9tSQ2bDF8NIoCC5QBjfoO2XuKGCkH1yCRt_Q>
Date: Fri, 1 Jun 2018 09:37:00 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Liu <liumartin@google.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 dma-mapping tree
Message-ID: <20180601073700.GA12809@kroah.com>
References: <20180601170825.622c7084@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601170825.622c7084@canb.auug.org.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 05:08:25PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   include/linux/device.h
> 
> between commit:
> 
>   3d6ce86ee794 ("drivers: remove force dma flag from buses")
> 
> from the dma-mapping tree and commit:
> 
>   8c97a46af04b ("driver core: hold dev's parent lock when needed")
> 
> from the driver-core tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fix looks great to me, thanks for this.

greg k-h
