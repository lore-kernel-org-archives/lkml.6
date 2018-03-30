Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeC3PfW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:35:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:59900 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeC3PfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:35:20 -0400
Date: Fri, 30 Mar 2018 09:35:18 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        viro@zeniv.linux.org.uk, x86@kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, luto@amacapital.net
Subject: Re: [PATCH] syscalls: define and explain goal to not call syscalls
 in the kernel
Message-ID: <20180330093518.3d8a92f3@lwn.net>
In-Reply-To: <20180325162527.GA17492@light.dominikbrodowski.net>
References: <20180325162527.GA17492@light.dominikbrodowski.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2018 18:25:27 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> As there have been multiple inquiries on the rationale of my patchsets
> removing in-kernel calls to sys_xyzzy(), here is an updated patch 01/NN
> which I will push upstream for v4.17-rc1. I will also include a reference
> to this mail (and therefore to the explanation below) in all related
> patches of the series. Any improvements, hints, suggestions, spelling
> fixes, and/or objections?

I have no objections to the text, but I do wonder about the placement.
The "adding syscalls" document isn't about *invoking* them; I suspect that
few people will see it there.  The coding-style document isn't quite right
either, but I wonder if it might not be a better place in the short term?

What we may really need is an "assorted rules" document that sits near
coding style; we can put stuff like this text, "volatile considered
harmful", and so on there.

Thanks,

jon
