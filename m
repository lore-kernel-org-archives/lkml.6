Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbeENNjx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:39:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57549 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753659AbeENNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:39:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180514133948euoutp016a02a977fa0ff414bc5632dbe96cc4e5~uhntoY6l91558215582euoutp01W
X-AuditID: cbfec7f4-713ff700000043e4-95-5af991a231b9
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: remove unused auo_k190xfb drivers
Date: Mon, 14 May 2018 15:39:44 +0200
Message-id: <508774774.A4nF8YdQe2@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <3959140.hnfON7x99k@phil>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7djP87qLJv6MMrjRJm1x5et7Nov/j16z
        Wpzo+8BqcXnXHDYHFo/73ceZPLZfm8fs8XmTXABzFJdNSmpOZllqkb5dAlfG9W0/2QreclXs
        +nqJsYHxOUcXIyeHhICJxPIVv1m6GLk4hARWMEp8W3iYFSQhJPCZUeL8mQKYogmTl7FBFC1j
        lHi/p5ERwvnNKLH64Ak2kCo2ASuJie2rGEFsEQEVibefOthBbGaBBIkvNz8zg9jCAi4S536t
        B4uzCKhKtPzdDxbnFdCWmHFvEhOILSrgJbFlXzuYzSmgJrF8Sx8jRI2gxI/J91ggZmpLPHl3
        gRXC1pO40nAC7AUJgSlsEhcaG9ggznaRuDB7KTuELSzx6vgWKFtGorPjIBNEQzPQzzv2MEMk
        JjBK7FkvBGFbSxw+fhFqA5/EpG3TgWo4gOK8Eh1tUCUeEvN+vIdqdZRY33uZGRIq0xklru06
        zDKBUXYWksNnITl8FpLDFzAyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAiM+9P/jn/Z
        wbjrT9IhRgEORiUe3hUrf0QJsSaWFVfmHmKU4GBWEuHdbfQzSog3JbGyKrUoP76oNCe1+BCj
        NAeLkjhvnEZdlJBAemJJanZqakFqEUyWiYNTqoGx7D8rN4/f4/N7a/VmvpyrH2zUPbudaf5/
        XoWlDbwBFsy3mMJ3H+YpNWha9SFY+M1GseL/c+z2iKXPP3J18uNJqs0LPok0Bbfaxqy+/e7H
        +y3prAV3ZArZDMvuq0e+eTAtXlrj+R495uPHP069ftFwyZPF3hmvFWtlXoiuUBA9VdPo0+0+
        +6iOEktxRqKhFnNRcSIAT/cRp/cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsVy+t/xa7oLJ/6MMpg6Xdfiytf3bBb/H71m
        tTjR94HV4vKuOWwOLB73u48zeWy/No/Z4/MmuQDmKC6blNSczLLUIn27BK6M69t+shW85arY
        9fUSYwPjc44uRk4OCQETiQmTl7F1MXJxCAksYZT4deEZlPOXUeL4702sIFVsAlYSE9tXMYLY
        IgIqEm8/dbCD2MwCCRKb7k9lA7GFBVwkzv1aDxZnEVCVaPm7nxnE5hXQlphxbxITiC0q4CWx
        ZV87mM0poCaxfEsfI8SymYwSG84/YYRoEJT4MfkeC8QCbYkn7y6wQtg6Er3fvzFPYOSfhaRs
        FpKyWUjKFjAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAgMzm3Hfm7ewXhpY/AhRgEORiUe
        3hUrf0QJsSaWFVfmHmKU4GBWEuHdbfQzSog3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB
        9MSS1OzU1ILUIpgsEwenVANjpMnWGhcJ9r0Ll/kw/yudkhG/46Muy26uqr9q2dMu/1e1aWDk
        WFnFME/ux9mizCN3vOTktk9MnRXynudx0qdUBoMJvksEmaK0+idO99M6/+llU4bU48WKMhb7
        TwQKuAqsW3pu1qcb798rWB9LqY56eVM5ba9l/N3529gfFk2e+CH2WMm+bOYeJZbijERDLeai
        4kQAa2SFOEoCAAA=
X-CMS-MailID: 20180514133945eucas1p22f2300decf24e259a29f5de423d93536
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180427110425eucas1p12aca3b573a6c3fc4b51da9d5d34b3cec
X-RootMTR: 20180427110425eucas1p12aca3b573a6c3fc4b51da9d5d34b3cec
References: <CGME20180427110425eucas1p12aca3b573a6c3fc4b51da9d5d34b3cec@eucas1p1.samsung.com>
        <6386409.PTMV4p8OHo@amdc3058> <3959140.hnfON7x99k@phil>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EDe0Jv028915

On Friday, April 27, 2018 05:07:41 PM Heiko Stuebner wrote:
> Am Freitag, 27. April 2018, 13:04:24 CEST schrieb Bartlomiej Zolnierkiewicz:
> > auo_k1900fb and auo_k1901fb drivers have been introduced six
> > years ago by following commits:
> > 
> > commit 2c8304d3125b ("video: auo_k190x: add code shared by controller drivers")
> > commit 96b1d500e028 ("video: auo_k190x: add driver for AUO-K1900 variant")
> > commit 53027cdf2a67 ("video: auo_k190x: add driver for AUO-K1901 variant")
> > 
> > They never had any in-kernel user so just remove them (since
> > they are platform drivers they need corresponding platform
> > devices to be registered by kernel and it has never happened).
> > 
> > Cc: Heiko Stübner <heiko@sntech.de>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> While I still hold the ereaders using these controllers in high regard
> as my first kernel hacking project, reality is that I don't think I'll
> ever continue on trying to mainline these and if later someone wants
> to resurrect these (very old now) devices, they'll probably need a drm-
> driver anyway. So for the removal
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks, I've queued the patch for v4.18.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
