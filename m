Date: Thu, 15 Mar 2018 11:18:26 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Gilad Ben-Yossef <gilad@benyossef.com>
Subject: Re: linux-next: manual merge of the staging tree with the crypto tree
Message-ID: <20180315101826.GA2802@kroah.com>
References: <20180315175841.5c3de18d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315175841.5c3de18d@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 05:58:41PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got conflicts in:
> 
>   drivers/staging/ccree/Kconfig
>   drivers/staging/ccree/Makefile
> 
> between commit:
> 
>   e294ca1cca3a ("staging: ccree: rename staging ver and mark as broken")
> 
> from the crypto tree and commit:
> 
>   8b0217965418 ("staging: ccree: remove ccree staging driver copy")
> 
> from the staging tree.
> 
> I fixed it up (I just removed the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks for this, we knew it was going to happen, sorry :(

You did the correct merge.

greg k-h
