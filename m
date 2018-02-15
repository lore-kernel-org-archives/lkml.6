Date: Thu, 15 Feb 2018 06:48:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [GIT PULL] x86 PTI and Spectre related fixes and updates
Message-ID: <20180215054836.GA9861@kroah.com>
References: <20180215003832.pzi7zbze5vlovp6l@gmail.com>
 <CA+55aFy-TRt++ujpxdq3U5mmXaKLW+jXuB=eD=KWY_Lsz+ox5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy-TRt++ujpxdq3U5mmXaKLW+jXuB=eD=KWY_Lsz+ox5w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 05:17:25PM -0800, Linus Torvalds wrote:
> On Wed, Feb 14, 2018 at 4:38 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >    This tree generates two relatively simple conflicts with your tree:
> 
> So what annoys me about these conflicts is that I'm not convinced that
> the stable tree actually *uses* your fancy x86/pti branch?
> 
> I think stable ends up working like a patch-queue anyway due to how
> Greg works and all his helper scripts, so the whole "let's keep a
> branch for pti" ends up being of dubious advantage when it results in
> conflicts on merging, and it's not the same commits in the end anyway.

I do use it, I take the commits from there and then queue them up as
individual patches for the stable releases.

And if it wasn't there, the conflict resolution would have to be on my
side, making them "not the same commits in the end", so either I have to
do that, or you do :)

> This is not a complaint so much as a "is it worth it?" question..

So far, I think this is the first conflict it's generated in a long
time, so previously it was worth it from my point of view.  As long as
it doesn't cause more work for the TIP maintainers, or for you, I
appreciate it.  But if it does cause more work, don't worry about it, I
can handle backporting things as needed.

thanks,

greg k-h
