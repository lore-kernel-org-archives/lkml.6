Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136DCC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA73523E81
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdR1R5Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA73523E81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeFVH4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeFVH4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:56:43 -0400
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com [209.85.128.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2697423E82;
        Fri, 22 Jun 2018 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529654203;
        bh=vwY+DnRatkGWVSI3sNmCAjo+iOWo8tP19g96BIRVeVU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mdR1R5ReNpBwGhStl1zByQa275npfFmCevChijHnx0SKxYp2MFwxiGSwKXOpmI4qq
         EnxYDBfKykZYTCQJsrR+jTO0mQSU2y7VqHlNyFRFUjACxyKAbRl6JMco4Ncj0//DWk
         o1kTz8Drf64CmgF7AbY2JfbqNFvDoPjMGzVzzvNU=
Received: by mail-wr0-f170.google.com with SMTP id h10-v6so5692696wrq.8;
        Fri, 22 Jun 2018 00:56:43 -0700 (PDT)
X-Gm-Message-State: APt69E3fp5P7w/Y+BM52/N0snPedTZZ9AL2hxB9xECwFGnLb87s92G15
        NoSb6OBBKI1nc/zjmPhdn/cZhyLmBZipQKqDms8=
X-Google-Smtp-Source: AAOMgpfecStzlb6CzxWJZ+Aw4gA6OMJiLDDSsc+Y87LeQ1FFkuGJae83ooBCkLeHzyVMt9OnwqZNPkeVIF0xBnJlnz4=
X-Received: by 2002:adf:9dc9:: with SMTP id q9-v6mr647157wre.12.1529654201658;
 Fri, 22 Jun 2018 00:56:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:56:41
 -0700 (PDT)
In-Reply-To: <1529608199-5583-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1529608199-5583-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Jun 2018 09:56:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdV+UKKnntcrXQ15aOB5eCehyxqVEJfvZp5faTw434rPw@mail.gmail.com>
Message-ID: <CAJKOXPdV+UKKnntcrXQ15aOB5eCehyxqVEJfvZp5faTw434rPw@mail.gmail.com>
Subject: Re: [PATCH 5/7] dt-bindings: samsung: Document bindings for Samsung
 aries boards
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

On 21 June 2018 at 21:09, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com=
> wrote:
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards=
.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index 14510b215480..edce6602de50 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -2,6 +2,8 @@
>
>  Required root node properties:
>      - compatible =3D should be one or more of the following.
> +       - "samsung,aries"       - for S5PV210-based Samsung Aries board.
> +       - "samsung,galaxys"     - for S5PV210-based Samsung Galaxy S (i90=
00)  board.

It is not strictly speaking Exynos-based board (as mentioned in the
header at beginning of file) so maybe change it to "Samsung's Exynos
and S5P SoC based boards"?

Best regards,
Krzysztof

>         - "samsung,artik5"      - for Exynos3250-based Samsung ARTIK5 mod=
ule.
>         - "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eva=
l board.
>         - "samsung,monk"        - for Exynos3250-based Samsung Simband bo=
ard.
> --
> 2.7.4
>
