Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE606C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE5A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547665525;
	bh=5olV6zpSzh9GNHl6Mc46BztOq/FXTTdaN6TPBFOQYI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MOBdhCUVa4DQP4D7Ri3cQUoPh7HVk0KXXjVBtlvtqSZD81Tr+7PrnrTFk3XKh5FK7
	 fe/0SXMnWqLvFleoNMJJ+yBzB6cLSSWwcXGLHJyWtlt9xjQJp2ig52ouXSAFLXS79s
	 S2PyIByR9FifMleTL8abpLTOKzyC2sLDUgXESXTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfAPTFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729330AbfAPTFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:05:23 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A2E2087E;
        Wed, 16 Jan 2019 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547665522;
        bh=5olV6zpSzh9GNHl6Mc46BztOq/FXTTdaN6TPBFOQYI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ni84c3LK2Ll4JX7SSOII9IzjQ2HXs0yXSpRhlxE1ccpgGQhz/Plr3ezxFxDuTvMV/
         JaWF8oZyQTIAI+EGaDJ/by6SN1ya7ebUs307bzxaWssKcj+q+GyjXV7X6ATIE0LlZa
         rcsqcyW8kQRYu5d1YHNyQnsFxweh6F/1gFBflmrY=
Received: by mail-qt1-f170.google.com with SMTP id y20so8411277qtm.13;
        Wed, 16 Jan 2019 11:05:22 -0800 (PST)
X-Gm-Message-State: AJcUukf0FAou+tor0f4tCmwRFtfMtc735GUaTFwiBGoqFAEUW8+q+Ylu
        nJO/UQqKbj6dHGs14ARqwsNo55cW0u6KhUCo3Q==
X-Google-Smtp-Source: ALg8bN7x0PUNJi6aq5r075dFNIchbq9tvoq5SX5dzf2ErkP0fH1eink68f7p77/k3hdYt9ZcZXdiBZjePbu5T84lZys=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr8272262qtj.76.1547665521715;
 Wed, 16 Jan 2019 11:05:21 -0800 (PST)
MIME-Version: 1.0
References: <1546949500-30044-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1546949500-30044-1-git-send-email-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jan 2019 13:05:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK=hE4T4YOsbvYFAwrVed8fECtAPhiHp7Z8PhD1XyQ3jQ@mail.gmail.com>
Message-ID: <CAL_JsqK=hE4T4YOsbvYFAwrVed8fECtAPhiHp7Z8PhD1XyQ3jQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: qcom: Fix trivial language typos
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 6:11 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Fix few trivial language typos in bindings.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 2 +-
>  Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Applied, thanks.

Rob
