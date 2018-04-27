Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524839427; cv=none;
        d=google.com; s=arc-20160816;
        b=diJbTy8njhjbqoJbPN8M55YLtn8tK/82Ssqg7/eRbQI1VLMy5DfF3dMIZcY8VlQ7Tq
         n54tyjW7TfBA63NPgWCeQLru6/GAbbR33iQN+ZrswgLat9DD6+heg6jPgc+8wNFm4psc
         mp/DCwwMf1qFy0nbLlwUG+Cu81cUBz6uLV2WE+6aKO3e3HVIZbqMHaBqM5sKOXAM8fi6
         c0BpeiY0IK015Jptci0N26h1LYO2yBqAQo+WVkwzJZX0k4o+y5H+zXrkjnMqZdHujuHK
         UczIaPRCU9Z89ZHgzZ5ngHDto8xf3w3yjxt7yrjeGXFnmJ6N61DAun9gllJ69x08UbVV
         6RRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=tI6nFnLV0RYXz3xOx3P6+HO/SioVgXUJvRqsidE4BsE=;
        b=tFch6C6KGkSNjuLA5887y37f7PQOJ09VeWneRAdcgtYswfMODyuf/1KgF5LmyfMWAm
         x5VovLxWNfOXVHG4d5j41YZgdOZDTgWRtq6sSNrO5DOGSFw2DH0V1uA6t2COuhMMQY3D
         8KupPIWwIRuvxUpVS92AjBGlEN+5VjqXXs4JquWJfuWcLCrPNAjV8xOITcsPf3sgfKux
         9BaOOw3Uyz8bBzRsDo6hpdcZuXh7hvTwY9KKk/+y66RP5MSS+IvnYGN1D0zMf6Uiu0ia
         TKeYmJyxkQAEplAcAiINpqnfHZtWnVSU2R0sDNlHRjat953Hpo2DkCox7WQ9tUwrqGNW
         WDnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZqoY/ltiClUTxOAcXRtAhwPMzhU8C5FUZFJak+aIHm3cA5/b2EHnwUQDwUQ+K+nMl5z/68N4A==
Date: Fri, 27 Apr 2018 09:30:25 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: iio: afe: add binding for
 current-sense-amplifier
Message-ID: <20180427143025.v2pbl6ejikjhsoyh@rob-hp-laptop>
References: <20180423210809.29586-1-peda@axentia.se>
 <20180423210809.29586-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423210809.29586-4-peda@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572695361215117?=
X-GMAIL-MSGID: =?utf-8?q?1598910027094441355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 11:08:08PM +0200, Peter Rosin wrote:
> Similar to current sense shunts, but an amplifier enables the use
> of a smaller sense resistance.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/iio/afe/current-sense-amplifier.txt   | 26 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt

Reviewed-by: Rob Herring <robh@kernel.org>
