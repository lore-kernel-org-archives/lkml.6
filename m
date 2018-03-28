Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeC1NTN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:19:13 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:16245 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeC1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:19:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328131909epoutp02531f592d39da6f741ec7e39744e67f94~gGBRV_HmX2864828648epoutp02G
X-AuditID: b6c32a37-55dff70000000fe6-26-5abb964d9dac
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Colin King <colin.king@canonical.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: aty: fix missing indentation in if statement
Date: Wed, 28 Mar 2018 15:19:05 +0200
Message-id: <3386391.UTD4dglipH@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180315181624.18684-1-colin.king@canonical.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7bCmnq7vtN1RBvt/Clv8Xt3LZnHl63s2
        i623pC1O9H1gtbi8aw6bxf/f51gtNm+ayuzA7jGroZfN4925c+we97uPM3ks32ni8XmTXABr
        FJdNSmpOZllqkb5dAlfGmsZO9oIGloqtX3awNjAuZu5i5OSQEDCR2Px0MhOILSSwg1FiYkNc
        FyMXkP2dUWL+6hdMMEVzLi1nhkhsYJR49W8SK4TzlVHi4LMbYFVsAlYSE9tXMXYxcnCICGhK
        nD9XBFLDLHCdUeLM/BVgNcICHhIHlx9mA7FZBFQlTi66BRbnBar/1vOPBcQWFfCS2LKvHSzO
        KWAnsXXhAXaIGkGJH5PvgdUwC8hL7Ns/lRXC1pE4e2wdI8gyCYE9bBINRyEGSQi4SEy5MY0V
        whaWeHV8CzvIcRIC0hKXjtpC1DczSnzbsQcaFhMYJfasF4KwrSUOH78ItYBP4t3XHlaIXl6J
        jjaoEg+JO+svQkPIUeLepa3skECZyChxovcJ6wRG2VlI7p6F5O5ZSO5ewMi8ilEstaA4Nz21
        2LDAWK84Mbe4NC9dLzk/dxMjOEFome9g3HDO5xCjAAejEg9vQcyuKCHWxLLiytxDjBIczEoi
        vO81dkcJ8aYkVlalFuXHF5XmpBYfYpTmYFES5w0IcIkSEkhPLEnNTk0tSC2CyTJxcEo1MEZv
        uWrqYtEy8yIbi7/ZjMs8q5Z13Wdvkvfdw6O6KrL94/EXe3U271/Ha/Uq2z3hcFLI5+falXz3
        C6WsVNhkf2Q2LPpXlptzIuRS/uvF+udYXNmmqX2SbVfReH836rnjs+qfK1UO7dpdURP+tnfP
        iXie+6+MrbhDHdaeivi26usRAy6exNhiZyWW4oxEQy3mouJEAKWRE9gMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t9jQV2fabujDE5vYbP4vbqXzeLK1/ds
        FltvSVuc6PvAanF51xw2i/+/z7FabN40ldmB3WNWQy+bx7tz59g97ncfZ/JYvtPE4/MmuQDW
        KC6blNSczLLUIn27BK6MNY2d7AUNLBVbv+xgbWBczNzFyMkhIWAiMefSciCbi0NIYB2jxJm+
        tVDOV0aJO7+2soNUsQlYSUxsX8XYxcjBISKgKXH+XBFIDbPAdUaJ87PnM4HUCAt4SBxcfpgN
        xGYRUJU4uegWWJwXqP5bzz8WEFtUwEtiy752sDingJ3E1oUHwOYLCUxmlHiyrQqiXlDix+R7
        YPXMAvIS+/ZPZYWwtSTW7zzONIGRfxaSsllIymYhKVvAyLyKUTK1oDg3PbfYqMAwL7Vcrzgx
        t7g0L10vOT93EyMwpLcd1urbwXh/SfwhRgEORiUe3oKYXVFCrIllxZW5hxglOJiVRHjfa+yO
        EuJNSaysSi3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFx9eejKVNW
        Wz/VmH5iqozd0f8F0rt8vk6Yln5+lcJG9bU5enyCBxhPzq3scIzucn9w+PNt7vffXuUf5T06
        RfLdhLyd1tkP2H/MnqkccW9erfl91c85qgxM4dFJF2t+BG24tEjIqMDGVpfBTSwnceW82TmT
        jNnmuabnr44z4tr2rNdK2vsQU993JZbijERDLeai4kQAQH4LR2UCAAA=
X-CMS-MailID: 20180328131908epcas1p14a8ca5c7da9d5b7e82ec3c5b803b9894
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180315181633epcas2p19407707285ccc33c3fcd2c8c0d071a57
X-RootMTR: 20180315181633epcas2p19407707285ccc33c3fcd2c8c0d071a57
References: <CGME20180315181633epcas2p19407707285ccc33c3fcd2c8c0d071a57@epcas2p1.samsung.com>
        <20180315181624.18684-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 15, 2018 06:16:24 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a missing indentation following an if statement, fix this.
> 
> Detected by Coccinelle:
> drivers/video/fbdev/aty/mach64_ct.c:183:2-15: code aligned with
> following code on line 184
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
