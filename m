Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031591AbeBNVi2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:38:28 -0500
Received: from mout.web.de ([212.227.15.4]:48633 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031427AbeBNViY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:38:24 -0500
To: linux-crypto@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Rice <rob.rice@broadcom.com>, Steve Lin <steven.lin1@broadcom.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] crypto/bcm: Adjustments for do_shash()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <68946b12-83d6-ab74-fd54-71b23cf9b7ef@users.sourceforge.net>
Date: Wed, 14 Feb 2018 22:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9PLhKeW/NpGEMnTmZlmA+u3eCmNMMFhEucajtKCPmZn01t/QeBW
 KV7hCxwH5MgKZmr0DU7eo1JSAAjK3c+HhbCNO03ZzR2clxWyncjuaFjt8VJFt6telfNgPDa
 WZo94kCdy1GfdhOLzCXlI9YHwI/CptOrNkWxnTDG0lgQu9zjHSm7TdlLs2Trp7sXXPdJRVP
 w7tnzL5DlXwQJdy/JTMIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PmZ06akmnqI=:wu4kmPal7jAC5laxYaJzhK
 u4ZDN8MNO0a01812KY5M+PN5Zx8NrRAAxZXtFOY6HTmqDL11V/H5OuhzxRtN7Onj5TaQffkKK
 JnL/zXw8ckH6vjtValqXIEnHo6LgE+Mi+wzY/Bh6fmEH9Q5q6zKHjRTdoRt72XDJtfe1Sni+4
 u2vQPF6Yh00neC4IIaHAXn6FVlQD45Atvt5keYpmNYX2y4eSxuD6uqgf/SXzT/jiMDXU+iH+x
 ltYDj9ZV0TCPp4Y0ob7r3rK1GnYhP/bMSrNOpEfIc9II3A8yvYLezngm2BiA+EfvSRK1YIKQe
 2rvcWC9OGNEsp9IxBNq5bpSgUAg9md7aUqoJM+qHVye1y6zQrSduqjg968jtehkmZ0u7mrwf1
 pPvqo5Nj5lpYt/C5qwFBYsaTrqjDoORn6l/5JoK+XCQfE2VvF1DLYsgdiGe94Czn3NGvv2dl3
 k4rfpTeQ+1Xqr2tQhrfSaKzJUfRiDDxRDBHYO1a/5E/o52JhR1EasFakvxz/PmzhGm3lGwtq6
 Kn/jl1VvAUsovP4q2IhVC/df8GS3FueNfncqzCfEhKBeYnx1uqi6bOs4ZF7Bl/RyUD/ZtIDWD
 2DaVxQzV2u++l8c+j0gQfzp3DB/7TY5Tec66U6e44yjPz1v2kFktixfKXEAaGQY+9CpnbJgBn
 1Z0qgf+04VMv31x3EekT/L5Qirl6XX+crIciToCJsQiU/ADs17Et7+uwcopns2lAb+1aEQYHj
 J0O7Cc5LcB71ig9cX3F9eHZ6UYEGVsylmoQuQTKuZ2M0PgKDoG5E2Y02BlJcddoovhe/mAWuD
 Ag7vN5WlFCtzBEszIjndcvOI42uFCtLYoV3t/awgQcz3OchhlA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 22:30:07 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  One function call less after error detection

 drivers/crypto/bcm/util.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.16.1
