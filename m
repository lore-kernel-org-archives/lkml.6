Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDXPzW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:55:22 -0400
Received: from imap.thunk.org ([74.207.234.97]:51830 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751285AbeDXPzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:55:16 -0400
Date: Tue, 24 Apr 2018 11:55:13 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG, PATCH] random: sleep in irq context
Message-ID: <20180424155513.GD30619@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sebastian Ott <sebott@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <alpine.LFD.2.21.1804231518060.1767@schleppi>
 <alpine.LFD.2.21.1804241037590.1601@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1804241037590.1601@schleppi>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 10:40:36AM +0200, Sebastian Ott wrote:
> On Mon, 23 Apr 2018, Sebastian Ott wrote:
> > This happend once during boot and I could not reproduce this since, but I
> > think the following patch should fix the issue:
> 
> I can now recreate the issue reliably. The following patch works for me:

I have a patch in the random tree that I will be pushing to Linus
shortly.  It uses a slightly different approach than yours, but should
address the problem you observed.

   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1672186.html

							- Ted
