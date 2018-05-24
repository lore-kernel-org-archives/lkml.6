Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031081AbeEXRta convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:49:30 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:64430 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966518AbeEXRt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:49:28 -0400
X-AuditID: c0a8fbf4-fcfff70000000f28-dc-5b06f7a07346
From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To: Mark Brown <broonie@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: RE: [PATCH 9/9] regulator: bd71837: Build BD71837 regulator driver
Thread-Topic: [PATCH 9/9] regulator: bd71837: Build BD71837 regulator driver
Thread-Index: AQHT82fKELMQ2zYNm0OjzWsO3aLaIKQ/IzFO
Date: Thu, 24 May 2018 17:34:24 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A4016C06B52@WILL-MAIL002.REu.RohmEu.com>
References: <20180524060114.GJ4249@localhost.localdomain>,<20180524140159.GT4828@sirena.org.uk>
In-Reply-To: <20180524140159.GT4828@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.216.252.121]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUgTYRzv2e5u5/TknA4fZ/VhFon5kiZxxZAggon70AsRKTHPPDfLbXab
        phElqaESJERpw3yJNJEZNSt8W4QvYErKyPdWZmqQWZKZlqZ256Xu0/3u/3v5Pw/PDxfL1lAF
        nmq0MKyRTlNiUuRV7bI9rGoRS9j35jeg7oxPYlRFRy9Kjf3qBNRCf4GI+nHzA0q9bS7DqOoh
        p4gqq+5CKGf3USrf0SGhVgefIoc91bZyG1DPDudL1E3W9xK1va4QU7sGWzH1T/vOY1i8pyqJ
        tmSeTNUZI2ISPfWPZ7rR9HY0y9X7B80BjUgR8MAhGQ1v9bdIioAUl5GDALa2t2DCTxeAq7NO
        jsFxjFTBohEJb/Ajg+DAogPhNWJyCYHPnoyuE75kHOwteQkEkQbeL6hFBRwFx5drMD4HIXfD
        +plgHhLkCVjfYOQVMlILW6xD65s8OPVqaTA/BuQOWJjzXcRjMekPRycrRMKRSfiwtU8sYDn8
        MrGKCjgI2rqbMEEfCitb5v7jvbCm6uu6niB94Ot7k0gxkFvdYq1uFqubxepmqQRIHYAGOjVN
        R1uYyHCWyQhnTXoD9zlnMtiB8KjzjWCtLbYNkDhQehE35rEEGUpnmrMNbSAAFynlxLZpbuSd
        ZErO1tNmvZbNSGPMbQDiYqUfUZnEcUQynX2ZYU0bVCCOKP2J+L6leBnJb77AMOkMu8Fux3El
        JJ4vcEYfltExWSmpaZYtWoR78OFShZ+ZMSYzLJ1h0Wv5UmjNXCt4yovbK+fthDmdNnBTwdoN
        AhT+hJwrqIzkCX2GcTN2Gvhzt/Ml8nibF9fqTdc0FyjiAp2PxHyghd6iFDnA+9t+yBy8DZf8
        NKIjvofyEkLCcl3nnacufgofCyoulyBnXbmBYiAdmWuIdJx5MT85FRfVuBLTmV3iG73Lc0UT
        2RUk1Xm7yqfuRlwZlkkVzbPRjgPXH0z30EMa07U4+2lVTP7EVW2jKvTv5z0nunr6NB9TLr07
        nlgkL40NsKUPKBGzno4MEbNm+h+ki+enkgMAAA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thu, May 24, 2018 at 09:01:14AM +0300, Matti Vaittinen wrote:
> > Configurations and Makefile for BD71837 regulator driver
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/regulator/Kconfig  | 11 +++++++++++
> >  drivers/regulator/Makefile |  1 +
> >  2 files changed, 12 insertions(+)
>
> Just squash this into the single patch adding the driver, it makes life
> easier.

Will do. I was wondering if it is nicer to have smaller patches and thus
decided to split this but if it is easier to read them in one patch
- no problem.

Br,
    Matti Vaittinen
