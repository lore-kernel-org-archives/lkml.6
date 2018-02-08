Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeBHOgL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:36:11 -0500
Received: from mout.web.de ([212.227.15.14]:45893 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeBHOgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:36:07 -0500
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] GPU-DRM-GMA500: Adjustments for four function
 implementations
Message-ID: <079c31b2-a2e6-cf42-cecb-e1e10dd241f6@users.sourceforge.net>
Date: Thu, 8 Feb 2018 15:35:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:6o9yLj2HuK6GXuCjuSEnxfFAENb22FSL9XFwehgc3Pj2rEfOMi8
 fxNOHwd+cq9AJdDEJWbi+fTB6nKPq5xJvKnrIoNN1NiK4XLmu8sFThSV4IoTZ83Wdhd5Kut
 I77Wtp0CZLykF3s1fgZ6b87zr34ajAG/KJpRtLk+xxEJd/tLsO6UZG26mESVfS2XbW0bSgk
 mbS9+mORD5HgJfj2LnLBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ya4rniR6xN4=:G+7lOaUbKMxUQVMrDrsCU0
 kQnhIAwI8qAA19q/7wBnh97VVpbDkaVV1jSSY0pa3BAtVeE515AHV5ww5ByJYEwsNWMG2ilGg
 UR4WfiBNp5RHNYzlnSVGVNX7P9pMBLcjSLm2F0xtj7PxGfy5DuYxncNJuclI0L1pMgymE2kHY
 izxDM/4Gsoyy5A6O+NLr6a4H+4728v8kOn48AoOidb7t/63qHAC/pfd5ILwFrV7TPUNskFKQW
 kelEqZMSXLwBD/lZP5ZQk9OffljSBo/OURmypdiNFnYut9YqismZsGqyHdgeuIkfUhIA4H5as
 sf/97nGr3Uy5kWYRxlCfJSqwcqJAq11x9Q4Bd4IjsyNUHsARApZp3YZF7kQ3c0Ex4bIR3PNTM
 YtRDR1VrHg5kFzzYARtWeslgbcD63v+ljr22EaGZ64f8XspN4yASNUKoKDdiBoVs0A7ghPsSG
 btL1bQpRcCB/pYAtrwHBP9wOovQf1rRQc5T4xOA2Yx7DDv7QTHx6STUs/GYtet45Sjt9K7yqm
 63OUXDOuKDPKW100fUHIQaoiOftTh6k4YTYDfh3/ssDcPkuJcw/czB1TjciC6BuhqQTOd1H4y
 lYFQlWLuFTUU1o4xVeeMHtO8n3pqjLM0WW4Y413XgOS9Dn225hyLNLonFD98FdcYpoBNAn7RG
 4l0LOG8/sv4sLLz9/f+vSFfAAkUkdkwrY5U43rjKPIYw62e23PTLssjvyIE5rm/lr2JlWFFiD
 kxc0fYCgCWmA6MorkXgTrdMvFt50TXyrLZvq1wEQqeP8lI5GtP7SeRdVsiqtMqMF6nxN10dCx
 z2Ta4vQrjxlEe6Sk4DkS5E3+LUWOyl2EyNdr2lddSVYrv53syk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 15:27:38 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in two functions
  Improve four size determinations
  Delete an unnecessary return statement in oaktrail_crtc_hdmi_dpms()

 drivers/gpu/drm/gma500/framebuffer.c   |  7 ++-----
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 13 ++++---------
 2 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.16.1
