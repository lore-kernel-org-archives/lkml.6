Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD08C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32492075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32492075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thebollingers.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936343AbeFRTXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:23:41 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:51682 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936142AbeFRTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:23:38 -0400
Received: from resomta-po-01v.sys.comcast.net ([96.114.154.225])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id Uwqefx5Guv8ZOUzkXfkXs3; Mon, 18 Jun 2018 19:23:37 +0000
Received: from thebollingers.org ([73.223.250.230])
        by resomta-po-01v.sys.comcast.net with ESMTPA
        id UzkSf2uNaVGSOUzkTf1duO; Mon, 18 Jun 2018 19:23:37 +0000
Date:   Mon, 18 Jun 2018 12:13:07 -0700
From:   Don Bollinger <don@thebollingers.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, brandon_chuang@edge-core.com,
        wally_wang@accton.com, roy_lee@edge-core.com,
        rick_burchett@edge-core.com, quentin.chang@quantatw.com,
        steven.noble@bigswitch.com, jeffrey.townsend@bigswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        don@thebollingers.org
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180618191307.2ikxtegft7d3e6xp@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
 <20180612181109.GD12251@lunn.ch>
 <20180615022652.t6oqpnwwvdmbooab@thebollingers.org>
 <ef0baf6d-1d1f-ba5b-708a-d8179bd1ea3b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0baf6d-1d1f-ba5b-708a-d8179bd1ea3b@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfDA3TKIJOQ/wCBvPMYKJ7xx9qzakkqiKS0TuzJH7zw+Q7kYdrQsAqWctz/OD6JfDNVcIh5z7hCgGAiE2GJCfXLG7hS3qfhnslMxspSY2IUB78NJ3obuK
 yTwzcLBjwu83s19CSzCUc2U/DLb2AXoC550vCpAWMZ5KLCkKnFi0GGstyd5xvp5tXNPEEZzRsPjOxfTOfLIUhoJSBhCvAY4+EwMODS6XCln+IFA1P+PekYi4
 rsekcDi9VAoKUHnsdobEF1q/sM4Qj9hCmIrAWykgzB2SU7K8Bn7DO1Gs+9pw/Zm3sFMpvsSyYfozIa7osra1SuFfVZNrxMvBge9OUY5goD9TmQDt0Hk0caEC
 mdVLxHC0E8ZlFxKMJuphin3wqKbdHghBHqB1LmERrtnBfeW6uRdKDniBWY7ns5tTQRo6xsvgBQ1AqVjdb/nD4geNjzf358MM9flV1EhmESSpDcKltCtsmxNE
 OSzNwvvPkLYTL7ocwzTRtIx3AEba08XhBWlwPuYwoie5k0fphdF+2TG5N67GwKDJtPpaT3NR5ym71MOoK7uuY1rJhTsyAx2/cY/cYFrkdJvK5lb394jIR6hR
 bpVZ+gfL2haIni2HOJI1EYhLqUwSFXlGTS/oq9uTeD1TVFb7gWBMAsV39r0loSXr23Z/+vGfKT4VXbWRQSmrGQlaeND227LwG8MzjeD59Pq+Ekn7o9V3BP6V
 FJ0ziw2IbYJYNx3r6tHNY9V0Qspyk1zS46cr7JUNc19AN7lRv3Ti61C6KY0KsH4hss3wq8ElvAbBamv9N918VnRL1f/xkTeUugLGwCaBwwJxcXPd06SB9TMO
 0Fu4zoCSpL9sh83pFz55+sx5vkF1Zy/K+Ymgxb27V8s0dayTodO65UpPwjyyNZr41Ho8ZoSm0ArZyo33Y0Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 08:24:34PM -0700, Florian Fainelli wrote:
