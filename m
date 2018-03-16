Date: Fri, 16 Mar 2018 13:58:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: ShuFan Lee <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux@roeck-us.net,
	shufan_lee@richtek.com, cy_huang@richtek.com, jun.li@nxp.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] staging: typec: rt1711h typec chip driver
Message-ID: <20180316125811.GB22994@kroah.com>
References: <1521191569-21221-1-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521191569-21221-1-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 05:12:49PM +0800, ShuFan Lee wrote:
> From: ShuFan Lee <shufan_lee@richtek.com>
> 
> Richtek RT1711H Type-C chip driver that works with
> Type-C Port Controller Manager to provide USB PD and
> USB Type-C functionalities.
> Add definition of TCPC_CC_STATUS_TOGGLING.
> 
> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
> ---
>  drivers/staging/typec/Kconfig         |   8 +
>  drivers/staging/typec/Makefile        |   1 +
>  drivers/staging/typec/tcpci.h         |   1 +
>  drivers/staging/typec/tcpci_rt1711h.c | 344 ++++++++++++++++++++++++++++++++++
>  4 files changed, 354 insertions(+)
>  create mode 100644 drivers/staging/typec/tcpci_rt1711h.c

This looks nice and simple to me, any reason it has to live in
drivers/staging/ and we can't just move it to drivers/usb/typec/ now?

Or are there still api things that need to be resolved with the existing
drivers/staging/typec/ code?

thanks,

greg k-h
