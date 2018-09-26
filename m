Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90024C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516362086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516362086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeIZVgo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:36:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:59063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeIZVgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:36:44 -0400
Received: from DESKTOPSLJ7U3P ([95.91.253.176]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIPhr-1g3Gm803fL-004828; Wed, 26
 Sep 2018 17:23:14 +0200
From:   <dollinger.florian@gmx.de>
To:     "'Bastien Nocera'" <hadess@hadess.net>, <andrew.smirnov@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-input-owner@kernel.org>,
        <linux-input@vger.kernel.org>
Subject: Re: hid: microsoft: Add rumble support for Xbox One S controller
Date:   Wed, 26 Sep 2018 17:23:09 +0200
Message-ID: <003601d455ac$d5512db0$7ff38910$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AdRVrHF+tcqYHPx6TYmavRikcr9JOw==
X-Provags-ID: V03:K1:Ll01lt5t8yq1XnXtCwhrfcLV4PNLq29b5jFWPC+2v3BdzqWeA8a
 aaKUNSK6yiBR+8/U5WV2/ud7+R25uaPIUdUosDGC2uVS6e/p4THmlwPbKCSvAUEOOP5Ess9
 2n4G6E/hb8+RqStHEjURin2YXw7vBrUfH79UsTGaY3jvQDeqtH7cWp7o7QhX+De9iARnf0y
 ZhWwG64zv7J2pUsaoYqqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y4QASYeaPIE=:Q4aMZzSkNDWlf5CnZNtwLC
 vbLJKOXxerJRllAQDb3DTUQYf6fWGqH2K/rT28SRw371jY5/5QWLsUBxED76KWHk3dOfxyu5A
 cNsHFt3VGvi10e8+yeji4wIhyGRcGSwnabq4rNmoNiDCxgmGCzybpt2oJQrYdvmRsUdk4km4C
 7T//5WhuRkXTzT3dlAKAs6c1tkehjvc0GXMdcrxkLEAx5XbZPA3yn99LLVaXG5gc49XrDX7N0
 Z6JSv9d3+C3TD4uJByOIn3L42s9AK73On4Mus5j8RZBKXDymZaGxiNs3jlCkrIT+m+DDU67rv
 sfFffkJWRuaAoiFbGr7jRLOMnFuQlb+4HlnK0+W6eS5d0oasPV+lS4sI774Q3GlKRqZRpI0k4
 DFLi3V9azH2sWfEmDZhZ/DdBstPoSpp9Hf6wPCIfU5D7EqmKt5cTzS10eSIwUSoMtWXlRSeQX
 wgaNmItf54/E/8aPyR6nkdxIePKJ/xQbk6mWKQb5glC2VKTjacIKdmKNvEW2l7j3+i5vgb3zT
 uQj3YQXIjpqcVm9uGqJLrWpM8bNENLhntCHziqazGhcD+Yhf7ZmXHONgXGxm2iUcEQ0KoUAPk
 0p1N+sKlZXWfYWw8rj5XxDIIUUFIU5vBs4HgbiMHrj/xh7tLKoMKqBtxZ1DjemcFA0qn/OJTS
 v6vgx9Ij/Ar5rvXRbhFpaFFt7GGoxVbFtt47imYWnritW1Bd0fa3bAaeOTjFLgpyxALFHa+Vr
 5zvsXGB+wij7TEhwPfDkueB4WUWmHJRjZQxrzEYbwrurv58GvEB0SJCsEdZTQlZqe1Eh+iTxC
 8vswGthxhMQXXBFEHeXjAueTpAzN6IznGn0op9vqUEYiOqfCrg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bastien,

> Probably because he didn't know about it, and how would he?

Hum, it's the first hit when you search for something like 'xbox one s driver linux' since half an year or longer 😊

> I spent quite a bit of time trying to get the XBox One S controller working over Bluetooth, without success, and I see that you have a patch for that which you didn't send upstream either:
https://github.com/atar-axis/xpadneo/blob/master/misc/kernel_patches/0001-fix_bluetooth_reconnect.patch

Jap, I just never pushed it because I never pushed anything to the linux kernel and I don't really know how the whole process works^^ Furthermore I wanted to fix possible before, but it looks like the driver is stable enough to push it now.

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



