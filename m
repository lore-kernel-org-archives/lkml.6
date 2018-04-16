Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeDPSGw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:06:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:58332 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbeDPSGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:06:51 -0400
Date: Mon, 16 Apr 2018 12:06:50 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.17-rc1
Message-ID: <20180416120650.6174a601@lwn.net>
In-Reply-To: <CA+55aFx62iBkj+hOmhLksUtvjwTcm_o1dwcyvaNnVpJ-AmvzVQ@mail.gmail.com>
References: <CA+55aFx62iBkj+hOmhLksUtvjwTcm_o1dwcyvaNnVpJ-AmvzVQ@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Apr 2018 18:55:38 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> End result: we actually removed more lines than we added:
> 
>  13538 files changed, 627723 insertions(+), 818855 deletions(-)
> 
> which is probably a first. Ever. In the history of the universe. Or at
> least kernel releases.

For the curious...that's not quite the case.  We shrunk a bit for 2.6.36,
due to the removal of all those defconfig files.  3.17 was also slightly
smaller than 3.16 - removal of POWER3 and a whole bunch of staging stuff.
So...third time's the charm!

Of course, one could look at the numbers involved and conclude that a
release with more lines removed than added is a harbinger of a dot-zero
release in the near future :)

jon
