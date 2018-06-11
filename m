Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rncOEpduHlvJRgAAmS7hNA
	; Mon, 11 Jun 2018 12:44:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 242A7607BB; Mon, 11 Jun 2018 12:44:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCMKNyXJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AD1B860351;
	Mon, 11 Jun 2018 12:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD1B860351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbeFKMoE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932668AbeFKMoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:44:02 -0400
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com [209.85.128.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67568208B1;
        Mon, 11 Jun 2018 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528721041;
        bh=Gt32s7oP1UfRqrK31BOJ31jh3rXLWM+ITgzPJQFrARM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WCMKNyXJ1lw3AiF36zFayMfavPE93GQpJgWYxLTN59wRPP1rgXU5RhxSLa7cBAWfh
         tolaTw2dGxE4ZvYmcvm+Ij5TnerTXOC8duNxTwqb5pdtWOWIVgUh17DSi2lKBnMG0Y
         4r78d3ZhTl2HyWV9nzmU+COeVzYpYWW/68sqUWGw=
Received: by mail-wr0-f169.google.com with SMTP id l10-v6so20267219wrn.2;
        Mon, 11 Jun 2018 05:44:01 -0700 (PDT)
X-Gm-Message-State: APt69E342yMqhlDtLDBegMwdEfQjxj4ESPxZYfg+x0sdrWU5eCbN0O3s
        Nua+Nb4nAnq5lOaW0Qd7PDqmirZkJMRJyH8mMOg=
X-Google-Smtp-Source: ADUXVKI0mWWWklcl7H2JbsVhwlRc+BHeJY+xGJB2c9wPgUTTi4ZRJmRJ3LHilDkh7O5AXOh9y9wtBLfZUwSKKwdRGXc=
X-Received: by 2002:a5d:4407:: with SMTP id z7-v6mr13768110wrq.227.1528721039881;
 Mon, 11 Jun 2018 05:43:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 05:43:59
 -0700 (PDT)
In-Reply-To: <1528640149-2195-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1528640149-2195-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 11 Jun 2018 14:43:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcVqaeYoU=tht5GSyEunnboG-+Mxo96LCDewbqDjCfy-A@mail.gmail.com>
Message-ID: <CAJKOXPcVqaeYoU=tht5GSyEunnboG-+Mxo96LCDewbqDjCfy-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: s5pv210: Add missing interrupt-controller
 property to gph2
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 4:15 PM, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
> This commit adds missing interrupt-controller property to gph2 block,

Just "Add missing". See:
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submit=
ting-patches.rst#L151

> to silence following warnings during build
>   /soc/pinctrl@e0200000/gph2: Missing interrupt-controller or interrupt-m=
ap property
>
> Observed on not yet mainlined, an S5PV210 based
> Samsung Galaxy S (i9000) phone.

The warning is not reproduceable (as you mentioned board is not
present in mainline) thus please skip it. Instead, either describe
existing reason for this change (e.g. because bindings require it for
node of every bank of pins supporting GPIO interrupts) or include this
in series mainlining new board (where the reason will be - it will be
used by new board etc).

Best regards,
Krzysztof
