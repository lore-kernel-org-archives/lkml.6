Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeBUM05 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:26:57 -0500
Received: from mx.socionext.com ([202.248.49.38]:15368 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbeBUM0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:26:55 -0500
From: "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To: "'Mark Brown'" <broonie@kernel.org>,
        =?iso-2022-jp?B?U3V6dWtpLCBLYXRzdWhpcm8vGyRCTmtMWhsoQiAbJEI+IUduGyhC?=
        <suzuki.katsuhiro@socionext.com>
Cc: <alsa-devel@alsa-project.org>, "Rob Herring" <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com> <20180221043311.25840-2-suzuki.katsuhiro@socionext.com> <20180221121354.GG8334@sirena.org.uk>
In-Reply-To: <20180221121354.GG8334@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623 codec
Date: Wed, 21 Feb 2018 21:26:50 +0900
Message-ID: <001801d3ab0f$3fe07490$bfa15db0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTqs0WhQRew7sK5EKErvLBkljnTKOuLmcAgACXoMA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thank you for your review.

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, February 21, 2018 9:14 PM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel@alsa-project.org; Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623 codec
> 
> On Wed, Feb 21, 2018 at 01:33:10PM +0900, Katsuhiro Suzuki wrote:
> 
> > +Optional properties:
> > +- VCCA-supply : regulator phandle for the VCCA supply
> > +- VCCP1-supply: regulator phandle for the VCCP1 supply
> > +- VCCP2-supply: regulator phandle for the VCCP2 supply
> 
> These should be documented as mandatory unless the device genuinely
> operates without power which seems unlikely.

Indeed, this IC does not work correctly if VCC power supply is lost.
It's not optional. I'll fix it and send V2.


Regards,
--
Katsuhiro Suzuki
