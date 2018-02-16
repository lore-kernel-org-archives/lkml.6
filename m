Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161604AbeBPRJJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:09:09 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45688 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032362AbeBPRJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:09:06 -0500
X-Google-Smtp-Source: AH8x224H0bfPUNadaOluqpvZOjjV+zzUqBLAoSuHEpxIgvm2BLBTUw6yBoaZ9wgTgOrUUWC/0mt/uA==
Date: Fri, 16 Feb 2018 09:09:05 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH v2] ASoC: dmic: Add optional wakeup delay
Message-ID: <20180216170905.GD99727@google.com>
References: <20180216022416.208265-1-mka@chromium.org>
 <20180216112801.GA5886@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216112801.GA5886@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, Feb 16, 2018 at 11:28:01AM +0000 Mark Brown ha dit:

> On Thu, Feb 15, 2018 at 06:24:16PM -0800, Matthias Kaehlcke wrote:
> > On some systems a delay is needed after switching on the clocks, to allow
> > the output to stabilize and avoid a popping noise at the beginning of
> > the recording. Add the optional device tree property 'wakeup-delay-ms'
> 
> This doesn't apply against current code, please check and resend.

Sorry about that, apparently 6d6c3946d877 ("ASoC: dmic: replace codec
to component") was merged just after syncing my tree. Will rebase and
resend.
