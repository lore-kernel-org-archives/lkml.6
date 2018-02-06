Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeBFVWN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:22:13 -0500
Received: from mout.web.de ([212.227.15.4]:50322 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754022AbeBFVWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:22:12 -0500
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] GPU-DRM-TILCDC: Adjustments for seven function
 implementations
Message-ID: <a7c7cebb-f4c9-04b7-5507-e41f8ebfb5f9@users.sourceforge.net>
Date: Tue, 6 Feb 2018 22:22:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:i2U7IZyOeoexwXiVdMQxW47S75I3UykKy7eN7BBl7DMz2W9uqN+
 GdOei7oA+jf4Pmj4LNJMQtk+5ZssUaIpWvUCx7EEdjFRsybhTgf5N8/Xd0dtXbkCsepMthQ
 HdVm1Hy7fy2UPXrTC38IStKFgQr3hdH2qJygcLpNq2UpzKOQf1/DU3jpWcnUred4mygA9vs
 ta7M3sqWSDWBCOWppmMNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9g9lE73Ifjo=:/43oBoZsBk2mz7/ouJciB4
 BzfAWmlJ0KYCPpFpni/qHI6tX4w3hAT2TxbGE3GSG9zExqrtlrQVyOb6ZIZast6Cx9Ng49fVz
 Rb3ZIPX6VQQ2vdhX/0m4pH2MJp7aAVCEjKPekGZnfU+tQmW1kcLLuh0jPW75S/Z/h7phwOvSY
 Vg4g/RGD9hkkfkBczEw/n2xFIKhietyIpBcHVLHKzWGnLuHyfd2ao00p3LkyVbgHQFKbhKBxK
 0VHwUmUcWf0SCXzELlBFuHcCxd3+0HoUqunsgSR6jckALop14m5/qI5Gj9L/HFxhFaoWJ4WfM
 5Zp2fGKNzwH4vxpe/0r3X5O8TYWDV/iP9isPqUPoq/NPJ8thxuVxyDd0W6GWSmnFFRr6r8sLl
 lWtPBLsg2JVW0IWr9BjiAWeANugSXPSAsQb++2C70P+yYP8bZa3c7djEr7E1IUII5IOCC2k+y
 r4vKZAoWi2kEqJiA+tiU3oCg8u2mzKICY/2sqC4dh1A0wnaDJIqXMbi1YQvH3b6kuBRNQoAw/
 8qxTM4QslLVN42mInhnW4R42fLSuoDQqi3BCURSoG/7ihO6nySMujkHNnl4eciDujtDJfO86t
 zPqKz2VnRYjeMXOFoNojNz9NfBFXU1N4n1i5SY0pOypViO1uEMgFyubS9/w9l3Pw94d+0ar4X
 RYr7D7fBEDC+0DIQ95qFAxtRIqoo3pQLGVThV1Mqoaa6l0raQZhcq8MHu/P6b24P1OEPOGtdX
 6xvPzuvnAxDh1UlnEpJ1FtW6mNBTQN4GE5gJ/xTW0yOEOVJqyNU3HiHNkMq46psthXL0Ey1hA
 0eST4PtC51j3D7/+UqC5mhAs/cHSExNbndZ59V+ThOib20QEHE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 22:17:44 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in seven functions
  Use common error handling code in of_get_panel_info()

 drivers/gpu/drm/tilcdc/tilcdc_crtc.c   |  4 +---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c    |  4 +---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 21 +++++++--------------
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c |  8 ++------
 4 files changed, 11 insertions(+), 26 deletions(-)

-- 
2.16.1
