Date: Mon, 9 Apr 2018 13:41:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jean-Baptiste Theou <jb@essential.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>, Dan Rue <dan.rue@linaro.org>,
	Mark Brown <mark.brown@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: Re: Linux 4.9.93
Message-ID: <20180409114146.GA20636@kroah.com>
References: <20180409180534.1768583293d0abe207168c5a@essential.com>
 <20180409093028.GA3398@kroah.com>
 <CAKv+Gu9Ny=EatuqrVOEFbOt+h0rH5uqxxDyHFT-PLH72ZzvZiw@mail.gmail.com>
 <20180409185751.247a0ac7@jbtheou>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409185751.247a0ac7@jbtheou>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 06:57:51PM +0900, Jean-Baptiste Theou wrote:
> On Mon, 9 Apr 2018 11:49:37 +0200
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
> > On 9 April 2018 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Apr 09, 2018 at 06:05:34PM +0900, Jean-Baptiste Theou wrote:  
> > >> Hi,
> > >>
> > >> After this patchset, a kernel built with CFI fails. Disabling
> > >> UNMAP_KERNEL_AT_EL0 fix the issue obviously.  
> > 
> > How does one 'build a kernel with CFI' for arm64?
> 
> From Google work on Android-4.9
> 
> https://android.googlesource.com/kernel/common/+/00a195e7c0752ff5d65c9caadfbcc226270ca232
> 
> I am not sure what is the plan on their side to upstream (Greg?), but definitely
> useful to isolate actual issues.

Ah, yeah, if you are taking anything from the Android tree, all bets are
off :)

Greg Hackmann can probably answer the questions about CFI and these
patches, as he's working on merging this stable release into the
android-4.9 branch this week.  I'll let him deal with this...

thanks,

greg k-h
