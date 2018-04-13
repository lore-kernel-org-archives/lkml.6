Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDMIzW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:55:22 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54733 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754126AbeDMIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:55:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180413085514epoutp026dd59488d21b646afdef61e0ed0db20d~k8vabPb1G1864618646epoutp02L
X-AuditID: b6c32a36-f6fff70000000fc2-d1-5ad07072c71a
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 10:55:10 +0200
Message-id: <2944702.qKZ0LXufY7@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1523597945.16235.52.camel@intel.com>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7bCmvm5RwYUog7W3dC3mX7nGanF51xw2
        i8+9RxgtLh26yGTx5GEfm8WjvrfsDmweO2fdZfdYvOclk8eJGb9ZPD5vkgtgieKySUnNySxL
        LdK3S+DKuLNlC3PBG96KP6t+sDQw3uDqYuTkkBAwkeifdp6pi5GLQ0hgB6PEtwUdzBDOd0aJ
        h2tWsXQxcoBVbdhgBxHfzSjxZes3FgjnK6NER+tcdpBRbAJWEhPbVzGC2CICyhKLzm1lBCli
        FrjIKDHlxXVWkISwgINEw4ZrYFNZBFQlnkx2AQnzCmhKtHZ8AesVFfCS2LKvnQnE5hQwktg2
        ezMrRI2gxI/J91hAbGYBbYkn7y6wQtiaEi++TAI7SEJgB5vE1wMQB0kIuEhcvw9xkISAsMSr
        41vYIb6Rlrh01Baivhno5R17mCFqJjBK7FkvBGFbSxw+fhFqAZ/Eu689rBC9vBIdbUIQpofE
        0U4tiGpHiTv310PDZA2jxK4jr5gnMMrOQnL2LCRnz0Jy9gJG5lWMYqkFxbnpqcWGBUZ6xYm5
        xaV56XrJ+bmbGMHpQMtsB+Oicz6HGAU4GJV4eBUqz0cJsSaWFVfmHmKU4GBWEuFtlrkQJcSb
        klhZlVqUH19UmpNafIhRmoNFSZz3qc+ZKCGB9MSS1OzU1ILUIpgsEwenVAPjWi6+hwpH9k6W
        2vFC6H6vXdeG8tPqnyMOy/96l5Tk4mZW/bON3cJ49s7dEt0T78relAh46X7qzq+YRdq7lssU
        Ztz19Dl25u+bWc7SLx//e1V6Psjyu+aSUEOHdLd1RXVLDt3da1nVt92l4He7U4qK+tud6Sum
        7p2+eaFrFq/c/jQvy28sTIpflFiKMxINtZiLihMBt1JG2wMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t9jAd2iggtRBnMXSlrMv3KN1eLyrjls
        Fp97jzBaXDp0kcniycM+NotHfW/ZHdg8ds66y+6xeM9LJo8TM36zeHzeJBfAEsVlk5Kak1mW
        WqRvl8CVcWfLFuaCN7wVf1b9YGlgvMHVxcjBISFgIrFhg10XIxeHkMBORonv+2+wQThfGSV2
        7TvN2MXIycEmYCUxsX0VmC0ioCyx6NxWRpAiZoHLjBLfDuxkBUkICzhINGy4xgIylUVAVeLJ
        ZBeQMK+ApkRrxxewXlEBL4kt+9qZQGxOASOJbbM3s0IsW8Mo8fb1QkaIBkGJH5PvsYDYzALa
        Ek/eXWAFmcksoC4xZUruBEb+WUiqZiGpmoVQtYCReRWjZGpBcW56brFRgWFearlecWJucWle
        ul5yfu4mRmD4bjus1beD8f6S+EOMAhyMSjy8CpXno4RYE8uKK3MPMUpwMCuJ8DbLXIgS4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzns771ikkEB6YklqdmpqQWoRTJaJg1OqgbFsi717xd5n2xki
        9q+coPhvesS/lgk747lnTjt64uH7v9e1liWc//CBt/VD24Pio7/WphQ/elA/KyThSFqNu8/2
        25qX4kxc1h/vPmI195fKr89lsw80TPebdH7r6sxLlyevcdfdP8/N9LbltDn38/ma0zIWsaX4
        XptfJ2UhXsL058amDvaq6OwPSizFGYmGWsxFxYkAbfgy6FsCAAA=
X-CMS-MailID: 20180413085514epcas1p131019e281e698edbf9d75f16054d49e6
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180413053914epcas3p3b7e3c278515ffed1b4c019b2c5af3ab4
X-RootMTR: 20180413053914epcas3p3b7e3c278515ffed1b4c019b2c5af3ab4
References: <1523436077.16235.5.camel@intel.com>
        <CGME20180413053914epcas3p3b7e3c278515ffed1b4c019b2c5af3ab4@epcas3p3.samsung.com>
        <1523597945.16235.52.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3D8tQcZ019330

On Friday, April 13, 2018 01:39:05 PM Zhang Rui wrote:
> Hi, Eduardo,
> 
> On 四, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> > Hello,
> > 
> > On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> > > 
> > > On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com>
> > > wrote:
> > > > 
> > > > 
> > > > could you please illustrate me what the kconfig & warning is?
> > > Just "make allmodconfig" and the warning is about a uninitialized
> > > variable.
> > > 
> > > Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> > > history
> > > is to be believed.
> > > 
> > >                 Linus
> > Yeah, this has also passed my local compilation error. Somehow my
> > gcc4.9
> > is not catching it. Using an older gcc (gcc4.6) does catch it.
> > 
> > Anyways, given that the conversion functions are written to cover
> > for unexpected cal_type, the right way of fixing this is to rewrite
> > the conversion functions to allow for returning error codes and
> > adjusting the callers as expected.
> > 
> > Rui, bzolnier, please consider the following fix:
> > 
> as it is late in this merge window, I'd prefer to
> 1. drop all the thermal-soc material in the first pull request which I
> will send out soon.
> 2. you can prepare another pull request containing the thermal-soc
> materials except the exynos fixes
> 3. exynos fixes with the problem solved can be queued for -rc2 or
> later.

Could you please just merge the obvious fix from Arnd instead?

[ it was posted two weeks ago and ACKed by me ]

https://patchwork.kernel.org/patch/10313313/

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
