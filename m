Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B2DC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAAB21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 10:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAAB21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeJFRV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 13:21:57 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeJFRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 13:21:57 -0400
Received: from null ([172.19.249.18]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MC2k1-1fz8Mn3IfF-00CTYf; Sat, 06
 Oct 2018 12:18:40 +0200
Received: from null ([172.19.249.18]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MC2k1-1fz8Mn3IfF-00CTYf; Sat, 06
 Oct 2018 12:18:40 +0200
Date:   Sat, 6 Oct 2018 12:18:38 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, phil@raspberrypi.org,
        Eric Anholt <eric@anholt.net>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Message-ID: <1715113043.52878.1538821118324@email.1und1.de>
In-Reply-To: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:zYUOZRpibr5TvV28J88CpGiTNsZz+DpClg1cvSpFUpptGWx7Ubh
 SMimqxGygAuqsGw+8T6x3N2xRta4duSqdklQBkiMS7U4I2PnRIzSha0Ndw05ak7u0f2zdU4
 Kx31O548NK42lMKM1mXpx3pZ6FcHj5krzCQMA7LtVwCf3PbuSUSsGpAUMJ1Cdb23cl8zsHe
 9twfQw60ePWVTA6DY0IvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6jmeXFEHqvQ=:rv+XTskXH9j+SN+KmThmkJ
 r1Igo16WR7lnNdlOOJIQijy0YTz2Bi11MvtV/DwDE5JkqYjWfOpFTRLHP4/3+ls5Ra2IWlczB
 Zct6pPswMgSj5/T359rw+dXpjdGSg+gBx1tAdjrFePxf8JpF7G5+VNuXzi6GDP63AqlfXJvVf
 3aICNEabFGxc146gzxTk/Wt44P1Z4lr+d6854Jpb4r0EHYm8QeM6DvXm4eSkP7QmXeRa7zesS
 3+kMq47cVqkDkJQAFzNMQb/3no3/Eff182x5YCb16d/GS2JMzpzEmdz/nHZs4/m2K5tLEfiSC
 4Z5c+7HkcaAaSHdYuyOryDYWg5Z9mB4e68PmDgatrfBtFUwc0/m+fijy3OY67yiEiW5txz7w2
 3UriSGcJLmzo4cOqAdvClFM/LBUjvk+SWnyCGLKVTZGM5V1kBoRCvtM7vQKsseuL5NjEiwaPH
 Xw81CRZkIxUtzjytzpPCOW6O6tY05LK3YUcivwFZyTXfmgKZvmdF8/M9p9Wx2sdT6yqefKQuO
 Wx7M2UfL6fdrZR035f7s6qH1fkhiMyfdY4kNIcE7ZK84oo36Baao+zGBiYVwe41Z1DI6ngjnS
 4DmB8A4+e4pnAVDArv7ncruHL4AkVluHZX1Ak6w9qB64riGaO/bio627PPe/DybxPt90r5e+L
 8J1RXK4aiaehVrEB0CeqHSk8qz6G8Sr8N51awTVWuD1wIny8A5wkQYMekWa7A63d/eroF3Tto
 LADde+MgDI6Togp1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tuomas,

> Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> hat am 4. Oktober 2018 um 11:37 geschrieben:
> 
> 
> Drop various pieces of dead code from here and there to get rid of
> the remaining users of VCHI_CONNECTION_T. After that we get to drop
> entire header files worth of unused code.
> 
> I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
> snd-bcm2835 can still play analog audio just fine.
> 

thanks and i'm fine with your patch series:

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Unfortunately this would break compilation of the downstream vchi drivers like vcsm [1]. Personally i don't want to maintain another one, because i cannot see the gain of the resulting effort.

[1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom/vc_sm
