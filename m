Date: Thu, 29 Mar 2018 11:46:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: wsa@the-dreams.de, devel@driverdev.osuosl.org,
	driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] staging: ks7010: Reorder ks_wlan_netdev_ops members.
Message-ID: <20180329094617.GA21780@kroah.com>
References: <20180329055152.13059-1-quytelda@tamalin.org>
 <20180329055152.13059-3-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329055152.13059-3-quytelda@tamalin.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:51:46PM -0700, Quytelda Kahja wrote:
> Reorder the members of 'ks_wlan_netdev_ops' to reflect the order
> of their counterparts in the kernel's 'struct net_device_ops'.

Why?  This shouldn't matter at all, why make this change?

greg k-h
