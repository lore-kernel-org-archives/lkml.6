Date: Fri, 16 Feb 2018 11:11:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [char-misc 4.16] mei: set device client to the disconnected
 state upon suspend.
Message-ID: <20180216101153.GA14170@kroah.com>
References: <20180214120329.16094-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214120329.16094-1-tomas.winkler@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 02:03:29PM +0200, Tomas Winkler wrote:
> This fixes regression introduced by
> commit 8d52af6795c0 ("mei: speed up the power down flow")

In the future, put:
	Fixes: 8d52af6795c0 ("mei: speed up the power down flow")

in your signed-off-by area so that we can track this more easily.

thanks,

greg k-h
