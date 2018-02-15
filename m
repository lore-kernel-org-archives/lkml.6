Date: Thu, 15 Feb 2018 11:23:41 +0100
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
Message-ID: <20180215102341.GA19398@kroah.com>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <alpine.LSU.2.20.1802151109550.14387@er-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1802151109550.14387@er-systems.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 11:15:41AM +0100, Thomas Voegtle wrote:
> 
> Hello,
> 
> On Tue, 6 Feb 2018, David Woodhouse wrote:
> 
> > I've put together a linux-4.9.y branch at
> > http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
> 
> 
> Are there any plans for a backport to v4.4?
> 
> I would volunteer for testing ;)

Care to volunteer to do the backport?  :)

Why do you need/want this type of thing for 4.4.y?  What is keeping you
from moving to 4.9.y instead?  Or even better yet, 4.14.y or 4.15, where
everything is fixed "correctly"?

thanks,

greg k-h
