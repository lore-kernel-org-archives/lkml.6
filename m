Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeERJwP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:52:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55828 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeERJwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:52:13 -0400
Date: Fri, 18 May 2018 11:52:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 04/10] locking: export osq_lock()/osq_unlock()
Message-ID: <20180518095204.GF12217@hirez.programming.kicks-ass.net>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-9-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518074918.13816-9-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:49:06AM -0400, Kent Overstreet wrote:

No.. and most certainly not without a _very_ good reason.
