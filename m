Date: Tue, 13 Mar 2018 09:47:40 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	NeilBrown <neilb@suse.com>
Subject: Re: linux-next: manual merge of the staging tree with the vfs tree
Message-ID: <20180313084740.GA8901@kroah.com>
References: <20180313152240.3a64e0c9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313152240.3a64e0c9@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 03:22:40PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got conflicts in:
> 
>   drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c
>   drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c
> 
> between commit:
> 
>   304ec482f562 ("get rid of pointless includes of fs_struct.h")
> 
> from the vfs tree and commits:
> 
>   37d3b407dc14 ("staging: lustre: remove linux-curproc.c")
>   6b7936ceefa7 ("staging: lustre: make signal-blocking functions inline")
> 
> from the staging tree.
> 
> I fixed it up (I just removed the files) and can carry the fix as
> necessary.

Sounds like the correct fix, thanks.

greg k-h
