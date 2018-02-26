Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeBZOC0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:02:26 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55993 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeBZOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:02:24 -0500
X-Google-Smtp-Source: AH8x227pYwIxDa6Gte8GieH4YmJT5HWAzB25WmegiTOCdCfmj4FcVGJFHlQuQXYCcp2Zw7LgTaN2Sig05IaZKSc0T7E=
MIME-Version: 1.0
In-Reply-To: <20180226131318.GA14045@amd>
References: <20180224214617.GA22619@amd> <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 26 Feb 2018 16:02:22 +0200
Message-ID: <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
Subject: Re: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
To: Pavel Machek <pavel@ucw.cz>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, peter.ujfalusi@ti.com,
        Linux-ALSA <alsa-devel@alsa-project.org>, ivo.g.dimitrov.75@gmail.com,
        khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi,
        kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org,
        martijn@brixit.nl,
        =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Mark Brown <broonie@kernel.org>, abcloriens@gmail.com,
        sakari.ailus@linux.intel.com, pali.rohar@gmail.com,
        clayton@craftyguy.net, linux-omap@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>, patrikbachan@gmail.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 3:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> JFYI: This issues is tracked in the regression reports for Linux 4.16
>> (http://bit.ly/lnxregrep416 ) with this id:
>>
>> Linux-Regression-ID: lr#4b650f
>
> Ok, so it seems that issue is bigger: whole sound subsystem does not
> work. /proc/asound/cards is empty.
>
> 7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.
>
> I tried to revert sound/soc changes, and sound is broken, too. Nasty


dmesg log?
