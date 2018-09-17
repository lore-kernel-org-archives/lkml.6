Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98203ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8C22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceeKGr0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8C22147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeIQQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbeIQQ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:59:22 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C02E4214DA;
        Mon, 17 Sep 2018 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537183947;
        bh=LzQmnILUJ9JTvAXqspk2XR+vBO+IOEYQ64E3Y3OVCJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ceeKGr0/JGHtC9kM478OXZ4/xnPapWRlR2tYqSSjr3KMzSzz6KJEutZlOfQfAd9Ah
         epHRXuFvKgdnenhTUbrRgV9kScx94FSloNHA2XRKKGoZFiATbB2DYmuiqyaFQZ4jEr
         F1Av8C+eUTYwIhwNJLxoDCJMouKs/BV81bIcMW0I=
Received: by mail-wm1-f47.google.com with SMTP id j25-v6so4481246wmc.1;
        Mon, 17 Sep 2018 04:32:26 -0700 (PDT)
X-Gm-Message-State: APzg51CYCdT6DxDY3dGdIhw+9W2Z4LhJbBNxTyGMXsBxYdlHp4cNMMHm
        06dkJfOuuHrqPiyinkaK6j3dwva/HIopXM42BzE=
X-Google-Smtp-Source: ANB0VdY/TbfBRMyeQXxqTJxkBDtJSGqnUAuOnc2DrFm8Wdinylu5YBXrtwGbnvQha8VPXPoAohbf/byYkPbtZVaai0o=
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr11308845wmd.45.1537183945147;
 Mon, 17 Sep 2018 04:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180723040816.19455-1-matheus@castello.eng.br> <20180916114520.4375nr2gv3y4ghzv@earth.universe>
In-Reply-To: <20180916114520.4375nr2gv3y4ghzv@earth.universe>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 17 Sep 2018 13:32:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
Message-ID: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
Subject: Re: [PATCH 0/4] power: supply: MAX17040: Add IRQ for low level and
 alert SOC changes
To:     sebastian.reichel@collabora.com, matheus@castello.eng.br
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2018 at 22:03, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi Matheus,
>
> Did I miss a v2 of this patchset, that solves the issues
> found by Krzysztof?

I did not see v2. This patchset brings nice feature so it would be a
pity if it were discontinued.

Best regards,
Krzysztof
