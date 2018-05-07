Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525702728; cv=none;
        d=google.com; s=arc-20160816;
        b=DqYlV4muVxpnxGdHI2zoaNyV7Wx4duD8KasDk+C8nhvSXmKkMMy1NJRLcUFi3hNO/o
         LY3XrviQZ5CczB3pnb01wzvFn9BgVCRZZsN7qimqAWE+uTbHN6xkw9NFR/X/a+mYkMXa
         qgG8s0/4soloNx5a8m70J9xiORFN8sGlOSynkPY31QyM41Q1e01g1jmf/bxwI3HQ26BA
         mRU4nk4uVE5YUxlBFRWw7zGc4GYzVVD78YwE2+5l1D7LQ4LAuwoKlicx+V98BgG2JttP
         +PrU6a9N6lfFFZFZKDM8WChQr3/NwnfDV5WrbulgqD1oY7TDHdUOO1wYsWKnnoq9OrBh
         CTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=pYwUz6TIcfaLyPES1K0pHvIn8UJZc7wZBQQ6v/B82VE=;
        b=GhZwjx0AbkKu3y2DczaBhPldzKFvqKY8PscmZadrwK+435v4LFPKcmf7JuqQSgLlCO
         QEv0O6wWdIY9Mrr9DS/vHzuAsWazJZCTYzVG0Xp+D2o0rU0O+Yx9vXg81KYdrHpeb0se
         f1sl4nLmqRjeglIxEmb7E1NqX+G6UTMsGvFI3kTrtfsZfaOz/MjnTvHmM3rPTV3a5xPG
         8hCeVOxQ7b8UCNVQ2pVJL0KBfHj/5HwpVB6Oqm0y7Y5WOX+ORaguOUZ3F2bQcElH/APN
         kY2HTSQny2T4z5eIiTqYLibr4fZe4hnRLPOQgCrfRaBpsSJz6hs7cmDlTcdv6yC3SN7e
         kgag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZofJmt8Cs0aQZhmSa3BOB0nA0ycwGrQL8K6cGuV1xGIKgjWrizWXFkTiLes0FFzFK+JDEy1ng==
Date: Mon, 7 May 2018 09:18:46 -0500
From: Rob Herring <robh@kernel.org>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugues Fruchet <hugues.fruchet@st.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Florent Revest <florent.revest@free-electrons.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Smitha T Murthy <smitha.t@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Randy Li <ayaka@soulik.info>
Subject: Re: [PATCH v3 10/14] dt-bindings: media: Document bindings for the
 Sunxi-Cedrus VPU driver
Message-ID: <20180507141846.GA1413@rob-hp-laptop>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
 <20180507124500.20434-11-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507124500.20434-11-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809526277615436?=
X-GMAIL-MSGID: =?utf-8?q?1599815263554547909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 02:44:56PM +0200, Paul Kocialkowski wrote:
> This adds a device-tree binding document that specifies the properties
> used by the Sunxi-Cedurs VPU driver, as well as examples.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../devicetree/bindings/media/sunxi-cedrus.txt     | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/sunxi-cedrus.txt

Reviewed-by: Rob Herring <robh@kernel.org>
