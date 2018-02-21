Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1361518-1519212951-2-4221129873808282931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519212950; b=fillgOJS2rWDkZVsUlH/yJ50H+DSogRLQWJx3Vx64DIFfz9
    DIqufeeiDsmH2g6PnqA/w5pUq0SmiqunKreFShL6TNzwS80Cx4Qw/tKJWXcR7Pib
    CiYzDlsnTvfPumf+78fG/uW8tB1H/Ha/m81Aykwk8QMNA2+lUWW8rZTVhB2NmMjy
    ePssfazEj1wd6w+HyBNn3Q+bK9lQhGSH8MWWWRcmSiAygVldiaAuSkOAkXiRtx62
    lnAi3HLOT0l4sldOPKSowJxaSu048p6kVXEmXBu7o/WeimppVhlxEshZr7oE+EMY
    fsQgEKaUcXjKKNfVYTwEgXMMWw/LvVAA78surAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519212950; bh=pUPcBX7NRKSYbgz+2NXMViH9Ex
    DPym/oMeck+OfDZdM=; b=kZhhpwUa7sI2V/OxzF+Bf/kEC8aNx43ZXEoA8SwgjF
    uF/7wfuQe2PsRYuqJi/j87vai+2zg0v8VjroOOOcgcclS6RaBk4DsG6Slph31aPa
    DvHmJAKBBBG79dsVLmfFpSFpMXNSyzgMysYkE14lp7Zscy2cjRc5bBtV+dcicnuM
    WgZUFEDTFm9Dktx9vWOmZcrLDC1nLzunGZ0+i9Oizkn2LIqDzkIHyOScazq3z9pJ
    Yjk9fDolo/jj+PZwhT9pxxXsjenNm7M6+c3V61TAfPckWoxNx6Gmz2gXQA/EuxCB
    esQV6eaW8551bR8BlDWj8INSsciACZJqAQjti9M9ddvA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeBULfr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 06:35:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbeBULfq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 06:35:46 -0500
Date: Wed, 21 Feb 2018 12:35:48 +0100
From: gregkh <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "4.15.x" <stable@vger.kernel.org>
Subject: Re: stable-rc/linux-4.15.y build: 185 builds: 0 failed, 185 passed,
 46 warnings (v4.15.1-61-g7ab5513e4cbc)
Message-ID: <20180221113548.GB19900@kroah.com>
References: <5a78c368.5896df0a.8f293.fd41@mx.google.com>
 <CAK8P3a1n2ELL56MHqEgffzNg2B8gdpwHpMnp_vgN4ftAAiwW8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1n2ELL56MHqEgffzNg2B8gdpwHpMnp_vgN4ftAAiwW8A@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 04:08:49PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 5, 2018 at 9:49 PM, kernelci.org bot <bot@kernelci.org> wrote:
> >
> > stable-rc/linux-4.15.y build: 185 builds: 0 failed, 185 passed, 46 warnings (v4.15.1-61-g7ab5513e4cbc)
> 
> Hi Greg,
> 
> FYI, the device tree compiler warnings are all fixed in
> linux-4.16-rc1. These are basically fixes
> that we ended up not submitting last minute for the release after one
> of them (the USB PHY
> one, if you remember) had blown up.
> 
> Anyway, I think the risk is rather low for any of them (they are
> mostly platforms that
> are not widely used, and the fixes make things work that didn't), so
> to get a clean
> build, feel free to pick up the remaining patches from mainline now or
> after -rc1:
> 
> > Warnings Detected:
> >
> > Warnings summary:
> > 2 arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Property 'dmas', cell 4 is not a phandle reference in /ahb/apb/serial@b4100000
> > 2 arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Missing property '#dma-cells' in node /interrupt-controller@ec801000 or bad phandle (referred from /ahb/apb/serial@b4100000:dmas[4])
> 
> cdd104099141 ("arm: spear13xx: Fix dmas cells")

Now applied.

> > 2 arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Property 'cs-gpios', cell 6 is not a phandle reference in /ahb/apb/spi@e0100000
> > 2 arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Missing property '#gpio-cells' in node /interrupt-controller@ec801000 or bad phandle (referred from /ahb/apb/spi@e0100000:cs-gpios[6])
> 
> f8975cb1b8a3 ("arm: spear13xx: Fix spics gpio controller's warning")

Applied.

> > 2 arch/arm/boot/dts/exynos5410-smdk5410.dtb: Warning (interrupts_property): Missing interrupt-controller or interrupt-map property in /soc/system-controller@10040000
> > 2 arch/arm/boot/dts/exynos5410-smdk5410.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/system-controller@10040000
> > 2 arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property): Missing interrupt-controller or interrupt-map property in /soc/system-controller@10040000
> > 2 arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/system-controller@10040000
> 
> 5628a8ca1414 ("ARM: dts: exynos: fix RTC interrupt for exynos5410")

