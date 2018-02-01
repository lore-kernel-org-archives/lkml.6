Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeBASO4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:14:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:42324 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbeBASOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:14:52 -0500
Date: Thu, 1 Feb 2018 11:14:50 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        jani.nikula@linux.intel.com
Subject: Re: [PATCH v2] Documentation/process: kernel maintainer PGP guide
Message-ID: <20180201111450.646b9974@lwn.net>
In-Reply-To: <20180201144233.GA19712@gmail.com>
References: <20180130184917.GA32095@gmail.com>
        <20180201144233.GA19712@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2018 09:42:33 -0500
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> This guide is an adapted version of the more general "Protecting Code
> Integrity" guide written and maintained by The Linux Foundation IT for
> use with open-source projects. It provides the oft-lacking guidance on
> the following topics:
> 
> - how to properly protect one's PGP keys to minimize the risks of them
>   being stolen and used maliciously to impersonate a kernel developer
> - how to configure Git to properly use GnuPG
> - when and how to use PGP with Git
> - how to verify fellow Linux Kernel developer identities
> 
> I believe this document should live with the rest of the documentation
> describing proper processes one should follow when participating in
> kernel development. Placing it in a wiki on some place like kernel.org
> would be insufficient for a number of reasons -- primarily, because only
> a relatively small subset of maintainers have accounts on kernel.org,
> but also because even those who do rarely remember that such wiki
> exists. Keeping it with the rest of in-kernel docs should hopefully give
> it more visibility, but also help keep it up-to-date as tools and
> processes evolve.
> 
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

OK, I've been through all of this.  Naturally, I have a few quibbles:

 - Capitalizing "Kernel" bugs me.  Obviously not a big deal.

 - The "master keys vs. subkeys" section is nice, but it's missing one
   thing, IMO: a sentence saying what a subkey *is* in the first place.

 - We don't normally endorse commercial products in kernel docs.  OTOH, I
   don't see any other way for people to know which keycards they should
   get. This section is sure to go obsolete as products come and go,
   though - you're on the hook for maintaining it :)

 - The suggestion to sign individual commits is, as I understand it,
   controversial (Linus doesn't agree with it) and is 100% contrary to
   current practice.  Are there any signed commits in the kernel repo
   now?  Given that, I'm a bit nervous about putting commit-signing
   forward as standard practice.

 - I'm not quite sure what the "finding paths to Linus" link is supposed
   to do for the reader.

Anyway, these are all quibbles, and I think the documentation is
definitely improved by having this, so I'm going ahead and applying it.
It may be worth considering some tweaks for the issues above, though, as
time allows.

Thanks,

jon
