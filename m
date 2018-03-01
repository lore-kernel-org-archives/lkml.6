Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033841AbeCASTx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:19:53 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34964 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033225AbeCASTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:19:51 -0500
X-Google-Smtp-Source: AG47ELtGh2rP6AGHtAtmqKjc7j/2cq3YqXktj/UkQnnKRpuQxBm98k7SFMQi+nE1FQ6LgvhWggNMNLcouPTZrFlt9CI=
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Mar 2018 15:19:50 -0300
Message-ID: <CAOMZO5BsSpi_40ky5L_XafxNULnprphv9nhPCQVNgi+vmexD+Q@mail.gmail.com>
Subject: regmap: Failed to create debugfs directory
To: Mark Brown <broonie@kernel.org>
Cc: brgl@bgdev.pl, david@lechnology.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Running linux-next 20180301 on a imx6q-sabresd the following
regmap-debugfs warnings are seen:

[    0.067965] CPU identified as i.MX6Q, silicon rev 1.2
[    0.083466] vdd1p1: supplied by regulator-dummy
[    0.084768] vdd3p0: supplied by regulator-dummy
[    0.085816] vdd2p5: supplied by regulator-dummy
[    0.109831] (NULL device *): Failed to create debugfs directory
....

[    2.961117] input: EETI eGalax Touch Screen as
/devices/soc0/soc/2100000.aips-bus/21a8000.i2c/i2c-2/2-0004/input/input0
[    2.977027] (NULL device *): Failed to create debugfs directory
[    2.983929] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered
20cc000.snvs:snvs-rtc-lp as rtc0
[    2.993457] i2c /dev entries driver
[    3.002084] (NULL device *): Failed to create debugfs directory
[    3.010452] imx2-wdt 20c0000.wdog: timeout 60 sec (nowayout=0)

I haven't started to debug this yet, but would like to know if anyone
has any ideas?

Thanks,

Fabio Estevam
