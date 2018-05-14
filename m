Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeENNqg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:46:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46498 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeENNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:46:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180514134631euoutp0209ff2cb7abc7aadeb44ae79566831cba~uhtlcLb0K0262702627euoutp02x
X-AuditID: cbfec7f5-f95739c0000028a9-c5-5af993335392
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR RENESAS"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH 0/3] fbdev/drm: sh_mobile: remove unused MERAM support
Date: Mon, 14 May 2018 15:46:25 +0200
Message-id: <1860943.gJ4HIv7g2V@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CAKMK7uEJYcxpwJbhvQBF87VOo+zFA73Ro-guGkh4FtOFtr1Ehw@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzneV3jyT+jDA7e1LP4v20is8WVr+/Z
        LObOnsRoceHtBzaLzolL2C1O9H1gtbi8aw6bxdaX75gcODz2flvA4jHxrK7H7I6ZrB73u48z
        ecz5+Y3F4/MmuQC2KC6blNSczLLUIn27BK6M5tNTmArWcFYcP3GbrYFxE3sXIyeHhICJxKu9
        R5m7GLk4hARWMEocfv+FEcL5zCjx+uMfoAwHWNW9hYEQ8WWMEttX34Aq+s0o8aN/IwvIKDYB
        K4mJ7asYQWwRAWWJ/s1zWEGKmAXamSXWbdkJtk9YwEvi7YVWJhCbRUBV4sm+WWDNvAKaEtsv
        TQVrFgWq2bKvHayGUyBY4uGTVcwQNYISPybfA6tnFpCX2Ld/KiuErSNx9tg6sIskBI6wSSzc
        dZoJ4jkXidftP9kgbGGJV8e3QD0tI9HZcZAJoqGZUeLbjj3MEIkJjBJ71gtB2NYSh49fhNrA
        JzFp23RoWPBKdLRBlXhIvO5ZCdXqKNHy/iwTJFgOMUosO/eBeQKj7Cwkh89CcvgsJIcvYGRe
        xSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZg8Tv87/nUH474/SYcYBTgYlXh4V6z8ESXE
        mlhWXJkLtIuDWUmEd7fRzygh3pTEyqrUovz4otKc1OJDjNIcLErivHEadVFCAumJJanZqakF
        qUUwWSYOTqkGxi2xi/l8T329cMQ0v5btRI5qZ3f7oUUXl6/rMrh3qCLZZsaMJ/OSnhi6v9/F
        s0LLZIPHw8DLh+MnGdkyTHugwt5VXPf4h0nMJYMiw5BTNecdjqq4Vh4+pRf4Yd+yVeoavmoX
        jrdOYK59XdCW9mfWmuJVl5d8rXYOOLEvYKbGl/tq/AfcfRd9jVJiKc5INNRiLipOBADTe++p
        GgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsVy+t/xq7qGk39GGTx5YWHxf9tEZosrX9+z
        WcydPYnR4sLbD2wWnROXsFuc6PvAanF51xw2i60v3zE5cHjs/baAxWPiWV2P2R0zWT3udx9n
        8pjz8xuLx+dNcgFsUVw2Kak5mWWpRfp2CVwZzaenMBWs4aw4fuI2WwPjJvYuRg4OCQETiXsL
        A7sYuTiEBJYwSkw9vpEVwvnLKPHz9z0gh5ODTcBKYmL7KkYQW0RAWaJ/8xywImaBTmaJQ63r
        wRLCAl4Sby+0MoHYLAKqEk/2zWIBsXkFNCW2X5oKViMKVLNlXztYDadAsMTshrNMENuOMErM
        uzWDCaJBUOLH5HtgzcwC8hL79k9lhbC1JNbvPM40gZF/FpKyWUjKZiEpW8DIvIpRJLW0ODc9
        t9hQrzgxt7g0L10vOT93EyMwwLcd+7l5B+OljcGHGAU4GJV4eFes/BElxJpYVlyZe4hRgoNZ
        SYR3t9HPKCHelMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2M
        0bX26XUhTWH2dx0nx7Gc+CL9tbP8/cF4gxi/y8+umh03qAprDm2pey699q/W/PP6j2K51s+5
        3GE/9fpGv+DtIdqPXlk1c55WnWC49ceHcvZjHy5PeaDssz5vUvzd1Z+Or1Fbm7WYWzq/6U1n
        vJOpjsEMXb1tXyNYN7fGrQnIm6u1gO88e0yzEktxRqKhFnNRcSIAVqm+k2wCAAA=
X-CMS-MailID: 20180514134625eucas1p17261db94e9cfdb0302c63138d262ca74
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8
X-RootMTR: 20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8
References: <CGME20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8@epcas2p3.samsung.com>
        <2561366.LzYTbHeMbO@avalon>
        <CAKMK7uEJYcxpwJbhvQBF87VOo+zFA73Ro-guGkh4FtOFtr1Ehw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 27, 2018 02:09:31 PM Daniel Vetter wrote:
> On Fri, Apr 27, 2018 at 1:36 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > Hi Bartlomiej,
> >
> > On Friday, 27 April 2018 14:21:42 EEST Bartlomiej Zolnierkiewicz wrote:
> >> Hi,
> >>
> >> This patchset removes unused MERAM support (last user was removed
> >> 3 years ago) from shmobile fbdev & drm drivers and then removes
> >> MERAM driver itself.
> >>
> >> If it is okay to merge this patches I would like patch #1 to go
> >> through fbdev tree and patch #2 to go through drm tree. Once they
> >> are both upstream (v4.18) I will apply patch #3 to fbdev tree.
> >
> > Or you could merge everything through the fbdev tree in one go, the shmobile
> > driver hardly sees any activity these days.
> >
> > For the whole series,
> >
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Yeah merging all through fbdev is probably simplest, shmobile is not a
> driver that's actively changed a lot. Ack from me too.

Thanks, I've applied all patches to fbdev-for-next.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
