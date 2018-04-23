Date: Mon, 23 Apr 2018 10:14:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Garry <john.garry@huawei.com>
Cc: jslaby@suse.com, joel@jms.id.au, p.zabel@pengutronix.de, arnd@arndb.de,
	fcooper@ti.com, sergei.shtylyov@cogentembedded.com,
	yamada.masahiro@socionext.com, khoroshilov@ispras.ru,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, linuxarm@huawei.com
Subject: Re: [PATCH] serial: 8250_of: Add IO space support
Message-ID: <20180423081402.GA19169@kroah.com>
References: <1524152268-228631-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524152268-228631-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 11:37:48PM +0800, John Garry wrote:
> Currently the 8250_of driver only supports MEM IO type
> accesses.
> 
> Some development boards (Huawei D03, specifically) require
> IO space access for 8250-compatible OF driver support, so
> add it.
> 
> The modification is quite simple: just set the port iotype
> and associated flags depending on the device address
> resource type.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

This no longer applies to my tree due to a patch that was sent before
yours that conflicts in the same area.  Can you rebase it against my
tty-testing branch and resend?

thanks,

greg k-h
