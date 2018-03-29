Date: Thu, 29 Mar 2018 11:51:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: wsa@the-dreams.de, devel@driverdev.osuosl.org,
	driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] staging: ks7010: Remove trailing "_t" from all
 structure names.
Message-ID: <20180329095157.GA5377@kroah.com>
References: <20180329055152.13059-1-quytelda@tamalin.org>
 <20180329055152.13059-7-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329055152.13059-7-quytelda@tamalin.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:51:50PM -0700, Quytelda Kahja wrote:
> The "_t" suffix is not needed for structure names in this driver,
> and is a reflection of an older typedef system that is no longer
> in place.  Remove the "_t" suffix from every structure defined in this
> driver.

Again, please break this up into smaller patches, as this one does not
apply to my tree at all.

I've taken some patches from this series, please fix up the rest, rebase
and resend the remaining ones.

thanks,

greg k-h
