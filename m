Date: Fri, 6 Apr 2018 08:58:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 089/134] ARM: dts: omap3-n900: Fix the audio CODECs
 reset pin
Message-ID: <20180406065800.GB8416@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171902.160796295@linuxfoundation.org>
 <1522615780.2654.76.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522615780.2654.76.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 01, 2018 at 09:49:40PM +0100, Ben Hutchings wrote:
> On Mon, 2018-03-19 at 19:06 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: "Andrew F. Davis" <afd@ti.com>
> > 
> > 
> > [ Upstream commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 ]
> > 
> > The correct DT property for specifying a GPIO used for reset
> > is "reset-gpios", fix this here.
> 
> This also depends on a driver change.  Please revert it for all stable
> branches.

Now reverted everywhere, thanks.

greg k-h
