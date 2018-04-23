Date: Mon, 23 Apr 2018 10:26:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [patch 8/9] LICENSES: Add CC-BY-SA-4.0 license text
Message-ID: <20180423082635.GB20868@kroah.com>
References: <20180422220208.772527041@linutronix.de>
 <20180422220833.423253901@linutronix.de>
 <20180423065449.GE4208@kroah.com>
 <alpine.DEB.2.21.1804230936290.6136@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804230936290.6136@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 09:37:14AM +0200, Thomas Gleixner wrote:
> On Mon, 23 Apr 2018, Greg Kroah-Hartman wrote:
> > On Mon, Apr 23, 2018 at 12:02:16AM +0200, Thomas Gleixner wrote:
> > > Add the full text of the CC-BY-SA-4.0 license to the kernel tree.  It was
> > > copied directly from:
> > >     
> > >    https://spdx.org/licenses/CC-BY-SA-4.0.html#licenseText
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > As we only have 1 user of this, do we really need it?
> > 
> > Willy, it's your file, Documentation/core-api/idr.rst that is needing
> > this addition to the LICENSES directory.  While I'm all for CC licenses
> > for Documentation, we don't seem to be very consistent with them.
> > Should this be the "default" license we choose for documentation for now
> > on?
> 
> I'm all for it. If we can agree than this should move to preferred/ and not
> to other/

Ok, that sounds good, Jon?  I know you have looked into picking a decent
license for documentation, any thoughts here?

thanks,

greg k-h
