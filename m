Date: Thu, 8 Feb 2018 17:39:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rolf Neugebauer <rolf.neugebauer@docker.com>
Cc: Borislav Petkov <bp@alien8.de>, Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
Message-ID: <20180208163940.GD9421@kroah.com>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
 <20180206142444.7xxegyyyfwskwrxl@pd.tnic>
 <20180207143428.GA31944@kroah.com>
 <CA+pO-2eiim-6E8VLAV2K3s=pqEv7QcV1f8znLeQWqZh=zKWVVQ@mail.gmail.com>
 <20180207181254.GC8698@pd.tnic>
 <CA+pO-2e=nZJeAR2j8Pukb=E4aHgvDXc9Tw4poatrUcD15Wi1Jg@mail.gmail.com>
 <20180208145348.GC7964@pd.tnic>
 <CA+pO-2c1WPr7UTtqMQBCzOzKr5ex=mu4URm=d=Of1+bn-jHJUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+pO-2c1WPr7UTtqMQBCzOzKr5ex=mu4URm=d=Of1+bn-jHJUA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 04:25:58PM +0000, Rolf Neugebauer wrote:
> On Thu, Feb 8, 2018 at 2:53 PM, Borislav Petkov <bp@alien8.de> wrote:
> > On Thu, Feb 08, 2018 at 01:55:48PM +0000, Rolf Neugebauer wrote:
> >> On the 4.4 kernel, 1f161f67a272c ("x86/microcode: Do the family check
> >> first") does not apply cleanly. Looks like it relies on 309aac77768c0
> >> ("x86/microcode: Decrease CPUID use") and 7a93a40be23e5
> >> ("x86/microcode: Remove local vendor variable") as well. These don't
> >> apply cleanly either.
> >
> > It figures. The backporting game is hm, well, a fun one. :-)
> >
> >> Should I just manually backport the functionality of 1f161f67a272c?
> >
> > Yeah, try that first.
> 
> Here it is below (same disclaimer about crappy mail client). If Boris
> is fine with the changes, Greg, I can send it properly with "git
> send-email" if needed.

Can you also send this for 4.9?  It should need it as well.  And at
first glance, it looks good to me.

thanks for doing this,

greg k-h
