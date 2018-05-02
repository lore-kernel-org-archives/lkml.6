Date: Wed, 2 May 2018 11:03:56 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Amit Pundir <amit.pundir@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] NFC: fdp: Remove __func__ parameter from dev_dbg() call
Message-ID: <20180502180356.GA4660@kroah.com>
References: <1525283379-7141-1-git-send-email-amit.pundir@linaro.org>
 <1525283968.21176.633.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525283968.21176.633.camel@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 08:59:28PM +0300, Andy Shevchenko wrote:
> On Wed, 2018-05-02 at 23:19 +0530, Amit Pundir wrote:
> 
> > -	dev_dbg(dev, "%s\n", __func__);
> > +	dev_dbg(dev, "\n");
> 
> If one enables function tracer this will be redundant completely. 

Yes those kinds of "trace" debug log messages should be just deleted.
