Date: Thu, 29 Mar 2018 11:53:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rene Hickersberger <Rene.Hickersberger@gmx.at>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: comedi: ni_stc: Fixed comment coding style issue
Message-ID: <20180329095344.GA6527@kroah.com>
References: <1522070830-11621-1-git-send-email-Rene.Hickersberger@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522070830-11621-1-git-send-email-Rene.Hickersberger@gmx.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 03:27:10PM +0200, Rene Hickersberger wrote:
> Fixed a coding style issue where the comment * was not aligned.
> 
> Signed-off-by: Rene Hickersberger <Rene.Hickersberger@gmx.at>
> ---
>  drivers/staging/comedi/drivers/ni_stc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_stc.h b/drivers/staging/comedi/drivers/ni_stc.h
> index cb9d4c3..831088c 100644
> --- a/drivers/staging/comedi/drivers/ni_stc.h
> +++ b/drivers/staging/comedi/drivers/ni_stc.h
> @@ -9,7 +9,7 @@
>  /*
>   * References:
>   *   DAQ-STC Technical Reference Manual
> -*/
> + */

Does not apply to my tree at all :(
