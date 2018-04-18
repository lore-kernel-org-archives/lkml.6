Date: Wed, 18 Apr 2018 17:47:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Larry Finger <Larry.Finger@lwfinger.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 0/4] virt: vboxguest: Fix vboxguest module not
 working on VMs with more then 4G of RAM
Message-ID: <20180418154746.GA800@kroah.com>
References: <20180418132450.11663-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418132450.11663-1-hdegoede@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 03:24:46PM +0200, Hans de Goede wrote:
> Hi Greg,
> 
> I know you are not entirely happy with the direct get_pages usage in this
> patch-set, but as discussed that is currently the only way to get DMA32
> memory.
> 
> Adding a better API for getting DMA32 mem really falls outside of the scope
> of these patches and in the mean time the vboxguest driver is broken on 
> VMs with more then 4G RAM, can we please get this bug-fix series merged to
> fix this bug?

I'm on the road all this week, let me catch up with patches next week...
