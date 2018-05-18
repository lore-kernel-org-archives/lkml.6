Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeERQVa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:21:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeERQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:21:28 -0400
Date: Fri, 18 May 2018 09:21:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/10] block: Convert bio_set to mempool_init()
Message-ID: <20180518162128.GB25227@infradead.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <20180509013358.16399-3-kent.overstreet@gmail.com>
 <20180518162028.GA25227@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518162028.GA25227@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:20:28AM -0700, Christoph Hellwig wrote:
> On Tue, May 08, 2018 at 09:33:50PM -0400, Kent Overstreet wrote:
> > Minor performance improvement by getting rid of pointer indirections
> > from allocation/freeing fastpaths.
> 
> Can you please also send a long conversion for the remaining
> few bioset_create users?  It would be rather silly to keep two
> almost the same interfaces around for just about two hand full
> of users.

This comment was ment in reply to the next patch, sorry.
