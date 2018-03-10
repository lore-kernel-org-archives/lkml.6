Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeCJATV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:19:21 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56834 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932970AbeCJATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:19:18 -0500
Date: Sat, 10 Mar 2018 01:19:16 +0100
From: Florian Westphal <fw@strlen.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com, xiyou.wangcong@gmail.com, fw@strlen.de
Subject: Re: [PATCH] proc: reject "." and ".." as filenames
Message-ID: <20180310001916.GB11882@breakpoint.cc>
References: <20180310001223.GB12443@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310001223.GB12443@avx2>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Various subsystems can create files and directories in /proc
> with names directly controlled by userspace.
> 
> Which means "/", "." and ".." are no-no.
> 
> "/" split is already taken care of, do the other 2 prohibited names.

Acked-by: Florian Westphal <fw@strlen.de>

I'll send a patch for xtables too to reject bogus names
coming from userspace (syzbot reports WARN() ).
