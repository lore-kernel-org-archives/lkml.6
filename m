Date: Tue, 6 Mar 2018 03:46:12 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Seunghun Han <kkamagui@gmail.com>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] x86: mce: fix kernel panic when check_interval is
 changed
Message-ID: <20180306114612.GA16784@kroah.com>
References: <20180302202706.9434-1-kkamagui@gmail.com>
 <20180306104320.GB11535@pd.tnic>
 <20180306105748.GA31087@kroah.com>
 <20180306110207.GC11535@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306110207.GC11535@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 12:02:08PM +0100, Borislav Petkov wrote:
> On Tue, Mar 06, 2018 at 02:57:48AM -0800, Greg Kroah-Hartman wrote:
> > It would have been nice to add a cc:stable for this, but I'll try to
> > watch it and when it hits Linus's tree I'll queue it up there.
> 
> I can still add it - it is the top patch and I haven't sent it yet.
> 
> /me goes and adds it.
> 
> Voila!
> 
> :-)

Wonderful, thanks for doing that.
