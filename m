Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeDJOI2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:08:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:30440 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeDJOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:08:26 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN2ETuY
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 4/5] DTS: Bindings: pca953x driver provides an optional vcc-supply property
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180410135557.umt5sgxrx23dirpo@rob-hp-laptop>
Date: Tue, 10 Apr 2018 16:08:14 +0200
Cc: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Message-Id: <A246E2A2-F360-4099-91E2-8A5A25656A36@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com> <e8e6fae4436e5390c7c4e831c9eb127d3f8cc65b.1522868423.git.hns@goldelico.com> <20180410135557.umt5sgxrx23dirpo@rob-hp-laptop>
To: Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3AE8XkT032561


> Am 10.04.2018 um 15:55 schrieb Rob Herring <robh@kernel.org>:
> 
> On Wed, Apr 04, 2018 at 09:00:23PM +0200, H. Nikolaus Schaller wrote:
>> So let's describe this property in the bindings.
> 
> It's not what the driver for some OS has. The h/w has a Vcc supply, so 
> let's add a property for it...

Ah, ok. It is a matter of speaker's standpoint :)

> 
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
>> 1 file changed, 1 insertion(+)
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks,
Nikolaus

> 
>> 
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
>> index d2a937682836..6a7cddb187c1 100644
>> --- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
>> @@ -35,6 +35,7 @@ Required properties:
>> Optional properties:
>>  - reset-gpios: GPIO specification for the RESET input. This is an
>> 		active low signal to the PCA953x.
>> + - vcc-supply:	power supply regulator.
>> 
>> Example:
>> 
>> -- 
>> 2.12.2
>> 
