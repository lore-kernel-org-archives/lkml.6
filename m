Date: Mon, 26 Mar 2018 11:57:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v7 2/6] Documentation: power: Initial effort to document
 power_supply ABI
Message-ID: <20180326095703.GA26466@kroah.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <0a26f379c29d65b6e0fa416a4b73aea010b9f718.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a26f379c29d65b6e0fa416a4b73aea010b9f718.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 10:12:21AM +0000, Adam Thomson wrote:
> This commit adds generic ABI information regarding power_supply
> properties. This is an initial attempt to try and align the usage
> of these properties between drivers. As part of this commit,
> common Battery and USB related properties have been listed.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 443 ++++++++++++++++++++++++++++
>  MAINTAINERS                                 |   1 +
>  2 files changed, 444 insertions(+)

How was this not documented before?

Anyway, any objection to me taking this through the USB tree, as the
typec patches depend on the 3/6 patch here.  If so, can I get an ack
from the power supply maintainers?

thanks,

greg k-h
