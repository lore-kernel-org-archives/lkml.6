Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88676C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E21D267C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E21D267C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933913AbeFZJ34 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:29:56 -0400
Received: from osg.samsung.com ([64.30.133.232]:52716 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933920AbeFZJYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:24:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 5100730B4B;
        Tue, 26 Jun 2018 02:24:48 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sxn0r0mTiaoX; Tue, 26 Jun 2018 02:24:47 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.130.70.dynamic.adsl.gvt.net.br [177.41.130.70])
        by osg.samsung.com (Postfix) with ESMTPSA id DD96130B2E;
        Tue, 26 Jun 2018 02:24:44 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fXkDK-0000Xg-2e; Tue, 26 Jun 2018 06:24:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Subject: [PATCH 3/4] alsa: multisound.sh: update module namespace
Date:   Tue, 26 Jun 2018 06:24:39 -0300
Message-Id: <5dbfe342b316515c88650fe7aadb2816e4312d3d.1530004939.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modules for the cards described here changed their names.
Update accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sound/cards/multisound.sh | 72 ++++++++++++-------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/sound/cards/multisound.sh b/Documentation/sound/cards/multisound.sh
index 0e0cb029421b..a915a1affcde 100755
--- a/Documentation/sound/cards/multisound.sh
+++ b/Documentation/sound/cards/multisound.sh
@@ -34,12 +34,12 @@
 #  composed of the following modules (these can also operate compiled
 #  into the kernel):
 #
-#  msnd               - MultiSound base (requires soundcore)
+#  snd-msnd-lib           - MultiSound base (requires snd)
 #
-#  msnd_classic       - Base audio/mixer support for Classic, Monetery and
-#                       Tahiti cards
+#  snd-msnd-classic       - Base audio/mixer support for Classic, Monetery and
+#                           Tahiti cards
 #
-#  msnd_pinnacle      - Base audio/mixer support for Pinnacle and Fiji cards
+#  snd-msnd-pinnacle      - Base audio/mixer support for Pinnacle and Fiji cards
 #
 #
 #  Important Notes - Read Before Using
@@ -66,7 +66,7 @@
 #
 #  * Classic/Monterey/Tahiti
 #
-#  These cards are configured through the driver msnd_classic.  You must
+#  These cards are configured through the driver snd-msnd-classic.  You must
 #  know the io port, then the driver will select the irq and memory resources
 #  on the card.  It is up to you to know if these are free locations or now,
 #  a conflict can lock the machine up.
@@ -81,10 +81,10 @@
 #  can be used to configure the card in non-PnP mode, and in PnP mode
 #  you can use isapnptools.  These are described briefly here.
 #
-#  pinnaclecfg is not required; you can use the msnd_pinnacle module
+#  pinnaclecfg is not required; you can use the snd-msnd-pinnacle module
 #  to fully configure the card as well.  However, pinnaclecfg can be
 #  used to change the resource values of a particular device after the
-#  msnd_pinnacle module has been loaded.  If you are compiling the
+#  snd-msnd-pinnacle module has been loaded.  If you are compiling the
 #  driver into the kernel, you must set these values during compile
 #  time, however other peripheral resource values can be changed with
 #  the pinnaclecfg program after the kernel is loaded.
@@ -96,7 +96,7 @@
 #  to obtain one with the command `pnpdump 1 0x203' -- this may vary
 #  for you (running pnpdump by itself did not work for me).  Then,
 #  edit this file and use isapnp to uncomment and set the card values.
-#  Use these values when inserting the msnd_pinnacle module.  Using
+#  Use these values when inserting the snd-msnd-pinnacle module.  Using
 #  this method, you can set the resources for the DSP and the Kurzweil
 #  synth (Pinnacle).  Since Linux does not directly support PnP
 #  devices, you may have difficulty when using the card in PnP mode
@@ -133,16 +133,16 @@
 #  pinnaclecfg program.  Using this program, you can assign the
 #  resource values to the card's devices, or disable the devices.  As
 #  an alternative to using pinnaclecfg, you can specify many of the
-#  configuration values when loading the msnd_pinnacle module (or
+#  configuration values when loading the snd-msnd-pinnacle module (or
 #  during kernel configuration when compiling the driver into the
 #  kernel).
 #
-#  If you specify cfg=0x250 for the msnd_pinnacle module, it
+#  If you specify cfg=0x250 for the snd-msnd-pinnacle module, it
 #  automatically configure the card to the given io, irq and memory
 #  values using that config port (the config port is jumper selectable
 #  on the card to 0x250, 0x260 or 0x270).
 #
