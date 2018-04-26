Return-Path: <andi@etezian.org>
X-Google-Smtp-Source: AB8JxZpYpXNvzjZwvZEVSTNhBlkELYXWsIZCgSmnX9J7QexKXL72iyPNJE+cE/pIaCg7kOpd5UJ/
ARC-Seal: i=1; a=rsa-sha256; t=1524717115; cv=none;
        d=google.com; s=arc-20160816;
        b=NYeore7M36LgRHugDGVXO66KInMWLTDbvgcpnscENJQoWjx6vDKhRuyVRc1Nu7sqKz
         c/ub2EvNowNBXlMUqwZiuuaBupaXyUYK0H+yfgunoTxgRyXFBEws2aSijnPW2d3e2bYT
         0lJP5NcAIgy2lTCMwr2qnL+uUB9XgidJmTZk49KMvectVTqmKeUZJ1LydFAjzKfl/Xn2
         OoCkzAvXKRP3uzPSIQO9ExbxoM6VxxMbBdoaGPDfgzNs2/hOd98sgwOrN0O1TKfgWxNI
         hmS80mXwVZhSVk+UxURc/W9pX1IGUGJOmLvclsq0srNi0CSsaddhN5pagc7I4/wDOJbK
         0ZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version
         :arc-authentication-results;
        bh=mpgxixnfhQ9OdD7+9obl3eRP4Ss3nNuln1wYIal71d0=;
        b=CuL9HUmykmeAv50ho7YjeMBasl1uO9p9fdWF/RzAditaSaAyFFN+wCcZQnXc08nA6Y
         F8E/EpWZ+F9MHQeBvkwhThrH0nzb1K9YUGUNQKlR8wqS6J9NyS5zTLq63iLsm351DT2a
         yQswNzNZ/Ep64n/1YxWM85QKIKKxQbvZEoa5Y0FFPsHwwFdLvE4Qq4LUIwMeaMMkAzpu
         TXw5Kdh7JCgjjHZBbBqYSwgyJApAFQhztzwSXMSCBD3aY+LZTVohKArR/15UuH5tJDFs
         Zq1vjFqkA+VVBTvamGBjfrOYDfsjjKJTYpVCBWNiOxPB0DiYr2QPRKNrmt5BMJOOAE9F
         Regw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andi@etezian.org designates 46.105.61.98 as permitted sender) smtp.mailfrom=andi@etezian.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=etezian.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andi@etezian.org designates 46.105.61.98 as permitted sender) smtp.mailfrom=andi@etezian.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=etezian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Apr 2018 13:31:11 +0900
From: andi@etezian.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>, Sylwester
 Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang
 Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Linus
 Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, Marek Szyprowski
 <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson
 <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 01/10] ARM: dts: exynos: Remove Exynos5440
In-Reply-To: <20180424203239.21885-2-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-2-krzk@kernel.org>
Message-ID: <66d27b987846172e290cbc587b9909ac@etezian.org>
User-Agent: Roundcube Webmail/1.3.6
X-Originating-IP: 113.161.58.156
X-Webmail-UserID: andi@etezian.org
X-Ovh-Tracer-Id: 6213278635976868505
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtgedrledvgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661065038031638?=
X-GMAIL-MSGID: =?utf-8?q?1598781773869521705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Krzysztof,

On 25.04.2018 05:32, Krzysztof Kozlowski wrote:
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There 
> are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
> 
> Remove all Device Tree sources for Exynos5440, as first step of removal
> of the platform to simplify the code and drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

makes sense, please feel free to add:

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
