Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDBQOe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53951 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbeDBQOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:14:31 -0400
Date: Mon, 2 Apr 2018 16:14:29 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk,
        torvalds@linux-foundation.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 002/109] kernel: use kernel_wait4() instead of sys_wait4()
Message-ID: <20180402161429.GS30543@wotan.suse.de>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
 <20180329112426.23043-3-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329112426.23043-3-linux@dominikbrodowski.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 01:22:39PM +0200, Dominik Brodowski wrote:
> All call sites of sys_wait4() set *rusage to NULL. Therefore, there is
> no need for the copy_to_user() handling of *rusage, and we can use
> kernel_wait4() directly.
> 
> This patch is part of a series which removes in-kernel calls to syscalls.
> On this basis, the syscall entry path can be streamlined. For details, see
> http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net
> 
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
