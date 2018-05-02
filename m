Date: Wed, 2 May 2018 04:10:46 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Linux I2C <linux-i2c@vger.kernel.org>,
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
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] i3c: Add sysfs ABI spec
Message-ID: <20180502111046.GA22091@kroah.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-4-boris.brezillon@bootlin.com>
 <20180429133700.GD28913@kroah.com>
 <CAMuHMdUe=zauTS7BQXyTvMbmc-AsEVdWN0gG_3Ejg3E4T-xFXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUe=zauTS7BQXyTvMbmc-AsEVdWN0gG_3Ejg3E4T-xFXQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 11:47:49AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Sun, Apr 29, 2018 at 3:37 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, Mar 30, 2018 at 09:47:44AM +0200, Boris Brezillon wrote:
> >> Document sysfs files/directories/symlinks exposed by the I3C subsystem.
> >>
> >> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >> ---
> >> Changes in v2:
> >> - new patch
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-i3c | 95 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 95 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
> >> new file mode 100644
> >> index 000000000000..5e88cc093e0e
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-i3c
> >> @@ -0,0 +1,95 @@
> >> +What:                /sys/bus/i3c/devices/i3c-<bus-id>
> >> +KernelVersion:  4.16
> >
> > Wrong kernel versions :)
> 
> Do you update these when backporting to stable? ;-)

I'm not adding new features/subsystems to stable :)
