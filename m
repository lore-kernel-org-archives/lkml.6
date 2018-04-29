Date: Sun, 29 Apr 2018 15:36:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add the I3C subsystem
Message-ID: <20180429133642.GC28913@kroah.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180423193814.5c8ca75a@bbrezillon>
 <20180423175646.GA23210@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423175646.GA23210@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 07:56:46PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 07:38:14PM +0200, Boris Brezillon wrote:
> > Hi,
> > 
> > On Fri, 30 Mar 2018 09:47:41 +0200
> > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > 
> > > This patch series is a proposal for a new I3C subsystem.
> > 
> > This v4 has been sent almost a month ago and I didn't get any feedback
> > so far apart from Rob's R-b. Greg, is there any chance we can get these
> > patches merged in 4.18? If not, could you tell me what should be
> > addressed/improved/reworked?
> 
> I'll look over it later this week, thanks.

At first glance, it would be great to have at least one other
reviewed-by or signed-off-by on the main code here.  I don't want to be
the only one to have to review it :)

thanks,

greg k-h
