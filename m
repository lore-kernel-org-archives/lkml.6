Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDKXRv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:17:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeDKXRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:17:50 -0400
Date: Wed, 11 Apr 2018 16:17:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc: fixup (c) sign
Message-Id: <20180411161748.870b31eb6293070f9928589f@linux-foundation.org>
In-Reply-To: <CA+55aFxrpn=GdgqgrczUdj-wndFdQvmfytwMiYL5=TQWhfpAjA@mail.gmail.com>
References: <CA+55aFxrpn=GdgqgrczUdj-wndFdQvmfytwMiYL5=TQWhfpAjA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 15:41:26 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Apr 11, 2018 at 1:24 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > It got sent from here as iso8859-1.
> 
> It's probably a good idea to just move away from Latin1 entirely, and
> encourage people to just use utf-8.

I had "set ttycharset=utf8" in .mailrc and when presented with Alexey's
patch heirloom-mailx said "Failed to create encoded message: Invalid or
incomplete multibyte or wide character".

After removing that line from .mailrc, hairloom-mailx did the offending
corruption.

Adding "set ttycharset=iso8859-1" to .mailrc permits Alexey's patch to
go through as-is.  But I assume it has broken something else :(

> But yes, Andrew's scripts clearly do a horrible job at looking at
> email encoding, and that really should be fixed.
> 
> I worry less about silly copyright signs than about peoples actual
> _names_, but we've certainly seen problems there too.

That's all fixed, afaik.
