Date: Sun, 8 Apr 2018 11:54:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marcin <marcin@ziemianowicz.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: at91: Added more information logging.
Message-ID: <20180408095449.GA31179@kroah.com>
References: <20180408094330.GA51669@hak8or>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408094330.GA51669@hak8or>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 05:43:30AM -0400, Marcin wrote:
> I noticed that when debugging some USB clocking issue that there weren't
> many ways to tell what the state of the USB clocking system was. This
> adds a few logging statements to see what the relevant code is trying to
> do.
> 
> Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>

Your "From:" line doesn't match this name :(
