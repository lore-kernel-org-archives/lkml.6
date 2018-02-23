Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeBWIX2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:23:28 -0500
Received: from mout.web.de ([217.72.192.78]:58201 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbeBWIX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:23:26 -0500
Subject: Re: [2/2] crypto: bcm: One function call less in do_shash() after
 error detection
To: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Rice <rob.rice@broadcom.com>, Steve Lin <steven.lin1@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <68946b12-83d6-ab74-fd54-71b23cf9b7ef@users.sourceforge.net>
 <55bdcf76-f1c9-180d-6798-959e617b10ac@users.sourceforge.net>
 <20180222134231.GC28447@gondor.apana.org.au>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <46bd73e1-73ae-24b2-49d6-623328c14e76@users.sourceforge.net>
Date: Fri, 23 Feb 2018 09:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222134231.GC28447@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WDM0MiSzq8OyumG+x37+2tAIHDV0l0jw8mnMth5POB1i5SiUV4K
 pRX+v75ZrjWC5K0dGhBXGJ6SQ4E8zq25uyjkE6nPFPvLUWtf4ASD2so2ZWfaMwN9oaLy8dt
 U0Rg/R9UOg+x5AobTlWzU+GEOPVAq3JYcW+l/2PZsaz3NJ73Fq+t/w8nya9Gz+R0lMZBvEN
 SyjEWmHgXRB+VNUTTZF7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bbs2RNVnMg0=:ln4wHR4gvHfx1D02BYja7I
 EW87ERq1m8zamZOjJbsU1bqkD2q8pUNfRAPFE7X+FJADdgzSbQGttZFYflR5oyRs2x2frnX4y
 d3J7swEacikVOdRfP98O5ZYEeEqr3ubC325keu8qSBgwjyduK/WN9iI4Rllc0yQsOiKf+3wHo
 6agrR6udYkkUsQk51L+zYDlO8cDdRfpAIm35fTjbmF9b2E+dNTBAFzdicd1T+XHEO/SMzda4P
 wG9WYDItFI/cOzvldf59p3JEJCFUuDLR07z9mSMsoZ0Or/DhAjwntxTdh1NovuzZwdIeloEAh
 tybj7CSF+7RW6d/YDXYGX6lsH1egnGS8vxZiflTAJ0MjAOpzPQTAWwQ1hOhWyNXlPawc+LfE5
 EtA++M1RR7TbNGh7nJUZthDukifnMpOvHVrCRzEvjfiYWQmu1pF8W3hbcYSWX4dr90grvOIf7
 Y32fdSmht+Xpw9zeHDjBKCPfc1USidhU71CnOBuo+qrW6IZ77DNW+W5sopWmIfs/nPR9rB6sl
 YTv+X2L+BMFFsQNLmE3kxQXKYDtCsFUXr77AP3PZ2RAGSK88mTUq1xCT8ozK9gf+9nqMC+Nqj
 +NL2tHFBtr+DNpVdO3rnAAEZzRzs93SLRSjd47zU8S20/q+PY/QdpF7SWrENjgjMMMA3T1xGl
 NtgLGSH8E8w5wmjfPszmoegWmtJ1qJ5Okf67qwCyBEn6dwGAnsI4E67Upcn4ClIPrXg4RXdHm
 bKuR6b6IcLYamupA656YMvcrYBCfnCSPzFYZcHhKyDWNmn5Zd3Yn2+4v4FyCgSTGXhrIDhkXO
 Mo3Tli2jhHZ59+fjIFGw1zUX1dlamYFMc7c9JQjI0MGFI3GU5w=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch is pointless as kfree on NULL is a no-op.

I prefer to avoid unnecessary function calls generally.

Regards,
Markus
