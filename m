Date: Fri, 9 Mar 2018 09:33:39 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Yueyao Zhu <yueyao.zhu@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	support.opensource@diasemi.com
Subject: Re: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Message-ID: <20180309173339.GA9837@kroah.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jan 02, 2018 at 03:50:48PM +0000, Adam Thomson wrote:
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

I've applied the first 3 patches now.  Can you rebase and resend based
on the feedback so far?

thanks,

greg k-h
