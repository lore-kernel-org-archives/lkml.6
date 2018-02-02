Date: Fri, 2 Feb 2018 17:12:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Rob Herring <robh@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
Message-ID: <20180202161246.GA3188@kroah.com>
References: <20180202154026.15298-1-robh@kernel.org>
 <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 05:49:20PM +0200, Igor Stoppa wrote:
> On 02/02/18 17:40, Rob Herring wrote:
> > Add SPDX license tag check based on the rules defined in
> 
> Shouldn't it also check that the license is compatible?

Baby steps please :)

> [...]
> 
> > +				} elsif ($realfile =~ /\.rst$/) {
> > +					$comment = '..';
> 
> What is the correct/acceptable license for documentation?
> Creative Commons? AFAIK GPL is for source code.
> 
> Googling didn't bring the wished-for enlightenment.

It depends on what you want to allow the documentation to be used for.
It's not a simple answer :(

thanks,

greg k-h
