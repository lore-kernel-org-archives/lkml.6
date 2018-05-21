Date: Mon, 21 May 2018 18:41:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] tty: add missing const to termios hw-change helper
Message-ID: <20180521164130.GF17976@kroah.com>
References: <20180521110844.30728-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521110844.30728-1-johan@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 01:08:44PM +0200, Johan Hovold wrote:
> Add missing const qualifiers to the termios hw-change helper parameters,
> which is used by few USB serial drivers. This specifically allows the
> pl2303 driver to use const arguments in one of its helper as well.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Greg, are you fine with me taking this one through my tree, or do prefer
> I split out the pl2303 bits?
> 
> Note that this helper is only used by a few USB serial drivers and that
> the pl2303 bits depend on a new patch targeted for -next.

Your tree is fine:

	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
