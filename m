Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754810AbeE2HCi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754626AbeE2HCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:02:32 -0400
Date: Tue, 29 May 2018 09:02:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Markus Elfring <elfring@users.sourceforge.net>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 102/496] drm/exynos: g2d: Delete an error message
 for a failed memory allocation in two functions
Message-ID: <20180529070211.GB2473@kroah.com>
References: <20180528100319.498712256@linuxfoundation.org>
 <20180528100324.148603249@linuxfoundation.org>
 <41d4c55b6e9ad7f68bdcbae6c3f8064938d58e68.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d4c55b6e9ad7f68bdcbae6c3f8064938d58e68.camel@perches.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 08:24:03AM -0700, Joe Perches wrote:
> On Mon, 2018-05-28 at 11:58 +0200, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> 
> I still wonder why any Markus Elfring patch should
> be applied to a stable branch.
> 
> The only reason I could believe is it would make
> forward porting of an actually useful fix easier.
> 
> Does this?

You are correct, it does not look like that at all.  I'll go drop it
from all of the stable queues.

thanks,

greg k-h
