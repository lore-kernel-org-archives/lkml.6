Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeBZSFt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:05:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbeBZSFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:05:47 -0500
Date: Mon, 26 Feb 2018 18:05:48 +0000
From: Will Deacon <will.deacon@arm.com>
To: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc: peterz@infradead.org, willy@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] A couple of i_dir_seq fixes for fs/dcache.c
Message-ID: <20180226180547.GL26147@arm.com>
References: <1519052155-6361-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519052155-6361-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H Al,

On Mon, Feb 19, 2018 at 02:55:53PM +0000, Will Deacon wrote:
> This is version two of the patch I previously posted here:
> 
>   http://lkml.kernel.org/r/1518526731-26546-1-git-send-email-will.deacon@arm.com
> 
> Changes since v1:
> 
>   * Added READ_ONCE to i_dir_seq access
>   * Added tags
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> Will Deacon (2):
>   fs: dcache: Avoid livelock between d_alloc_parallel and __d_add
>   fs: dcache: Use READ_ONCE when accessing i_dir_seq
> 
>  fs/dcache.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Is there anything more you need from me on this series? I don't see it
queued anywhere and we're seeing this livelock hitting us in practice.

Cheers,

Will
