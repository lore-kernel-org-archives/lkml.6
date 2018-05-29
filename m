Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755299AbeE2IFN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:05:13 -0400
Received: from verein.lst.de ([213.95.11.211]:53830 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754938AbeE2IFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:05:07 -0400
Date: Tue, 29 May 2018 10:11:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: prefer strlcpy to strncpy
Message-ID: <20180529081117.GA1416@lst.de>
References: <1527576558-26817-1-git-send-email-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527576558-26817-1-git-send-email-nick.desaulniers@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:49:18PM -0700, Nick Desaulniers wrote:
> Fixes a stringop-truncation warning from gcc-8.

What would that warning be?  Maybe it actually is genuinly useful,
and switching to strlcpy just papers over it..
