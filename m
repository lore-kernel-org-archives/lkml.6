Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933565AbeBVRk2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:40:28 -0500
Received: from ms.lwn.net ([45.79.88.28]:52518 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933427AbeBVRk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:40:27 -0500
Date: Thu, 22 Feb 2018 10:40:24 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] doc: process: Add "Root-caused-by" and "Suggested-by"
Message-ID: <20180222104024.60408a75@lwn.net>
In-Reply-To: <20180222003749.GA4724@beast>
References: <20180222003749.GA4724@beast>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018 16:37:50 -0800
Kees Cook <keescook@chromium.org> wrote:

> As recently pointed out by Linus, "Root-caused-by" is a good tag to include
> since it can indicate significantly more work than "just" a Reported-by.
> This adds it and "Suggested-by" (which was also missing) to the documented
> list of tags. Additionally updates checkpatch.pl to match the process docs.

So I'm not really opposed to this, but I do wonder if we really need to
make a catalog of all the tags that might appear.  A quick grep turns up
stuff like:

	Niced-by
	Based-on-a-patch-by
	Debugged-by
	Requested-by
	Despised-by
	Improvements-by
	Tracked-by
	Analyzed-by
	Bisected-by
	Okay-ished-by
	\o/-by
	Pointed-at-by
	Brown-paper-bag-to-be-worn-by
	Not-longer-ranted-at-by
	Rightfully-ranted-at-by
	Helped-by
	Architected-by
	Also-posted-by
	Complained-about-by
	Mehed-by
	Reminded-by
	Actually-written-by
	Generated-by
	Historical-research-by

Some of these are arguably more useful than others, but I'm not sure we
want to bother documenting even an often-used subset of them.

That said, we can add this one; I'll take the patch if I get an ack from
Joe.

jon
