Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755159AbeDZKdI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:33:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbeDZKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:33:06 -0400
Date: Thu, 26 Apr 2018 03:33:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: dsterba@suse.cz, Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-ID: <20180426103304.GA4639@infradead.org>
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org>
 <20180425205531.GA9020@avx2>
 <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:26:29PM +0200, David Sterba wrote:
> There are about 20k header files, none of them has #pragma once.
> Updating that will bring many unnesessry git commits.
> 
> I doubt that one more define in preprocessor tables is a problem we
> should fix. The LOC argument also does not sound very convincing. The
> include protection is at the top of the file, not mixed among other
> code. Replacing 2-3 lines with one will be barely noticeable.

Let's put it another way:  does this make any noticable difference
for compile times?
