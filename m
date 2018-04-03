Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754886AbeDCGpR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:45:17 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37807 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeDCGpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:45:16 -0400
X-Google-Smtp-Source: AIpwx4/44CT5nQf0AfQ+hWYK08TE17AIeLuxfnjPiMJ9/uzWIw6KZOr9P+Oxa2cvOKF1kKiEIu41iw==
MIME-Version: 1.0
In-Reply-To: <20180403061836.3926-7-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com> <20180403061836.3926-7-mylene.josserand@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 3 Apr 2018 14:44:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v67c8poFgzu5UXCNGk1BQEYw390+2_oVcOUaYUf7MtzSeg@mail.gmail.com>
Message-ID: <CAGb2v67c8poFgzu5UXCNGk1BQEYw390+2_oVcOUaYUf7MtzSeg@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] ARM: dts: sun8i: a83t: Add CCI-400 node
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 2:18 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> Add CCI-400 node and control-port on CPUs needed by SMP bringup.
>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
