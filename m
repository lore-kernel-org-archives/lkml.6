Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeERRiZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:38:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43415 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeERRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:38:22 -0400
X-Google-Smtp-Source: AB8JxZoB9yv82mTj+cpI+rYtG9UFzaXPHVQDlSnIz8eXK/k750S5ejnbLohuuM0usFvhXMP4mFvAVA==
Date: Fri, 18 May 2018 13:38:18 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: Re: [PATCH 06/10] Generic radix trees
Message-ID: <20180518173818.GC31737@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-13-kent.overstreet@gmail.com>
 <20180518160203.GC22791@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518160203.GC22791@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:02:03AM -0700, Christoph Hellwig wrote:
> Completely lacks any explanation, including why this should be
> in lib/.  Also should come in the same series with actual users
> of the infrastructure.

Also in the cover letter...

 * Generic radix trees

 This is a very simple radix tree implementation that can store types of
 arbitrary size, not just pointers/unsigned long. It could probably replace
 flex arrays.
