Date: Mon, 30 Apr 2018 15:48:31 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REBASED PATCH 1/2] usbip: usbip_host: delete device from
 busid_table after rebind
Message-ID: <20180430224831.GA7190@kroah.com>
References: <9cfffc546fc9774a9e38e81b0f396866a9d8d11f.1525115738.git.shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfffc546fc9774a9e38e81b0f396866a9d8d11f.1525115738.git.shuah@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 04:17:19PM -0600, Shuah Khan (Samsung OSG) wrote:
> Device is left in the busid_table after unbind and rebind. Rebind
> initiates usb bus scan and the original driver claims the device.
> After rescan the device should be deleted from the busid_table as
> it no longer belongs to usbip_host.
> 
> Fix it to delete the device after device_attach() succeeds.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  drivers/usb/usbip/stub_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Why are these REBASED?  I can't remember the first version of these
patches, what are these for?

confused,

greg k-h
