Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeB0IoN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 03:44:13 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:50718 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbeB0Ine (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 03:43:34 -0500
X-Google-Smtp-Source: AH8x2260NiCqg6rwOqar1lGS/XqgByGRY1cS7+wkzRzE9em6/hXaMMFMAFlabHuhiwDgpOnno8hWV52J9VyDTQ2juKc=
MIME-Version: 1.0
In-Reply-To: <20180226231336.GA18565@amd>
References: <20180224214617.GA22619@amd> <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd> <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2018 09:43:32 +0100
Message-ID: <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
Subject: Re: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Ivajlo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        kernel list <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>, martijn@brixit.nl,
        =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Mark Brown <broonie@kernel.org>, abcloriens@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        clayton@craftyguy.net, Linux-OMAP <linux-omap@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, patrikbachan@gmail.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 12:13 AM, Pavel Machek <pavel@ucw.cz> wrote:

> I did git bisect, and the winner seems to be:
>
> pavel@duo:/data/l/linux-n900$ git bisect bad
> c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
> commit c85823390215e52d68d3826df92a447ed31e5c80
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Wed Dec 27 16:37:44 2017 +0100
>
>     gpio: of: Support SPI nonstandard GPIO properties

I have fixes queued for this, tried to send a pull request yesterday
but it turns out the fixes need fixing... OK I'm onto it anyways.

Yours,
Linus Walleij
