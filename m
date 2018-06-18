Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31929C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2D208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B2D208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbeFRKlG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:41:06 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:53854 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934177AbeFRKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:41:04 -0400
Received: from faui49man5 (faui49man5.informatik.uni-erlangen.de [131.188.42.193])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id EDEB358C534;
        Mon, 18 Jun 2018 12:31:20 +0200 (CEST)
Received: by faui49man5 (sSMTP sendmail emulation); Mon, 18 Jun 2018 12:31:20 +0200
From:   Roman Sommer <roman.sommer@fau.de>
Cc:     Roman Sommer <roman.sommer@fau.de>, linux-kernel@i4.cs.fau.de,
        Daniel Graefe <daniel.graefe@fau.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Fabi=C3=A1n=20Inostroza?= <soulsonceonfire@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] sound/usb/line6: fix some styling issues
Date:   Mon, 18 Jun 2018 12:29:36 +0200
Message-Id: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
CC: Kees Cook <keescook@chromium.org>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
CC: Bhumika Goyal <bhumirks@gmail.com>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: alsa-devel@alsa-project.org
CC: linux-kernel@vger.kernel.org


This patchseries addresses some styling issues in sound/usb/line6 found by
checkpatch.

Roman Sommer (3):
  sound/line6: checkpatch: fix block comment style
  sound/line6: unsigned -> unsigned int
  sound/line6: add newline after declarations

 sound/usb/line6/capture.c  |  20 ++++-----
 sound/usb/line6/driver.c   | 110 ++++++++++++++++++++++-----------------------
 sound/usb/line6/driver.h   |  33 +++++++-------
 sound/usb/line6/midi.c     |  24 +++++-----
 sound/usb/line6/midibuf.c  |   6 +--
 sound/usb/line6/pcm.c      |  26 +++++------
 sound/usb/line6/pcm.h      |  74 +++++++++++++++---------------
 sound/usb/line6/playback.c |  36 ++++++++-------
 sound/usb/line6/pod.c      |  60 ++++++++++++-------------
 sound/usb/line6/podhd.c    |   8 ++--
 sound/usb/line6/toneport.c |  30 ++++++-------
 sound/usb/line6/variax.c   |  40 ++++++++---------
 12 files changed, 235 insertions(+), 232 deletions(-)

-- 
2.7.4

