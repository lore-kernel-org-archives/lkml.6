Date: Tue, 3 Apr 2018 19:20:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bob Peterson <rpeterso@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to get lockref patch merged?
Message-ID: <20180403172055.GB15938@kroah.com>
References: <CAHc6FU4B9SeO_5LcVmf4OhYeYW0K1V+LjKe2TJ9U4DipVCqNVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4B9SeO_5LcVmf4OhYeYW0K1V+LjKe2TJ9U4DipVCqNVw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 01:13:00PM +0200, Andreas Gruenbacher wrote:
> Hello,
> 
> what's the best way to get the following lockref patch merged? The
> maintainers file doesn't list a maintainer. Should we go straight to
> Linus? Does one of you want to take it?

Andrew normally takes lib/ patches, but:

> We have a gfs2 patch that depends on it.

Then just include it in your patch series for gfs2 through the normal
path you use for that.

thanks,

greg k-h
