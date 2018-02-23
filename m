Date: Fri, 23 Feb 2018 10:17:38 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the staging tree
Message-ID: <20180223091738.GA11425@kroah.com>
References: <20171128081651.71a2e92a@canb.auug.org.au>
 <20171128194139.GA2653@kroah.com>
 <20171129095916.062d6f7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129095916.062d6f7d@canb.auug.org.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Nov 29, 2017 at 09:59:16AM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Tue, 28 Nov 2017 20:41:39 +0100 Greg KH <greg@kroah.com> wrote:
> >
> > I need to set up a git hook for this :(
> 
> I couldn't find an appropriate hook for fetching or merging other
> trees :-( Instead I run the attached script below after each fetch.

Ok, instead of just running this every so often (obviously I was
forgetting to), I've now added it to my main "commit this set of
patches" script so that I will be notified of any problems _before_ you
ever see them.

Sorry for taking so long with this, ugh.

greg k-h
