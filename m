Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeD2VIN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 17:08:13 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:32816 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeD2VII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 17:08:08 -0400
X-Google-Smtp-Source: AB8JxZoulzdFI/E7v5dC8ohTc7kqVLS3Ikni+UKy4eDr3e8xIrjOiQjZFf9E2QsPdc2Tsa9uPGns+U35yUvHBQofCbs=
MIME-Version: 1.0
In-Reply-To: <60772240-3c75-7814-9237-d60916a8ceca@suse.de>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com> <20180429055417.GA10221@mithrandir>
 <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com> <60772240-3c75-7814-9237-d60916a8ceca@suse.de>
From: Wesley Terpstra <wesley@sifive.com>
Date: Sun, 29 Apr 2018 14:08:07 -0700
Message-ID: <CAMgXwThYN1E=awkd8yF2aNN+QOLwHkx=UyWqGrOnMxv5jyVj5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver documentation
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3TL8Kjf009485

On Sun, Apr 29, 2018 at 2:01 PM, Andreas Färber <afaerber@suse.de> wrote:
> "pwm0" sounds like a zero-indexed instance of some pwm block. If 0 is
> the version here, I'd suggest to make it "pwm-0" for example - you might
> want to take a look at the Xilinx bindings, which use a strict x.yy suffix.

That's fine. I'll change it to pwm-0.00 in the next patch series.

> Most SoCs don't have clearly versioned IP though, that's why for
> community-contributed bindings the first SoC we encounter the IP in
> usually gets the name.

In this particular case, we do have versioned IP, and we will be
contributing drivers for those which wind up in linux-capable chips.
