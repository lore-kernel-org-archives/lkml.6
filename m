Date: Thu, 8 Mar 2018 09:47:54 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Darren Hart <dvhart@infradead.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Santeri Toivonen <santeri.toivonen@vatsul.com>
Subject: Re: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Message-ID: <20180308174754.GA28545@kroah.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
 <20180308045810.8041-25-alexander.levin@microsoft.com>
 <20180308173914.GC11045@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308173914.GC11045@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 09:39:14AM -0800, Darren Hart wrote:
> On Thu, Mar 08, 2018 at 04:59:01AM +0000, Sasha Levin wrote:
> > From: Santeri Toivonen <santeri.toivonen@vatsul.com>
> > 
> > [ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]
> > 
> > Asus laptop X302UA starts up with Wi-Fi disabled,
> > without a way to enable it. Set wapf=4 to fix the problem.
> > 
> > Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
> > Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> 
> Hi Sasha,
> 
> I'm curious about this AUTOSEL tag, and what about this patch triggered
> its selection?

It's "magic"!  :)

Seriously, it's close to magic, there's a tool that Sasha is using that
takes "machine learning" to match patches that we have not applied in
stable kernels to ones that we have, and try to catch those that we
forgot to tag for the stable tree.  Not all subsystems mark stable
patches, so this is an attempt to catch those fixes that should be
getting backported but are not either because the developer/maintainer
forgot to mark it as such, or because they just never mark those types
of patches.

Sasha has a better write up about how this all works somewhere, and
given that this type of question keeps coming up every other week or so,
I think I need to add it to a FAQ somewhere to point people at to make
it more obvious what is happening.

thanks,

greg k-h
