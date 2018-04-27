Date: Fri, 27 Apr 2018 09:30:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?0JzQuNGF0LDQuNC7INCd0L7RgdC+0LI=?= <drdeimosnn@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: stable 4.16.5 hmm build error
Message-ID: <20180427073004.GA12770@kroah.com>
References: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
 <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 02:19:24AM +0300, Михаил Носов wrote:
> Oh. Yes. Tag v4.16.5 without commit
> 9d8a463a7016e9e5578a561588a18acef139919c.
> It's in v4.17-rc1/2.
> Thank you.

That patch does not apply to the stable trees.  I'm also confused by the
lack of "real" git commit ids that are being referred to here, that
commit refers to one that is not valid.

> 2018-04-27 0:52 GMT+03:00 Randy Dunlap <rdunlap@infradead.org>:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=199515
> >
> > kernel/fork.o: In function `__mmdrop':
> > /kernel/build_kernel/linux-4.16.4/kernel/fork.c:600: undefined reference
> > to `hmm_mm_destroy'

What .config is creating this?  I have not seen any kbuild reports of
this in the past.

> >
> > "It is also reproduced in linux-4.16.5"
> >
> >
> > There have been a few attempts to fix this build error.  The kernel
> > mainline
> > repo seems to have it fixed, but it looks to me like Arnd's latest patch
> > (9d8a463a7016e: "mm/hmm: fix header file if/else/endif maze, again")
> > was mis-merged to 4.16.5 stable.
> >
> > Please take a look.  Do you already have a fixup for this?

thanks,

greg k-h
