Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeEJUWk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:22:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:59174 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbeEJUWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:22:38 -0400
Date: Thu, 10 May 2018 14:22:35 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] Fix some doc build warnings/errors and broken
 links
Message-ID: <20180510142235.221da447@lwn.net>
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 May 2018 10:18:43 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Patches 1 to 5 on this series contain the patches that weren't yet
> applied from the past patch series and touch only at Documentation.
> There are two changes there:
>   patch 2: fixed the description and added a c/c to cgroup maintainers;
>   patch 4: rewritten according with Louis request, droping several hunks.

Of these, I've applied 2, 4, and 6.  The networking and crypto folks like
to apply their own documentation fixes; I assume they'll pick these up.

> Patch 6 rewrites scripts/documentation-file-ref-check on Perl,
> adding an auto-fix feature.

Applied this one.

> Patches 7 and 8 fix things that would cause troubles for the
> automatic autocorrection tool.

#7 is applied.  #8 doesn't apply, though; I'm not sure which tree you made
it against?  In any case, I've stopped here for now.

> Patch 9 touches a lot of random places (including MAINTAINERS)
> that contain broken links and can be auto-fixed. It could be
> broken into one patch per touched file, but I think that is
> overkill. 

Let's keep this one (and the ones that follow) aside.  I'm happy to apply
them, but I think they are best applied as an end-of-merge-window thing.  I
envision lots of conflicts, and I already have a pile of those to explain
to Linus this time around.

Sound good?

Thanks,

jon