> 
> 
> On 06/14/2018 07:26 PM, Don Bollinger wrote:
> > On Tue, Jun 12, 2018 at 08:11:09PM +0200, Andrew Lunn wrote:
> >>> There's an SFP driver under drivers/net/phy.  Can that driver be extended
> >>> to provide this support?  Adding Russel King who developed sfp.c, as well
> >>> at the netdev mailing list.
> >>
> >> I agree, the current SFP code should be used.
> >>
> >> My observations seem to be there are two different ways {Q}SFP are used:
> >>
> >> 1) The Linux kernel has full control, as assumed by the devlink/SFP
> >> frame work. We parse the SFP data to find the capabilities of the SFP
> >> and use it to program the MAC to use the correct mode. The MAC can be
> >> a NIC, but it can also be a switch. DSA is gaining support for
> >> PHYLINK, so SFP modules should just work with most switches which DSA
> >> support.  And there is no reason a plain switchdev switch can not use
> >> PHYLINK.
> >>
> >> 2) Firmware is in control of the PHY layer, but there is a wish to
> >> expose some of the data which is available via i2c from the {Q}SFP to
> >> linux.
> >>
> >> It appears this optoe supports this second case. It does not appear to
> >> support any in kernel API to actually make use of the SFP data in the
> >> kernel.
> >>
> >> We should not be duplicating code. We should share the SFP code for
> >> both use cases above. There is also a Linux standard API for getting
> >> access to this information. ethtool -m/--module-info. Anything which
> >> is exporting {Q}SFP data needs to use this API.
> >>
> >>    Andrew
> > 
> > Actually this is better described by a third use case.  The target
> > switches are PHY-less (see various designs at
> > www.compute.org/wiki/Networking/SpecsAndDesigns). The AS5712 for example
> > says "The AS5712-54X is a PHY-Less design with the SFP+ and QSFP+
> > connections directly attaching to the Serdes interfaces of the Broadcom
> > BCM56854 720G Trident 2 switching silicon..."
> > 
> > The electrical controls of the {Q}SFP devices (TxDisable for example)
> > are organized in a platform dependent way, through CPLD devices, and
> > managed by a platform specific CPLD driver.
> > 
> > The i2c bus is muxed from the CPU to all of the {Q}SFP devices, which
> > are set up as standard linux i2c devices
> > (/sys/bus/i2c/devices/i2c-xxxx).
> > 
> > There is no MDIO bus between the CPU and the {Q}SFP devices.
> > 
> >> 2) Firmware is in control of the PHY layer, but there is a wish to
> >> expose some of the data which is available via i2c from the {Q}SFP to
> >> linux.
> > 
> > So the switch silicon is in control of the PHY layer.  The platform
> > driver is in control of the electrical interfaces.  And the EEPROM data
> > is available via I2C.
> > 
> > And, there isn't actually 'a wish to expose' the EEPROM data to linux
> > (the kernel).  It turns out that none of the NOS partners I'm working
> > with use that data *in the kernel*.  It is all managed from user space.
> > 
> > More generally, I think sfp.c and optoe are not actually trying to
> > accomplish the same thing at all.  sfp.c combines all three functions
> > (PHY, electrical control, EEPROM access).  optoe is only providing EEPROM
> > access, and only to user space.  This is a real need in the white box
> > switch environment, and is not met by sfp.c.  optoe isn't better, sfp.c
> > isn't better, they're just different.
> 
> sfp exposes standard ethtool hooks such as get_module_info() which pass
> the whole data blob to user-space, e.g: ethtool where all of this is
> better interpreted.

Yes.  But ethtool depends on the underlying driver to access the data.
The current sfp.c implementation limits the amount of data that can be
accessed.  optoe makes the entire EEPROM accessible.  I think the right
solution is to call optoe for access to the EEPROM.  A couple of lines
of code in sfp_i2c_read could call optoe to get the data instead of
formatting the i2c_transfer directly.  That change would immediately
give the whole SFP framework access to all the address space of both SFP
and QSFP.  (Same change to sfp_i2c_write.)

