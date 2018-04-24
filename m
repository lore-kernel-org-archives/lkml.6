Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933555AbeDXN7Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:59:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757994AbeDXN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:59:09 -0400
Date: Tue, 24 Apr 2018 06:59:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Huacai Chen <chenhc@lemote.com>,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180424135900.GA11224@infradead.org>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 01:55:54PM +0100, Matt Redfearn wrote:
> The core oprofile code in drivers/oprofile/ has not seeen significant
> maintenance other than fixes to changes in other parts of the tree for
> the last 5 years at least. It looks as through the perf tool has
> more or less superceeded it's functionality.
> Additionally the MIPS architecture support has bitrotted to an extent
> meaning it is not currently functional.

I wonder if time has come to drop oprofile support entirely.

(in addition to your patch which seems more urgent)
