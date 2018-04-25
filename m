Return-Path: <b.zolnierkie@samsung.com>
X-Google-Smtp-Source: AIpwx4/y7L3UZichjs82k4/tgjmpNabwSpl3yO8F29BCTNVAL3+wKdyNPAP9f7eux9SQnj4X0j71
ARC-Seal: i=1; a=rsa-sha256; t=1524652958; cv=none;
        d=google.com; s=arc-20160816;
        b=a9NE6B0bEEO/d3TBj1mzA5iMYYjBUZzI0IORptaq9671C52GO7oudiUI114IZ3cuFJ
         TaTBP8o0HwwBdWVgxKPcbyA9QubieNqXwF7K+GV5PZ3Xyb1c1XCddks0Kr8iHLQlR8AB
         ivFn5xCq0Blxh1gQS5MSJM9hO3JQVgzZGodZ5QDVSCA8uToBgt9Ox5Tp4VzU0RMMdqOf
         DWgWTJIzriJhiRtDMPjTK9msU7eI5/ErDPKurWfkTYmDmMrhaIbuGbYxFrhlA3Drphnm
         ekaQFjands77tYpG/GPf57HbcIABpk6HAb79E2ZC1jvYsTkj7PdsDYHa6J7l/3+l+lza
         vifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:mime-version
         :in-reply-to:user-agent:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=LrUugWA73u8WdDGLLyppDHocZ7T6xSzQeQRmblPyrAI=;
        b=Vfsxr35vPDH8k2Qnf0zCvI12bYMcOhsHw9mgk97Sejegd3++QNn0+DVOdou+Nxq2N7
         j1nGeqE7YebirEt8XKoF0/jhr7MnIGdDRQO2h8+NgKzb92uANusoCkyiiygK94PlncLZ
         es0i9QA+oGe1MfKlQ9t2raWim+ic0+7aA43XuFu/MRxSJFk32CePFqh/QEeKoEXlq3gN
         DTBB7rhSidJY+IYnPttn3dJ2TtkBCWUeB4pEkMyEHfmfMmo35ggWfS9EpaavV0XK+dm+
         cp7JgNKOlddPock54HLGQWXSNJ4zXfQlEiVamHVvmkxZ78fGgX8jlZ/yUHxbv0D1nwub
         4WKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=YsJhjhwn;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 210.118.77.12 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=YsJhjhwn;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 210.118.77.12 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180425104232euoutp0212dbcd701346013696f407eab390c405~op8hbSfKL2875428754euoutp02X
X-AuditID: cbfec7f5-b45ff700000028a9-7b-5ae05b97e90d
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark
	Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>, Sylwester
	Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang
	Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Russell
	King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Linus
	Walleij <linus.walleij@linaro.org>, Andi Shyti <andi@etezian.org>, Mark
	Brown <broonie@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, linux
	-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 06/10] thermal: samsung: Remove support for Exynos5440
