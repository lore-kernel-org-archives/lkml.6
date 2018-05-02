Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeEBSJW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:09:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38505 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:09:18 -0400
X-Google-Smtp-Source: AB8JxZqZWR+SqNZs6w1m4qzKpke4braNeTzOGr2PkrfoMCbvCstn3t0CAIAwavbwj2dbYtV70G7HsA==
Date: Wed, 2 May 2018 11:09:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.17-rc3
Message-ID: <20180502180914.GA67132@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem: just a few driver fixes.

Changelog:
---------

Christophe JAILLET (1):
      Input: synaptics-rmi4 - fix an unchecked out of memory error path

Dmitry Torokhov (1):
      Input: leds - fix out of bound access

Javier Martinez Canillas (1):
      Input: atmel_mxt_ts - add missing compatible strings to OF device table

Masanari Iida (1):
      Input: hideep_ts - fix a typo in Kconfig

Nick Dyer (1):
      Input: atmel_mxt_ts - fix the firmware update

Pali Rohár (1):
      Input: alps - fix reporting pressure of v3 trackstick

Vittorio Gambaletta (VittGam) (1):
      Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro

Wolfram Sang (1):
      MAINTAINERS: Rakesh Iyer can't be reached anymore

Diffstat:
--------

 .../devicetree/bindings/input/atmel,maxtouch.txt   |   7 +
 MAINTAINERS                                        |   1 -
 drivers/input/input-leds.c                         |   8 +-
 drivers/input/mouse/alps.c                         |   2 +-
 drivers/input/rmi4/rmi_spi.c                       |   7 +-
 drivers/input/touchscreen/Kconfig                  |   2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           | 200 +++++++++++++--------
 7 files changed, 142 insertions(+), 85 deletions(-)

Thanks.


-- 
Dmitry
