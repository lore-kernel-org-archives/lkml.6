Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeCTNqg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:46:36 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:31369 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbeCTNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:46:34 -0400
Date: Tue, 20 Mar 2018 19:15:06 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Message-ID: <20180320134505.GB25623@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <20180319152722.GA31104@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319152722.GA31104@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 03/19/18, 2018 at 20:57:22 +0530, Christoph Hellwig wrote:
> On Mon, Mar 19, 2018 at 07:50:33PM +0530, Rahul Lakkireddy wrote:
> > This series of patches add support for 256-bit IO read and write.
> > The APIs are readqq and writeqq (quad quadword - 4 x 64), that read
> > and write 256-bits at a time from IO, respectively.
> 
> What a horrible name.  please encode the actual number of bits instead.

Ok.  Will change it to read256() and write256().

Thanks,
Rahul
