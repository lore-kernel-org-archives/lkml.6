Return-Path: <s.nawrocki@samsung.com>
X-Google-Smtp-Source: AIpwx4/z8bx8itqhVEiB676iHSw/SxqInfSqfxIeeaDMcjClGeJLR62lh5ofL8oySYXJJBN6Hhml
ARC-Seal: i=1; a=rsa-sha256; t=1524660580; cv=none;
        d=google.com; s=arc-20160816;
        b=kRuxWgi5x4yv7y5xm7FtLD7s33cKL8zgRUblPD/OP96vAkLM4UbM1InPRMIdzgzA9I
         Yf5pVKKDssKvCegP2/ueL0doV+RPLX+dznWbo42vm29q3A70PUDkx2yzZr697pRm769b
         FMPkGkAAgjmk6jM5/U6olYSaPgQj2YNm+2AO8urTdleXTuIKt15G0fYNpUU9Hlu0Wl5Q
         mM1fLA5/CAZH+uDCNaqEQSVJdxjRORYcodwIxhrC2e06wVa+abutIdQjDQaktRCpYYPQ
         l3Nwjc2svySpgWMV0FuO4/jVESEBh7jJDD1iUjV1QrUc5u1mVDDd/Nf+ttfoMG2eSm/K
         j5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:content-language
         :in-reply-to:mime-version:user-agent:date:message-id:from:cc:to
         :subject:dkim-signature:dkim-filter:arc-authentication-results;
        bh=ar20vDfqTwwpmuZIX3eA4umpxU3vGOxAWOw33klaKUw=;
        b=Cu0NPusYynd9M56kfzekSyCqFmyUU21Cc9O2/CfLLDsqeLFsHuk8SdifcBquyBiXif
         8cE9Ry0Ph4AqTuHjykC5Mt9YkUvZHFlyOHont4jNgbvao7PCpR9A4WYG47WauvhKiXyE
         embF0gJ8v1R1AymVLhV9SxrH4J7l5/IPvlYUsBOiE3Lh/5Tzp3QKS5+DIPV2WSReorQ4
         rtXNKXua8Gysdoa95KeXbt2Y+WJ9+cSr2Ru8rNXbTshe8naiCNa9l56PrIDlRpU6fyQK
         mVW2nIPdr7v9F8GenjeEvY+AqyvcefKAfuZWwwLFBNdbpRC2pM6A6yaE5PAY9fbcBYUe
         NiuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=gBKShnAN;
       spf=pass (google.com: domain of s.nawrocki@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=s.nawrocki@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=gBKShnAN;
       spf=pass (google.com: domain of s.nawrocki@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=s.nawrocki@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180425124938epoutp0143918016810e80890b04671504bb68f4~orrfXaozW2821128211epoutp01g
X-AuditID: b6c32a39-8a5ff70000000fed-28-5ae079618189
Subject: Re: [RFC 04/10] clk: samsung: Remove support for Exynos5440
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark
	Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>, Tomasz Figa
	<tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael
	Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar
	<viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin
	<edubezval@gmail.com>, Russell King <linux@armlinux.org.uk>, Hans de Goede
	<hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Andi Shyti
	<andi@etezian.org>, Mark Brown <broonie@kernel.org>, Bartlomiej
	Zolnierkiewicz <b.zolnierkie@samsung.com>, Alan Stern
	<stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, Marek Szyprowski
	<m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson
	<olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jingoo Han
	<jingoohan1@gmail.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <8e4e4712-4b21-83f8-fa06-142e9557a251@samsung.com>
Date: Wed, 25 Apr 2018 14:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180424203239.21885-5-krzk@kernel.org>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUyTVxjd7ftJpctrdXqVjc1m/pCkKm7EB+eYJkjuD3/4YybaGF1j36Eb
	RdYiA43KVKp28iGKw06HATcNKWJbRpgBzCrQqUQsSKuJUBCUKn4hhQIFs9IXE/7cnPuc8zzn
	nieXp5Q97GJ+d3qmaEjXpqlYOV17c5larc3p0axsrP4EKsYGZDBV3MKBrbSagZLefha8gQEG
	ypruho/7HgaOVFSz8ML1mwweTJgYuBI4x0Fh3yAFbW3XODgzeVkG9r6wbuhkNwOOskkEx6cC
	CFrqHsug4/p5FobzmxCUtjXK4JehhxyU/5VHgbOkAUFVUxcHf3rdMnDf3gC3vcMstN5pZyCv
	oYmD/t4CFt55bDQUhe6xMHG5GUHl9fB02whZt5RY/7Ai0uFxUyQ0UYzI6wd5HPFeekuRfyxd
	HKmofyYj9soTLHnkqWfJjQtWjjguHSL3/zvMkNeNnSyp6TxGk9+7xhApqKlEm+Zq5Gt1Ytru
	LNGwIuk7+a5ei53O8FPZg7duMLmokDKjKB4LX+IL4y9YM5LzSqEO4clyHy1dgggP37Kh9yrP
	235KIq4hXGV9NqPyITyYWxKZNU9Ixm+Cx9hpPF9Yhr1TQWZaRAmlcmzNe8pME6wQj/ObCyJj
	FUISHm0ojGBaWIrfHbkawR8JW/DhgXFO0szFY6e76WkcJSTgCdu/ETMqbOAPFNMSXohbfA+R
	hD/FDuvLyFOx4OdxqH2ckTIk45c250yeefi5qyZswIdxDG5v/loq78cnTGZO6j0aXsbZdlYi
	vsI3XW5GMvgQvxo5yUi9CnzcpJQkBFc57swsdT2+mD88syEHwvaSMlSEYi2z8lhmZbDMymCZ
	leEioivRAjHDqE8VjfEZCcuNWr1xb3rq8p179HYU+fdxiXWo5e5GJxJ4pIpWrNzq0ygZbZYx
	R+9EmKdU8xUNsd0apUKnzdknGvbsMOxNE41OFMPTqoWKJxtbNUohVZsp/iiKGaLhPSvjoxbn
	oqu/6tT7Eu91fFw6tvmHA+sF3WndukN/yxP9336zKioYHFI7j1L6qc91Sa7mNXPeaIrizOWj
	ar119c7VOw7a1vpN5pS+hCexn5Ev5piWnP+pdlF0suD+4Mr2np87Q67oQFao9vttrb7M7JTR
	Rb7kipHs7vxTMae6VAr9WV+9MmXTqhUq2rhLGx9HGYza/wGPZUuX8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0jTQRzAuf2ergY/p+GlZDKwUMoyFL5BRFDBQf1RJGIW6MgfGrlpW1ZG
	lGk+Kp3mg2w9jNR8ZNZcWIk6nI/SomXZpvlqaS8sMtPykdamRP5zfO7u87m7P46n5A8YT/6g
	+oioUStjFayUfjo35LpWmfg2fH3BFAfFkx8lMJvbxoGh8C4DBfZhFmzjHxkoannuGLqsDKQU
	32Xhy+NLEuieTmOgfPwyB9lDIxRYLPc4yP9dJoGaIYf3PXOAAWPRbwQZs+MI2h6+k8Cruqss
	/MhqQVBoaZTAme89HNy8lUqBuaABwZ2Wfg5KbZ0S6OzYDh22Hyw8e/qSgdSGFg6G7ToW5qwG
	GnJmXrAwXdaKoLLOcbphgmzxJVXXqxB5Ze2kyMx0LiLfulM5YisZo8gjfT9Hius/S0hN5TmW
	9FnrWWK6VsURY8lp0vUkmSHfGl+z5P7rdJpc6Z9ERHe/Eu1yDZduihJjDx4VNes2R0pj7Poa
	Ov4TdXyk3cQkoWzqPHLhsRCErWPDDpbycqEa4Yr3BWhhYkfYcK2EcVpuwjY8+iuddbK74Idt
	s78Yp0QJhVLc1dPOLBRGhI3J6chpsUIgzmrVzbNM2Ix/NmTPMy344rmU6nleJoThAcsYu+C4
	4sm8AdrJLkIwnjY0Od7EO25YjfPzVc5lSvDAbYM9aIFXYmPVVyoHCfpFtf5/oV9U6BcVNxBd
	iZaL8VpVtEq7IT5QLR4L0CpV2gR1dMCBOFUNcnyn2mZ/3UM0WBJhRgKPFEtl3aGD4XJGeVSb
	qDIjzFMKd1mD90C4XBalTDwhauIiNAmxotaMvHha4SHrVbftlQvRyiPiIVGMFzX/diW8i2cS
	ysjbd7vvQljITlO9+M6Nhyc955MSfGsjJ5pPNvtNHd4XFOPp+qGwwpQVRHu5b1xtObeDObPC
	wyVU5+OjbyryuV2e8rgv7OLWsylLbt47lfbHuxT1R5I1mWPBq5JXzNWN9JaPDlWb8vzs+xMM
	o2lh5tnGkIyoCVLmP7H7zZ79N45NKWhtjDLQn9JolX8BDJHkNEoDAAA=
X-CMS-MailID: 20180425124937epcas1p4733eb597ccc5a280756441b1de5ac6b0
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180424203341epcas5p3a6db7d58b0ce8940d03711823fbf6e41
X-RootMTR: 20180424203341epcas5p3a6db7d58b0ce8940d03711823fbf6e41
References: <20180424203239.21885-1-krzk@kernel.org>
	<CGME20180424203341epcas5p3a6db7d58b0ce8940d03711823fbf6e41@epcas5p3.samsung.com>
	<20180424203239.21885-5-krzk@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661087387202007?=
X-GMAIL-MSGID: =?utf-8?q?1598722492228593288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cc: Jingoo Han

On 04/24/2018 10:32 PM, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks Krzysztof, patch applied, assuming there is no issues with applying 
patches from this series individually through the subsystem trees.

-- 
Regards,
Sylwester
