Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031253AbeBNPYP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:24:15 -0500
Received: from mout.web.de ([212.227.15.4]:48327 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031177AbeBNPYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:24:13 -0500
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joel Fernandes <joelf@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] crypto/omap: Adjustments for three function
 implementations
Message-ID: <28780631-d093-a581-8690-3868f8fa327e@users.sourceforge.net>
Date: Wed, 14 Feb 2018 16:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:eov5iLzK4ZKeSnEih21xVzqBY+7+kiksmDTVYgt/EGFA2hriqrI
 pcSREgEPlq0b2TUl/IbdvXbbfpPjl5QOyImJhzUjnmccTlHc3fKA7QVae40h903tStqPhvJ
 XdDa67oXNVvli6pmMfikNWoe7aCR1cufDfwXuPfgvQYdLMn9cCyydTl2OGqeBmFc26OGffA
 Uc6DtYNyMIyj8WV48VypQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A3z8SkGGnY4=:+kTy1n4kAqVVjAYIa4iSpt
 m10MGTddP8l13fOkV40P1Pc1T1zUmESxYXC4NDWYd/D8zuaoP3MBGczWaoa7nq+R9SMmzriq3
 o1huuotFjUY25Z7oqze3KKe8D7jupuf+9yeqevFGQ+m91jGy9divkN7h/0qEkyB6ndg7kEewd
 SG43Tkl5oFlcb3uMxzcayGMYOrL3ar8KyeU8oOvY/AQxsFGLe43CtFmyoMQiW6DOZ17b7RmrN
 Fzw4wNUMx0sk9ZkPzHxRs16zIfdYQ+j8GJLuq3qIRLbIhOfyrd180t8rP2euLrSXDipB1ohyd
 mVAUeCbOGM0xpsU3edqNYcDNPfY5GnEknF4TOPaB+PohFheKX72nQhszmAZwWGm/qNypPti2x
 lOa8y47q6gttzL8fWWznUzU7c8fDvl9mCoUyGTOctyeUVR6UixmBvv++4PkF8IzqjbO0yfrGk
 BoKZLR9vLBXPKOgMEHVtahKl3L551032MOG/MxZKuB0954i6D3gXBa2oJA8ifnScmhn9l+o7W
 /LjjMn+WyTRUR0vfnX5aRLEPwcwfMElNzK5lunsJhamrLVQmvqw6VZGPZAQI30T2wK0lxs3Qy
 aUTsb5a4CBkWT1FaqoEvaRzJ9bIxa1jOt5zorImjDfAPQcWA9klvyMwA9XoAKjxPIN/NcJw87
 AquXBmuVem16s+JDA3PcEI2pxqr8p5TABPKcwNE2C5I3yEBe/BiM9rzRUSa2VL3qwup84oZ9d
 CVxmRBlgty0BCPbp16JSuOxItyoQfoQgn/idKy4JloyLt3+LzOrZ0PJt7dknhIhsjqQhv4Ws8
 yFpPHaPqMVglDQwBytL/7S/EA9FffR2S1Go16wmxxnbp8P59zg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 16:18:19 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete error messages for a failed memory allocation
  Improve size determinations

 drivers/crypto/omap-aes.c  | 8 +++-----
 drivers/crypto/omap-des.c  | 8 +++-----
 drivers/crypto/omap-sham.c | 4 +---
 3 files changed, 7 insertions(+), 13 deletions(-)

-- 
2.16.1
