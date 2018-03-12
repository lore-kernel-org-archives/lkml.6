Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeCLO0y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:26:54 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24843 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:26:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180312142650epoutp0344c4c4a6b07bd099f81f7db10d7e0f0c~bMnzUFc-E1921519215epoutp03f
X-AuditID: b6c32a46-3a9ff70000001029-80-5aa68e290ded
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Winischhofer <thomas@winischhofer.net>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: sis: avoid mismatched prototypes
Date: Mon, 12 Mar 2018 15:26:32 +0100
Message-id: <80049144.V4PLGzs4dk@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180202150114.299409-1-arnd@arndb.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZdljTQlezb1mUwYx7vBbHJ1ha/J10jN3i
        ytf3bBZb96hanOj7wGpxedccNovpx/6yWaxe+ZjdgcPj969JjB7rDqp63Lm2h81j3slAj/vd
        x5k8Pm+S81gw4z9LAHsUl01Kak5mWWqRvl0CV8bLxjUsBRN5K1r3rmJqYHzD1cXIySEhYCLx
        c/UJti5GLg4hgR2MElPbDzBDON8ZJW59mssCU9X44iQLRGI3o8TL998YIZyvjBIrf09iA6li
        E7CSmNi+ihHEFhFQlJj64hnYKGaBViaJ55OPs4IkhAWcJc5MWgZmswioSpydt5wZxOYV0JL4
        /KePHcQWFfCS2LKvnQnE5gRaPeUShM0rICjxY/I9sJOYBeQl9u2fygph60icPbaOEeLUM2wS
        398pQNguEkum32aCsIUlXh3fwg5hS0s8W7UR7AMJgWZGiW879jBDJCYwSuxZLwRhW0scPn4R
        agGfRMfhv0DNHEBxXomONqgSD4m+9h5miLCjxJMV0BBqZ5Ron/6RdQKj7CwkZ89CcvYsJGcv
        YGRexSiWWlCcm55abFRgpFecmFtcmpeul5yfu4kRnDy03HYwLjnnc4hRgINRiYfXoHlZlBBr
        YllxZe4hRgkOZiUR3juaQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8rQEuUUIC6YklqdmpqQWp
        RTBZJg5OqQbGuEOhL107Jt2NedOrsL3r2t4CB7esmrUmm+PPv0rt5VrnGXlZ9WC9ZNWbP6V1
        9/25DOrjPynMn/F6B392eeSdPqPs6usMUw/NvvxlxkQtBaEDu9smcFVy/PyR8PrAxuVKKyb7
        Tbq0P2TK9yDBFaem6/afPax35cf7M/MmnDzrmzjtZ+DyV9PmvFRiKc5INNRiLipOBABkmtX0
        GgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsVy+t9jAV2NvmVRBjs/GFkcn2Bp8XfSMXaL
        K1/fs1ls3aNqcaLvA6vF5V1z2CymH/vLZrF65WN2Bw6P378mMXqsO6jqcefaHjaPeScDPe53
        H2fy+LxJzmPBjP8sAexRXDYpqTmZZalF+nYJXBkvG9ewFEzkrWjdu4qpgfENVxcjJ4eEgIlE
        44uTLF2MXBxCAjsZJQ72v2CEcL4ySny5vZUNpIpNwEpiYvsqRhBbREBRYuqLZ8wgRcwC7UwS
        k753gBUJCzhLnJm0jBXEZhFQlTg7bzkziM0roCXx+U8fO4gtKuAlsWVfOxOIzQm0esolCFtI
        oJNR4uxVDoh6QYkfk++xgNjMAvIS+/ZPZYWwtSTW7zzONIGRfxaSsllIymYhKVvAyLyKUTK1
        oDg3PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMw3Lcd1urfwfh4SfwhRgEORiUe3o7WZVFCrIll
        xZW5hxglOJiVRHjvaAKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2C
        yTJxcEo1MAbtavbOdDl2Il//h/dj78nOe3/93Jfu0xxpk9XVYOBtY9n+0tHvUHi5h8r33783
        /Kvam+l/i/uaN+vsd29ckx5dXLef8QzHmw8vl/I4rFrB1ai2e1tVo9faKb6Xbxc+1LPtY3yw
        aB/X2jNJUb5FG0Oa9h3fx9hdbrGz01U9pUezXytrxzmTECWW4oxEQy3mouJEAKT/eL9zAgAA
X-CMS-MailID: 20180312142648epcas2p3d66789028e7fcd997dd7aa4f72d130ad
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180202150152epcas1p2f5bae6daf58da50e78af5ea7f5525e63
X-RootMTR: 20180202150152epcas1p2f5bae6daf58da50e78af5ea7f5525e63
References: <CGME20180202150152epcas1p2f5bae6daf58da50e78af5ea7f5525e63@epcas1p2.samsung.com>
        <20180202150114.299409-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 02, 2018 04:00:48 PM Arnd Bergmann wrote:
> Building with LTO enabled reveals some functions whose prototypes
> in the header are different from the definition:
> 
> drivers/video/fbdev/sis/sis_main.h:765:0: error: type of 'SiS_SetCH70xxANDOR' does not match original declaration [-Werror=lto-type-mismatch]
>  extern void  SiS_SetCH70xxANDOR(struct SiS_Private *SiS_Pr, unsigned short reg,
> 
> drivers/video/fbdev/sis/init301.c:8937:0: note: type mismatch in parameter 4
>  SiS_SetCH70xxANDOR(struct SiS_Private *SiS_Pr, unsigned short reg,
> 
> drivers/video/fbdev/sis/init301.c:8937:0: note: type 'short unsigned int' should match type 'unsigned char'
> drivers/video/fbdev/sis/init301.c:8937:0: note: 'SiS_SetCH70xxANDOR' was previously declared here
> 
> The root cause appears to be the way that header files are used in this
> driver, where they contain both static variable and declarations for
> symbols in other files.
> 
> To clean that up, I'm changing all mixed headers to only contain
> declarations the way we normally do in C, or contain only static
> variables, and move the rest to a more appropriate place.  Once that
> is done, the headers can be included in the other files as well, and
> guarantee that the prototypes match.
> 
> There are a few headers that now only contain static variables, and
> I'm leaving those alone here as the patch is already too big. These
> could be trivially moved into the respective .c files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
