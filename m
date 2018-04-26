Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753692AbeDZGkU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:40:20 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:56962 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeDZGkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:40:14 -0400
X-AuditID: 0a3aad10-427ff70000000ee7-f0-5ae17452295d
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH v2] Input: add bu21029 touch driver
Thread-Topic: [PATCH v2] Input: add bu21029 touch driver
Thread-Index: AQHT1aVA9GELBAUy3U2UugtB3KZAQaQSpTFw
Date: Thu, 26 Apr 2018 06:40:10 +0000
Message-ID: <04ff5fe9c5c3449b887eb9b269be1038@de.bosch.com>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
 <1523897378-23207-1-git-send-email-mark.jonas@de.bosch.com>
In-Reply-To: <1523897378-23207-1-git-send-email-mark.jonas@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf0wbZRjHeXt37dFweLQwnjHBrAl/TKUDptm5TbIfarosE4P84fAPd8hB
        G2nBXotlcZEYyoTgBAMGbg2OwZAsOEgzXGUQpKvbGMvqQswgUoHBwOGYEcZAGNW7HT/6h/89
        7/N9Ps/3eZ83L4lpvGQcabLYOKuFzdcp1bh6z/fxSRm28azkyb/0zLe+2wRz9dwfiPGMjGLM
        8NwTghnscimZ83fvKBhnj0+1X2Voa2hDhgbhBm74UQioDO4L5UrDvDvhHSJLvS+HyzcVcdad
        acfVxpnaaaJwLtxxp/0HrATVkBUonAT6FWi7fQurQGpSQ9cpYODWTSQfuhFMj9atHWYRTPV5
        FRvKaNeIQuKV9B441TKgkuJo2gGrLT5CKsLonxXwtMuprEAkqaV3Q6DzgFzDwMC1x7gcp8Kv
        1aVIinE6ESZWvnvWk6L3QtOYh5DNnAjuOZsISQinDTA22vwMQHQ8dHT4MSnG6FhwTy0S8oVo
        aO6W80DHwIOJICHNAPR2cNUdlMv1MFRbo5Tjl6Cl8U9M9o2C/vpJvArFCiFdhRBECEGEEOQs
        wi+gmFwuuci8+7UURm/N5vgTySn6DwvMbiS/Ku1BQn+2F9Ek0kVQ9uPjWRqCLeKLzV70KqnQ
        xVDBDDEVmV2QU2xkeeMHVns+x+viKBQWFqbRbqR5e7bZxPOmAosXAYnpoqn3vhzL0lA5bPEJ
        zlogY160jcR1sVRlzqdZGjqPtXEfcVwhZ11X95KkDqgEXjSMsnJ5nCPXlG9bl3XxsueWUCXU
        VkGGe9EuMkL0fmoVW1B8IWvmTXlr+FYZ16xnN9Gb6BD5sKyyEtPglgILFxdLrUg8LVUa7ZaN
        CeKepxayRSEmRNjsMoOGkLhDLXVMmj9C/Dyb3kB5tK5jmqi15CaU2iwytEsJDZ9boXd4EEF7
        cBaDmvFqAoJDnRT0nvk6Ek7/3hgJy/W1z4E/INAw1HojBuqa/FugIdiWAJcGlxOgt3ZxOzwo
        6dkBDwcGd4Cn6tLL8HjhepLI3mcg2N2+D1q/qEyD4fKzB8HXHngDrowNvwm/tJ42QG+/6zD0
        l147DBfL3EfB803fUXCvVKVDua8xHQT/o8wZca8Kca9slPSmvI21/c9e17Kbl4srQfwnWvyy
        vdamgsSmF/CyTtfVt1K31ZRm+A3/uKeqDgTOR2ZO7NzlGHcs/vtb6dz8u6O2ldwj79tR89JX
        W8H9tvH1z06OXL73ZAkr+knoSd8/XX/ONXv9Slr0PNah75pY1d2dDFy8f6pVrVo9iU1g1X0f
        Zz46dEb/d6Kzb2E5yT+/pMN5I5vyImbl2f8A+hJCetUEAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3Q6ePlL003963

Hello,

> Betreff: [PATCH v2] Input: add bu21029 touch driver
> 
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
> 
> Add Rohm BU21029 resistive touch panel controller support with I2C
> interface.
> 
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> Reviewed-by: Heiko Schocher <hs@denx.de>
> ---
> Changes in v2:
>  - make ABS_PRESSURE proportionally rising with finger pressure
>  - fix race between interrupt and timer during shutdown
>  - use infrastructure from include/linux/input/touchscreen.h
>  - add SPDX tag for the driver
>  - improve binding documentation
>  - fix multi-line comments

In the mean time I received a Reviewed-by from Rob Herring.

How shall I proceed? I am convinced that we did all the requested
changes and published them 2018-04-16 in the cited patch above. 

Greetings,
Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1) 
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118 
Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
