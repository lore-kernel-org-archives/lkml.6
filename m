Date: Thu, 17 May 2018 11:10:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 4.4 159/190] ipsec: check return value of skb_to_sgvec
 always
Message-ID: <20180517091002.GH25318@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183601.856116959@linuxfoundation.org>
 <1526479082.9159.120.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526479082.9159.120.camel@codethink.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 02:58:02PM +0100, Ben Hutchings wrote:
> On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jason A. Donenfeld <Jason@zx2c4.com>
> > 
> > commit 3f29770723fe498a5c5f57c3a31a996ebdde03e1 upstream.
> [...]
> 
> This leaves the error paths in esp{4,6}.c leaking memory; fixed
> upstream by:
> 
> commit e6194923237f3952b955c343b65b211f36bce01c
> Author: Steffen Klassert <steffen.klassert@secunet.com>
> Date:   Thu Jul 13 09:13:30 2017 +0200
> 
>     esp: Fix memleaks on error paths.

Really?  That patch doesn't apply at all.  It looks like this patch
fixes things that happened after the above patch.

Or am I confused?

thanks,

greg k-h
