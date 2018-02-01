Return-Path: <liviu@dudau.co.uk>
X-Google-Smtp-Source: AH8x224SpSXbF1fgpr3xtDAL32Bxr1voLfev/C+wDepMQzc9vrBDLrHfO3rH5fM6QMS1nLW6Ir00
ARC-Seal: i=1; a=rsa-sha256; t=1517484885; cv=none;
        d=google.com; s=arc-20160816;
        b=cWvy2Kezfg9jocatJAUB+JNds+UumLZTBJLSkEyR7mToHwtm96O+nru/wEBrbmuKSe
         6DScfX6sdqyqhFR+sU9Lfyq1hIrwrHR28P7LChihGgoXhxIYfLwqyhsQOqKMcAZQTkbw
         3HuswmJ7kETxCoej+dInA5Wya52sPvp2jk3Z6cPY9Fanesb41uQQJXqYp/EoiS6UkcFa
         R8o07UVwpie1wX6cK9KGmov1GBeOahiToC/mmgt+Rm8IXsrYh/vOeW9q9m/pgV1HqiCz
         2CW0lguUoYSYBIvc4wqWdQMNuicBL44TSaOTniWKbhbYiLgrQCMCsTo3jMLL/DV0YGNv
         PV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Y6MAJx6b57ISAeLaxRGLsg5z+AApuTrYUl8GtI4wQHE=;
        b=JT5pFRor5QwenbGnW6WHTsrnJdxzHLRvK6P1ZKjTHRX9NxRnGlWSEjm65KRKjyfivg
         JCKofuMTdPvU5YzuOYEwpW2928Or2nyEoI28XnopR4UA0k90iQfnA+b/3+dnUtWV1yZi
         BIbajQxNm2jBmac+tb9Iqu1Jkt4v0C/hbzRNkrPPPhbN4/r9FBOPdtACWMgG1uIBElSU
         E0bOmLZOYKjxGRXadTUkdxPT9ViaF+XEPUo5itLh9Ikk6R5BChaW+5vtTS4m5z4nrhTi
         xRs8zcUdcXrtJskwD5MLvxm+937+f76ALK/wad89i/dFYS6dQck/iVt0NLhFp4Tqolj7
         hQQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.229.23.120 is neither permitted nor denied by best guess record for domain of liviu@dudau.co.uk) smtp.mailfrom=liviu@dudau.co.uk
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.229.23.120 is neither permitted nor denied by best guess record for domain of liviu@dudau.co.uk) smtp.mailfrom=liviu@dudau.co.uk
Date: Thu, 1 Feb 2018 11:34:43 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Yong <yong.deng@magewell.com>, kbuild test robot <lkp@intel.com>,
	kbuild-all@01.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Hugues Fruchet <hugues.fruchet@st.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Rick Chang <rick.chang@mediatek.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-sunxi <linux-sunxi@googlegroups.com>, megous@megous.com
Subject: Re: [linux-sunxi] Re: [PATCH v6 2/2] media: V3s: Add support for
 Allwinner CSI.
Message-ID: <20180201113442.GC19945@bart.dudau.co.uk>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <201801260759.RyNhDZz4%fengguang.wu@intel.com>
 <20180126094658.aa70ed3f890464f6051e21e4@magewell.com>
 <20180126110041.f89848325b9ecfb07df387ca@magewell.com>
 <20180131030807.GA19945@bart.dudau.co.uk>
 <20180131074212.7hvb3nqkt22h2chg@flea.lan>
 <20180131144753.GB19945@bart.dudau.co.uk>
 <20180201083222.q6rqql4nngn2bhiy@flea.lan>
 <CAK8P3a01DqmVJKt6J2i_okVoeELJCUW0voW0r52EzBY7iF74xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a01DqmVJKt6J2i_okVoeELJCUW0voW0r52EzBY7iF74xQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590370608168306586?=
