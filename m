Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36609C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56AF20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56AF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJQDTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:19:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQDTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:19:44 -0400
Received: from null ([172.19.249.18]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mg6mM-1fiMe52UkI-00hhgx; Tue, 16
 Oct 2018 21:26:59 +0200
Received: from null ([172.19.249.18]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mg6mM-1fiMe52UkI-00hhgx; Tue, 16
 Oct 2018 21:26:59 +0200
Date:   Tue, 16 Oct 2018 21:26:58 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org
Cc:     eric@anholt.net, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, tiwai@suse.de
Message-ID: <181642350.143349.1539718018593@email.1und1.de>
In-Reply-To: <0611161a74bf9f91471bb13bf93cd1e8cc36c7d0.camel@suse.de>
References: <20181016150228.16994-1-nsaenzjulienne@suse.de>
 <20181016150228.16994-7-nsaenzjulienne@suse.de>
 <4039d99c-5e57-c9d3-3af5-bc160e1adb57@i2se.com>
 <0611161a74bf9f91471bb13bf93cd1e8cc36c7d0.camel@suse.de>
Subject: Re: [PATCH 6/9] ASoC: dt-bindings: bcm2835-rpi: add onboard audio
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:InKydtlMFCNxxoVY43TKKZXtTwMo4lstOJ5QyJ0UCpwsJXRlgZq
 28b4ebmN2PYMxx3tGmqD4Jk3hHpGb2SWrgRnS3nXC3XWJ8uYdQ2+t6BK4m5+hnf3jsQ8liI
 0G0ALYYbLfifYWQnxZUmktAimIg+TIMX7f7mgbHDfd4HZpmWAdU/PC/KjovJUwtHoAjNorA
 8OX5EfuGZhcgh/u+cMkjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CzeS5YbcawE=:vtuPhnL8Nb39/C/Qf7zqtO
 VdO+1vi+sIPEgaGihdNVhyXSb65vQExNCU17vo6V/6bTDKeBgGG4WI+5KzWZeT+wcukshei3m
 +FL4jFKkpoHVb3GDuXR5jM59Qm7ysTFUnHSiWIHaick9l9QyPw2nHLkew2TpO0GE601z73HHv
 RihVZCX402+0jveJ1Ewh3bZB91a16gV5MxJ6m2MnAqLVD/Wro4JVoykWAZcgN226Gxe+Dq/5o
 PkvDaXN08OG3abqA1tI1pE2doKRAyRmizQ94FdQ8F8N0O644OHGWX/0ML6mHJpuwWUYn5Q/I/
 +gC49kc4EtRQu9fomoFuGnM8sxhm6O4Zv3d+lt1MJysGUPL+Y558j2azyu8a8P+PniAHfRz/A
 8RbEn3IBJ4vhD4jNUkVf/Yfeh2Ugoe66e/8PhsJ3W/bovdZLhMqK1Vp1WRWbbh4feDaxfBrKh
 RjBVeT1wJ3L3pkXqTLrB4POqPAbQ/4Gyutg5LAVBAEcoLMAlSJqricRE0DJUHHvc/QT0wB9Ve
 IPrbc5gsQB6oLCjfPsMAHKK1X8RmAeSUMLv/sET2lP27huUMjgnUQh5ZiocVu4TMePajlBDCe
 iKgwp1Igg0i+f0fEsAWmzpOK7TdF5iX2NjL26cH1Q591pMY0mtTQtMSlgFxAmSNRWGZSPR9oU
 FlV9ITv6vOgT2dya7HRYoK6Yv9ji+RND1DaPOP3m2p9FAwUrCnyDtmp6I0HcKqSU/6IBwNbQe
 2DSJpmdv2HtO6WDX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 16. Oktober 2018 um 18:48 geschrieben:
> 
> 
> Hi Stefan, thanks for the review,
> 
> On Tue, 2018-10-16 at 17:56 +0200, Stefan Wahren wrote:
> > Hi Nicolas,
> > 
> > Am 16.10.2018 um 17:02 schrieb Nicolas Saenz Julienne:
> > > Adds a device tree binding file for Raspberry pi's Headphones and
> > > HDMI
> > > audio output devices.
> > > 
> > > Based on raspberry's downstream kernel implementation:
> > > 
> 
> https://github.com/raspberrypi/linux/blob/rpi-4.14.y/arch/arm/boot/dts/bcm2708-rpi.dtsi
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >  .../bindings/sound/brcm,bcm2835-audio.txt         | 15
> > > +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-
> > > audio.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-
> > > audio.txt
> > > new file mode 100644
> > > index 000000000000..ee6fa085aaa9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-
> > > audio.txt
> > > @@ -0,0 +1,15 @@
> > > +Broadcom BCM283x audio device
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: Should be "brcm,bcm2835-audio"
> > > +- brcm,pwm-channels: number of PWM channels, they are behind RPi's
> > > Video Core
> > > +		     IV, not actual Linux PWM devices.
> > > +
> > > +Example:
> > > +
> > > +audio: audio {
> > > +	compatible = "brcm,bcm2835-audio";
> > > +	brcm,pwm-channels = <8>;
> > > +};
> > > +
> > 
> > i apologize but it seems to me that the TODO mentioned in the cover
> > letter isn't update to date anymore.
> > 
> > Phil Elwell posted an important bugfix for vchiq before [1], but only
> > the driver part has been applied yet. After applying the DT changes
> > i'm
> > not sure if it still works.
> > 
> > AFAIK the audio driver uses VCHIQ as a software interface and the
> > binding doesn't describe the real hardware.
> > 
> > Since the camera driver will be registered as a platform device [2],
> > i
> > prefer this way for the audio driver, too.
> > 
> > I'm actually working on this here [3] (currently only compile
> > tested).
> > 
> 
> Fair enough. I wasn't feeling too good about the bindings myself. I
> only went with them because I saw something similar was happening
> between "raspberrypi,bcm2835-power" and "raspberrypi,bcm2835-firmware". 
> I'll be glad to review & test your patches whenever they are ready.

i will inform you.

> 
> This makes commits 6 to 9 useless. Do you want me to send a v2? I can
> throw in an extra change Takashi suggested and update the TODO file.

You can add my

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

to patches 1 to 5. Please drop 6 to 9 from the series and add the other suggestions.

Btw please add devel@driverdev.osuosl.org to CC for V2

Thanks
Stefan

> 
> Regards,
> Nicolas
