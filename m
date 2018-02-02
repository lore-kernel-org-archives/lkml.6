Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeBBOUw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:20:52 -0500
Received: from mout.web.de ([212.227.15.4]:63159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751887AbeBBOUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:20:46 -0500
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] i2c-sh7760: Adjustments for sh7760_i2c_probe()
Message-ID: <3f4a9053-5518-61ab-2cdf-e400f6b35ce3@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Bnd4FJgGe2HCKnoLcZIonAMPbwgChseisopKN+2F1objA/ikwOp
 orgH4/tuB8LC6v0PCkkprxSUFZekptE8feKucqYhCS5j+5tBV0xadf4+VDep/kvmw7MoUZO
 AIAL/yN4ECLGW2ORa8KD94iyDwzcdX23di4u5YmbVAUiGz/90Oxc/NWR6IA0XNZ6p3KP7Z1
 n3dDKAMITTO5G0kZAbRug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/0xZaAiVQPM=:QUmHI8Xpfe46o2xDTN1mgz
 5O5w0dxXclRwijsR2RVKJQwrnFaB62igaXkV5+r0Mx50+gpVRpLuA3KRWQzOAzRy54o8LWIRu
 4ocJ1nuC0rvu+5CO5eljQhRkjk4DVR8MGB1bXN5ts5iIiuQfrUE8GYVXOaA1ULvfu2j/UTOvv
 qlfYBPNxqrqTg5bNMa/heLkyzCQF3OGTRMOcOTrpW6cyRcjIQpvPMfJIBdcUL0DZxa0Vwkztj
 5Ol+i50qPUdcLr6kRDQM4wf5PxJsui/cGwQfa5S5Sc5w6KjAr8eOqYc+fZ1UcSDAf4QTyGX70
 51xz4GrnM7pro1jr7dZl6qU+/iE8RmTddOoTUBPdj7aB3rHNJA9GykX6yqFbNKCpLqmWwmpk4
 noXSez+y6Rc2fYgrinBxJVocOHfThylOqtKcHhkELqnAGz8tXp5iwwdLxkONa5lQIZ8CiG0LK
 lasssUNhaObyWTbCPlKPnKmrgH9qfwCizASUt7/HVkm9Et4VOXKCEAvxPvaTOSc6wFC0Lpuzx
 GnvwWFIRkVo2QQ9Yt4p/t4YavwfggOsLGDV+xqMmvxdLhiHtJf4F3/sHZaPZYL9EO3cuk5YG4
 nna/j98ywMN8wX0BWT/rLdeJAxMMMQF3pV1IrW72cyICjwikOb/jCVUd6LD3bjq/x0+Ro0HRr
 uH3uoTbH4cHMHItAxJSSeLWPZiMGcXV3R4AwLPvOt4ydxvVEsMX4dLwpIJf1yu9Y1Y2Eyvdq8
 aEQRpnMUr2dDLZgGIDfQj3GOpuem4zy+wbKt3YB8VfbL07Kfgf+lasCwLEiciSIiD+Bn3Pxpn
 JuChyo5Shm42x2SleusRNjaEKp8DPJJUDWWawtDrqYZHirmua8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:18:29 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/i2c/busses/i2c-sh7760.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.16.1