> 
> > 
> > Finally, sfp.c does not recognize that SFP devices have data beyond 512
> > bytes, accessible via a page register.  It also does not recognize QSFP
> > devices at all.  QSFP devices have only 256 bytes accessible (one i2c
> > address) before switching to paged access for the remaining data.  The
> > first design requirement for optoe was to access all the available
> > pages, because there is information and controls that we (optics
> > vendors) want to make available to network management applications.
> 
> Patches welcome if you wish to extend sfp.c to support QSFP devices for
> instances.

I would love to collaborate on this.  I don't have an environment
(hardware or software) where I could build or test changes to the sfp
code.

> 
> > 
> > If sfp.c creates a standard linux i2c client for each SFP device, it
> > should be possible to create an optoe managed device 'under' sfp.c to
> > provide access to the full EEPROM address space:
> 
> It's the other way around, SFP relies on a standard Linux i2c bus master
> to exist such that it can read the EEPROM from the standard slave
> address location, same goes with a possibly present PHY.

Great.  Then plugging optoe in should be easy.

> 
> >   # echo optoe2 0x50 >/sys/bus/i2c/devices/i2c-xx/new_device
> > This might prove useful to user space consumers of that data.  We could
> > also easily add a kernel API (eg the nvmem framework) to optoe to provide
> > kernel access.  In other words, sfp.c could assign EEPROM management to
> > optoe, while managing the electrical interfaces.  (This is actually
> > pretty close to how the platfom drivers work in the switch environment.)
> > sfp.c would get SFP page support and QSFP EEPROM access 'for free'.
> 
> That sounds like a possibly good approach.

Thanks

> 
> > 
> >>                       There is also a Linux standard API for getting
> >> access to this information. ethtool -m/--module-info. Anything which
> >> is exporting {Q}SFP data needs to use this API.
> > 
> > optoe simply provides direct access from user space to the full EEPROM
> > data.  There is more data there than ethtool knows about, and in some
> > devices there are proprietary registers that ethtool will never know
> > about.  optoe does not interpret any of the EEPROM content (except the
> > bare minimum to access pages correctly).  optoe also does not get in the
> > way of ethtool.  It could prove to be a handy way for ethtool to access
> > new EEPROM fields in the future.  QSFP-DD/OSFP are coming soon, they
> > will have a different (incompatible) set of new fields to be decoded.
> 
> sfp is the same it only passes the EEPROM information to user-space and
> interprets just what it needs to get the work done.

I offer include/linux/sfp.h as a counter example.  Every byte, every bit
in the spec is spec'ed there.  That's great, but exceeds the mandate of
optoe.  Optoe is just there to get the data in and out of the EEPROM.

> 
> > 
> > Bottom Line:  sfp.c is not a useful starting point for the switch
> > environment I'm working in.  The underlying hardware architecture is
> > quite different.  optoe is not a competing alternative.  Its only
> > function is to provide user-space access to the EEPROM data in {Q}SFP
> > devices.
> 
> I just don't understand why would we want optoe when the standard way to
> expose both EEPROM and diagnostics modules has been through ethtool's
> get_module_info since the basic paradigm is that a network port is a
> net_device instance in the kernel. If that basic device driver model
> does not exist, then it is unclear to me what are the benefits.

We want optoe to access regions of the EEPROM which are paged, and to
access QSFP which only has one I2C address and is also paged.  It is
just the sfp_read/sfp_write function, but reading and writing the whole
EEPROM.  Plugging it into sfp gives that broader access to the ethtool
interface and the rest of the net-device model.

> 
> Would I be completely wrong if I wrote that you are likely working with
> a switch SDK which primarily runs in user-space and so with lack of a
> proper kernel-based device driver for your piece of hardware you are
> attempting to create a driver which is some sort of a "tap" for some
> specific portion of that larger hardware block?

Not completely wrong, but biased.  The switch ASIC and the switch SDK do
not connect to the i2c bus (at least in the architecture I'm working
with).  Whether or not it is in user-space isn't the point.  That it
doesn't access i2c, hence doesn't access the EEPROM, is the reason we
have a 'proper kernel-based device driver'.

> -- 
> Florian
> 

Don
