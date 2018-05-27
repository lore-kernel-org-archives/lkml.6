Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934508AbeE0GkK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 02:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933685AbeE0GkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 02:40:08 -0400
Date: Sun, 27 May 2018 08:39:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: gadget: ccid: add support for USB CCID Gadget
 Device
Message-ID: <20180527063946.GA1232@kroah.com>
References: <20180526203401.16586-1-marcus.folkesson@gmail.com>
 <20180526205652.GA25534@kroah.com>
 <20180527054847.GB22105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527054847.GB22105@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 07:48:47AM +0200, Marcus Folkesson wrote:
> On Sat, May 26, 2018 at 10:56:52PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, May 26, 2018 at 10:33:59PM +0200, Marcus Folkesson wrote:
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > 
> > I can't take patches without any changelog text.  And why would you
> > submit a patch over 1000 lines without any?
> 
> I'm sorry, obviously not much went well for me yesterday.
> The changlelog was "fixup:ed" away and now I noticed that my
> patch version history did not follow for v2.
> 
> Is it better to send a v3 with updated version history or wait for more
> comments?

Nah, that's fine, but I'll let Felipe decide as he is the one that has
to review this, not me.

thanks,

greg k-h
