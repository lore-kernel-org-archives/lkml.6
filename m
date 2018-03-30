Date: Fri, 30 Mar 2018 12:00:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: wsa@the-dreams.de, devel@driverdev.osuosl.org,
	driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_mib_set_confirm_t'.
Message-ID: <20180330100058.GA19140@kroah.com>
References: <20180330070842.25224-1-quytelda@tamalin.org>
 <20180330070842.25224-12-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330070842.25224-12-quytelda@tamalin.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 12:07:35AM -0700, Quytelda Kahja wrote:
> The "_t" suffix is not needed for structure names in this driver, and is a
> reflection of an older typedef system that is no longer in place. Replace
> all occurences of 'struct hostif_mib_set_confirm_t' with 'struct
> hostif_mib_set_confirm'.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> index 5261810fbc76..7a0e0c610c50 100644
> --- a/drivers/staging/ks7010/ks_hostif.h
> +++ b/drivers/staging/ks7010/ks_hostif.h
> @@ -175,7 +175,7 @@ struct hostif_mib_set_request {
>  	struct hostif_mib_value mib_value;
>  } __packed;
>  
> -struct hostif_mib_set_confirm_t {
> +struct hostif_mib_set_confirm {
>  	struct hostif_hdr header;
>  	__le32 mib_status;
>  	__le32 mib_attribute;

As Joe points out, please just remove structures that are not used at
all, it's pointless to keep them around.

thanks,

greg k-h
