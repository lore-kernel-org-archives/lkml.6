Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeERGmu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:42:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERGms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:42:48 -0400
Date: Thu, 17 May 2018 23:42:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Talpey <tom@talpey.com>
Cc: longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 00/09] Implement direct user I/O interfaces for RDMA
Message-ID: <20180518064245.GA9425@infradead.org>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <d5eaf67d-4b0d-9206-a016-67cb3b5a0df8@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5eaf67d-4b0d-9206-a016-67cb3b5a0df8@talpey.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 07:10:04PM -0400, Tom Talpey wrote:
> What's the security risk? This type of direct i/o behavior is not
> uncommon, and can certainly be made safe, using the appropriate
> memory registration and protection domains. Any risk needs to be
> stated explicitly, and mitigation provided, or at least described.

And in fact it is the same behavior you'll see on NFS over RDMA, or
a block device or any local fs over SRP/iSER/NVMe over Fabrics..
