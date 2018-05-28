Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeE1HFG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:05:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56654 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbeE1HE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:04:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180528070456euoutp01536bc6f0c2806647fe6feb372759b7b3~yvQ8dQ_aS0113501135euoutp01j
X-AuditID: cbfec7f4-6f9ff700000043e4-b8-5b0baa1563a6
Subject: Re: [PATCH v2 1/3] usb: gadget: ccid: add support for USB CCID
 Gadget Device
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Date: Mon, 28 May 2018 09:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180526211940.25474-1-marcus.folkesson@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djP87qiq7ijDfrmWlvMWb+GzeJY2xN2
        iycH2hkt5pxvYbFoXryezaJnThOjxcK2JSwWl3fNYbNYtKyV2WLi+nusFu8/dTJZvL0zncWi
        Z+cJRovNm6YyO/B5bFl5k8lj56y77B6bV2h5bFrVyebx7tw5do8TM36zeOyfu4bdY3HfZFaP
        z5vkAjijuGxSUnMyy1KL9O0SuDK+3pjGWnCHs6J5ZVoD40X2LkZODgkBE4nXP6YzdTFycQgJ
        rGCU+Dn7NyuE84VRonnrchaQKiGBz4wSe9dHwHRcOTOTHaJoOaPE8RWtzBDORyDnD8gsTg5h
        gXCJhhPbGEESIgInmSUmNq1lBkkwC0RInPhykBHEZhMwlth7sAPMZhFQlZh89z2YLQpU0/T8
        J9iBvAKCEidnPgE7g1PAQWLemiuMEHPEJW49mc8EYcsDnTob7AoJgb/sEh+2fYNqLpNYMqeZ
        BeJuF4lvN3awQtjCEq+Ob4GGgIzE6ck9UDXlElM3X2ODGNTDKLH8w1uoBmuJw8cvAtkcQNs0
        Jdbv0ocIO0rc6HjKDhKWEOCTuPFWEOIePolJ26YzQ4R5JTrahCCqlSW2fD3FDGFLSrS+WcY4
        gVFpFpIvZyH5bBaSz2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMN2d/nf8
        yw7GXX+SDjEKcDAq8fA2/OaKFmJNLCuuzD3EKMHBrCTCy6ULFOJNSaysSi3Kjy8qzUktPsQo
        zcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCUamBk2mw6W9hV4O7DOssypsYp8lcSHNtPOGfY
        ZTcv16nkXM7y5qp3CFfWg5Bb4bJTtsssYjMvjo+UPccwS7Kwiv+jLWPUIfeZkzQDd5iaLBKv
        e3WBw2DLau7WfUYSRZarepjvX69x8H4SkS2YatKcWL5mX/hGM7H35m0533veP77rEJR6adlb
        ByWW4oxEQy3mouJEACG4nCNzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xe7oiq7ijDSa+MrSYs34Nm8Wxtifs
        Fk8OtDNazDnfwmLRvHg9m0XPnCZGi4VtS1gsLu+aw2axaFkrs8XE9fdYLd5/6mSyeHtnOotF
        z84TjBabN01lduDz2LLyJpPHzll32T02r9Dy2LSqk83j3blz7B4nZvxm8dg/dw27x+K+yawe
        nzfJBXBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
        6GV8vTGNteAOZ0XzyrQGxovsXYycHBICJhJXzswEsrk4hASWMkqsWPGbGSIhKdH78ABUkbDE
        n2tdbBBF7xkljt2fBlYkLBAu8WHTH2aQhIjAWWaJ/wsvgiWYBSIk1n6+xALRMZlRYuvzjawg
        CTYBY4m9BzsYQWxeATuJx4f/gsVZBFQlJt99DxYXBWq+d/4TG0SNoMTJmU9YQGxOAQeJeWuu
        MEIsMJOYt/kh1DJxiVtP5jNB2PISzVtnM09gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz23
        2FCvODG3uDQvXS85P3cTIzDGtx37uXkH46WNwYcYBTgYlXh4G35zRQuxJpYVV+YeYpTgYFYS
        4eXSBQrxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjD95JXEG5oamltYGpobmxubWSiJ8543
        qIwSEkhPLEnNTk0tSC2C6WPi4JRqYHRKmvPx7kqDPflyi/5YqRxqK/mpENGe3u05973Y0jd8
        n/ybVSWPp798UrIqXdevdc2FupOhlyL2fExN2ieVozHnZ0+LwpQ/Z6Ifuj6Oy94/y69dXkvj
        2IIHWjM9a5b/cttjXvCgJ+jduSVaC+02TC99FsZUNbf/9u5QSYHyE6H/1OQ2Lb/yvU2JpTgj
        0VCLuag4EQBmmTaqBwMAAA==
Message-Id: <20180528070453eucas1p294be19abd2cab7d112404d15710edfde~yvQ5mevbz2769227692eucas1p2k@eucas1p2.samsung.com>
X-CMS-MailID: 20180528070453eucas1p294be19abd2cab7d112404d15710edfde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180526212048epcas2p1510fd6c92f20e8f6d0059742ab5fb3f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180526212048epcas2p1510fd6c92f20e8f6d0059742ab5fb3f7
References: <CGME20180526212048epcas2p1510fd6c92f20e8f6d0059742ab5fb3f7@epcas2p1.samsung.com>
        <20180526211940.25474-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mi Marcus,

W dniu 26.05.2018 o 23:19, Marcus Folkesson pisze:
> Chip Card Interface Device (CCID) protocol is a USB protocol that
> allows a smartcard device to be connected to a computer via a card
> reader using a standard USB interface, without the need for each manufacturer
> of smartcards to provide its own reader or protocol.
> 
> This gadget driver makes Linux show up as a CCID device to the host and let a
> userspace daemon act as the smartcard.
> 
> This is useful when the Linux gadget itself should act as a cryptographic
> device or forward APDUs to an embedded smartcard device.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

>   
> +config USB_CONFIGFS_CCID
> +	bool "Chip Card Interface Device (CCID)"
> +	depends on USB_CONFIGFS
> +	select USB_F_CCID
> +	help
> +	  The CCID function driver provides generic emulation of a
> +	  Chip Card Interface Device (CCID).
> +
> +	  You will need a user space server talking to /dev/ccidg*,
> +	  since the kernel itself does not implement CCID/TPDU/APDU
> +	  protocol.

Your function needs a userspace daemon to work.
It seems you want to use FunctionFS for such a purpose
instead of creating a new function.

Andrzej
