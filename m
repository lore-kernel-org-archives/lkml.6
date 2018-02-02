Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeBBPAd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:00:33 -0500
Received: from mout.web.de ([212.227.15.14]:65467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752391AbeBBPAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:00:20 -0500
To: linux-i2c@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] i2c-puv3: Adjustments for puv3_i2c_probe()
Message-ID: <2fbd709c-2790-af6c-4fd4-0c8ec6b5b3d7@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:e5CZFh1vs8EngItRUt64scMpreLABLjareFrQ7YVgHCcKWQjm8c
 F1aSyjcw+C4CSscmso/CdOkESjI98MNmOIM1MDKoYPWGT1YJdnll/wneO4hPk7kgu0asVl6
 B+OJkg1t32dxo5Z3lSNb0TjH9kem0DrFbSuj7IvM8Kb/cpPQ4+wPtS6X/hoEEAplVXHVFo+
 TGfx8cZgmYNrbwTdYE2uQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QCCo+6rIkUI=:psQ7VBrucbmIAfw2iwTZ5z
 hfWHZJ8XnQ7Pd/TDHWw0bf1x28Mv41CXKjwPFbUOBd00Pq/UQyt/9nIUUI/PNUn1PS7nA8h6p
 PJf8+kPhXebtOgbAC94CYoH24Y1oQmbPWIkSH9RfG0uE0h9P3lz34JzfrvXO2G0owaPZccsM0
 Nf9mTHCdqP3lHFT9KpiZz/HDYRxRPwHi92NbP8dy5hLN36cwquNENSIwOZ9RH/J38Sc8XVTIM
 +G7kF5TfzDsQHO/vN7vWLw4hlCighER4yYW5s+UGM3F8B75zQJfb0RvRInxgMIpz/vZGrJ3AU
 JtuyZTSYennZbLHq3sr+EB03SZRpCVA/pKTHyG8GXKg3U+b5rJ1B0R7hehmDTmnMxN0WFrAuX
 dnYE556Gc0jX5hTvBLnSemugRwhEEeGdcaeUpgOldeuvKAuwONuhebz7EZrqpV8NqlWPqqIg2
 DhN11zNjapxj06mb/qutXmk0PaXPR/tv0ZsE/jGZrltnYL0HhsRuYpqJ0lzx2/LTFvulmB+eu
 wgVOf3pdqS35DkIgr3uF791iOgzVhb4Ni3eEXrDLVHj/zh1LKUPc9J50LN5IqbR610kzVRjdO
 mHsFFlIeo7frDDNJjnl6bORic7UmdInaDKGO0E38U9HifQ8+40wftj30Q+2TOADCR/QCHoH/J
 wXTvDOJxTl9GFsME7SYtF6tArQ8ZkVFdRBjX/14uz4hQ5TBxF4UGDr7AqtahoBQBqx6czS9RY
 MzlGSH0a8Cx1OwhNJQSED2xhAmXY+XKIcva3ZBTpKdJWapsBTjXoMermE0vc0MasqvMQfEExK
 eQUvHO1WgtLcI4tOQYWt0lfltlupUTk4A+eY35TwGoBNDm9GjU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:54:32 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/i2c/busses/i2c-puv3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.16.1
