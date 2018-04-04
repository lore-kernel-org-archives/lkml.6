Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeDDTCT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:02:19 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.173]:35798 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbeDDTCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:02:17 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WiucxqETr1IQ==
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/5] pcal6524 extensions for pca953x
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <cover.1522868422.git.hns@goldelico.com>
Date: Wed, 4 Apr 2018 21:02:12 +0200
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Message-Id: <4DCDA9A2-934F-4BAA-AC33-54E3DDA741AD@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com>
To: Kumar Gala <galak@codeaurora.org>, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34J2Pfo002033


> Am 04.04.2018 um 21:00 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> V2:
> * added PCA_PCAL flags if matched through of-table
> * fix address calculation for extended PCAL6524 registers
> * hack to map LEVEL_LOW to EDGE_FALLING to be able to
>  test in combination with ts3a227e driver
> * improve description of bindings for optional vcc-supply
>  and interrupt-controller;
> 
> 2018-03-10 09:32:53: no initial description
> 
> H. Nikolaus Schaller (5):
>  gpio: pca953x: set the PCA_PCAL flag also when matching by DT
>  gpio: pca953x: add register definitions for pcal6524 and fix address
>    calculation
>  [RFC] gpio: pca953x: hack to map LEVEL irqs to EDGE irqs (may loose
>    interrupts/hang)
>  DTS: Bindings: pca953x driver provides an optional vcc-supply property
>  DTS: Bindings: pca953x: add example how to use interrupt-controller
>    and gpio-controller
> 
> .../devicetree/bindings/gpio/gpio-pca953x.txt      | 34 +++++++++++++++++++++
> drivers/gpio/gpio-pca953x.c                        | 35 ++++++++++++++++++----
> 2 files changed, 64 insertions(+), 5 deletions(-)
> 
> -- 
> 2.12.2
> 
