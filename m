Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0063821776
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="CclXkiZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0063821776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeHUUDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:03:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52356 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeHUUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:03:34 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] pinctrl-ingenic GPIO merge + JZ4725B
Date:   Tue, 21 Aug 2018 18:42:28 +0200
Message-Id: <20180821164236.21101-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534869762; bh=2Nq7fxmKhWgKhtrPW5XumCryCK+LD90rsKezlS2f13M=; h=From:To:Cc:Subject:Date:Message-Id; b=CclXkiZuSzhwN8mRWh8lVriqJeMi6KKfvjuOWy6yRJ3hxkiYrQF8ntr7F+D0BqwpsspLMNhpqFXu2mWSPAvTSkcjAHlVOFSYyJ5e1UPkNNKeg0sU4fpqBbwgn24kPUt/DbdjYIlBGg/CIqpgXxn/TEsdjF/0r4ZoUOVgkJdBDBY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I created a V2 to address the issue that Rob's bot reported.
The dt-bindings doc changes were moved to their own patch [1/8].

The only other change is that I dropped the "ingenic,jz4725b-pinctrl"
compatible string as it does not provide any functional difference.

Thanks,
-Paul Cercueil

