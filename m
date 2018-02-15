Date: Thu, 15 Feb 2018 14:57:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Voegtle <tv@lio96.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>, stable@vger.kernel.org
Subject: Re: [STABLE 4.9.y PATCH 0/9] Backport of KVM Speculation Control
 support
Message-ID: <20180215135714.GA30750@kroah.com>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <alpine.LSU.2.20.1802151109550.14387@er-systems.de>
 <20180215102341.GA19398@kroah.com>
 <alpine.LSU.2.20.1802151148570.14387@er-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1802151148570.14387@er-systems.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 11:49:54AM +0100, Thomas Voegtle wrote:
> On Thu, 15 Feb 2018, Greg KH wrote:
> 
> > On Thu, Feb 15, 2018 at 11:15:41AM +0100, Thomas Voegtle wrote:
> > > 
> > > Hello,
> > > 
> > > On Tue, 6 Feb 2018, David Woodhouse wrote:
> > > 
> > > > I've put together a linux-4.9.y branch at
> > > > http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
> > > 
> > > 
> > > Are there any plans for a backport to v4.4?
> > > 
> > > I would volunteer for testing ;)
> > 
> > Care to volunteer to do the backport?  :)
> > 
> > Why do you need/want this type of thing for 4.4.y?  What is keeping you
> > from moving to 4.9.y instead?  Or even better yet, 4.14.y or 4.15, where
> > everything is fixed "correctly"?
> 
> 
> Puhh, I would love to do the backport but I had a quick look at the patch
> series and that is beyond my scope, I'm afraid. I'm a tester ;)
> 
> If there are no plans I know I have to move to a newer kernel, sadly.

You should always move to a newer kernel, what is holding you back from
doing that today?  Please, move to 4.14.y if you want a "LTS" kernel to
survive you for the year, and if not, then use 4.15.y please.

Seriously, staying on old kernels should not happen, unless you are
paying someone for support of such a thing (i.e. you have specific
hardware support only for an old kernel version.)

thanks,

greg k-h
