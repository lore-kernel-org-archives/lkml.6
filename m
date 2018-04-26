Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755628AbeDZTZr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:25:47 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36164 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755422AbeDZTZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:25:43 -0400
X-Google-Smtp-Source: AIpwx4+nXElH3uhRQaXEi4F0wcwfrah23SUd9PE+Bzo1FQUjFFqC9DUmDF24OniR5obBH7BTedLhvA==
Date: Thu, 26 Apr 2018 22:25:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: dsterba@suse.cz, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-ID: <20180426192538.GB4919@avx2>
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org>
 <20180425205531.GA9020@avx2>
 <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
 <20180426103304.GA4639@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180426103304.GA4639@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 03:33:04AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 26, 2018 at 12:26:29PM +0200, David Sterba wrote:
> > There are about 20k header files, none of them has #pragma once.
> > Updating that will bring many unnesessry git commits.
> > 
> > I doubt that one more define in preprocessor tables is a problem we
> > should fix. The LOC argument also does not sound very convincing. The
> > include protection is at the top of the file, not mixed among other
> > code. Replacing 2-3 lines with one will be barely noticeable.
> 
> Let's put it another way:  does this make any noticable difference
> for compile times?

Should be the same as include guard pattern is recognized and becomes
#pragma once internally.