X-GMAIL-MSGID: =?utf-8?q?1591198230792187052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:20:28AM +0100, Arnd Bergmann wrote:
> On Thu, Feb 1, 2018 at 9:32 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Wed, Jan 31, 2018 at 02:47:53PM +0000, Liviu Dudau wrote:
> >> On Wed, Jan 31, 2018 at 08:42:12AM +0100, Maxime Ripard wrote:
> >> > On Wed, Jan 31, 2018 at 03:08:08AM +0000, Liviu Dudau wrote:
> >> > > On Fri, Jan 26, 2018 at 11:00:41AM +0800, Yong wrote:
> >>
> >> Yeah, sorry, my threading of the discussion was broken and I've seen
> >> the rest of the thread after I have replied. My bad!
> >>
> >> >
> >> > In our case, the bus where the device is attached will not do the
> >> > address translations, and shouldn't.
> >>
> >> In my view, the bus is already doing address translation at physical
> >> level, AFAIU it remaps the memory to zero.
> >
> > Not really. It uses a separate bus with a different mapping for the
> > DMA accesses (and only the DMA accesses). The AXI (or AHB, I'm not
> > sure, but, well, the "registers" bus) doesn't remap anything in
> > itself, and we only describe this one usually in our DTs.

I was actually thinking about the DMA bus (AXI bus, most likely), not the
"registers" bus (yes, usually APB or AHB). The DMA bus is the one that does
the implicit remapping for the addresses it uses, if I understood you correctly.

> 
> Exactly, the DT model fundamentally assumes that each a device is
> connected to exactly one bus, so we make up a device *tree* rather
> than a non-directed mesh topology that you might see in modern
> SoCs.

I think you are right, but we also have the registers property for a device node
and that can be used for describing the "registers" bus. Now, it is possible
that some driver code gets confused between accessing the device registers
(which in Arm world happens through an APB or AHB bus) and the device doing system
read/writes which usually happends through an AXI (or for very old systems, AHB) bus.

For the sake of making sure we are talking about the same thing and in hope
that Maxime or Yong can give a more detailed picture of this device, I'll
re-iterate what a lot of devices in the Arm world look like nowadays:

- they have a bus for accessing the "registers" of the device, for controlling
  the behaviour of that device. Inside the SoC, that happens through the
  APB bus and it has a separate clock. The CPU has a view of those registers
  through some mapping in the address space that has been backed by the hardware
  engineers at design time and in DT we express that through the "registers" property,
  plus the "apb_clk" for most of the bindings. In DT world we express the mapping
  vis-a-vis the parent bus by using the "ranges" property.

- they have a high speed bus for doing data transfers. Inside the SoC that
  happens through an AXI or more modern CCI interconnect bus. The CPU does not
  have a direct view on those transfers, but by using IOMMUs, SMMUs or simple
  bus mastering capabilities it can gain knowledge of the state of the transfers
  and/or influence the target memory. In the DT world, we use the "dma-ranges"
  property like you say to express the translations that happen on that bus.

Maxime/Yong: does your device have more than one AXI bus for doing transfers?


> 
> The "dma-ranges" property was introduced when this first started
> falling apart and we got devices that had a different translation
> in DMA direction compared to control direction (i.e. the "ranges"
> property), but that still assumed that every device on a given bus
> had the same view of DMA space.
> 
> With just "dma-ranges", we could easy deal with a topology where
> each DMA master on an AXI bus sees main memory at address
> zero but the CPU sees the same memory at a high address while
> seeing the MMIO ranges at a low address.
> 
> What we cannot represent is multiple masters on the same
> AXI bus that use a different translation. Making up arbitrary
> intermediate buses would get this to work, but would likely
> cause other problems in the future when we do something
> else that relies on having a correct representation of the
> hierarchy of all the AXI/AHB/APB buses in the system, such
> as doing per-bus bandwidth allocation for child devices or
> anything else that requires configuring the bus bridge itself.

Agree we cannot express multiple masters on the same AXI bus having
different translations. Maybe we need to try to make things look more like
PCI where the child busses can have their own view of the world as long as
they don't try to communicate upwards to their parents or sideways to sibling
busses?


> 
> >> What you (we?) need is a simple bus driver that registers the
> >> correct virt_to_bus()/bus_to_virt() hooks for the device that do
> >> this translation at the DMA API level as well.
> >
> > Like I said, this only impact DMA transfers, and not the registers
> > accesses. We have other devices sitting on the same bus that do not
> > perform DMA accesses through that special memory bus and will not have
> > that mapping changed.
> 
> virt_to_bus()/bus_to_virt() don't actually exist on modern platforms any
> more, but when they did, they were only about dma access, not
> mmio access, so they would correspond to what we do with
> 'dma-ranges' rather than 'ranges'.

I think we are all in agreement here, I was thinking about DMA transfers
and (by extension) the behaviour of 'dma-ranges'.

Best regards,
Liviu


> 
>         Arnd
