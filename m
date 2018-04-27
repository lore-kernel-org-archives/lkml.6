Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757436AbeD0R6h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:58:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57326 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeD0R6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:58:35 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180427175832euoutp014142e2a1e6f8eabf9691b9c0272e9b11~pXLwpVcus1504715047euoutp01b
X-AuditID: cbfec7f4-6f9ff700000043e4-06-5ae364c6cbde
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Date: Fri, 27 Apr 2018 19:58:28 +0200
Message-id: <2055912.iuafLNK0IC@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180427174714.bdvvlljk3txwu2bo@darkstar.musicnaut.iki.fi>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87rHUh5HGby6IG6x5oWDxZWv79ks
        OicuYbc40feB1eLyrjlsFrOX9LNYrJ9/i82B3WN2x0xWj8NfF7J43O8+zuRx/MZ2Jo/Pm+QC
        WKO4bFJSczLLUov07RK4MqYuOcBacIutYkvDQqYGxtWsXYycHBICJhKXty1h62Lk4hASWMEo
        0TqhkQnC+cwosWfKAiaYqu9felggEssYJRZ8u8AOkhAS+M0o0X6YH8RmE7CSmNi+ihHEFhHQ
        kHi1r58VpIFZ4B6jxP33D1hAEsICphLL/m9nBrFZBFQlfjYsB9vAK6ApcWPNfrCbRAW8JLbs
        aweKc3BwCnhI/D1SCFEiKPFj8j2wMcwC8hL79k9lhbB1JM4eW8cIcegONonWl7oQtovEhIm/
        2CFsYYlXx7dA2TISlyd3gz0jIdDMKPFtxx5miMQEoJfXC0HY1hKHj1+EWsAnMWnbdGaQeyQE
        eCU62qBKPCTuXtrJBmE7Sqz8+g4aQLsZJeZc/cAygVF2FpK7ZyG5exaSuxcwMq9iFE8tLc5N
        Ty02ykst1ytOzC0uzUvXS87P3cQITBKn/x3/soNx15+kQ4wCHIxKPLwMno+jhFgTy4orcw8x
        SnAwK4nw7rj9MEqINyWxsiq1KD++qDQntfgQozQHi5I4b5xGXZSQQHpiSWp2ampBahFMlomD
        U6qBsWTZIU3exyb33ASahTJFdzVPO3iOXZfhWtIaceWLTctqy47t4zFcdun2thc9DgpCj7Sk
        /R4fnSpe/9yj/FTkp87k2TO9KmLaTnXPXGZ+kCH94czS5i+We58VhpsknJ2a0b6HMWJT7tbb
        zQ8FTRuDfoW/u7Tt5PoOuY3Wqkme1lUrQ8sWih4zVWIpzkg01GIuKk4EAHnKiOwOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t/xy7pHUx5HGZyfrGOx5oWDxZWv79ks
        OicuYbc40feB1eLyrjlsFrOX9LNYrJ9/i82B3WN2x0xWj8NfF7J43O8+zuRx/MZ2Jo/Pm+QC
        WKO4bFJSczLLUov07RK4MqYuOcBacIutYkvDQqYGxtWsXYycHBICJhLfv/SwdDFycQgJLGGU
        mLPhEZTzl1FiT+8pNpAqNgEriYntqxhBbBEBDYlX+/pZQYqYBe4xSjRO+MkOkhAWMJVY9n87
        M4jNIqAq8bNhOROIzSugKXFjzX6wdaICXhJb9rUDxTk4OAU8JP4eKYRYtpdRYveGflaIekGJ
        H5PvsYDYzALyEvv2T2WFsLUk1u88zjSBkX8WkrJZSMpmISlbwMi8ilEktbQ4Nz232EivODG3
        uDQvXS85P3cTIzCYtx37uWUHY9e74EOMAhyMSjy8DJ6Po4RYE8uKK3MPMUpwMCuJ8O64/TBK
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8ooIYH0xJLU7NTUgtQimCwTB6dUAyNbhZ3j1FPz
        fqv8eXCqle3Z5jyFU8e98n7aTM1r58hOu1S1TsQ6dJnrE1svn2yH+Fd3Hkw8kbK7eIZxIpug
        aayjcrdOxcaPP44KSpgvCLDzfdHy4J2t08E9T6WO3Es6lPts5iJBx4kN/m4MJ8pSq+ZqV4Rd
        m9pg3WNS1b3A+4PaVecs8b6ZbUosxRmJhlrMRcWJAOoT0zhiAgAA
X-CMS-MailID: 20180427175829eucas1p1e05e7c5e59d8c5534ce20d3d0c4ac765
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c
X-RootMTR: 20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
        <2238944.jilJcacc6d@amdc3058>
        <20180427174714.bdvvlljk3txwu2bo@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 27, 2018 08:47:14 PM Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Apr 27, 2018 at 05:09:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > omapfb equivalent of drm's commit aa61321d4c08 ("drm/omap: remove rfbi"):
> > 
> > The RFBI driver has not worked nor compiled for many years. There are
> > very few boards out there that use RFBI, and no one has stepped up to
> > fix it.
> >
> > So let's remove the RFBI code that doesn't even compile.
> 
> NACK. I'm just about to start fixing this and hoping to get display
> working on N8x0 boards.
> 
> See the other thread: https://marc.info/?l=linux-omap&m=152469100217934&w=2

You should be targeting omapdrm driver instead, fbdev subsystem is closed
for the new hardware support.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
