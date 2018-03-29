Date: Thu, 29 Mar 2018 13:58:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Michael Thayer <michael.thayer@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] virt: vbox: Use __get_free_pages instead of kmalloc
 for DMA32 memory
Message-ID: <20180329115831.GD6734@kroah.com>
References: <20180329112116.26488-1-hdegoede@redhat.com>
 <20180329112116.26488-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329112116.26488-2-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 01:21:15PM +0200, Hans de Goede wrote:
> It is not possible to get DMA32 zone memory through kmalloc,

Why can't we just fix that issue here instead?

thanks,

greg k-h
