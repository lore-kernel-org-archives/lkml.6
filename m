Date: Sun, 22 Apr 2018 15:57:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usbip: usbip_host: delete device from busid_table
 after rebind
Message-ID: <20180422135711.GA4233@kroah.com>
References: <cover.1523488629.git.shuahkh@osg.samsung.com>
 <e245729770ca221377aabb7db4daba4c41dabdb9.1523488629.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e245729770ca221377aabb7db4daba4c41dabdb9.1523488629.git.shuahkh@osg.samsung.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 06:13:31PM -0600, Shuah Khan wrote:
> Device is left in the busid_table after unbind and rebind. Rebind
> initiates usb bus scan and the original driver claims the device.
> After rescan the device should be deleted from the busid_table as
> it no longer belongs to usbip_host.
> 
> Fix it to delete the device after device_attach() succeeds.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/usb/usbip/stub_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)

This patch doesn't apply to my tree, nor does patch 3/3.  Can you rebase
and resend?

thanks,

greg k-h
