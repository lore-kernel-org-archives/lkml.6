Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D521ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB5A21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB5A21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeJQWdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:33:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44919 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQWdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:33:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so12626395pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nSIEJxgznH8EAppRelSrm5qC2SSC0dPcCuAlLVdnMrE=;
        b=gLbhdOuJsiS4duwoA5xy6BJeEE8nXSACWqYP6+0e4isGaT3QBnQN0Ai31+TaMlpCBf
         KA+evKISktdabBr+PL1LA5Lo9/R18z4QIcoSDBPdELTYAAJAiUQ0IysKDoGFq85WMKhy
         AjEqsGnjMk4cZ7gqhQpC9sBcAQByP+4eJHOls1EiJy0OuoxFc9n0MFC2TvDBIy+QmDWH
         Sn6KFhJJGofGUYO2sG54rluOXXWCd/rXIU9b0cXwMwmZ/SgD+noC3fyAyTvKgUvkhHrf
         elv9rNT9dZPkvukF8o2TN8k0ClPA/uXcr1978t7ckAcMqgmtyonW1D+dRgGENWuAa0Hi
         W0GA==
X-Gm-Message-State: ABuFfoh1A99PkLSMstTWX7/NMLueC2OLk/IiwOvUEwp8mlVqFk6ov817
        BcSPIsEODPSZdite/FnaWMw=
X-Google-Smtp-Source: ACcGV63PHgu/11bkwFIhUitfbZrIryvZfUuLzykcbqT/951KNAW2FYnpNCzi022BjL5bZR38C++vwQ==
X-Received: by 2002:a63:24f:: with SMTP id 76-v6mr24297418pgc.67.1539787037814;
        Wed, 17 Oct 2018 07:37:17 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id z26-v6sm21193456pfh.77.2018.10.17.07.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 07:37:16 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v2] code-of-conduct: Remove explicit
 list of discrimination factors
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>
References: <20181017082648.919-1-geert@linux-m68k.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <01f49baf-d6ad-5ea6-e9ad-226725404cce@acm.org>
Date:   Wed, 17 Oct 2018 07:37:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017082648.919-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 1:26 AM, Geert Uytterhoeven wrote:
> Providing an explicit list of discrimination factors may give the false
> impression that discrimination based on other unlisted factors would be
> allowed.
> 
> Avoid any ambiguity by removing the list, to ensure "a harassment-free
> experience for everyone", period.
> 
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Frank Rowand <frowand.list@gmail.com>
> Acked-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@iki.fi>
> ---
> v2:
>    - Add Acked-by.
> 
> The use of "race" may also conflict with the United Nation's views on
> this matter, cfr. e.g. the UNESCO's "Four statements on the race
> question"[1][2] and "Declaration on Race and Racial Prejudice"[3].
> 
> [1] https://en.wikipedia.org/wiki/The_Race_Question
> [2] http://unesdoc.unesco.org/images/0012/001229/122962eo.pdf
> [3] http://portal.unesco.org/en/ev.php-URL_ID=13161&URL_DO=DO_TOPIC&URL_SECTION=201.html
> ---
>   Documentation/process/code-of-conduct.rst | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index ab7c24b5478c6b30..e472c9f86ff00b34 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -6,10 +6,7 @@ Our Pledge
>   
>   In the interest of fostering an open and welcoming environment, we as
>   contributors and maintainers pledge to making participation in our project and
> -our community a harassment-free experience for everyone, regardless of age, body
> -size, disability, ethnicity, sex characteristics, gender identity and
> -expression, level of experience, education, socio-economic status, nationality,
> -personal appearance, race, religion, or sexual identity and orientation.
> +our community a harassment-free experience for everyone.
>   
>   Our Standards
>   =============

Acked-by: Bart Van Assche <bvanassche@acm.org>


