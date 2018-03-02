Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946492AbeCBMdH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:33:07 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:38151 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427595AbeCBMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:33:05 -0500
X-Google-Smtp-Source: AG47ELuGhPVxXbwdUVIUXFw9E3oM791WumxlkTUhpDzk6I7yXtnKCHzIfWtlj3gU6v+uUYGtodb7+mbLi/tNf3iAndY=
MIME-Version: 1.0
In-Reply-To: <20180302121442.GB28931@amd>
References: <20180224214617.GA22619@amd> <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd> <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd> <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd> <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
 <20180302103127.GA2081@amd> <CACRpkda-VLsMVqYx3Y6+3JtLJERhmeJZF5g4Gd9ecvgR1Nnr0A@mail.gmail.com>
 <20180302121442.GB28931@amd>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 13:33:04 +0100
Message-ID: <CACRpkdawRd6aGpj7hjVPv7TZ+YqLjgJaqphkDnkX6xR+3Gx-xA@mail.gmail.com>
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
        Sebastian Reichel <sre@kernel.org>, Martijn Braam <martijn@brixit.nl>,
        =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?TWlja3Vsw6HFoSBRd2VydHo=?= <abcloriens@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        clayton@craftyguy.net, Linux-OMAP <linux-omap@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Patrik Bachan <patrikbachan@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 1:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> >> Ok, so this code looks pretty crazy to me: I tried removing the
>> >> "of_find_spi_gpio" part, and audio started working.
>> >
>> > Hmm. Looks like audio is working w/o any changes, too. Not sure why
>> > festival hung on me before.
>>
>> Does it mean that mainline is working find for you or
>> do we need to look deeper into the problem in the OF
>> lookup?
>
> It now works for me.
>
> (But take a look at the patch I sent -- I believe you are still
> overwriting return values in a bad way, and code is quite confusing).

I think that code is a result of piled fixes, so noone
really designed it to look like that.

I'll try to look at it, I am a bit afraid of the code since I've
broken so many things with it.

Yours,
Linus Walleij
