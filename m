Date: Wed, 14 Feb 2018 14:56:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Will Deacon <will.deacon@arm.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	ard.biesheuvel@linaro.org
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for -stable
Message-ID: <20180214135637.GC24189@kroah.com>
References: <20180209134811.GB11309@arm.com>
 <20180209134957.GA1677@kroah.com>
 <20180209135131.GC11309@arm.com>
 <20180209150436.GA8265@kroah.com>
 <20180213164859.GA5446@kroah.com>
 <20180214124101.GE2992@arm.com>
 <20180214125403.GA30072@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214125403.GA30072@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 01:54:03PM +0100, Greg KH wrote:
> On Wed, Feb 14, 2018 at 12:41:01PM +0000, Will Deacon wrote:
> > Hey Greg,
> > 
> > On Tue, Feb 13, 2018 at 05:48:59PM +0100, Greg KH wrote:
> > > On Fri, Feb 09, 2018 at 04:04:36PM +0100, Greg KH wrote:
> > > > On Fri, Feb 09, 2018 at 01:51:31PM +0000, Will Deacon wrote:
> > > > > On Fri, Feb 09, 2018 at 02:49:57PM +0100, Greg KH wrote:
> > > > > > On Fri, Feb 09, 2018 at 01:48:11PM +0000, Will Deacon wrote:
> > > > > > > Hi Greg,
> > > > > > > 
> > > > > > > I've put together a tag which includes all of the upstream arm64 spectre and
> > > > > > > meltdown mitigations based on v4.15. Please could you consider taking this
> > > > > > > into the 4.15 stable tree?
> > > > > > > 
> > > > > > > I understand that Ard (cc'd) is using this stack to create a version for 4.14
> > > > > > > too.
> > > > > > > 
> > > > > > > Note that there are two commits in here that are already in stable:
> > > > > > > 
> > > > > > >   9c9345fb26ff [Variant 1/Spectre-v1] Documentation: Document array_index_nospec
> > > > > > >   60d6c8a8e54e [Variant 1/Spectre-v1] array_index_nospec: Sanitize speculative array de-references
> > > > > > > 
> > > > > > > so you can skip those when applying.
> > > > > > > 
> > > > > > > Please shout if you run into trouble.
> > > > > > 
> > > > > > Ah, nice, thanks for this.  I'll use this for the next 4.15.y kernel
> > > > > > release after the one I _just_ sent out for review a few minutes ago.
> > > > > 
> > > > > Cool, sorry for the unfortunate timing. This only hit mainline last night.
> > > > 
> > > > Ok, then it's not a big deal to wait a few more days :)
> > > 
> > > All now queued up, thanks!
> > 
> > Good to hear, thanks! Could you also queue the 4.14 backport [1], please?
> > Having this in an LTS would be really handy.
> 
> Yes, please give me a chance, I have 240+ pending stable patches at the
> moment to dig through :)

Ok, now queued up, but there were some conflicts, so checking I got it
all correct would be wonderful.

thanks,

greg k-h
