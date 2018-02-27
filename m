Return-Path: <yong.deng@magewell.com>
X-Google-Smtp-Source: AH8x2249JQy4WAwK+u99LrxJifZ9hlFi5KUnkg50pkH2UenO9BZtaxuXf8VsIlaYuWmZ/Nfw3H5e
ARC-Seal: i=1; a=rsa-sha256; t=1519720274; cv=none;
        d=google.com; s=arc-20160816;
        b=0qcdrSj/s7crs3ONi4VEAtPp6SYbKh2im/86loYNPVdqImGtVCYSM9ib2TJ+DBMHwd
         NmHbTdexmPCKaFtTxWYFxvJoRZbZrfhuhxA2cg0MAlrnngUAYyeqgWl/Kg8E0XFqxwdK
         yXmpjNWC0Omj5+K3FsBHGeX/k7gobFXoAssHm+3E6Lm0F97/cqthz2C1FF6A6gaGJdUl
         kPe3mc3Fe+AJMp3RcPsDYmTiPUzL1OKsQwXhGMH3V0042/n+VsWFxCOSnb5175TMEHlP
         LoY+Mk9anCNoibNej2m/MPvBKISPMSzQi7mADaIG9e+WXTBjmiElP+mafREUAOanA4MV
         +iKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=wOszgjMTKg9YED7AW9E0v9xpUdVL/4DK+hsVvkTilds=;
        b=h901yntaL02EcuWl8P9HKhV6NOkEXnUV9U/Vd1uGyKDnj29+N/wzxQdrC6F5jcyVCW
         9GjRlz1rskxy/DJvwgM/wr1SyANjjdiFM4arw1Wvwm+R7az6vWmmvBJpF+20n/VsTDHz
         yp7fEqqPxkg6GGQRsFiEqBPeEoGedxmTLEKu/vmipvekSRRznTj017NUtEeflz5/ADNg
         94xD1D1L6W1HpxGeyb70H2FLO7yYxm6fn6BL3pegXxeqvZUFbaUQ5dOxdMvf2YMKMpOX
         no88pXD7Kj+4t57pnQ2l3WEA7I4Tfk+e08uUdjeWURdPubKrpT75RwNkCbEL+W7f+3g2
         FKRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yong.deng@magewell.com designates 115.124.20.13 as permitted sender) smtp.mailfrom=yong.deng@magewell.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yong.deng@magewell.com designates 115.124.20.13 as permitted sender) smtp.mailfrom=yong.deng@magewell.com
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1035927|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.B6AfdjB_1519720260;
Date: Tue, 27 Feb 2018 16:31:00 +0800
From: Yong <yong.deng@magewell.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, "David S. Miller"
 <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap
 <rdunlap@infradead.org>, Hans Verkuil <hans.verkuil@cisco.com>, Stanimir
 Varbanov <stanimir.varbanov@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Ramesh
 Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Yannick Fertre
 <yannick.fertre@st.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Todor
 Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v8 1/2] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
Message-Id: <20180227163100.af7828ff4930b91cda54fd46@magewell.com>
In-Reply-To: <1519719639.3402.2.camel@pengutronix.de>
References: <1519697256-32472-1-git-send-email-yong.deng@magewell.com>
	<1519719639.3402.2.camel@pengutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593518132578299122?=
X-GMAIL-MSGID: =?utf-8?q?1593542206587189457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Feb 2018 09:20:39 +0100
Philipp Zabel <p.zabel@pengutronix.de> wrote:

> On Tue, 2018-02-27 at 10:07 +0800, Yong Deng wrote:
> > Add binding documentation for Allwinner V3s CSI.
> > 
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Yong Deng <yong.deng@magewell.com>
> > ---
> >  .../devicetree/bindings/media/sun6i-csi.txt        | 59 ++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > new file mode 100644
> > index 000000000000..2ff47a9507a6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > @@ -0,0 +1,59 @@
> > +Allwinner V3s Camera Sensor Interface
> > +-------------------------------------
> > +
> > +Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> > +interface and CSI1 is used for parallel interface.
> > +
> > +Required properties:
> > +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> > +  - reg: base address and size of the memory-mapped region.
> > +  - interrupts: interrupt associated to this IP
> > +  - clocks: phandles to the clocks feeding the CSI
> > +    * bus: the CSI interface clock
> > +    * mod: the CSI module clock
> > +    * ram: the CSI DRAM clock
> > +  - clock-names: the clock names mentioned above
> > +  - resets: phandles to the reset line driving the CSI
> > +
> > +Each CSI node should contain one 'port' child node with one child 'endpoint'
> > +node, according to the bindings defined in
> > +Documentation/devicetree/bindings/media/video-interfaces.txt. As mentioned
> > +above, the endpoint's bus type should be MIPI CSI-2 for CSI0 and parallel or
> > +Bt656 for CSI1.
> > +
> > +Endpoint node properties for CSI1
> > +---------------------------------
> > +
> > +- remote-endpoint	: (required) a phandle to the bus receiver's endpoint
> > +			   node
> > +- bus-width:		: (required) must be 8, 10, 12 or 16
> > +- pclk-sample		: (optional) (default: sample on falling edge)
> 
> It would be helpful to state that 1 is rising edge and 0 is falling
> edge, see for example ov5640.txt

I think this is already documented at 
Documentation/devicetree/bindings/media/video-interfaces.txt.

> 
> regards
> Philipp


Thanks,
Yong
