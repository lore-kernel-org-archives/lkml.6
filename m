Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELsaATwys25vLodHKZeeAgqylJc/x8vNf9Ms/ys+306Kyx+cVFho1UTTJbcgljj4/e/6VbDS
ARC-Seal: i=1; a=rsa-sha256; t=1521432041; cv=none;
        d=google.com; s=arc-20160816;
        b=eM7/LKyWyt1keoKTXBX/eNqypdi2QG4pMolJd0UC2ZK/vhvIwCdxcZFIBabCSFUNkV
         pbOPq7rEKwHa7ekxgm5TJALgcK2+rI5HOObUTFDsto13u1X4BMsvGn5gLrpX9PcjXC0j
         aHvWnGIxU3+6TTarcU7b3rvPFyr7QOjDv/RqhAw4Glq97X0LLg5FZRq7DHYh9hBC5P/G
         oVUUp4u4OPKaoCWzdqb1LG/tKSflEHNYszRDfHpXrTNMELTlPPIX9nVQOivK/mTpDjli
         +9bzaELLuSRBFfR47sumRtIA633AO/kyMc+JTvKspyIPv9+gCSIXGAnl0Z9cUklUAbrY
         p6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=EjR21xzKLRRsJYDJSHeZw5z73Q104Aftt5SzszA9qHA=;
        b=YwXqxzERSif7i1URbjF0muGd8Fa9KNtfvElxXSZYrTdVnuVgbQQeB8ojJmaFvko5rf
         B6nUWBNvnmSl7sL1lhIyLzrZVkmatC2ucrb5cksbjTrFHrNREvZpEWccz9i40tZDpC8I
         5V80K4YYZzaHaD3Z5XQ29nPGjoGntU0fcurbY30dx3K6+o8ZcYFLGFo/xhEGIX/cKqSB
         hnB+TvmUX4AlimJ779eZsZeLAoG+45m3/eKcjwOkoNJ9NQnfle/U/d6QMgImpyx1TgGC
         r5UaNfZu7quZbzMz6kgTJTVSofdmO+JbICz1ypb0MsW1zQXxDGf0xvGehkZBFqCw8nwU
         k8yA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.25 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.25 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: vz@mleia.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <d4d668280fc1615bdf64c2f1fc225a89>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AAF35A8.3040107@rock-chips.com>
Date: Mon, 19 Mar 2018 11:59:36 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org,
 broonie@kernel.org, alexandre.belloni@bootlin.com
CC: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
 Joseph Lo <josephl@nvidia.com>,
 Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 lee.jones@linaro.org, Emil Renner Berthing <kernel@esmil.dk>,
 Heiko Stuebner <heiko@sntech.de>,
 Brian Norris <briannorris@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 linux-rockchip@lists.infradead.org,
 Kate Stewart <kstewart@linuxfoundation.org>,
 linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Gabriel Fernandez <gabriel.fernandez@st.com>, linux-clk@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v5 3/4] clk: lpc32xx: Set name of regmap_config
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com> <20180312095142.30854-4-jeffy.chen@rock-chips.com> <23a9cbf8-9b1d-f7ec-b980-a16c9b2c4d84@mleia.com>
In-Reply-To: <23a9cbf8-9b1d-f7ec-b980-a16c9b2c4d84@mleia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594725097578676295?=
X-GMAIL-MSGID: =?utf-8?q?1595337124528726710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vladimir,

On 03/19/2018 05:57 AM, Vladimir Zapolskiy wrote:
>> >  static struct regmap_config lpc32xx_scb_regmap_config = {
>> >+	.name = "lpc32xx-scb",
> please rename it to "scb", LPC32xx SoC name is already known from the context.
>
> When it's done, feel free to add to the next version my
>
> Acked-by: Vladimir Zapolskiy<vz@mleia.com>
>

ok, will do, thanks:)
