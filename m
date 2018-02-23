Date: Fri, 23 Feb 2018 10:18:09 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	NeilBrown <neilb@suse.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the staging tree
Message-ID: <20180223091809.GA13919@kroah.com>
References: <20180223085137.625574c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223085137.625574c2@canb.auug.org.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 08:51:37AM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Commit
> 
>   cc738c1a69da ("staging: lustre: opencode cfs_cap_{raise, lower, raised}")
> 
> is missing a Signed-off-by from its author.

Obviously I wasn't running your script very often, so I've now fixed my
workflow to always do that.  thanks for letting me know.

greg k-h
