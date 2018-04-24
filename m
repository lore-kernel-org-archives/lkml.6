Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeDXPtI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:49:08 -0400
Received: from imap.thunk.org ([74.207.234.97]:51780 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeDXPtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:49:07 -0400
Date: Tue, 24 Apr 2018 11:49:04 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180424154904.GC30619@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
 <20180424135621.GD4189@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424135621.GD4189@thunk.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 09:56:21AM -0400, Theodore Y. Ts'o wrote:
> On Tue, Apr 24, 2018 at 01:48:16PM +0200, Paul Menzel wrote:
> > Dear Linux folks,
> > 
> >
> > Since Linux 4.17-rcX, Linux spams a lot of `random: get_random_u32 called
> > from` messages. I believe, this setting should be reverted by default as
> > otherwise a lot of other messages are not seen.
> 
> Can you tell me a bit about your system?  What distribution, what
> hardware is present in your sytsem (what architecture, what
> peripherals are attached, etc.)?

Can you also send me your dmesg or kern.log so I can see where
get_random_u32 is getting called from during your system startup?

Thanks!

				- Ted
