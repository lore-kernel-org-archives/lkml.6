Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968125AbeE2Xij (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:38:39 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38346 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967996AbeE2Xii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:38:38 -0400
X-Google-Smtp-Source: ADUXVKKFrQTIBz7rsOwIKOFiIUo+W2lf8Mkv4FucopT814O+WZ4mpdyDignXic8Sgl5JInyvgctdgw==
Date: Tue, 29 May 2018 16:38:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.17-rc7
Message-ID: <20180529233834.GA50727@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. We are switching a bunch of
Lenovo devices with Synaptics touchpads from PS/2 emulation over to
native RMI/SMbus.

Given that all commits are marked for stable there is no point delaying
them till next release.

Thanks!

Changelog:
---------

Aaron Ma (1):
      Input: synaptics - add Intertouch support on X1 Carbon 6th and X280

Benjamin Tissoires (2):
      Input: synaptics - add Lenovo 80 series ids to SMBus
      Input: elan_i2c_smbus - fix corrupted stack

Dmitry Torokhov (1):
      Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices should use RMI

Edvard Holst (1):
      Input: synaptics - Lenovo Thinkpad X1 Carbon G5 (2017) with Elantech trackpoints should use RMI

Diffstat:
--------

 drivers/input/mouse/elan_i2c_smbus.c | 22 +++++++++++-----------
 drivers/input/mouse/synaptics.c      |  6 ++++++
 2 files changed, 17 insertions(+), 11 deletions(-)

Thanks.


-- 
Dmitry
