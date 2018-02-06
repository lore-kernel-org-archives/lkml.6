Date: Tue, 6 Feb 2018 11:02:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: whiteheadm@acm.org
Cc: David Woodhouse <dwmw2@infradead.org>, Hugh Dickins <hughd@google.com>,
	dave.hansen@linux.intel.com, jikos@kernel.org,
	Borislav Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
	Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	eduval@amazon.com, labbott@redhat.com,
	Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Message-ID: <20180206190233.GA10476@kroah.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517643438.31953.108.camel@infradead.org>
 <CAP8WD_Yrp5g6YZwV+XQTx93YpTakWEL8MD+p0bZDaPi3-r88JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_Yrp5g6YZwV+XQTx93YpTakWEL8MD+p0bZDaPi3-r88JQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 01:33:30PM -0500, tedheadster wrote:
> On Sat, Feb 3, 2018 at 2:37 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Fri, 2018-02-02 at 23:52 -0500, tedheadster wrote:
> >> I just tested the 4.15 kernel and it is reporting that my old i486
> >> (non-cpuid capable) cpu is vulnerable to all three issues: Meltdown,
> >> Spectre V1, and Spectre V2.
> >>
> >> I find this to be _unlikely_.
> >
> > This should be fixed in Linus' tree already by commit fec9434a1
> > ("x86/pti: Do not enable PTI on CPUs which are not vulnerable to
> > Meltdown").
> >
> > We'll make sure it ends up in the stable tree too, if it hasn't
> > already.
> 
> David
>   I believe I got the patch(es) you mention in in the stable 4.15.1 kernel:
> 
> Pull x86/pti updates from Thomas Gleixner: "Another set of melted
> spectrum related changes"
> (commit 6304672b7f0a5c010002e63a075160856dc4f88d).
> 
> Unfortunately, the symptoms I reported remain on at least the i486 and i686.

Can you try 4.15.2-rc1?  Or how about Linus's kernel tree now?  There
was a lot of spectrum patches merged just this week that were not in
4.15.1.

thanks,

greg k-h
