Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeBESks convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:40:48 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:45371 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753896AbeBESi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:38:57 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: RE: [PATCH] arc: dts: use 'atmel' as manufacturer for at24 in
 axs10x_mb
Thread-Topic: [PATCH] arc: dts: use 'atmel' as manufacturer for at24 in
 axs10x_mb
Thread-Index: AQHTlVvm/SdiZv61U0qKPJ6JiV5gQaOWNaxQ
Date: Mon, 5 Feb 2018 18:38:51 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE646802914A@DE02WEMBXB.internal.synopsys.com>
References: <20180124213955.4975-1-brgl@bgdev.pl>
In-Reply-To: <20180124213955.4975-1-brgl@bgdev.pl>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.178.24]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz, all,

> -----Original Message-----
> From: Bartosz Golaszewski [mailto:brgl@bgdev.pl]
> Sent: Thursday, January 25, 2018 12:40 AM
> To: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Russell King <linux@armlinux.org.uk>; Alexey
> Brodkin <Alexey.Brodkin@synopsys.com>; Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-snps-arc@lists.infradead.org; Bartosz Golaszewski
> <brgl@bgdev.pl>
> Subject: [PATCH] arc: dts: use 'atmel' as manufacturer for at24 in axs10x_mb
> 
> Using compatible strings without the <manufacturer> part for at24 is
> now deprecated. Use a correct 'atmel,<model>' value.

Even though I agree with this change itself I think it may worth
mentioning an explicit commit that deprecated manufacturer'less parts.

-Alexey
 