Date: Wed, 25 Apr 2018 12:42:28 +0200
Message-ID: <2298900.1CNNTOno1l@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20180424203239.21885-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUyTVxTefT/u+7au+rayeAfbjB2asai4uJmb6ZZFx3LZYuKvResH68Y7
	dINqWnFjP5yOIBUdYMXgwAkRtFqRj1q1xVIjlCK4UAvSsmVFBDajlTjHx1gFXduXZv65ec45
	z3Oec04uT6v+gIn8Dt1uUa/TZquhnLns+de7rHzzoGbFNZca10zdo/CMycPhY3dHIA6M32Nx
	lbs78tz2szi/pgHihx3lFO4PH2BxyXCIxl5vI4fLps0Utg5HKI8PD7D4YtU0wMaZcYA99iEK
	9zafgHjsRzfAx70uCu9//CuHT50poHHrsRaAL7iDHD4d8FHY15WGuwJjEP9ys4fFBS1uDo/c
	LYa47WEhi5/6mxhc+uQWxGFzO8CW5ohF0wT5IJnUnawDpNfvo8mTsAmQR/0FHAnU/k0TR0WQ
	IzXO+xSxWg5C8rvfCcm1n+s4crH2e3L7xg8seeTqg8TWV8iQyuAUIMU2C9ig1MjXZIrZO/aI
	+tT3P5NvP9U3wO2aoL8t65LtA9V0EZDxSHgb1Qf9ESznVcJZgKaN16EUjANUUtzJSMEYQAVD
	Ni4uqW2OS8wAHW63s1LwF0Ch+k4YZUHhXXSk0AKiOEFIQYGZf2IkWrgvQyFTiIoW5gsE3ejr
	ZKOYERYjz2RDTKyICNpGe2J2LwkfI5urMMaXCe+g8JUwLXGUqPOnESaKaWEhMvbujxkg4aoM
	mf1WSpr1QzT45xSU8Hz0oCO+wyvomaOKkgT5AE3anbP3KAXI2aCS8GrU1uGLdOUjDimooTlV
	Sr+HzOcmQTSNhLmof1QpzTAXmS6X01JagYwHZpssQY1nGmHctchxbtaIoJLferhSoK54bpuK
	57ap+N+3GtAWsEDMNeRkiYaVOvGb5QZtjiFXl7X8i505VhD5/DefdkzYgWv681Yg8ED9omLF
	pjsaFavdY8jLaQWIp9UJipbXBjQqRaY27ztRvzNDn5stGlpBEs+oFyi2vbFXoxKytLvFr0Vx
	l6iPVylelrgPdCctWdTUrmS9dxTnve4EOBkyCqsupcrr60bXJyQHv3r9y8SXy2uS29nK1Z9u
	WbpuXXpykfBsI+88ZP3k6KuOrRnWhemm9I+WVjP51hZHJbzUqLw+lunJm5MGbFeHk3wXDqIr
	Lt2tIcvRF1ZOdaX196Q4usvg2iP2jGXOeWu2nB9UM4bt2rfepPUG7X9fFuar+AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hUaRiH+86Zcxlr4jhZfUnXoWhbanI08zWsDSL46q8oCJoId8qjVs5M
	zJmRXOi2m1lSrV3GaqwcdSqbLE2ldb0tmI230NScSUi7CbJoRlpm44XOZIH/fDzwe3683wsv
	T6v7mFB+v8kqWkyGJA0bpGiaqOtalbn7tT7MWTYP8kZ6KRi/6OHA/qaHBd+nXgaya5vl57mX
	gb/yClnor7tCwQv/KQb+ftdHQ0tLEQeXx+5QUPxOVj6e7WagJHsMwenxTwg8ZW8paC+/zsLQ
	uVoEV1uqKTjxsZOD3NupNNTYqxDcr+3i4JavlYLWxs3Q6Bti4WlTGwOpVbUc9Lw5z8Lj/jQG
	JrwPFZAx+owF/50nCNzl8oiHn8nGpaTgZgEi7d5Wmoz6LyLy4UUqR3yuQZr86+jiSF7l/xQp
	dp9hyUtvJUv+u1HAkRLXMfK8/k+GfKjuYElpR5qCZHWNIHK+1I22Beu1MRazzSouTjRL1vWa
	3ToI1+qiQRu+Jlqri4jasy48UrN6Q0ycmLQ/WbSs3vC7NjG3o5s79Jk+fLlReRw56XSk5LGw
	BrvKvTIH8WrhFsIlnUVsOuLlYD6uK0yedGbhMW86O+kMINzsqmQCASuswxfS3CjAIcIK7Bv/
	wgQkWmhQ4pFXd6lAMEsguL6j4XtBISzDnuFCNsAqufD4fRsX4NnCVlxanfbdVwqR2P+P/8eP
	ChG+3plPTRaCccO1HkWAaWERPt1+gpnkldhZMchmoGDHFM0xRXNM0ZyIdqMQ0SYZE4xSuFYy
	GCWbKUG7z2wsRvKhPfJ8LS1D6QM7apDAI80MVdiuV3o1Y0iWUow1CPO0JkRVtbBbr1bFGVL+
	EC3mWIstSZRqUKS83QU6dPY+s3y2JmusLlIXBdG6qIioiLWgmatqCUvRq4UEg1U8KIqHRMvP
	HsUrQ4+je9u9Ck/OgG97vGtGz7xdmQ+mx6zfuWk8O9ZnL1oeF+RYO3PawaHha0deKnfWn7x/
	dCt+u6B373DTiv583hlf/nVgbtacikv3yjJf3/XYnfH2A/5Flb2xC0qW/mKzuJa0900YN7tz
	mPyctqzcLdRgY6ummBquyKj/zeQtGD3T7DTd0CikRIPuV9oiGb4BUDfhsH4DAAA=
X-CMS-MailID: 20180425104230eucas1p2c498af765175a5040cdb8caec701f3f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180425104230eucas1p2c498af765175a5040cdb8caec701f3f3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180424203356epcas4p44b884a8d409d0faa188a0ecdf4945c11
X-RootMTR: 20180424203356epcas4p44b884a8d409d0faa188a0ecdf4945c11
References: <20180424203239.21885-1-krzk@kernel.org>
	<CGME20180424203356epcas4p44b884a8d409d0faa188a0ecdf4945c11@epcas4p4.samsung.com>
	<20180424203239.21885-7-krzk@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661101248192093?=
X-GMAIL-MSGID: =?utf-8?q?1598714500314428708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday, April 24, 2018 10:32:35 PM Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.

Thanks for doing this.

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
