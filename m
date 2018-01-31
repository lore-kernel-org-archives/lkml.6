Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932286AbeAaAWo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:22:44 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45406 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932270AbeAaAWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:22:43 -0500
X-Google-Smtp-Source: AH8x225L9i1p2muFK1X2kTxOHEvCX14STl6ZEC19G4+Fy3VeieTFrAH8Wp/fHLmGcV/K7lR49adXOM/7iPTFsr4pSnw=
MIME-Version: 1.0
In-Reply-To: <7hr2q6c2r4.fsf@baylibre.com>
References: <20180111023401.125658-1-yixun.lan@amlogic.com> <7hr2q6c2r4.fsf@baylibre.com>
From: Kevin Hilman <khilman@baylibre.com>
Date: Tue, 30 Jan 2018 16:22:41 -0800
Message-ID: <CAOi56cW4ufsegpy7heK1+pCxvZ2gz5Lf3dkUgxkZCgMq5oBzSA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] ARM64: dts: meson-axg: UART DT updates
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: devicetree <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 4:04 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
>
>> HI Kevin
>>  These are the UART DT updates for the Meson-AXG platform.
>>
>>  The patch 1 is a general fix.
>> Other patches are about adding clock & pinctrl info, then using them.
>> Last patch enable UART_A which connect to a BT module on the S400 board.
>
> Applied to v4.16/dt64,

Oops, I meant v4.17.

Kevin
