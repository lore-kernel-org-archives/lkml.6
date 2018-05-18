Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeERQCu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:02:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeERQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:02:46 -0400
Date: Fri, 18 May 2018 09:02:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: Re: [PATCH 10/10] Dynamic fault injection
Message-ID: <20180518160245.GE22791@infradead.org>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-21-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518074918.13816-21-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:49:18AM -0400, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

Completely lacks any explanation or argument why it would be useful.
