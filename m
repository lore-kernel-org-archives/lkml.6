Date: Tue, 20 Mar 2018 12:47:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: hariprasath.elango@gmail.com
Cc: aditya.shankar@microchip.com, ganesh.krishna@microchip.com,
	dan.carpenter@oracle.com, gehariprasath@gmail.com,
	linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] staging: wilc1000: replace switch statement by simple
 if condition
Message-ID: <20180320114720.GA31253@kroah.com>
References: <20180320114331.4084-1-hariprasath.elango@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320114331.4084-1-hariprasath.elango@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 05:13:31PM +0530, hariprasath.elango@gmail.com wrote:
> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> In this case,there is only a single switch case statement.So replacing
> by a simple if condition
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> ---
>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

What changed from v1?  Always put that information below the --- line,
like the kernel documentation asks you to do.

v3?  :)

thanks,

greg k-h
