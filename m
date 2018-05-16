Date: Wed, 16 May 2018 18:35:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] driver-core: record error on bus registration
Message-ID: <20180516163554.GC20425@kroah.com>
References: <20180516120527.29403-1-flo@geekplace.eu>
 <20180516160816.20251-3-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516160816.20251-3-flo@geekplace.eu>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 06:08:15PM +0200, Florian Schmaus wrote:
> If bus_register() fails on a driver then record the error code so that
> it can be inspected later on.

I don't think this is really needed, has it ever triggered before?

thanks,

greg k-h
