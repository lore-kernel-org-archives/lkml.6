Date: Fri, 16 Feb 2018 19:50:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Liam Mark <lmark@codeaurora.org>
Cc: devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: ion: Initialize dma_address of new sg
 list
Message-ID: <20180216185059.GC9616@kroah.com>
References: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
 <20180216162353.GA13019@kroah.com>
 <alpine.DEB.2.02.1802160956030.20374@lmark-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1802160956030.20374@lmark-linux.qualcomm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 09:57:12AM -0800, Liam Mark wrote:
> On Fri, 16 Feb 2018, Greg KH wrote:
> 
> > On Fri, Feb 09, 2018 at 10:16:56PM -0800, Liam Mark wrote:
> > > Fix the dup_sg_table function to initialize the dma_address of the new
> > > sg list entries instead of the source dma_address entries.
> > > 
> > > Fixes: 17fd283f3870 ("staging: android: ion: Duplicate sg_table")
> > 
> > So this should be sent to the stable trees as well, right?
> > 
> > Please add that when you resend...
> 
> My understanding was that I should only send this to the stable branch if 
> it fixes a real bug.
> 
> Both myself and Laura can't see any actual problems that result from this 
> issue, the change is more to help future proof the code.
> 
> My commit message wasn't clear about this and could have mislead people 
> into thinking there was a bug.
> I will update the commit message to make it clear that this issue doesn't 
> currently result in any problem.
> 
> Do you still want me to send it to the stable trees?

If it's not a bugfix, no need to.  But please clean up your changelog
text as it implies that it is a bugfix...

thanks,

greg k-h
