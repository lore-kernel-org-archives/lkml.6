Date: Wed, 25 Apr 2018 08:16:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	devel@driverdev.osuosl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
Message-ID: <20180425061650.GB1450@kroah.com>
References: <20180424071618.GB17825@kroah.com>
 <20180424074459.7215-1-k.marinushkin@gmail.com>
 <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
 <CAHp75Vd=_7g4N6b2Mkw1dLOao6gFsQuhzO7-9d=1kjyX0kgMAQ@mail.gmail.com>
 <2c7fc106-4c57-5e55-4f45-8fcf03a40dda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7fc106-4c57-5e55-4f45-8fcf03a40dda@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 08:51:34PM +0200, Kirill Marinushkin wrote:
> On 04/24/18 20:35, Andy Shevchenko wrote:
> > On Tue, Apr 24, 2018 at 9:27 PM, Kirill Marinushkin
> > <k.marinushkin@gmail.com> wrote:
> >
> >> @Andy
> >>
> >>> AFAIR I gave you a tag and you again missed it.
> >>> Before sending anything just check twice if all prerequisites are fulfilled.
> >> I think you mix it up. This is a new patch, you didn't review it before.
> > Ah, okay, send new version as a separate thread and if I have time I
> > would review it.
> >
> 
> Thank you!
> But it will be in the same thread. From my understanding, keeping the thread
> when sending new versions of a patch helps to keep tracking of the conversation

It doesn't really matter either way.

thanks,

greg k-h
