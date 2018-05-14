Return-Path: <m.szyprowski@samsung.com>
X-Google-Smtp-Source: AB8JxZq53M1eJivZ5uhdKM9pkV5C6kqqMVyDVBoZOS4j3l7vLu5dxWx5i6z1qx5Y4LdCQ/o74OI7
ARC-Seal: i=1; a=rsa-sha256; t=1526301390; cv=none;
        d=google.com; s=arc-20160816;
        b=aq8kpyltIIZXQtHPqJG+NNjEULAA6/AuUl6PFOWYQkz9jPb5JOLiikKsV41+54BLpp
         +sLd/CAbCvH1zw0457q4AhsiclgboingkkLet19fzFDxO9hTaKyuP3COE4I5DcnGKEz9
         ajpUotN9wR2KYoT1ibwjw8K1ss0eOJD63+KVGmXPXB5ZYgRDWV2iAyAxlDIkLKtMi6wu
         BPZV3Yxbr/W85eN/7dXNYKB2izas+kHjEjVz+we/q6OCffjHwJfp8I4Qx9pwKa4w8bEa
         8MMClXEONxH2TlfM/C4C7Rqe726gsFahSkU4hZ+wmxifn+mME8nbNHUGQ9XwTHDrBwtj
         3Oig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-language:content-transfer-encoding
         :in-reply-to:mime-version:user-agent:date:message-id:from:cc:to
         :subject:dkim-signature:dkim-filter:arc-authentication-results;
        bh=LaDfJsW/9f+V519I6ni7BGNVN3R1HOckajUyH2qzBiM=;
        b=BqpiD3msQeDagO/81P1R3ei2fQNhGLVlEjH9meaiHatgfXsWLtOldf5WTQpVK5AHme
         mCt6zw+Anf6whqfE29R3eZ6w3NldLT+WyhO6bkDkxIKdWlJ5Lmk2lZIJWc8/kHThjrrG
         VRTLw8Blt6Mi3iBxZb9xtx0P2AN5UkcNDjcSrLwYs3LtePrwhPQFI40gXOh7xspzxQyw
         5HWd4a9i0Zvn5Q/GOUWDxlOBy1wOwX53TPRQFN2Jp66wxFUBmcEvHGIsLWc2YMmtxB0S
         fZ47Z9z4W77/KRcvfLshQXKZ/MfRu3KvKGqcjP6K6pHTNv5RXQfcRLdWvBKM0gngWVmS
         RS0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=az33GWGM;
       spf=pass (google.com: domain of m.szyprowski@samsung.com designates 210.118.77.11 as permitted sender) smtp.mailfrom=m.szyprowski@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=az33GWGM;
       spf=pass (google.com: domain of m.szyprowski@samsung.com designates 210.118.77.11 as permitted sender) smtp.mailfrom=m.szyprowski@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180514123624euoutp01227d1529a214d08f52ded3699dfc25f4~ugwXa98yy1490814908euoutp01F
X-AuditID: cbfec7f2-1c1ff70000011644-1e-5af982c7e1c9
Subject: Re: [FAIL bisect] Sound card probe error
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki
	<s.nawrocki@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Mark Brown <broonie@kernel.org>, Inki Dae
	<inki.dae@samsung.com>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Andrzej Hajda <a.hajda@samsung.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <27b46bcd-a146-7f89-3682-3407ccc8643d@samsung.com>
