Date: Tue, 24 Apr 2018 15:57:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
Message-ID: <20180424135749.GA21610@kroah.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 03:10:55PM +0100, Adam Thomson wrote:
> This patch set adds sink side support for the PPS feature introduced in the
> USB PD 3.0 specification.
> 
> The source PPS supply is represented using the Power Supply framework to provide
> access and control APIs for dealing with it's operating voltage and current,
> and switching between a standard PDO and PPS APDO operation. During standard PDO
> operation the voltage and current is read-only, but for APDO PPS these are
> writable as well to allow for control.
> 
> It should be noted that the keepalive for PPS is not handled within TCPM. The
> expectation is that the external user will be required to ensure re-requests
> occur regularly to ensure PPS remains and the source does not hard reset.

Sebastian, any objection from me taking this series through my USB tree?

thanks,

greg k-h
