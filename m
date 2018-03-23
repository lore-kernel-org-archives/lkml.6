Date: Fri, 23 Mar 2018 17:56:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arend van Spriel <aspriel@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.16 0/3] drivers: base: revise coredump ABI
Message-ID: <20180323165629.GB21833@kroah.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 10:55:22AM +0100, Arend van Spriel wrote:
> Not sure if this can be considered as fix for v4.16. Upon submitting
> the driver patches I received valuable feedback that I would like to
> address with this series.
> 
> The patch apply to master and driver-core-next of the driver-core
> repository so you can take it either way.

We can wait for 4.17-rc1 for these, they are not fixing regressions.

thanks,

greg k-h
