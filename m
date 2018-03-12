Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeCLVRJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:17:09 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:51696 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932242AbeCLVRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:17:08 -0400
Date: Mon, 12 Mar 2018 21:01:52 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 04/35] syscalls: do not call sys_getpgid() within the
 kernel
Message-ID: <20180312200152.GF16666@light.dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180311105557.20807-5-linux@dominikbrodowski.net>
 <20180312083517.GA11010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312083517.GA11010@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 01:35:17AM -0700, Christoph Hellwig wrote:
> The subject (and lack of description) for this and the following patches
> is rather confusing.
> 
> I'd expect something like:
> 
> ---- snip ----
> Subject: kernel: add a do_getpgid helper
> 
> And use it to avoid an in-kernel sys_getpgid call.
> 
> ---- snip ----
> 
> instead.

Thanks, will expand the commit messages a bit.

	Dominik
