Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeEJCKT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 22:10:19 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33318 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756088AbeEJCKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 22:10:17 -0400
X-Google-Smtp-Source: AB8JxZrRYrAogaViDwnJPDh1ziuk+1lSvfDAbIcODBGqTLD9Y5QvAnmCoVlF6vIcJahfV+DtqQ0t8w==
Date: Wed, 9 May 2018 19:10:13 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the thermal tree
Message-ID: <20180510021011.GA3765@localhost.localdomain>
References: <20180509214341.1d490677@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509214341.1d490677@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Rui,

On Wed, May 09, 2018 at 09:43:41PM +1000, Stephen Rothwell wrote:
> Hi Zhang,
> 
> Commits
> 
>   a2ace598c00a ("thermal: exynos: Reading temperature makes sense only when TMU is turned on")
>   f9cd6a904e6e ("thermal: exynos: Propagate error value from tmu_read()")
> 
> are missing a Signed-off-by from their committer.

Did you cherry-pick them instead of merging? If cherry-picking you have
to add your Signed-off-by..

> 
> -- 
> Cheers,
> Stephen Rothwell
