Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932150AbeCIQYl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:24:41 -0500
Received: from mout.web.de ([212.227.17.11]:42567 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeCIQYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:24:39 -0500
Subject: [PATCH v2 0/4] mfd/tps65910: Adjustments for four function
 implementations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:24:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Gmkf7pgfBOhcbDS9SUZHL3J7A5P4fXQEu2uHw+KIOllMRBZKg20
 9xvo/APqdBZNxlIQ0tWzq3zw1+IopOqrY+KrkrMUo6d+xOANKZjji8Qb9SIC5HaG9HKAyvI
 4W+98KFnvEI6y+G8pecj9KCoonYXGxuhE8a9yjfuOcAfwqNzqrL3LF9rmdgQepeftrTKs/I
 W0z/Iu6H5SgRgzLhaWNyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ASl9YKiVlgY=:yS4UqJKL8PSBGjCLcXf1fm
 sG9bbMiG8I7vh5uz6Npobzew9wYWzdt3J2ddhYODs2tKab6Q0gwTtVDnzE+0xR9XNLQRnYKqa
 v39Pynx1p4Yv5u3JWvDFumjDm+T5dKw1J8/HubvOte7rcBjms5j78E5ruewrIyX9ukT0JGwAI
 CuXKMmzxcQcpgOQBZ1pa8bmvgVZtjbrf9ByVY/lqKts1paQTDJvFhuFHEzSwUoBzAQXE6+5sq
 x+oN+yZqrmb9bqR0wFG4EDfd4OQTJxPSVuGe8MEqxNVIz/cbk+CqYbgsJWoC6Rbz7iUv5omcd
 rd/Zdtnm/lsEDrrOu9RpNBjgw2/u8OepEAtsFo8tG5biYvatrsQnWHTuZ/99lUP60tDIwXjd/
 Wcgqok/++Zywl58JhPfbsXQ48aihdCVmgm4ynVTc2upk+oWH1Om6VFSlyyNZtOL35J82dkLVm
 y1YvBS2F+Uv2ZmFJ6AqkLTAgNDqipMUmoFylq7epV/xsiafN5RAeIP3qEib0rXHY1CEjcTY1l
 rGZEyKbDKllyL2F7RmCDDC3YMeobi4TfFOknwXlWMqlSnbDTZWiAMmQIEVynz2leA5L5JM2mY
 0tW8eCuTqpmvCvNtWJL5h9btTDoPqnaALBIqCq8d2M3aqbpKnP+o9E8zBN4xzDdwTYZhCv0Cz
 KGcLYNsdzxqxg9RqVZ822kDIMaUcTQ2NNQuFLhhuSXA8FwmBrFgacKr4hDrvg/0NTkgiPYLWs
 oI+rQ5IeUOEBxq1sQOqmPZ8YxTnCnApLjARbvs5iqIYT0ODQ0yDOlckEJbVDjBi9y67evyy0n
 aPjKcbhCl1qUqC6+djmnUuonOeEnSbpFtkq2oPx/JGhxnujnlI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation in tps65910_parse_dt()
  Delete an unnecessary variable initialisation in four functions
  Delete an unnecessary variable initialisation in tps65910_sleepinit()
  Move an assignment in tps65910_sleepinit()
---

v2:
Lee Jones requested a resend for these patches. The changes were rebased
on source files from Linux next-20180308.

 drivers/mfd/tps65910.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.15.1