-#  See the `msnd_pinnacle Additional Options' section below for more
+#  See the `snd-msnd-pinnacle Additional Options' section below for more
 #  information on these parameters (also, if you compile the driver
 #  directly into the kernel, these extra parameters can be useful
 #  here).
@@ -157,44 +157,44 @@
 #
 #  * MultiSound Classic/Monterey/Tahiti:
 #
-#  modprobe soundcore
-#  insmod msnd
-#  insmod msnd_classic io=0x290 irq=7 mem=0xd0000
+#  modprobe snd
+#  insmod snd-msnd-lib
+#  insmod snd-msnd-classic io=0x290 irq=7 mem=0xd0000
 #
 #  * MultiSound Pinnacle in PnP mode:
 #
-#  modprobe soundcore
-#  insmod msnd
+#  modprobe snd
+#  insmod snd-msnd-lib
 #  isapnp mypinnacle.conf
-#  insmod msnd_pinnacle io=0x210 irq=5 mem=0xd8000 <-- match mypinnacle.conf values
+#  insmod snd-msnd-pinnacle io=0x210 irq=5 mem=0xd8000 <-- match mypinnacle.conf values
 #
 #  * MultiSound Pinnacle in non-PnP mode (replace 0x250 with your configuration port,
 #    one of 0x250, 0x260 or 0x270):
 #
-#  insmod soundcore
-#  insmod msnd
-#  insmod msnd_pinnacle cfg=0x250 io=0x290 irq=5 mem=0xd0000
+#  modprobe snd
+#  insmod snd-msnd-lib
+#  insmod snd-msnd-pinnacle cfg=0x250 io=0x290 irq=5 mem=0xd0000
 #
 # * To use the MPU-compatible Kurzweil synth on the Pinnacle in PnP
 #   mode, add the following (assumes you did `isapnp mypinnacle.conf'):
 #
-#  insmod sound
+#  insmod snd
 #  insmod mpu401 io=0x330 irq=9                    <-- match mypinnacle.conf values
 #
 # * To use the MPU-compatible Kurzweil synth on the Pinnacle in non-PnP
 #   mode, add the following.  Note how we first configure the peripheral's
 #   resources, _then_ install a Linux driver for it:
 #
-#  insmod sound
+#  insmod snd
 #  pinnaclecfg 0x250 mpu 0x330 9
 #  insmod mpu401 io=0x330 irq=9
 #
 #  -- OR you can use the following sequence without pinnaclecfg in non-PnP mode:
 #
-#  insmod soundcore
-#  insmod msnd
-#  insmod msnd_pinnacle cfg=0x250 io=0x290 irq=5 mem=0xd0000 mpu_io=0x330 mpu_irq=9
-#  insmod sound
+#  modprobe snd
+#  insmod snd-msnd-lib
+#  insmod snd-msnd-pinnacle cfg=0x250 io=0x290 irq=5 mem=0xd0000 mpu_io=0x330 mpu_irq=9
+#  insmod snd
 #  insmod mpu401 io=0x330 irq=9
 #
 # * To setup the joystick port on the Pinnacle in non-PnP mode (though
@@ -203,15 +203,15 @@
 #
 #   pinnaclecfg 0x250 joystick 0x200
 #
-#  -- OR you can configure this using msnd_pinnacle with the following:
+#  -- OR you can configure this using snd-msnd-pinnacle with the following:
 #
-#  insmod soundcore
-#  insmod msnd
-#  insmod msnd_pinnacle cfg=0x250 io=0x290 irq=5 mem=0xd0000 joystick_io=0x200
+#  modprobe snd
+#  insmod snd-msnd-lib
+#  insmod snd-msnd-pinnacle cfg=0x250 io=0x290 irq=5 mem=0xd0000 joystick_io=0x200
 #
 #
-#  msnd_classic, msnd_pinnacle Required Options
-#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  snd-msnd-classic, snd-msnd-pinnacle Required Options
+#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 #
 #  If the following options are not given, the module will not load.
 #  Examine the kernel message log for informative error messages.
@@ -223,8 +223,8 @@
 #  mem                  Shared memory area, e.g. mem=0xd8000
 #
 #
-#  msnd_classic, msnd_pinnacle Additional Options
-#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  snd-msnd-classic, snd-msnd-pinnacle Additional Options
+#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 #
 #  fifosize             The digital audio FIFOs, in kilobytes.  If not
 #                       specified, the default will be used.  Increasing
@@ -244,8 +244,8 @@
 #                       to zero).
 #
 #
-#  msnd_pinnacle Additional Options
-#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  snd-msnd-pinnacle Additional Options
+#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 #
 #  digital              Specify digital=1 to enable the S/PDIF input
 #                       if you have the digital daughterboard
-- 
2.17.1

