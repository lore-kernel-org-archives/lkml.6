Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754224AbeE2Ffv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:35:51 -0400
Received: from verein.lst.de ([213.95.11.211]:53181 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeE2Ffq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:35:46 -0400
Date: Tue, 29 May 2018 07:41:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20180529054155.GA31118@lst.de>
References: <20180529134209.4b8353f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529134209.4b8353f1@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [Christoph, I noticed that the comment above datagram_poll in
> net/core/datagram.c needs the function name updated]

I'll send a fix for that.

> 
> I have added the following merge fix patch for today:

This looks correct, thanks!
