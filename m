Return-Path: <sboyd@kernel.org>
X-Google-Smtp-Source: AB8JxZqzSRVz0X/Sj/ZxK9nulTcJczHrvOMEkHPgPNJuD8egUKykDSefG5szfQXeg4/hb804qSf6
ARC-Seal: i=1; a=rsa-sha256; t=1525212073; cv=none;
        d=google.com; s=arc-20160816;
        b=vDKNE6mDlBk6PtSD6B0nuorOg7KXW96eiKLrsmCERoAtdGIbpjgL9AA0/jEDshQfye
         DyyW8boIQUGbX2zihB14RByXM0TCrgHFFbEprd0KCfCbP71Df447VzIMjUlE6EGzy7rR
         xifoMPQqR1nCrHoUtr8/V0tzPS0PCpulU64U6MYfXWu5xrcZKXI1PslfdIOvhgJgjxrE
         XVpZTpT8O0YIhaC2ITnNuW3r6gsAa91j5p25ZnnTeexWykbWsuMmxZwvVkU5aoLWciN/
         acpnvr6ZhN7z4GQfigXZGnJFuFo8jyBq73EzLuR2Sh9FNZ27//FROgxlc9JrOu5o1G5d
         m8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:subject:user-agent:message-id:references:cc:in-reply-to:from
         :to:content-transfer-encoding:mime-version
         :arc-authentication-results;
        bh=DQcx5NHn42J8c1q8wrj0ZBPdF/q7ugOSjp+AKp2jfUQ=;
        b=ds5NkePPrs4fyM/9WyBaSVSqRL3Ebztp87NLjEqG/9x50dRvv/S6OnoZ7RoUl6vO1W
         FiDmD70BxWnOyFzyPOyZS1ewp/KO+4Z6cIqJj5tF6oFeDo9qiK0sqWvCkGlUvFiMU622
         cvqi2Mp2B3wRmMdR63JrikKU9mq5AFI0H+s7Sr5mU8+6kxVxWkztO85Dv+lEC0EqMhGo
         6XbGrADpiiyAJnau5e2k4SuWz+4JYqg3T6a5JsWLONYiAPJ9O+msTbK7Gq/lvYuMGuen
         syQsC+SE7WNjAb62JSZfyWRExTnMbQW0qbigUt91aWxHq96UIM+YfuFyxvi85B3U7sri
         kP2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Alan Stern <stern@rowland.harvard.edu>, Andi Shyti <andi@etezian.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Eduardo Valentin <edubezval@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Tejun Heo <tj@kernel.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180424203239.21885-5-krzk@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-5-krzk@kernel.org>
Message-ID: <152521207260.138124.8854083284582052993@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC 04/10] clk: samsung: Remove support for Exynos5440
Date: Tue, 01 May 2018 15:01:12 -0700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661087387202007?=
X-GMAIL-MSGID: =?utf-8?q?1599300775429806769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Krzysztof Kozlowski (2018-04-24 13:32:33)
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> =

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
