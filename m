Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEEUfp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 16:35:45 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:39969 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeEEUfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 16:35:42 -0400
X-Google-Smtp-Source: AB8JxZrMyMXbiFn78MtZ4I0MF+6hjaCNJGxGJRPDBjpa+ILAmQM44ZmgQlikr35R3osIr2Q71JiGmA==
Date: Sat, 05 May 2018 13:35:34 -0700
In-Reply-To: <20180504152103.18152-1-antoine.tenart@bootlin.com>
References: <20180504152103.18152-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Autocrypt: addr=f.fainelli@gmail.com; keydata=mQGiBEjPuBIRBACW9MxSJU9fvEOCTn
 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
 uUuzv+GKZ6nsysJw==
Subject: Re: [PATCH net-next] net: phy: sfp: handle cases where neither BR,min nor BR,max is given
To: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        linux@armlinux.org.uk
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <53A4DFE3-C335-49B2-89C5-061A96C6D99D@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w45KaBbd003246

On May 4, 2018 8:21:03 AM PDT, Antoine Tenart <antoine.tenart@bootlin.com> wrote:
>When computing the bitrate using values read from an SFP module EEPROM,
>we use the nominal BR plus BR,min and BR,max to determine the
>boundaries. But in some cases BR,min and BR,max aren't provided, which
>led the SFP code to end up having the nominal value for both the
>minimum
>and maximum bitrate values. When using a passive cable, the nominal
>value should be used as the maximum one, and there is no minimum one
>so we should use 0.
>
>Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
>---
>
>Hi Russell,
>
>I'm not completely sure about this patch as this case is not really
>specified in the specification. But the issue is there, and I've
>discuss
>this with others. It seemed logical (at least to us :)) to use the
>BR,nominal values as br_max and 0 as br_min when using a passive cable
>which only provides BR,nominal as this would be the highest rate at
>which the cable could work. And because it's passive, there should be
>no
>issues using it at a lower rate.
>
>I've tested this with one passive cable which only reports its
>BR,nominal (which was 10300) while it could be used when using
>1000baseX
>or 2500baseX modes.

Which SFP modules (vendor and model) exposed this out of curiosity? Russell and I already saw the Cotsworks modules having so e issues with checksums, so building a table of quirks would help. Thanks!

-- 
Florian
