Return-Path: <heiko@sntech.de>
X-Google-Smtp-Source: AG47ELtmBFm6YWXdnywmDzgD90+wWopJybMp6EzUPOoiCVOdRvHhSdzhhPjK05ppmKEsD3B2Xtdk
ARC-Seal: i=1; a=rsa-sha256; t=1520849491; cv=none;
        d=google.com; s=arc-20160816;
        b=TFIaN6b4/a2E7Z9XLeVdrPsDmmhU2nskmy5S9tcpHu23kG+WiJKgNWgMB+VfzbowrN
         ugZBKpX3j6GaSpQz0H/AMUIR2QaYHbEE0fkxSop6cTK1zniI0VHCv2rzcokIhyK7CptE
         esKIja2PHwY3zC/HiSyzIPg0Q7EdxazwheQ4sDdw2vdjiqoSnV5y25a3s276H/dLWans
         mPn/QXuP/9u7H1gVniuAv5JCv9nFmaus1i8ST2Heo782t19CfZ6KDfXCJ87hiwF3VFr8
         nvDopHCrBofxmKGi1Ma+ZtIlvQlSJ/vOiAEbVezDgDXwECh6nTQsnaobmWwFVirokqe0
         lErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=j+Q3EdnANJ96zJu73dlAwm8TJybVUeN68dXiwcVaFco=;
        b=zDEDQFp3eJ/HTzmADr1o1z+2Wz+z9lq8H5TQhf8rwbNxD0yZbpS0itSeoUl+FgFezd
         31d2OMhlGZF17Y7WNOqesaBSAowvijNGaJ7Apf4E4FzIvoPxRYvPrGSUb+GSBwB5E2EL
         LpkSO+YCuyYJ6B15IB9hIlYcfIZ2XSYNnvohOppA2IZQiJ2Nq8Au9pmd9qwKBaSh4Wb2
         ud/4y4MR3d3x+EhifF4FBQynUcUrs9fUKZiUgjNycsoa+P2WCxRJ24EdRTNAFD1IgDaM
         6P0C6f2Y07U91J7GTRpNsBmTSEdpZ9flWsXF0UQw9N9wBN5eXK7ng/UmPj+tOVO+T5Mm
         y1DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
From: Heiko Stuebner <heiko@sntech.de>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, alexandre.belloni@bootlin.com, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, lee.jones@linaro.org, Emil Renner Berthing <kernel@esmil.dk>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v5 4/4] ARM: rockchip: Set name of regmap_config
Date: Mon, 12 Mar 2018 11:11:04 +0100
Message-ID: <6419126.t34s1xtZxx@phil>
In-Reply-To: <20180312095142.30854-5-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com> <20180312095142.30854-5-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594725108978688321?=
X-GMAIL-MSGID: =?utf-8?q?1594726275859671903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Montag, 12. M=E4rz 2018, 10:51:42 CET schrieb Jeffy Chen:
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
>=20
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied for 4.17


Thanks
Heiko
