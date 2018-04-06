Date: Fri, 6 Apr 2018 08:49:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 088/134] ARM: dts: am335x-pepper: Fix the audio
 CODECs reset pin
Message-ID: <20180406064942.GA8416@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171902.020707561@linuxfoundation.org>
 <1522615695.2654.74.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522615695.2654.74.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 01, 2018 at 09:48:15PM +0100, Ben Hutchings wrote:
> On Mon, 2018-03-19 at 19:06 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: "Andrew F. Davis" <afd@ti.com>
> > 
> > 
> > [ Upstream commit e153db03c6b7a035c797bcdf35262586f003ee93 ]
> > 
> > The correct DT property for specifying a GPIO used for reset
> > is "reset-gpios", fix this here.
> 
> This doesn't work without commit a825f31f9328 ("ASoC: tlv320aic31xx:
> Use standard reset GPIO OF name") which went into 4.16.  Please revert
> this for all stable branches.

Now reverted, thanks.

greg k-h
