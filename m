Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeCWIv4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:51:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37734 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeCWIvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:51:55 -0400
Date: Fri, 23 Mar 2018 09:51:53 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: please clean up the alpine tree
Message-ID: <20180323085153.GB9682@kwain>
References: <20180323083315.58976d73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180323083315.58976d73@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Mar 23, 2018 at 08:33:15AM +1100, Stephen Rothwell wrote:
> 
> The alpine tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/atenart/linux.git#alpine/for-next)
> only contains commits that have been upstreamed as different commits.
> It also hasn't been updated since late March 2017.  Please clean it up
> (it takes some time to merge - presumably just because of its age).
> 
> Or, if it is no longer being used, please let me know and I will remove
> it from linux-next.

Thanks for pointing this out, and sorry for the inconvenience. The
Alpine tree isn't very active and I haven't got patches for quite
some time.

I updated alpine/next to point to v4.16-rc1 to fix the issue. It's not
completely dead, but as it's not active you can also remove the
alpine/for-next tree from linux-next. And when/if I get patches to merge
in the future I'll ask to add it back. As you wish :)

Thank you for making linux-next!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
