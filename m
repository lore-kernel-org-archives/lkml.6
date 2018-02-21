Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeBUMIL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:08:11 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:42351 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeBUMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:08:07 -0500
X-Google-Smtp-Source: AG47ELupEmtcE41O71WfNsTEXL+bPjqAahJTjk6FXcuanuIsz22i1iyW88gSvYhk/P6OPnkijXTXO8Ekb08AQgQC7rw=
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Wed, 21 Feb 2018 17:38:06 +0530
Message-ID: <CAHhAz+hE_F3hQdawbh2c0f3gWFB54kOQWxZBB=2zRXWkDHWCCQ@mail.gmail.com>
Subject: audio CODEC(CS42888) test
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LC8RRX014719

 [ Please keep me in CC as I'm not subscribed to the list]

Hi All,


I’m having a sound hardware which contains an analogue audio
CODEC(CS42888) and configuring the CODEC is performed over SPI bus.


I noticed that linux kernel already had a driver(snd-soc-cs42xx8.ko)
for this, I planned to use this driver.


Basically I’d like to perform loopback test and compare the sent and
received files to verify data fidelity. Also the test to be repeated
for various data rates and data formats.


I’d like to know how to test this loopback scenario and compare the
sent\received files?


I appreciate any help.


--
Thanks,
Sekhar