Applied

> > 2 WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o
> 
> 3343647813fd ("ARM: pxa/tosa-bt: add MODULE_LICENSE tag")

Applied

> > 1 arch/arm64/boot/dts/qcom/msm8916-mtp.dtb: Warning (phys_property): Missing property '#phy-cells' in node /soc/mdss@1a00000/dsi-phy@1a98300 or bad phandle (referred from /soc/mdss@1a00000/dsi@1a98000:phys[0])
> > 1 arch/arm64/boot/dts/qcom/apq8016-sbc.dtb: Warning (phys_property): Missing property '#phy-cells' in node /soc/mdss@1a00000/dsi-phy@1a98300 or bad phandle (referred from /soc/mdss@1a00000/dsi@1a98000:phys[0])
> 
> b0ab681285aa ("arm64: dts: msm8916: Add missing #phy-cells")

Applied.

> > 1 arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@1:cooling-device[0])
> > 1 arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@0:cooling-device[0])
> 
> acbf76ee0506 ("arm64: dts: add #cooling-cells to CPU nodes")

Does not apply at all, can you send a backport?

> > 1 arch/arm/boot/dts/stih410-b2260.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000
> > 1 arch/arm/boot/dts/stih410-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000
> > 1 arch/arm/boot/dts/stih407-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000
> 
> 7ac1f59c09a6 ("ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property")

Applied.

> > 1 arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd@10120000
> > 1 arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd@10120000
> 
> e8bfa0422469 ("ARM: dts: nomadik: add interrupt-parent for clcd")

Applied

> > 1 arch/arm/boot/dts/spear600-evb.dtb: Warning (interrupts_property): Missing interrupt-parent for /ahb/apb/rtc@fc900000
> 
> 6ffb5b4f248f ("arm: spear600: Add missing interrupt-parent of rtc")

Applied.

> > 1 arch/arm/boot/dts/s5pv210-torbreck.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> > 1 arch/arm/boot/dts/s5pv210-smdkv210.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> > 1 arch/arm/boot/dts/s5pv210-smdkc110.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> > 1 arch/arm/boot/dts/s5pv210-goni.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> > 1 arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
> 
> 5c1037196b9e ("ARM: dts: s5pv210: add interrupt-parent for ohci")

Applied.

> > 1 arch/arm/boot/dts/mt7623n-rfb-nand.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon@1b000000 or bad phandle (referred from /ethernet@1b100000:resets[0])
> > 1 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon@1b000000 or bad phandle (referred from /ethernet@1b100000:resets[0])
> 
> 76a09ce214ad ("arm: dts: mt7623: Update ethsys binding")

Applied.

> > 1 arch/arm/boot/dts/mt2701-evb.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon@1b000000 or bad phandle (referred from /ethernet@1b100000:resets[0])
> 
> ae72e95b5e4d ("arm: dts: mt2701: Add reset-cells")

Applied.

> > 1 arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
> > 1 arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
> > 1 arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
> > 1 arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
> 
> ca32e0c4bf9c ("ARM: lpc3250: fix uda1380 gpio numbers")

Applied.

> > 1 arch/arm/boot/dts/arm-realview-eb-a9mp.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> > 1 arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> > 1 arch/arm/boot/dts/arm-realview-eb-11mp.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> > 1 arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> > 1 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> > 1 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd@10008000
> 
> 586b2a4befad ("ARM: dts: Delete bogus reference to the charlcd")

Applied.

Thanks for all of these, only one needs manual help.

greg k-h
