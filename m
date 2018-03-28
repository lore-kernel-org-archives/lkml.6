Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeC1ON6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:13:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:62515 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbeC1ON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:13:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180328141354epoutp031783e0499cfea92b4931e0a5fd030db7~gGxEVgGsV2462624626epoutp03W
X-AuditID: b6c32a39-579ff70000000ff4-09-5abba32133b1
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] video: ARM CLCD: Delete an error message for a
 failed memory allocation in clcdfb_probe()
Date: Wed, 28 Mar 2018 16:13:50 +0200
Message-id: <3142281.EDeMi996z3@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <0ad85d10-a18f-ff02-f1f4-95452e54d32d@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCmga7S4t1RBjf6mSyufH3PZnG+czmz
        xdZb0hYn+j6wWlzeNYfN4tDUvYwObB6Xr11k9rjffZzJo+lUO6vH501yASxRXDYpqTmZZalF
        +nYJXBn/rjxjKmhgqVh83KmBcSFzFyMnh4SAicTNncvZQGwhgR2MEgceJnUxcgHZ3xkltk5Z
        ywJXdOY9M0RiN6PEgyM9bBDOVyDn3zVGkCo2ASuJie2rgGwODhEBU4k/J0JAapgFNjBKHL35
        lR2kRligRGLKrstg9SwCqhJdk16AxXkFNCU+bzsHtk1UwEtiy752JpA5nAKeEudW8kCUCEr8
        mHwPrIRZQF5i3/6prBC2jsTZY+sYQXZJCKxhk/h3bxHUay4Sr5ccgrKFJV4d38IOMlNCQFri
        0lFbiPpmRolvO/ZA1UxglNizXgjCtpY4fPwi1AI+iXdfe1ghenklOtqgSjwkfl+/xgRhO0p8
        7GpnhYTJbUaJzXfPME9glJ2F5O5ZSO6eheTuBYzMqxjFUguKc9NTiw0LTPWKE3OLS/PS9ZLz
        czcxglOBluUOxmPnfA4xCnAwKvHwWizaHSXEmlhWXJl7iFGCg1lJhPe9BlCINyWxsiq1KD++
        qDQntfgQozQHi5I4b0CAS5SQQHpiSWp2ampBahFMlomDU6qBcUuQiOj/t9v+3u492XYlwDJi
        zrwvVk92yi8+1780fF3nE1G1inPTF+tvt00QCp+lcU9+28utkXdYFpn9EL6etVs+4rhas1WJ
        UJvVxrJP3S9sith5veXdn7hZnoyOcZD+vF7uc9nvv62d39tXyLHH/ead/n5FzUvGvr9BgRu3
        feS58I2TpT5YTYmlOCPRUIu5qDgRAIqHESoBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsVy+t9jAV3FxbujDK6dFrG48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i0NT9zI6sHlcvnaR2eN+93Emj6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGX8u/KMqaCBpWLxcacGxoXMXYycHBICJhI3z7wHsrk4hAR2Mkocf/iQFcL5yiix5she
        sCo2ASuJie2rGLsYOThEBEwl/pwIAalhFtjAKPF7+VxWkLiwQInEi+OcIOUsAqoSXZNesIPY
        vAKaEp+3nWMBsUUFvCS27GtnAinnFPCUOLeSB2LVbUaJXx1vWSDqBSV+TL4HZjMLyEvs2z+V
        FcLWkli/8zjTBEb+WUjKZiEpm4WkbAEj8ypGydSC4tz03GKjAsO81HK94sTc4tK8dL3k/NxN
        jMDg3XZYq28H4/0l8YcYBTgYlXh4LRbtjhJiTSwrrsw9xCjBwawkwvteAyjEm5JYWZValB9f
        VJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDo6CE7owG09pDeR+2W7LEPI0u
        9PxSebzLUjbT+NvZgHjGtLUVVrzKR1Y+7dh160D8dm1nxy8tXHeX2Dbz9WkueVB8ZXq6rq8I
        6+kpBmsdREwWcBzyuOD8YMWTxJ85963DjFJs6zQuvORNes3IEPE//P61uwqsT//feKQcUZQy
        rUVYZU7v87qNSizFGYmGWsxFxYkAd5tzjloCAAA=
X-CMS-MailID: 20180328141353epcas1p243ffc0a7f0686c03dad486c0803015f1
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171205171236epcas4p33d714ae79a5b69676eec15c84985576a
X-RootMTR: 20171205171236epcas4p33d714ae79a5b69676eec15c84985576a
References: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
        <CGME20171205171236epcas4p33d714ae79a5b69676eec15c84985576a@epcas4p3.samsung.com>
        <0ad85d10-a18f-ff02-f1f4-95452e54d32d@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 05, 2017 06:12:30 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 5 Dec 2017 17:50:11 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
