Date: Sat, 10 Mar 2018 06:52:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap
 copy
Message-ID: <20180310145258.GA6874@kroah.com>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
 <20180310001043.GD13963@kroah.com>
 <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 08:27:54AM +0100, christophe leroy wrote:
> 
> 
> Le 10/03/2018 à 01:10, Greg Kroah-Hartman a écrit :
> > On Fri, Mar 09, 2018 at 04:48:59PM +0100, Christophe Leroy wrote:
> > > Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d
> > 
> > There is no such git commit id in Linus's tree :(
> > 
> > Please fix up and resend the series.
> 
> I checked again, it is there
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/mm/slice.c?h=next-20180309&id=326691ad4f179e6edc7eb1271e618dd673e4736d

That is linux-next, which has everything and the kitchen sink.  It is
not Linus's tree.  Please wait for these things to be merged into
Linus's tree before asking for the to be merged into the stable tree.
That's a requirement.

thanks,

greg k-h
