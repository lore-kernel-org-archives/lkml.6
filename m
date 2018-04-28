Date: Sat, 28 Apr 2018 17:50:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sujeev Dias <sdias@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
Subject: Re: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
Message-ID: <20180428155057.GA14312@kroah.com>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
 <20180427072211.GA6735@kroah.com>
 <71afaf61-4f93-8ebd-bcef-5b1a391890d4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71afaf61-4f93-8ebd-bcef-5b1a391890d4@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 07:28:17AM -0700, Sujeev Dias wrote:
> Thanks for quick feedback
> 
> 
> On 04/27/2018 12:22 AM, Greg Kroah-Hartman wrote:
> > On Thu, Apr 26, 2018 at 07:23:28PM -0700, Sujeev Dias wrote:
> > > MHI Host Interface is a communication protocol to be used by the host
> > > to control and communcate with modem over a high speed peripheral bus.
> > > This module will allow host to communicate with external devices that
> > > support MHI protocol.
> > > 
> > > Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> > No one else has ever reviewed this code before?  That's not good, please
> > at the very least, have someone else at your company go over it first.
> > I don't want to be the ones having to point out all of the "obvious"
> > issues :)
> > 
> This code has gone thru rigorous code review and testing, before I submit
> next patch I will have multiple people sign off on it.

Thank you.

> Intention was to completely compile out MHI_VERB messages because we have
> those messages in data path.  For release build, we wanted to reduce
> as much mips as possible.  However, for debugging these messages are
> extremely helpful.

That's exactly what dev_dbg() does today.  So please use it.

> I will look into tracepoints...

Or that, if you want them, they can be useful on data paths.

thanks,

greg k-h
