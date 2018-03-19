Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbeCSP10 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:27:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755497AbeCSP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:27:25 -0400
Date: Mon, 19 Mar 2018 08:27:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        davem@davemloft.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Message-ID: <20180319152722.GA31104@infradead.org>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 07:50:33PM +0530, Rahul Lakkireddy wrote:
> This series of patches add support for 256-bit IO read and write.
> The APIs are readqq and writeqq (quad quadword - 4 x 64), that read
> and write 256-bits at a time from IO, respectively.

What a horrible name.  please encode the actual number of bits instead.
