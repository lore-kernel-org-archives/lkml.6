Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFCDECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568BD206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFiii875"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568BD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeGSHfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbeGSHfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:35:33 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E65A52086B;
        Thu, 19 Jul 2018 06:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531983238;
        bh=lQIrKh5xe77+I/i1S67DVgLZqEWKdD4VbFo77oKzlqs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=DFiii875Gtxys14sYaAvRy8TsfO/KpLpKbwyXsVrfF+udSNRBuWncm4WF5+k3chRq
         TkXtqvIRpeGC3RifGDSsjTOvrKAqZRND/WAjsosbmTzaJouMsmqfK5AFG9h8ovrkWK
         /csH/IP+vYD0uHcwMGbGhrPyWkG7T+Q0khr5fLmo=
Received: by mail-wr1-f46.google.com with SMTP id e7-v6so6872396wrs.9;
        Wed, 18 Jul 2018 23:53:57 -0700 (PDT)
X-Gm-Message-State: AOUpUlF71RP5J9QTXBsaMui/aqX8xd5yZkgBWMxL2F+nMTRQuYegWHsH
        siSRADPTG6z4rspWExvPGxjQQvjJb6RC68hQNiY=
X-Google-Smtp-Source: AAOMgpcFfWKAJHWHMUAGq/uZ+dovI29g40ad4rYM2+K7lp1f0lUK4hTL0NJDAElsEmJik3yLb37EC3okEVWsB7hEKag=
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr6206108wro.279.1531983236351;
 Wed, 18 Jul 2018 23:53:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 23:53:55
 -0700 (PDT)
In-Reply-To: <1531946245.26473.2.camel@toradex.com>
References: <20180718194824.3704-1-krzk@kernel.org> <1531946245.26473.2.camel@toradex.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 19 Jul 2018 08:53:55 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfKunyOqYA8vNjN71K92=FW4vcTjdcz9TQ8mHdFJL7VKQ@mail.gmail.com>
Message-ID: <CAJKOXPfKunyOqYA8vNjN71K92=FW4vcTjdcz9TQ8mHdFJL7VKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: tegra: apalis-tk1: Fix SPDX license identifier format
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 22:37, Marcel Ziswiler <marcel.ziswiler@toradex.com> wrote:
> On Wed, 2018-07-18 at 21:48 +0200, Krzysztof Kozlowski wrote:
>> Fix incorrect format used for OR clause in SPDX license identifier.
>
> Can you please elaborate how you got to that conclusion as there are
> various other device trees having it specified the exact same way. Plus
> I was actually even in discussion with Philippe on that patch set back
> when I introduced those.

Hi,

I thought these were pointed by checkpatch but it was my mistake -
checkpatch complained about missing SPDX in tegra124-apalis.dtsi, not
about these files. Maybe I was mislead by the in-kernel example [1]...
although SPDX specification uses them so I think this patch can be
abandoned.

[1] https://elixir.bootlin.com/linux/v4.18-rc5/source/Documentation/process/license-rules.rst#L130

Best regards,
Krzysztof
