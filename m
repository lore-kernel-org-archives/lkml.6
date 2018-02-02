Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeBBULt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:11:49 -0500
Received: from mout.web.de ([212.227.15.14]:63999 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeBBULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:11:41 -0500
Subject: [PATCH 2/2] HSI: ssi_protocol: Fix a typo in two comment lines
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>, Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org
References: <14dd4865-f983-ba7d-3068-f6450a8de7ea@users.sourceforge.net>
Message-ID: <74402fa6-dab4-e542-f49e-c20487580ca0@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <14dd4865-f983-ba7d-3068-f6450a8de7ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Gc1D5EP+FbU4y2U90RVnMRJmdf4mIEbmDNmHMCcVFywEuh5t+0z
 aI+o3Uy4Po21hFey5Zrr6UX2msvwksNa4vR3lDQAX+YYH0JDxhRi1psukjdMpHIHC2EyFKF
 ZGWqah+ABMZrL1gfMvUDuy4qmW2q5x9cyC2xw5kFXt8KcVY5ObWov+f+dWxVpdOkDRAbdVb
 R2tJiK3aO7bPzToYjlOxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GMAvAWGDxLI=:/AK1KKoIvDE7vvKaqoovvX
 CfAmq3i6xO5xYnOsqcFersOF/9M0+IoSw0gL74QALKdRfMOVqPqt32kS8auu/kL5N9FzJlv7g
 /V/Ald1zd133SqXT6Ds8pwkekNp6t0NCOlLORghwFyH75W0s4+QbjdGSHanb1+hbzz6ginPQb
 OmutUyUXnSizj6lkOy+OSe/JxC4DxSWpo9jowgk/ialFIFY0BE+uAMnQfcUq3dvs92yHltcvJ
 0NyOXukfk41HSBnGQt5h4tr5xIVtW3QdD5cAvPw61IaGDUJRSA+a7KFGYYkmd+4IaOOVxEDbU
 25T93i7XOpxL7LJX0F95l7uCXgPPRevR20Ip1NtzVmNyjnzdEXN5I54FTttqs15M5hxF+tU/4
 jwh8ymAsvdo0V75PHwNFVXR+mb4Ga6wPgBBpgHr1BO9yOHKUxjzk6nPqjRySRpPYLY2wQEKE5
 FOwT+iWvFrNtiM8a7myDu1qghxlzDseg42Rk+BYCTGRtTgNWu3JgItHrYVQzrAKnAuoB+TMmQ
 ql57IATv1MoGbFDuNBrAxi+uyev19uXyr7YYcrj6gCYMjUjHjKm11vJkvcFZJO3TAxHq6/WwU
 UZS41/uJMUa+v2fCEFlJ7XVEmM6suIi69tDl7gjtxxmcTBv4pRHUMzIgHPSV78L0UV/w4pz+G
 J9IBgLJo2W6k5ldBvojtawEktVxkxnVkvnaHo74MwcIcoEmz8H8xY26f4O+Zod6j8Xl4IyHUd
 NWNTZ5wnJUwuQwuO/ngrmc8jhaJFddKOraC31DbTFJzLQBX9mh64+Mw/5HeGUWFeq6+vxLpyR
 zP1dL5/tetmdaJfxIjQoa6wmSqThHmKqpGQExUUsUCDsj1JKI8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 20:57:23 +0100

Adjust two words in this description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hsi/clients/ssi_protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 0bccea2fa119..6dbead863d07 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -993,8 +993,8 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto inc_dropped;
 
 	/*
-	 * Modem sends Phonet messages over SSI with its own endianess...
-	 * Assume that modem has the same endianess as we do.
+	 * Modem sends Phonet messages over SSI with its own endianness.
+	 * Assume that modem has the same endianness as we do.
 	 */
 	if (skb_cow_head(skb, 0))
 		goto drop;
-- 
2.16.1
