Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754363AbeCUXZQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:25:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754328AbeCUXZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:25:12 -0400
Date: Wed, 21 Mar 2018 16:25:07 -0700
From: Darren Hart <dvhart@infradead.org>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] fujitsu-laptop: Consistent naming of constants
Message-ID: <20180321232507.GA24138@fury>
References: <20180227211539.5708-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227211539.5708-1-kernel@kempniu.pl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 10:15:32PM +0100, Michał Kępień wrote:
> This patch series is an attempt to organize all the named constants used
> throughout fujitsu-laptop so that their names more clearly convey their
> purpose: a set of prefixes is introduced to "map" constant names to
> call_fext_func() parameters.
> 
> The chosen constant naming patterns are a compromise between readability
> and enabling longer conditional expressions to fit into the 80-character
> line length limit.  Some changes (like those in patches 4/7 and 5/7) may
> be perceived as bikeshedding, so please just think of them as proposals,
> not fixes.
> 
> Finally, patch 7/7 again [1] proposes a set of helper functions which
> seem to be making quite a difference in terms of code readability in
> certain places (especially in long conditional expressions).  YMMV,
> though, feel free to disagree.
> 
> This patch series should be applied on top of for-next as it builds on
> the previous patch series I submitted.
> 
> [1] https://www.spinics.net/lists/platform-driver-x86/msg11633.html
> 
>  drivers/platform/x86/fujitsu-laptop.c | 228 +++++++++++++++++++---------------
>  1 file changed, 127 insertions(+), 101 deletions(-)

What I see here is an agreement on a simple integer listing for patch 1/7 per
Andy's latest reply. 7/7 appears to address Andy's concerns in 6/7. I agree they
KEY vs EVENT_HK is a bit of bikeshedding - but I don't have a preference and I
think overall the code is more readable for this series.

Based on feedback on a couple of the patches, a respin appears to be pending, so
I'm marking this series as "changes requested" and will await the v2.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
