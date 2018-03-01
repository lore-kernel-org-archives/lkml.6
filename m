Date: Thu, 1 Mar 2018 13:06:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] parport: ax88796: Delete an error message for a
 failed memory allocation in parport_ax88796_probe()
Message-ID: <20180301120609.GA31656@kroah.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdAEEjycTvxb=KLOsBESRfSjio1uDXfY=gR91TxCCOkVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdAEEjycTvxb=KLOsBESRfSjio1uDXfY=gR91TxCCOkVg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 12:46:07PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 7, 2018 at 9:47 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> >
> > Omit an extra message for a memory allocation failure in this function.
> >
> > This issue was detected by using the Coccinelle software.
> >
> 
> Greg, just to be sure this series is under your scope.
> IIRC it had been sent during merge window, though it looks like your
> tty tree doesn't include it yet, while even older patches, which were
> sent as well during merge window, made it

It's in my large "to-review" queue...

Personally, stuff like this, from this specific developer, ends up at
the bottom of that list as well...

greg k-h
