Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeCLON2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:13:28 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:32238 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeCLONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:13:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180312141322epoutp0106e677486915408fcfb0c694dc0159df~bMcCYiqUY1448114481epoutp01w
X-AuditID: b6c32a48-9adff70000000ff0-e4-5aa68b01721d
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: remove unused kconfig SH_LCD_MIPI_DSI
Date: Mon, 12 Mar 2018 15:13:11 +0100
Message-id: <3051452.cQdIOQBJIn@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180122123500.12359-1-clabbe.montjoie@gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCmhS5j97Iog+lv5C3+/q20uPL1PZvF
        ib4PrBaXd81hc2Dx2DnrLrvH/e7jTB6fN8kFMEdx2aSk5mSWpRbp2yVwZbzqfctYsJu5Yt/2
        ZUwNjO+Zuhg5OCQETCS69it3MXJyCAnsYJR4+c+6i5ELyP7OKPHo9X1WkARITee7hcwQid2M
        EjdmvoFyvjJKXHy6kRmkik3ASmJi+ypGEFtEQE+ibdYhMJtZIEHi9KJ7LCC2sICjxLuXm8Dq
        WQRUJVrfXQaL8wpoSlw/0wtWLyrgJbFlXzsTiM0pYC+xftMdqBpBiR+TIeYwC8hL7Ns/lRXC
        1pE4e2wdI8hBEgIz2CT2bm6FOttFYtPrpUwQtrDEq+Nb2CFsaYlnqzZCNTQzSnzbsYcZIjGB
        UWLPeiEI21ri8PGLUBv4JDoO/2WHhBevREebEITpIbH1jApEtaPEn/vzWCHBOIlR4vMM/QmM
        srOQnD0LydmzkJy9gJF5FaNYakFxbnpqsVGBiV5xYm5xaV66XnJ+7iZGcLRreexgPHDO5xCj
        AAejEg9vR+uyKCHWxLLiytxDjBIczEoivHc0gUK8KYmVValF+fFFpTmpxYcYpTlYlMR52wJc
        ooQE0hNLUrNTUwtSi2CyTBycUg2M4j/WL15V8W3mx74DU/nlA/8Y1a1+V/qr3MO3fX+98uMP
        hjuvs4T6WmTYlYRvf3vTfPW3/2bvLjcK2dewM7XPveZiX8r968dDsczYvQk5opvkQl+rJ71q
        cVP1EfyxWUP5jUf+IvYPU982dqj/OeJwVKKlwMH/nc4U5jyGSJfSy2fuJM0y4ahSYinOSDTU
        Yi4qTgQAHfde+vICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsVy+t9jAV2G7mVRBrM+aFn8/VtpceXrezaL
        E30fWC0u75rD5sDisXPWXXaP+93HmTw+b5ILYI7isklJzcksSy3St0vgynjV+5axYDdzxb7t
        y5gaGN8zdTFyckgImEh0vlvI3MXIxSEksJNRYvaL+VDOV0aJ/n332EGq2ASsJCa2r2IEsUUE
        9CTaZh0Csjk4mAUSJJ7NSwEJCws4Srx7uYkZxGYRUJVofXeZBcTmFdCUuH6mF6xVVMBLYsu+
        drDFnAL2Eus33WGB2DWFUWLtqROsEA2CEj8m3wNrZhaQl9i3fyorhK0lsX7ncaYJjPyzkJTN
        QlI2C0nZAkbmVYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsYgSG67bBW/w7Gx0viDzEK
        cDAq8fB2tC6LEmJNLCuuzD3EKMHBrCTCe0cTKMSbklhZlVqUH19UmpNafIhRmoNFSZyXP/9Y
        pJBAemJJanZqakFqEUyWiYNTqoHxoPW2Azef8fzhZpv2/dBzttq3Atcufl22a9Hix9NCX2j+
        2DO7x7X+667U32Jy5QtOhb701fh2Jfjd8+Zk59Ucu0ULji5WCi1Ue5D16bHANJXzMx1bHJ54
        Ci4tzl7AxBgoOfl4mknJjGZJTuXv5TFX3m9/wzvtbtG/eTWCE1R0PZ9NZVivG92xS4mlOCPR
        UIu5qDgRAAcLT2ZNAgAA
X-CMS-MailID: 20180312141320epcas2p44944acc3a827b9f3a9d7eb7cbcc8c19c
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180122123705epcas3p48a62b38bd5358d3335a2a85ff7e5b131
X-RootMTR: 20180122123705epcas3p48a62b38bd5358d3335a2a85ff7e5b131
References: <CGME20180122123705epcas3p48a62b38bd5358d3335a2a85ff7e5b131@epcas3p4.samsung.com>
        <20180122123500.12359-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 22, 2018 01:35:00 PM Corentin Labbe wrote:
> SH_LCD_MIPI_DSI is unused since commit 18b6562c243f ("fbdev: sh_mipi_dsi: remove driver")
> So no need to keep it.
> Fixes: 18b6562c243f ("fbdev: sh_mipi_dsi: remove driver")
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
