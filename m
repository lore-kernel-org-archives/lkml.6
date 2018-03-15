Date: Thu, 15 Mar 2018 18:39:34 +0100
From: Greg KH <greg@kroah.com>
To: Pratik Jain <pratik.jain0509@gmail.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
	abbotti@mev.co.uk
Subject: Re: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line
 derefernce issue
Message-ID: <20180315173934.GA30586@kroah.com>
References: <20180315173040.11468-1-pratik.jain0509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315173040.11468-1-pratik.jain0509@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:00:40PM +0530, Pratik Jain wrote:
> Fixed coding style issue.
> 
> Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
> ---
>  drivers/staging/comedi/drivers/ni_atmio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/staging/comedi/drivers/ni_atmio.c
> index b9e9ab548c4b..e82fbe987dd8 100644
> --- a/drivers/staging/comedi/drivers/ni_atmio.c
> +++ b/drivers/staging/comedi/drivers/ni_atmio.c
> @@ -226,8 +226,8 @@ static int ni_isapnp_find_board(struct pnp_dev **dev)
>  	for (i = 0; i < ARRAY_SIZE(ni_boards); i++) {
>  		isapnp_dev = pnp_find_dev(NULL,
>  					  ISAPNP_VENDOR('N', 'I', 'C'),
> -					  ISAPNP_FUNCTION(ni_boards[i].
> -							  isapnp_id), NULL);
> +					  ISAPNP_FUNCTION(ni_boards[i].isapnp_id),
> +					  NULL);
>  
>  		if (!isapnp_dev || !isapnp_dev->card)
>  			continue;
> @@ -356,4 +356,3 @@ module_comedi_driver(ni_atmio_driver);
>  MODULE_AUTHOR("Comedi http://www.comedi.org");
>  MODULE_DESCRIPTION("Comedi low-level driver");
>  MODULE_LICENSE("GPL");
> -

Why did you also delete this last line?
