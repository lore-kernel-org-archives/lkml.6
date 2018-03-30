Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeC3HGx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:06:53 -0400
Received: from verein.lst.de ([213.95.11.211]:53845 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbeC3HGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:06:52 -0400
Date: Fri, 30 Mar 2018 09:06:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baegjae Sung <baegjae@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
        axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eric Chang <echang@sk.com>
Subject: Re: [PATCH] nvme-multipath: implement active-active round-robin
        path selector
Message-ID: <20180330070651.GA17095@lst.de>
References: <20180327043851.6640-1-baegjae@gmail.com> <20180328080646.GB20373@lst.de> <20180328194741.GJ13039@localhost.localdomain> <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 01:57:25PM +0900, Baegjae Sung wrote:
> Our prototype uses dual-ported PCIe NVMe connected to a single host. The
> host's HBA is connected to two switches,

What "HBA"?  We are talking about NVMe here..
