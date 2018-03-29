Return-Path: <inki.dae@samsung.com>
X-Google-Smtp-Source: AIpwx4+DPhPjEovSqj4YHsHYrKG+tr63zZLH+urTIl+NDMPr7GrUWlswMChJP+LxgdKHWVDJhadg
ARC-Seal: i=1; a=rsa-sha256; t=1522305596; cv=none;
        d=google.com; s=arc-20160816;
        b=Ii90CJ8JmcH3TlczIBBdpav1lT2L6bjfEUqv9kmZJY1lH5ATUzoyyGc0zXn/8nxySl
         fQEQk6fAI1pYETKpD16hAYnPfBzdfuD2hxqX3musryR6N60qrPNoZTvRtIBaIuAR9gUP
         LAUY93ZwYRSALZLEdGVKYThiTImGtev7tsG8AKMPkIeE/+JeOfADoJ0mqb71DAeCKQVX
         rCOf0ufjOl0Vq8y7/7gtlPTYt2QLlCclolZUc2cHEGpP7ZPw1MgVCugHa2Kuz0ijlfzb
         EefEAb3R7iP0eYzrgL1XnYthupgQE+W0wNZIa/jqHj2X0Z7Lgftb9lYkBK7sqyRXlrnP
         ms0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:in-reply-to:subject:cc:to:user-agent
         :from:date:message-id:content-transfer-encoding:mime-version
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=dTA7PqMiTbNnRl1z6jSy6jT8moa+8tgnlGRGS4xJjVc=;
        b=G8m/3r9DGcq8WoUHKqhsmxo3jFRN/U8kcJzghKunb4ivSpYZjpt+r/4BUJ/26iD3y/
         APAHCUqaLtCrD3GLKcw8samalLZEkECdtkd6CE8X1vY5qD3KzD84jRfqQfxPf1IC5Zx3
         6wU1uKBhPPBJsgNh18oPxiC2Wvo+aZPAwMcE7B0cM8FnH0CCXiNv8p7J1HrcZbtnZLo2
         97TSBbjO3MZ6g6v8g/HWpPpA/2cN73YkW9FyT91VVVaP/n83k3OSWuobtim5xUNVQNNC
         lQs2nEwRakm3J7v1R/hZELOEniGrEPn6zTqwzhtRvwWNkQFK/fBLJ7xCmXOaiedGShOX
         ouUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=eWo2bHRa;
       spf=pass (google.com: domain of inki.dae@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=inki.dae@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=eWo2bHRa;
       spf=pass (google.com: domain of inki.dae@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=inki.dae@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180329063955epoutp02b8869460a82a03a201c22ba11f1bc19d~gUN_RB39h2228322283epoutp02Z
X-AuditID: b6c32a47-0fbff70000000fe8-09-5abc8a3a1d32
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5ABC8A3A.5030602@samsung.com>
Date: Thu, 29 Mar 2018 15:39:54 +0900
From: Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
	Thunderbird/31.6.0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Media Mailing
	List <linux-media@vger.kernel.org>, stable@vger.kernel.org, Mauro Carvalho
	Chehab <mchehab@infradead.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Seung-Woo Kim <sw0312.kim@samsung.com>,
	Brian Warner <brian.warner@samsung.com>
Subject: Re: [PATCH for v3.18 00/18] Backport CVE-2017-13166 fixes to Kernel
 3.18
In-reply-to: <20180329042558.GA9003@kroah.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmma5V154og6VTtSx6VvcwWTQvXs9m
	cXnXHDaLng1bWS12nFrEbHF/SaHFgo2PGC1mTH7J5sDhsXmFlsf+uWvYPTZ9usvq0bdlFaPH
	501yAaxRqTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5
	QJcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVog0NjfQMDcz1jIyM9EyMY62MTIFKElIz
	Vky+zFLQwF1xbvYmpgbGixxdjJwcEgImEiu7Z7B0MXJxCAnsYJSYfHg7O0hCSOA7o8ThbcIw
	RU9+bmaHKNrAKHHo0D+wIl4BQYkfk+8BdXNwMAvISxy5lA0SZhbQlNi6ez1U/T1GiQNTu1kh
	6rUkPs79AdbLIqAq8WxBMzOIzQZkT1xxnw3EFhWIkNg5/xtYjYiAhsTLo7fArmMWOMYkcefW
	M7CEsECwxOpf05lAbE4BPYl/h5czghRJCJxgk3jz/TsrxNkuEp9ObmOGsIUlXh3fwg5hS0s8
	W7URqqGdUWLX2etsEE4Po8TyxYugqowlni3sYoJ4iE+i4/BfdpA/JQR4JTrahCBKPCRa37ZB
	LXCUaLkznRXi5wuMEn3r9rFPYJSdhRRMsxDBNAspmBYwMq9iFEstKM5NTy02KjDWK07MLS7N
	S9dLzs/dxAhOcVruOxi3nfM5xCjAwajEw2uxaHeUEGtiWXFl7iFGCQ5mJRHe9xpAId6UxMqq
	1KL8+KLSnNTiQ4ymwFCeyCwlmpwPTL95JfGGJpYGJmZmRuZmFsBkJc7bGuASJSSQnliSmp2a
	WpBaBNPHxMEp1cDInirq057TpW4WVqcos16VPymzMVR31vtKr9jvV5cKZm16rrHj3a4LN80P
	uQVucDCt7Ptp86ItVHx5ycnnkVfXH2nZfTB3467WJ0Yuvf9nSPAc3l69Pfqt+7k8dgXH3MDM
	i4pWq+70/ZapWaCrFHt0euo3ZcenZvMWvm9TkXVz8fe1VXpcWaDEUpyRaKjFXFScCAARXZR2
	hwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t9jQV2rrj1RBs8u81j0rO5hsmhevJ7N
	4vKuOWwWPRu2slrsOLWI2eL+kkKLBRsfMVrMmPySzYHDY/MKLY/9c9ewe2z6dJfVo2/LKkaP
	z5vkAlijuGxSUnMyy1KL9O0SuDJWTL7MUtDAXXFu9iamBsaLHF2MnBwSAiYST35uZu9i5OIQ
	EljHKHFxzW52kASvgKDEj8n3WLoYOTiYBeQljlzKBgkzC6hLTJq3iBmi/gGjxPKVL1kh6rUk
	Ps79AdbLIqAq8WxBMzOIzQZkT1xxnw1kjqhAhET3iUqQsIiAhsTLo7dYQOYwCxxjktiythFs
	jrBAsMTqX9OZIBZcYpS4+XIX2FBOAT2Jf4eXM05g5J+F5L5ZCPfNQnLfAkbmVYySqQXFuem5
	xUYFRnmp5XrFibnFpXnpesn5uZsYgaG97bBW/w7Gx0viDzEKcDAq8fBaLNodJcSaWFZcmXuI
	UYKDWUmE970GUIg3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU1ILUIpgsEwen
	VANj/5M9YdG79odtl/0pruhim2WnZ2PHeIfZeU1MT7J93U1byzsl7RNu3j3iwtzq9UVo+536
	au+TTw02uyz4aa7+6trnZWH7ZjJwbX665vvn/Ys54q3EVzuxnGyaXfI+Z0rVVYdqSZUQdif2
	k4tuFyit7E2acOGm6tWQ86cT/s65cWmeiXvbS8UlSizFGYmGWsxFxYkA8JH1NmkCAAA=
X-CMS-MailID: 20180329063954epcas2p2a22e4878ef3c8147336cc648485a5a17
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093
X-RootMTR: 20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093
References: <CGME20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093@epcas4p2.samsung.com>
	<cover.1522260310.git.mchehab@s-opensource.com> <5ABC23A0.20907@samsung.com>
	<20180329042558.GA9003@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596206117324180738?=
X-GMAIL-MSGID: =?utf-8?q?1596253113327675008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



2018년 03월 29일 13:25에 Greg KH 이(가) 쓴 글:
> On Thu, Mar 29, 2018 at 08:22:08AM +0900, Inki Dae wrote:
>> Really thanks for doing this. :) There would be many users who use
>> Linux-3.18 for their products yet.
> 
> For new products?  They really should not be.  The kernel is officially

Really no. Old products would still be using Linux-3.18 kernel without kernel upgrade. For new product, most of SoC vendors will use Linux-4.x including us.
Actually, we are preparing for kernel upgrade for some devices even some old devices (to Linux-4.14-LTS) and almost done.

> end-of-life, but I'm keeping it alive for a short while longer just
> because too many people seem to still be using it.  However, they are
> not actually updating the kernel in their devices, so I don't think I
> will be doing many more new 3.18.y releases.
> 
> It's a problem when people ask for support, and then don't use the
> releases given to them :(
> 
> What is keeping you on 3.18.y and not allowing you to move to a newer
> kernel version?

We also want to move to latest kernel version. However, there is a case that we cannot upgrade the kernel.
In case that SoC vendor never share firmwares and relevant data sheets, we cannot upgrade the kernel. However, we have to resolve the security issues for users of this device.

Thanks,
Inki Dae

> 
> thanks,
> 
> greg k-h
> 
> 
> 
