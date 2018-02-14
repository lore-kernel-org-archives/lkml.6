Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030340AbeBNNcx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:32:53 -0500
Received: from mout.web.de ([212.227.15.4]:46267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030198AbeBNNcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:32:51 -0500
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] crypto/sahara: Adjustments for sahara_probe()
Message-ID: <6a487cd1-c05c-3d5d-ec6b-a6a2ae376f05@users.sourceforge.net>
Date: Wed, 14 Feb 2018 14:32:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:eBP2Tmtl7C4bTUvai5dTgA9LsoxGJYKbq0NV62btHkp0ALfew4C
 WBWnhkRfhCRBGVa3ul1QWFj3mTSqPk2o0gDFqLJqN0Xsdl5Ov+yylqg30liKwUNhBzJD97t
 G2YvpB+uu+AbEL/G+bKVD97epn55Qipd3PNAvSTXSUcrwwvWW67Sl+IZPyFoEWRUjzebXUn
 bqRdk6IlnZjwW3POHCJrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+iz9XGUOlnU=:9Qo5s/3+G6jj94AZaUiImM
 LYED5g/3UXC3IgKy9CnBTDhFukB+tamKOQLJYNldMD8xHFk7dBRftB4qOA0unZHY9LYbINQ5Q
 84iAelnG65sd2NQhTASxHGMd9Egq99fLhbEkrlWPeCE1v+f0OlPVRdvMOL38t+qbO/hLE37s6
 nX8zc+Klte2lbdto+zQTY8py5i78bBhjCzWcr6P/raCWKh4YMpsDkMwEmRh3NaDTQyxmUkOIC
 QhtCIE3xBfngP0AD7PnttVymhLuARGdXBjU+snYus9uaXLYxN0ZmMyo1gLcf7qDQZx33MhGLz
 nhkL2yeAGvwL+1+wzm9l1CoDknnEKY1XunOUUY/EJZHT1ky+qSVOAzaEcqjoPRnw3B9DadKEV
 TzvAig3+FBrmwg0BXGgQ1VCP67paaFwFBGKiOQyAz2WRvxMkhpAdTc7CcU5jgJZE4OAad/ZVg
 Z/zQIR/3naO0JQxuB8MAnIEg6vJqksAbDhnVx4z0Y0Em8q4cUhHGSL5edNyG1iv/tEKBfqk4P
 ivYNzn/u8m3E+NZv6v0pF3W92AvXZAJSaCpPCrEO0g3vomD3A9HuV7cZhPO+NCwdclYBwl2zs
 loWnutQ/UjPl62QatGElucIhjcvsrDd2djFDw7XSMKN8TS0UhTbw093Sg2aSZZKQjsCW8a0sy
 swZXcV+i3HOTscjErTkMq9/1LSCxU0ZKUCF52r07PFCKnI/J2PCopKrZM5zA29xb8NIcHa6zj
 09tCVMPBEV/9FHiEHj0TaW2GW0laAz0HtaR0JUirjeFIHOAv4xBvlaoNuyTxis25ebLj2sKnj
 6otb2od2UIMZqJjULqxL48Z6teU8KUPuSt9rnUBoYUoFr2QSb4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 14:30:28 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/crypto/sahara.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.16.1
