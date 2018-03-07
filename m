Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeCGL6a convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:58:30 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:55907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeCGL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:58:27 -0500
Date: Wed, 7 Mar 2018 12:58:07 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: linus.walleij@linaro.org, Matheus Castello <matheus@castello.eng.br>
Cc: eric@anholt.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <821312841.275581.1520423887935@email.1und1.de>
In-Reply-To: <1520216960-19880-1-git-send-email-matheus@castello.eng.br>
References: <431699005.307231.1520086916739@email.1und1.de>
 <1520216960-19880-1-git-send-email-matheus@castello.eng.br>
Subject: Re: [PATCH v2 0/3] pinctrl: bcm2835: Add brcm,level property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:XWhppvzj83o3fRpzwIUGtnj4ruwEitjkFmnyVzPAnElFEyrQ43F
 +ryLlqUEny1VLXijJA/wsmBPSAk+x7u1aVy1Uxi1r/sav7suoCxdd6MmvaoC+sDr/nwl5xG
 OTJj0vGbRlGGqggH7dbfFFmD5EFz3LsdFalbu/Cg2YL8z4hc2AJIByvWfSEMVzANI/bAB2q
 zJx85ZcPs8JQlmZ632hxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hP+TZK582jc=:3fdLT3h8rvoFFcjn8cvvNC
 eJNfkCErerY/69C7YV9d3CzQarnSInwr4+o2q5EtvapBuB4ac6jffwTtpArOEacObdFWTIm9l
 Wg5sU151E9x4PliXLaJfedl2h9yzVmGSI/fFmf3lp7t0QUZ1nRmcZljtXE6o5TsDHawuv0LUD
 FnGQefY9MPaD9SvEtuIg8pl6YIi/gIffuBP8j/cNSU7bvJlHxD1tgJ6qqTYJJNUI9TkjBeBNY
 LW4ax9GpyNsaXGqg+7tWe7GvxALBcgPYzdGccWvCSBm+L5oIIC0O6wZadUO0PE9N84uPoJVC0
 RUAnaKEjQAkbM580QADc/ohDBOk+lkeX31Q2Dwgg524GJQx5uwu07duaXw5wK3wjfeI+ZsuaB
 pPQRFWhHKnIa/eTV5sjFDzQuVF6ZNdC1OYKb7jzXRqQoXnyit9I5Lu36TOmv0cw6Fdw68pczt
 ALEJcis9Zk6iR2z4jXfSlUyGQn+Xpc41MIYNcwre2UsR+1j+YmDWP09pFNHHaLfJ+S+zmjNPb
 OsY4s3LqcfKRL/Ee76lgQSA6EiT3kb2CtB0ctnFqO6kJ7ib6HGCDpLC2LYrsCySuZvK0NZ2gZ
 CT5bNeINxGDxKu6YbNmdEY7QKhsmDAcoJqNufY4Xb7nuQx0LARG8h17IExihMfdGcbs7W+nBE
 fehfeShT8aQCs28RoUPKuVxhD93dNhaBTSrbNgPCIVD1MUBFIF+k5qI5wgEM/plxfVJtH/d/O
 pjjPrHccKMixLor+6m0d9jmDoPJRyyYhtgafbuwMj1rwdANLlHN6BP42InM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

> Matheus Castello <matheus@castello.eng.br> hat am 5. März 2018 um 03:29 geschrieben:
> 
> 
> Hi Linus and Stefan,
> 
> thanks for the tips.
> 
> This series adds support for generic binding for pinctrl bcm2835 driver,
> and add the code for set output buffer of a pin using the output-low and
> output-high generic properties.
> 
> Tested on Raspberry Pi Zero W, based on bcm2835 SoC.
> 
> Matheus Castello (3):

looks like you missed the changes to the dt binding. Please also add Rob Herring and Mark Rutland to CC. We need a ACK from them.

>   pinctrl: bcm2835: switch to GENERIC_PINCONF
>   pinctrl: bcm2835: Add support for generic pinctrl binding
>   pinctrl: bcm2835: Add support for output-low output-high properties
> 
>  drivers/pinctrl/bcm/Kconfig           |  1 +
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c | 88 +++++++++++++++++++++++------------
>  2 files changed, 60 insertions(+), 29 deletions(-)
> 
> --
> 2.7.4
>
