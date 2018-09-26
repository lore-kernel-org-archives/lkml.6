Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BC5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70E32083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70E32083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeIZV3G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:29:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:46013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeIZV3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:29:05 -0400
Received: from DESKTOPSLJ7U3P ([95.91.253.176]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIuft-1g2ih619rN-002TkP; Wed, 26
 Sep 2018 17:15:37 +0200
From:   <dollinger.florian@gmx.de>
To:     "'Bastien Nocera'" <hadess@hadess.net>, <andrew.smirnov@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-input-owner@kernel.org>,
        <linux-input@vger.kernel.org>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>    <20180926125130.974-1-dollinger.florian@gmx.de> <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
In-Reply-To: <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
Subject: AW: hid: microsoft: Add rumble support for Xbox One S controller
Date:   Wed, 26 Sep 2018 17:15:35 +0200
Message-ID: <003401d455ab$c6df5280$549df780$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQIcVUB51KcuudU3lqXOhHs+u7eMcgJbAG/MAWFS0HOkVMN8EA==
X-Provags-ID: V03:K1:ZUNVznu/qIPes57mGwZd1q4I5y36wTTiNRDhHMhwix3b732pMxa
 S/Z5WFEPzG5it7i8zMakgb1/n3e4EcI2ijYU5HaclCGob7YQ34O6zW7Sq0jGIhgSuFeYdw5
 Vol0eoe10LgX0LaYjWT8nGCiODfFJMBDlvKRgfm1veGdQGdGukmM00rixh5y4W3X5Mqmt+S
 J0Ka8f/GtMbCBBjF3upVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UIcIKhbx+wY=:UUV8gtkTz0e7nLB/w7mHQ5
 LR2au6w5w5464yw6dkUi/8bTgHVFwwlfjYwmx7Fk7myniw7bqrPQLftVJ7XS9ALny0UpNCov1
 sa8ZVGv5JB6hQcvazNM7AC7E8jqlXYi78XR/zFCwD6lcVfphMCLJjAPLNlsyqe2WC5x8phX5/
 4f/JEjsGLfikSnAqpQ1miGhxsmrA52JT7jshWQstEMp0GknMHqF4izFxDDdeEpuI71gx2ZvcU
 0L8hUqH/TBwC6IgjKd6EtM31Ix9+3uG82jzBDGLKtoi+P0jnHUu0a4bh0PUkG6HKx9DA17RzY
 PVsq4Vly+w3e6ElpnQ5Y4mwilapdzfT7AZdDFmQ8+g97aZN7kSyPAJFIAtx3aFFXOkGjLeN4z
 mYMiny5KsPVl5T0HfhwG80QRiQMUU9khxkTMCmTb/hYmvEe+FGpAmKPkKcrbIc30c1Q/oWOnw
 xBy8xrv1We64TqLt+gyAriFkHxxBD0fvQ8irQZrzcpjXuFy1xl0bfkeyek4Cu5x2knm7eyUIi
 djTxMpg83H2pfbOkAr9IgZrE75zegR8KKY9rKNEAkpihTihihmryQTDEzHAzyFmH8o/dzE0SA
 XxLxqp/pZFZTvzcIX2JzhJbhe3/ZjtNpARWCP6CGlDcA2+PluQMJJlb++nubaLNLhV1Si7ail
 2OyATNgoGQMJW/yrIfUcxNZxlXhDWzQ+uMm3kSFSQWnyz2s7sXTYIdOdsWSAHvUWg7DVJMkGY
 dudE46jR+AWJylBW0no0c7JbH0ctT2sWvtWNJf/h7QCwrmGk0vwCMGX4LdyRUkF+Yur8fnIm9
 ABBwQaGREJx/xOLCGssjMwaq9RyvLnsf9mHeQYdVkHX2TdOGGo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bastien,

> Probably because he didn't know about it, and how would he?

Hum, it's the first hit when you search for something like 'xbox one s driver linux' since half an year or longer 😊

> I spent quite a bit of time trying to get the XBox One S controller working over Bluetooth, without success, and I see that you have a patch for that which you didn't send upstream either:
https://github.com/atar-axis/xpadneo/blob/master/misc/kernel_patches/0001-fix_bluetooth_reconnect.patch

Jap, I just never pushed it because I never pushed anything to the linux kernel and I don't really know how the whole process works^^
Furthermore I wanted to fix possible before, but it looks like the driver is stable enough to push it now.

> I can imagine that a large portion of the driver can be integrated in the existing XBox pad driver, with each feature added in individual patches.

Would be great! But ist the xpad driver really the right place?

First of all, the BT interface is using HID, USB does not.
Furthermore, the driver is currently around 1,3k lines long - for a single device and only BT... (okay yes, there are a lot of comments in it).
But anyway, is it really a good idea to put everything into hid-microsoft?
Moreover, there is another interface which I am trying to support at the moment - the one which is used by the XBOX (WiFi).

I think in the end the whole hid-microsoft thingy will get blown-up a bit - right?
Or, everything is scattered over many places (hid-microsoft, xpad, another driver fort he wifi-interface).

Isn't it possible to use "one driver per device" in the kernel too, like I did?

> If I get the time, there are good chances I will send a patch to integrate the battery reporting in the existing driver at least, and then add support for missing buttons if there's a problem there (I see that mentioned in the README).

Jap, the wrong mapping is possibly the biggest problem of all. Battery support and FF is more "nice to have" but not really crucial. 

> "Trigger Force Feedback" is likely something that would need to be integrated at a lower level, this is probably not something we'd want to have replicated in each driver.

True.


Best regards, Flo


