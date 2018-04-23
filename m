Date: Mon, 23 Apr 2018 13:37:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, samuel@sholland.org,
	LKML <linux-kernel@vger.kernel.org>,
	Coreboot <coreboot@coreboot.org>
Subject: Re: [PATCH 0/5] coreboot table bus and framebuffer driver
Message-ID: <20180423113753.GA8630@kroah.com>
References: <20180125014120.20851-1-samuel@sholland.org>
 <20180314180830.GA6311@kroah.com>
 <CAODwPW9gbZgFKs6_Lc_oD_pPgGa1nUSdM2p0k8o9Mygx9d+HJw@mail.gmail.com>
 <CAODwPW96LfXRbLFkX9OAUV7DH9t1MPogqvUUrCExrzk00Vy4_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwPW96LfXRbLFkX9OAUV7DH9t1MPogqvUUrCExrzk00Vy4_w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 09:22:04PM +0000, Julius Werner wrote:
> [resend in plain text]
> 
> > It would be great to get some of the google developers to ack these, as
> > this touches their code...
> 
>  From the coreboot point of view I guess we're fine with it since it claims
> to maintain all of the existing functionality. It's just changing the
> kernel-level plumbing for these drivers and I don't really have the
> expertise to comment on whether this is better or worse than the old code
> (maybe Dmitry or Guenter will?). It seems a little odd to me to call this a
> "bus", but if we think that's the most fitting abstraction the kernel has
> for it, I'm okay with that. All I care about is that it will work (in all
> combinations... e.g. regardless of probe order and even if some parts are
> compiled as modules and loaded/unloaded at runtime).

Thanks for the response, patches are all now queued up.

greg k-h
