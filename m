Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165130AbeE1NIf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:08:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:55450 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163869AbeE1NIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:08:31 -0400
Date: Mon, 28 May 2018 07:08:28 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: doc: Italian translation
Message-ID: <20180528070828.3a3c7287@lwn.net>
In-Reply-To: <20180527145559.16411-1-federico.vaga@vaga.pv.it>
References: <20180527145559.16411-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2018 16:55:55 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> here the doc-guide translated in Italian. This set of patches includes
> some minor changes to the main one. The idea of this first set of patches
> is also to adjust the structure and our expectations.

I've only done a quick scan so far.  It looks reasonable, but I have a
couple of requests:

 - Please include a proper changelog with each patch describing what the
   patch does and why.  Otherwise I'll have to fill them in, and that
   makes me grumpy...:)

 - You might as well add a MAINTAINERS entry.  The other translations
   don't have them, but they should.

 - For extra credit: it's time to move the translations out of the
   top-level index into an index.rst in the translations directory.  Then
   the top-level file can have a single pointer to the translations.

> We tried to translate everything in **Italian**; which means that we avoided
> imported English words wherever there is the possibility to use the Italian
> ones. Of course, this is not always possible, or worst doing the translation
> make it less clear, for example the word "file".

"We"?  Is there somebody else's work represented here too?  If so, they
should appear in the signoff chain (or as a Co-developed-by credit).

> Another point. I noticed that the disclaimer for other translations is
> in English, so I did the same. But actually shouldn't be in Italian, since
> that page will be read by Italian speakers?

Perhaps, though part of the idea is to give the English speakers, too,
some vague clue of what they're looking at.

Thanks,

jon
