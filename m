Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeERQXR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:23:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeERQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:23:15 -0400
Date: Fri, 18 May 2018 09:23:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Message-ID: <20180518162314.GC25227@infradead.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <b3970608-95dd-3d4f-140c-3d7cbd12cf8d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3970608-95dd-3d4f-140c-3d7cbd12cf8d@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 03:13:38PM -0600, Jens Axboe wrote:
> Looked over the series, and looks like both good cleanups and optimizations.
> If we can get the mempool patch sorted, I can apply this for 4.18.

FYI, I agree on the actual cleanups and optimization, but we really
shouldn't add new functions or even just exports without the code
using them.  I think it is enough if we can collect ACKs on them, but
there is no point in using them.  Especially as I'd really like to see
the users for some of them first.
