Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbeDTI6e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:58:34 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:41955 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754368AbeDTI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:58:30 -0400
X-Google-Smtp-Source: AIpwx49AsMPp0khzJAgESwjr+LytekNIo1BYiprTbyUQrHU8j4C50sM8+h9n5BVtvkYJYiQFscH37A==
Date: Fri, 20 Apr 2018 09:58:26 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] regulator: bd9571mwv: Add support for DDR backup
 mode
Message-ID: <20180420085826.4omlf2rrwuno3mtj@dell>
References: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
 <20180420074914.vl4rer5zdeldfzb3@dell>
 <CAMuHMdWeROfJNvUtfooN8gqA+nTRXhVLvQFpc-xiqUbG9XgcmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWeROfJNvUtfooN8gqA+nTRXhVLvQFpc-xiqUbG9XgcmA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018, Geert Uytterhoeven wrote:
> On Fri, Apr 20, 2018 at 9:49 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 18 Apr 2018, Geert Uytterhoeven wrote:
> >> The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
> >> development boards supports DDR Backup Power, which means that the DDR
> >> power rails can be kept powered while the main SoC is powered down.
> >
> > Should this set be applied together, or can the MFD patches be applied
> > on their own, without the Regulator patch?
> 
> The regulator patch depends on the MFD patches, so it's best for them to
> go in together.
> 
> > If the former, then we're going to need an Ack from Mark.
> 
> Alternative, as you've already supplied (some form of) your Ack for the firs
> 3 patches, they can go in through Mark? All of it is enhancing the
> regulator part.

Yes, that's fine too:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
