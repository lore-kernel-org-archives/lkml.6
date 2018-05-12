Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeELJJA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 05:09:00 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELJI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 05:08:58 -0400
Date: Sat, 12 May 2018 11:08:33 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: linus.walleij@linaro.org, eric@anholt.net,
        Matheus Castello <matheus@castello.eng.br>
Cc: swarren@wwwdotorg.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1682893537.255642.1526116113914@email.1und1.de>
In-Reply-To: <1763017303.92936.1525369119182@email.1und1.de>
References: <1525030092-3643-3-git-send-email-matheus@castello.eng.br>
 <1525135334-28506-1-git-send-email-matheus@castello.eng.br>
 <1525135334-28506-2-git-send-email-matheus@castello.eng.br>
 <1763017303.92936.1525369119182@email.1und1.de>
Subject: Re: [PATCH v7 2/3] pinctrl: bcm2835: Add support for generic
 pinctrl binding
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:jpy0Yyj38VcjYoBPQ8ZcuXcfwVQLMLfHFa/qkhNoOzgZepzZOLV
 1hsACmoRvaTLOrFzCmtJxDYENvZ8X8n4OGYdjbnmR8OUZ2Zc3Njm6jzBowhEuy7TyIvi6xW
 Tj6yd7b/oBlXWpz3RdSbn3tPtOi1YO5/gi3xr2/2xIxNkWMRQbMgrijixuE6W4UlmFMhC51
 m+mk49Pqc78r83BEJlFwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J5B8vKoOqT8=:u9dT1Fw3WC4ZdjDlGROPin
 cda7rNTPsPWZChMoY0ZSTmvYTfIuCeu0n45J/Mwrfidse2RCxCUBDfQHEL8J9hdzLuPyF4xKZ
 Gpmda97hgbWjx79VxVWlHZdC/9dPnGf056M7AN/cRrqnQxXh3ZH+c0ws5xv9XfC4ISeOBRKlB
 TKoHYSnTLBeOso+zCM3/B9MeV2Gcpgnxa6YLAkAbfHBeYBRACM+67NUgNrxUyVnMv0oxtVZsd
 H9QxoDqXENp7OvGPquJ4XOuS9i2Jd8ohsnlp4rjwPYxbPlq8rDp2RnukcxGlUz2xVEVwm4y4e
 THQNDSyPkW1vXsX2W1gK615XZlqtDyFooYzinoP5abUITxKHi6yTgD+BOyHPWOKGeA8i4jKR+
 ly/By5XErp5LmfDaKt84TQJoIcJ3/1Nm68Izd65z89eq4TfNjkGSh964WmyiqiRiiOWhQMuf0
 lfusja5fJWFnlo57ouFM7IFER8P3+V5q9Ve/exTTXgesprUPCFPtSRJRtcUNxdbLIn4cIxAXS
 UJLpCgdZexQdEbQcp7bQBwakrhE1i3nM7DSLEXgaaA2JAd0J3tJb299UO9ja3VmdEnFw7u5i+
 nuKLxOkAZNcQA/ALKYTOx+Ei/W3vqMmm8NePpsZ1b7tPKu7LIdfq7UceYGN6jiHIn+YDV/d05
 75qnucW6QbRwd9uAelb+VggzMex7kvtjMTeF2x6Az0qFK0aUAOIlruOTUk5QtcTZMTOUaLl0J
 a6Qnkr4gubX+Zvfx
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 3. Mai 2018 um 19:38 geschrieben:
> 
> 
> 
> > Matheus Castello <matheus@castello.eng.br> hat am 1. Mai 2018 um 02:42 geschrieben:
> > 
> > 
> > To keep driver up to date we add generic pinctrl binding support, which
> > covers the features used in this driver and has additional node properties
> > that this SoC has compatibility, so enabling future implementations of
> > these properties without the need to create new node properties in the
> > device trees.
> > 
> > The logic of this change maintain the old brcm legacy binding support in
> > order to keep the ABI stable.
> > 
> > Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> > Reviewed-by: Eric Anholt <eric@anholt.net>
> 
> Patches 2 and 3 are
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Thanks
> Stefan

gentle ping ...
> 
> Btw Stephen isn't BCM2835 maintainer anymore
