Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4EFC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BC127089
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="luYEjD0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BC127089
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933843AbeF1Hwl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933594AbeF1Hwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:52:39 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9363A27081;
        Thu, 28 Jun 2018 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530172358;
        bh=0ihMN7CPJuUMY7Es2Yl6vDA3Sxr67o5qmJRANKHu94g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=luYEjD0ngpmDxILh7X/X7zhtmQ8i0/472BTZiCwvdQZMsAGEeXtFg0Mb9ipLeljtI
         BbUVZY8VMlgLuwyjahXrGLW/Hir50mBcxr4oJWUAMOceqvmgTzLKszFZd057+aTnGi
         VL77fiwf6W9a0OQdsshiBJOobLRZuFJ8in3/M50s=
Received: by mail-wm0-f53.google.com with SMTP id z13-v6so7939882wma.5;
        Thu, 28 Jun 2018 00:52:38 -0700 (PDT)
X-Gm-Message-State: APt69E3vxBMmzxFzH/Sheqp613TDFgcBBgpW/4SN1YP7nKQeg6yKipWu
        ZyzeyJoU9Sz/wn9bivA/UGHvEYtuHvns3ZhDSSc=
X-Google-Smtp-Source: AAOMgpfLwKihrJnxi9pmcuyHlgFf0vob45CwBhLB5MBBVRwvHx6P1+1WYygutBo0Oi4H02yTx8jD+L8P5T1njRKvqKQ=
X-Received: by 2002:a1c:c05:: with SMTP id 5-v6mr7667469wmm.117.1530172357065;
 Thu, 28 Jun 2018 00:52:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 00:52:36
 -0700 (PDT)
In-Reply-To: <1530119544-30023-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1530119544-30023-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 28 Jun 2018 09:52:36 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcZJWW49TL-eybV5486pnik0+-G9ByVg=b1iWbTJwAvAw@mail.gmail.com>
Message-ID: <CAJKOXPcZJWW49TL-eybV5486pnik0+-G9ByVg=b1iWbTJwAvAw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: samsung: Add S5PV210 as possible
 soc in Samsung boards
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 19:12, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com=
> wrote:
> There are Samsung devices, which are not Exynos-based boards,
> like it's in case of S5PV210. Document this information at beginning
> of file.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards=
.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index 14510b215480..175f669d9bb6 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -1,4 +1,4 @@
> -* Samsung's Exynos SoC based boards
> +* Samsung's Exynos and S5P SoC based boards

At the point of this commit, there are no S5P boards mentioned. These
will be added with next commit so please just squash it with the next
one.

I saw that Rob reviewed your v1 after you sent v2, so don't forget to
include it in v3:
Reviewed-by: Rob Herring <robh@kernel.org>

Best regards,
Krzysztof
