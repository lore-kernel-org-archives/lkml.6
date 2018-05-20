Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeETWRl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 18:17:41 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45093 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeETWRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 18:17:38 -0400
X-Google-Smtp-Source: AB8JxZqqvNpRjEmOIfdokaUUe5+zr+p0l+aFEIH/D9FJcZsLe3ltsfkK6XU9HN1CSgKeJKCwtGNdyQ==
Date: Sun, 20 May 2018 18:17:33 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Message-ID: <20180520221733.GA11495@kmo-pixel>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
 <20180518090636.GA14738@kmo-pixel>
 <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:12:27PM +0000, Bart Van Assche wrote:
> On Fri, 2018-05-18 at 05:06 -0400, Kent Overstreet wrote:
> > On Thu, May 17, 2018 at 08:54:57PM +0000, Bart Van Assche wrote:
> > > With Jens' latest for-next branch I hit the kernel warning shown below. Can
> > > you have a look?
> > 
> > Any hints on how to reproduce it?
> 
> Sure. This is how I triggered it:
> * Clone https://github.com/bvanassche/srp-test.
> * Follow the instructions in README.md.
> * Run srp-test/run_tests -c -r 10

Can you bisect it? I don't have infiniband hardware handy...
