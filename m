Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeBHOrc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:47:32 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:45637 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbeBHOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:47:30 -0500
X-Google-Smtp-Source: AH8x227QQSWItRNeb2qNVaJw2OvkC4WPQYl8jkllMN+r3F3R3dek0QLf/gqwNjSZRzuwnAXbNKYCgPmFc8AANESxvXo=
MIME-Version: 1.0
In-Reply-To: <38270e84210144d52178def5ec7364b966a616eb.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com> <38270e84210144d52178def5ec7364b966a616eb.1517910489.git.sean.wang@mediatek.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:46:49 +0100
Message-ID: <CAOFm3uHhhZYonXGE1keoEkVWKDP4a9_F7W8tXfVrFH-Arxb-6A@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] arm64: dts: mt7622: add PMIC MT6380 related nodes
To: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean,

On Tue, Feb 6, 2018 at 10:52 AM,  <sean.wang@mediatek.com> wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> Enable pwrap and MT6380 on mt7622-rfb1 board. Also add all mt6380
> regulator nodes in an alone file to allow similar boards using MT6380
> able to resue the configuration.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>

Thank you for the use of SPDX licenses ids!

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
