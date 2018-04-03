Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755236AbeDCJGl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:06:41 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38214 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeDCJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:06:40 -0400
X-Google-Smtp-Source: AIpwx49sFJ/N1nCigYnXRZmc97c/+Er8GOzOc09H1cj9MxbnZ5va80N5yYFEjVGPsYOFcD7ezSUkXg==
MIME-Version: 1.0
In-Reply-To: <20180403061836.3926-10-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com> <20180403061836.3926-10-mylene.josserand@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 3 Apr 2018 17:06:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v67n8DzqOJWAaWGpdb2-AS0UM+_+qFZCt4_Dzb4+ySTcRQ@mail.gmail.com>
Message-ID: <CAGb2v67n8DzqOJWAaWGpdb2-AS0UM+_+qFZCt4_Dzb4+ySTcRQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] ARM: sun9i: smp: Rename clusters's power-off
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, quentin.schulz@bootlin.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 2:18 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> To prepare the support for sun8i-a83t, rename the variable name
> that handles the power-off of clusters because it is different from
> sun9i-a80 to sun8i-a83t.
>
> The power off register for clusters are different from a80 and a83t.
>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
