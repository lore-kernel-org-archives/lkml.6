Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCLNbd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:31:33 -0400
Received: from mout.web.de ([212.227.15.3]:57559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeCLNbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:31:31 -0400
To: linux-crypto@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] crypto/talitos: Adjustments for talitos_edesc_alloc()
Message-ID: <ad256dc9-a064-37f9-fb8e-aea22ba40a2b@users.sourceforge.net>
Date: Mon, 12 Mar 2018 14:30:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yhJIvRS17tF8hQHbOcpzVukayUa+Jccivli/czAk+MsRBrD6HbR
 wsxEo+WF1IQfYAXfV5lz/nsQWHoZWahZ4n7Mwlco2GQ9nzGLpglolHgFnVSQ7GhdFemOdDY
 La0lDXLOcO4Si1dFzHhEBtl6hRDGnVPFK6G97gW7rRdYrU9K4sYRAq2nL2jdMGvmB8/iwpG
 +v6C8J1F7FyEimg2oAcoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k9OGV1iZjCQ=:pGug8i1yXPIhU/UyRYFCnW
 X3qH7eUevEwjz5ASpXRCzwcE6IyYgRCOC7fjlos5dKf9FvTVUMUKiWx58bsuOT8sVnimrjNlL
 n5ANzHqXzCg3GeYsCXIDCQMwdIxKHh7eTFd36RBS/iWG1W7uVhr/toEG9+7xvcCxTz835mkF3
 ADP7FpSAILYXj1+5GsG4E2Cw8NNns/T0ETeyEpVka+y9DVo7N07V0DP8i1M2GhIEfUAkZTBQr
 cyazdtntJZQSrQMKYZgWAE1FGY8NibDwBgyNCCSo2x0CoeARgY4QwMhNfcOa7rTaziOvOjPSK
 C8TTuUyrOfH0pMnpw49VbIIRxI7M/0cWbM8CvVGZHOCs+QCoJspwUqdSGakYvSoj7jwJHvLeD
 Yfntpe1ZASjKnIivWYpMvQJeut8ba4Tcbx3NuWfHam8TYKUIg8BH6yz1LIxmzu0BrRWb75P+P
 5YeJFIAiJZzxtO9mFDVXufzQx+gN4EjKomevEBVq+obH5U7Op7r603MOppMkXPDVRFym+adIP
 zEF+pj7lZkwe+Q6vzs8JQz9dz14SiOaMIzddprgyEtWWDoVXd6ES8oOtpch2000PU/us6dLmQ
 LVJVQirXJsO98YSf3KbQTgFozNOzxLY0mTQgoA0ummtRa+f1zyZRKbE8E/Dkvywop3ZyMB+Ho
 YMqHZMMqEat5keMvRt/vvC+kJ3ONydGSmwxOCwgLiAZJEfPygEehilk5xcotIqm9Jg36gKhUn
 kqn30WT8JJnW1JYkfS1N9VYUQIfFpNbRRKAqZ/ZGG0pPvq2xr2ainUz0A9Tw7mtiHVGqf9j4X
 T5cqvCqnTwX/ZoB8VwORvnbAzjS1KGyF1qlwNMpSJX8jRqucDQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 14:24:34 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code
  Delete an error message for a failed memory allocation

 drivers/crypto/talitos.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

-- 
2.16.2