Date: Mon, 14 May 2018 14:36:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe8/Zzcux4zR8sLBYFCWoqVEHSvND0KQvBoU2NFt6UEs323FL
	C9JSvBWi4lJn3rByiGnNu5nivCwxmk2YKVaEghe0RPOGkG2eWX778b/wfx94BbhwgOsuiJMl
	0QqZNF7Es+e0Dm4avQyPNyWncopF1ETDJy6l/jHNo9JrGnlU4fd8DmU0vuFTuikzlxrtfM6j
	SozdGDWlXeRTfQtZXMrwOjTIQVzTNYeJdXU5PPGkuYsn7imv54ubXqSK85rrkHhF5xHCl9if
	j6bj41S0wifwpn2sYWgQS1wjk6urt1AaGidykZ0AyNNQZp7BrCwktQg6e+/mInsL/0ag15o4
	rLGCIL/HY7ewNDCH2FAtgkJjka39C0Hb+DUru5C+sLWchqzsSobB1wwTbi3gZA4OqytLOwbP
	EspdzOVZmSADQa8u2NE55DHIrtrYWT5AhsOzijGMzTjDUOn0jm5HXoGf2mGulXHyMLQtPsdZ
	doOJ6UrMOgbkBB9mMtdw9tkXoSCvHmPZBeYNzXyWD8F2R6VNT4W89X5b+SmC9xlqm3EO+gyf
	LWsCy8JJaOz0YeUAGCnvQFYZSCf4sujMvsEJCluLcVYmIDtTyKaPg8bQ8G+1d8SE56Ojmj2X
	afZco9lzjeb/bhXi1CE3WskkxNCMr4y+581IExilLMY7Sp6gQ5bPNfzHsNyOVk239IgUIJEj
	sa9+QyLkSlVMSoIegQAXuRLv/DYlQiJamnKfVsgjFcp4mtGjgwKOyI24ceKhREjGSJPoOzSd
	SCt2XUxg556GHNWjC8FO4QVnWkYzv81rxLXBl8MiSsl++cuQ2vQLJcFDl1rK/Cf3Vzp8DNo2
	EoGNZ+exq/5RE6/aQ4k4R7OpPFq1ldYkaYpMuT3iqarkvpV4LSRFrSdVjPlmqRMD5Ey36we5
	cvLIE7+iRykVs/yCtv6O2cbEiGJzMud6W+SDbRGHiZX6euIKRvoXN8ltyVgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7rHmn5GGTR/ULG4te4cq8XUh0/Y
	LJoXr2ezmHR/AovF+fMb2C02Pb7GanF51xw2ixnn9zFZPF7xlt3i8Jt2Vovja8MduD0W73nJ
	5LFpVSebx51re9g89s9dw+6xeUm9R9+WVYwenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
	WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUcP3mMqeCbQMXChb8ZGxhv8nYxcnJICJhI
	fDj6khHEFhJYyijRfkwWIi4jcXJaAyuELSzx51oXWxcjF1DNW0aJn7sPsIEkhAUMJX5/agBr
	FhGIkDj+bBEzSBGzQDezxJJDz1kgOhYwSdx6f40ZpIoNqKPrbRdYN6+AncShqRPBulkEVCU6
	FvxgAbFFBWIkfhztYoGoEZQ4OfMJmM0pECjxbsVpsJOYBcwk5m1+yAxhy0tsfzsHyhaXuPVk
	PtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjdduxn1t2
	MHa9Cz7EKMDBqMTDu2Lljygh1sSy4srcQ4wSHMxKIry7jX5GCfGmJFZWpRblxxeV5qQWH2I0
	BXpuIrOUaHI+MJXklcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpg
	zO6e1Bty1IH5+uXLn0r8VntpGLAJi85ZvDz3SqvT1HdnZXSX6AcceCP6SWiP9EG+d+nznCbz
	sCa9yH+RHTTH0OCvwFwR313t27RrgiPm2+15v9+yhPVT39FnQqd3Pix5NsnW8ZL75oV5R9Yw
	5W3eaSggW+wh5e2qdvTtitjlP/qOf4zYUzspSImlOCPRUIu5qDgRAKi/bfXtAgAA
X-CMS-MailID: 20180514123622eucas1p197f2aeea88cfdfbc56494b328a25f120
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180514123622eucas1p197f2aeea88cfdfbc56494b328a25f120
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180514101728epcas4p3108760546a415b36252df93dfe38e0fb
X-RootMTR: 20180514101728epcas4p3108760546a415b36252df93dfe38e0fb
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
	<CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
	<b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
	<CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600434255100788752?=
X-GMAIL-MSGID: =?utf-8?q?1600443006213186005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Krzysztof,

On 2018-05-14 14:29, Krzysztof Kozlowski wrote:
> On Mon, May 14, 2018 at 2:22 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> Hi,
>>
>> On 05/14/2018 12:17 PM, Krzysztof Kozlowski wrote:
>>
>>> Bisected to:
>>> 8c123c14bbba4add148536b6d47a9226deda2f7a is the first bad commit
>>> commit 8c123c14bbba4add148536b6d47a9226deda2f7a
>>> Author: Ulf Hansson <ulf.hansson@linaro.org>
>>> Date:   Thu Apr 26 10:53:06 2018 +0200
>>>
>>>      driver core: Respect all error codes from dev_pm_domain_attach()
>>>
>>>      The limitation of being able to check only for -EPROBE_DEFER from
>>>      dev_pm_domain_attach() has been removed. Hence let's respect all error
>>>      codes and bail out accordingly.
>>>
>>>      Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>      Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> The DRM driver creates the HDMI codec but its registration fails, due
>> to some missing clocks. The clock are missing because the exynos5-subcmu
>> driver probing fails.
>>
>> [    0.678578] exynos5-subcmu: probe of GSC failed with error -17
>> [    0.679250] exynos5-subcmu: probe of MFC failed with error -17
>> [    0.679992] exynos5-subcmu: probe of DISP failed with error -17
>>
>> The exynos5-subcmu driver before registering platform device makes
>> of_genpd_add_device() call, so in platform_drv_probe() dev_pm_domain_attach()
>> call will fail, as dev->pm_domain is already set. Previously the error
>> was masked by code removed in the above commit and platform_drv_probe()
>> was could complete successfully.
> Thanks Sylwester!
>
> Ah, I missed these messages because I was looking at err dmesg level
> (and for some reason these are warn). Anyway do you have any thoughts
> how is it connected with missing Odroid XU3 sound card and max98090
> codec?

Odroid XU3 sound card driver is waiting for HDMI codec, which is being 
created
by Exynos DRM HDMI driver, which was deferred by lack of clocks.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
