Date: Wed, 25 Apr 2018 13:06:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org, Azhar Shaikh <azhar.shaikh@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH 0/3] v4.16 tpmdd backports
Message-ID: <20180425110600.GA1996@kroah.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 01:44:20PM +0300, Jarkko Sakkinen wrote:
> "tpm: add retry logic" caused merge conflicts so I picked couple of
> other fixes in order to get it apply cleanly.

Are these only needed in 4.16.y?  Nothing earlier?

thanks for the backports, I'll queue them up after this next 4.16.y
kernel is released at the end of this week.

greg k-h
