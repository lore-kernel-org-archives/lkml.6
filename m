Date: Mon, 19 Mar 2018 19:51:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: wsa@the-dreams.de, devel@driverdev.osuosl.org,
	driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: ks7010: Factor out repeated code.
Message-ID: <20180319185125.GA13209@kroah.com>
References: <20180316062704.2713-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316062704.2713-1-quytelda@tamalin.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:26:59PM -0700, Quytelda Kahja wrote:
> Some of the code for reading IEs is replicated multiple times in the
> switch statement for get_ap_information().  Factor that code out into
> read_ie().
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 48 +++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)

These patches do not apply to my tree at all :(

Can you please rebase and resend?

thanks,

greg k-h
