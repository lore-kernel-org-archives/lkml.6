Date: Wed, 25 Apr 2018 18:36:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, alexdeucher@gmail.com,
	christian.koenig@amd.com, kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org, hdegoede@redhat.com
Subject: Re: [PATCH 1/2] firmware: some documentation fixes
Message-ID: <20180425163631.GB30492@kroah.com>
References: <20180425152617.GA5058@kroah.com>
 <20180425162540.11574-1-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425162540.11574-1-andresx7@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 12:25:39PM -0400, Andres Rodriguez wrote:
> Including:
>  - Fixup outdated kernel-doc paths
>  - Slightly too short title underline
>  - Some typos
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
> 
> Hey Greg,
> 
> Here is the patch rebased on gregkh/driver-core-linus as requested.
> 
> Note that there is a patch by Hans de Goede <hdegoede@redhat.com> that contains
> some of the path fixes as well.
> 
> I also included an extra patch to fix the htmldocs build. I think we are in time
> to squash the fix into the offending commit.

We can't "squash" commits as our trees are not rebasable :)

thanks,

greg k-h
