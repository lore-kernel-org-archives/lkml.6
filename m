Date: Mon, 23 Apr 2018 08:54:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Matthew Wilcox <mawilcox@microsoft.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [patch 8/9] LICENSES: Add CC-BY-SA-4.0 license text
Message-ID: <20180423065449.GE4208@kroah.com>
References: <20180422220208.772527041@linutronix.de>
 <20180422220833.423253901@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422220833.423253901@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 12:02:16AM +0200, Thomas Gleixner wrote:
> Add the full text of the CC-BY-SA-4.0 license to the kernel tree.  It was
> copied directly from:
>     
>    https://spdx.org/licenses/CC-BY-SA-4.0.html#licenseText
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

As we only have 1 user of this, do we really need it?

Willy, it's your file, Documentation/core-api/idr.rst that is needing
this addition to the LICENSES directory.  While I'm all for CC licenses
for Documentation, we don't seem to be very consistent with them.
Should this be the "default" license we choose for documentation for now
on?

thanks,

greg k-h
