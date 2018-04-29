Date: Sun, 29 Apr 2018 14:07:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180429120705.GA18149@kroah.com>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180426061108.GB4977@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426061108.GB4977@amd>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 08:11:08AM +0200, Pavel Machek wrote:
> On Wed 2018-04-25 08:46:02, Matthew Wilcox wrote:
> > Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
> > developers report bugs in hfs, which they deem a security hole because
> > Ubuntu attempts to automount an inserted USB device as hfs.
> 
> We promise "no-regressions" for code in main repository, no such
> promise for staging. We have quite a lot of code without maintainer.
> 
> Moving code to staging means it will get broken -- staging was not
> designed for this. I believe moving anything there is bad idea.
> 
> Staging is for ugly code, not for code that needs new maintainter.

Staging is used for getting code _out_ of the kernel tree as well as
_in_.  We use it all the time to move code there, see if anyone shows up
in 6-8 months to say "I will fix this!", and if not, we delete it.

Look at what just happened to IRDA in the 4.17-rc1 release as an example
of this.

thanks,

greg k-h
