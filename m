Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-492998-1522315983-2-15861877397291620881
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522315983; b=phIBmFIm7m2gU/eLmm+XlgwJ55qNP1IFV9tp/WtLkWli+jyp8/
    qmb55CoN22smkIwZSvlfFbkJg1BADxIl9tp10TqsZGu9hWjA/0SNlyIv53Dh6sfQ
    982ICBHze2qemc3UQG/7C0rqwG4KizZ5t/Giz9tFhbrrhz4ASNC9fPMESJYvcsqE
    etbkOfC/PJmGBK+8lp1F2YjZwfeGQP9sd+XsPp5Re6JVTRm58Zceld/rF1PFPI5d
    fcwQdQyF6z4NUbldYnTBfMyUFen64tv8TU1NTy6JG87yclADGdG94szAC1gFfVXf
    W5OW/g1kozubAXf8bSxaaU+uWqhkkyBBZmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=fm2; t=1522315983; bh=NXhgzVB+S/20
    SDFfS2v8FLejk515qQw9Rf+i+D/3kAA=; b=UVrtsyffTrBjrL2oAnz4tu2sZ0WJ
    cmTmg6UE3Q2ka5Ta3cZb/F8ltf8wrcvFWywW3lmL1NO39hlzubrEQiMuDkFcOqi/
    t02qO3oNv+exCIlC844Sjp8hRIgrTBD5/m3ewg5WpVjhEDduKRTjPo7QTU3rybSu
    P+9DcAJwMQHgYKv61l5lK+9q/aC7RnYrSQF/GFrzGQ0rPsXWW9JsBNV/8sYtPYIA
    nd5pER5u+JbvISbv208+jN+tFuVs/K9XxpgOVhRImMBUBZOzv0riv05f/myOgLI4
    NzjCkzXd4nxTRcqhZlU5YBUbJBfRuElO/OAG7AqHdLHwnpjgfchU8cu1ZQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=Qjqa7rYr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=Qjqa7rYr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGvmkPh8Hhoo0GEJwMHmkTeneLTaAvGHNgbDWCPLHV6/ZY9+Ea1BqJKMP3iYXjgYhkAMFGtSUMuBCIFueAsOZT4788CwhHAUXUhyU5yPz9rX1RTUaihx
    kOG6326uGlzHZWqb6jVMbwZnwTJBWjak/IMebCC1/r8IC/WC+y972J97paNQwEnnu7DhHS06R1hCrkEA8soEsVt5nlZQaDg4HsAkEbc08Ab14uT6hUVkonZI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=quT60FQZ56WyGy6BLv4A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbeC2Jct (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 05:32:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:33590 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC2Jcr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 05:32:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180329093245epoutp0185c78b42cf997329d8d656033803c435~gWk4msw3-1294212942epoutp01D
X-AuditID: b6c32a39-591ff70000000ff4-c1-5abcb2bcb87d
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5ABCB2BC.6050408@samsung.com>
Date: Thu, 29 Mar 2018 18:32:44 +0900
From: Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Brian Warner <brian.warner@samsung.com>
Subject: Re: [PATCH for v3.18 00/18] Backport CVE-2017-13166 fixes to Kernel
 3.18
In-reply-to: <20180329070045.GA8759@kroah.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmnu6eTXuiDJasMrPoWd3DZNG8eD2b
        xeVdc9gsejZsZbXYcWoRs8X9JYUWCzY+YrSYMfklmwOHx+YVWh77565h99j06S6rR9+WVYwe
        nzfJBbBGpdpkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
        AF2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVijY0NNIzNDDXMzIy0jMxjrUyMgUqSUjN
        6Nj6gKVgM2/F6rnLWBsYj3F1MXJySAiYSJw6d5e1i5GLQ0hgB6PEnt7NjBDOd0aJp3MuscNU
        bV/bwgKR2MAosWj/fxaQBK+AoMSPyfeAbA4OZgF5iSOXskHCzAKaEi++TIKqv8cocbUJpl5L
        YuXsi2wgNouAqsTTvg1gNhuQPXHFfTBbVCBCYuf8b2CLRQQ0JF4evQU2iFngGJPEnVvPwBLC
        AsESq39NZwJZzCmgJ9GyTwmkRkLgAJvEsXd9LBBXu0jMPvoc6gNhiVfHt7CD1EsISEtcOmoL
        Ud/OKLHr7HU2CKeHUWL54kVQDcYSzxZ2MUG8wyfx7msPK0Qzr0RHmxBEiYdE69s2ZgjbUaLl
        znRoOE4GOnTeEaYJjLKzkAJpFiKQZiEF0gJG5lWMYqkFxbnpqcWGBaZ6xYm5xaV56XrJ+bmb
        GMEJTstyB+Oxcz6HGAU4GJV4eC0W7Y4SYk0sK67MPcQowcGsJML7XgMoxJuSWFmVWpQfX1Sa
        k1p8iNEUGMYTmaVEk/OByTevJN7QxNLAxMwImKYsDQ2VxHkDAlyihATSE0tSs1NTC1KLYPqY
        ODilGhgnJVey5E2eZPbrzwpGp69bfR/wb5jLJ5noGzI95mTU5D1H644eT2M9nz7vadN3Z8na
        P44X9578vddg57OAwudBB5aGiLqHd606Zcl8veKEm3DY4nnexzc+4/+4r31519KbUdx1ZgWP
        7s6c93NdwxfRrq74eQL/FcL3WtdZ3GhrUX156cLmaUz8SizFGYmGWsxFxYkA5tv4t4YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t9jQd09m/ZEGfyfr2jRs7qHyaJ58Xo2
        i8u75rBZ9GzYymqx49QiZov7SwotFmx8xGgxY/JLNgcOj80rtDz2z13D7rHp011Wj74tqxg9
        Pm+SC2CN4rJJSc3JLEst0rdL4Mro2PqApWAzb8XquctYGxiPcXUxcnJICJhIbF/bwtLFyMUh
        JLCOUeLR/tUsIAleAUGJH5PvAdkcHMwC8hJHLmVDmOoSU6bkQpQ/YJRo/LCdGaJcS2Ll7Its
        IDaLgKrE074NYDYbkD1xxX02kF5RgQiJ7hOVIGERAQ2Jl0dvga1lFjjGJLFlbSMrSEJYIFhi
        9a/pTBALpjJJLDtwhBWkmVNAT6Jln9IERv5ZSK6bhXDdLITrFjAyr2KUTC0ozk3PLTYqMMxL
        LdcrTswtLs1L10vOz93ECAzqbYe1+nYw3l8Sf4hRgINRiYfXYtHuKCHWxLLiytxDjBIczEoi
        vO81gEK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwti94
        o/850KErNcn7UfLW/oDVBltXvOKQ/cDJvCj/vOjM8KPWJivVf0w2feCxa96nGV8jXc57G8xy
        eKJ0af4PptKTW1fb7bHJ7vwvblv6NuDumju2Sv9YhQum8GT8TOiJ5VQ7Hvb6dILnmaN8bJPi
        mBYxlHN7cnKILTjY4bkns3vf6wa7Kd6pSizFGYmGWsxFxYkA/U3/6GYCAAA=
X-CMS-MailID: 20180329093244epcas1p46b22c233f658961796c44695bfa3275f
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093
X-RootMTR: 20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093
References: <CGME20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093@epcas4p2.samsung.com>
        <cover.1522260310.git.mchehab@s-opensource.com> <5ABC23A0.20907@samsung.com>
        <20180329042558.GA9003@kroah.com> <5ABC8A3A.5030602@samsung.com>
        <20180329070045.GA8759@kroah.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



2018년 03월 29일 16:00에 Greg KH 이(가) 쓴 글:
> On Thu, Mar 29, 2018 at 03:39:54PM +0900, Inki Dae wrote:
>> 2018년 03월 29일 13:25에 Greg KH 이(가) 쓴 글:
>>> On Thu, Mar 29, 2018 at 08:22:08AM +0900, Inki Dae wrote:
>>>> Really thanks for doing this. :) There would be many users who use
>>>> Linux-3.18 for their products yet.
>>>
>>> For new products?  They really should not be.  The kernel is officially
>>
>> Really no. Old products would still be using Linux-3.18 kernel without
>> kernel upgrade. For new product, most of SoC vendors will use
>> Linux-4.x including us.
>> Actually, we are preparing for kernel upgrade for some devices even
>> some old devices (to Linux-4.14-LTS) and almost done.
> 
> That is great to hear.
> 
>>> What is keeping you on 3.18.y and not allowing you to move to a newer
>>> kernel version?
>>
>> We also want to move to latest kernel version. However, there is a case that we cannot upgrade the kernel.
>> In case that SoC vendor never share firmwares and relevant data
>> sheets, we cannot upgrade the kernel. However, we have to resolve the
>> security issues for users of this device.
> 
> It sounds like you need to be getting those security updates from those
> SoC vendors, as they are the ones you are paying for support for that

It's true but some open source developers like me who use vendor kernel without vendor's support will never get the security updates from them.
So if you merge CVE patches even through this kernel is already EOL then many open source developers would be glad. :)

Thanks,
Inki Dae

> kernel version that they are forcing you to stay on.
> 
> good luck!
> 
> greg k-h
> 
> 
> 
