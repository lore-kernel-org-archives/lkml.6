Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeBOFFY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 00:05:24 -0500
Received: from ozlabs.org ([103.22.144.67]:59359 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeBOFFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 00:05:23 -0500
Date: Thu, 15 Feb 2018 16:05:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Progyan Bhattacharya <bprogyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        narmstrong@baylibre.com, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Build: Scripts/Makefile: Remove Repeated Lines
Message-ID: <20180215160520.5828f900@canb.auug.org.au>
In-Reply-To: <CAGyWO1-9scERtpPw5CCwQcUbCU0SpcqpNq2eiBWRtwpRC-kB-A@mail.gmail.com>
References: <20180214092558.5846-1-progyanb@acm.org>
        <20180214224937.3f2feb80@canb.auug.org.au>
        <CAGyWO1-9scERtpPw5CCwQcUbCU0SpcqpNq2eiBWRtwpRC-kB-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Progyan,

On Thu, 15 Feb 2018 09:50:03 +0530 Progyan Bhattacharya <bprogyan@gmail.com> wrote:
>
> The last commit I have in here:
> 
> 8396647363e1 (origin/next, next) Add linux-next specific files for 20180206

I don't know where you got that from, as my copy of that commit has
SHA1 417c85c22818aefd973fa957b62fb1fe081404dd (as does the copy on
git.kernel.org).  So you do not have a clean copy of the linux-next tree.

> It was not building properly because of repeated lines in
> scripts/Makefile.kasan

That file is also correct in my next-20180206.

> PS: I have another question, Is use of range expression within case
> statements allowed in Kernel? If not, are we using If-Else ladder for that?

I am not sure if we have a policy on ranges in case labels, but it is
not standard C (well, C11 at least).  If-else ladders are certainly
common.

-- 
Cheers,
Stephen Rothwell
