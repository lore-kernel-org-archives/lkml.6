Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeFBW2G (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 18:28:06 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:17168 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeFBW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 18:28:05 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 03 Jun 2018 00:28:03 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8] ASoC: pxa: switch to new ac97 bus support
References: <20180602192930.17846-1-robert.jarzmik@free.fr>
X-URL: http://belgarath.falguerolles.org/
Date: Sun, 03 Jun 2018 00:27:58 +0200
In-Reply-To: <20180602192930.17846-1-robert.jarzmik@free.fr> (Robert Jarzmik's
        message of "Sat, 2 Jun 2018 21:29:30 +0200")
Message-ID: <87fu24su1d.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Switch to the new ac97 bus support in sound/ac97 instead of the legacy
> snd_ac97 one.
> +	codecs_pdata = pdata ? pdata->codecs_pdata : NULL;

It's a shame my automated build and test system didn't catch that : it should
have been pdata->codec_pdata and not pdata->codecs_pdata.

Given that this slipped in, please don't apply this until I find out why my
builder lives in utopia.

Cheers.

--
Robert
