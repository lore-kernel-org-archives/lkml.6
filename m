Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C3121927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbfBOP75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:59:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45724 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfBOP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:59:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so1322467qtg.12;
        Fri, 15 Feb 2019 07:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpVzP9kdDCuEe8ZJvld+w9pheSBC5BIslIPsLpg4a44=;
        b=nz80dY8Ui/nbRRvnWr/T5SBYiFtZhfaK/7UNroMlGvIgjS2ehNMgGosgXFTA4C9fcV
         g/9KxXtSDrJJYeMbSKpbps3OwXIkpIXnOeMYcry9VdYJRJs5loLAP2LBPKKVO6E/To80
         BTOjDVtbkhtjfwfYxcr6yV7yprRTzNXid2Sj0+WA4WTMYEHu7aAahAfQ3IEMNEFrrKEo
         1xxri1atzzq+jluEHSVvypmv4qdI3L6+jDT8Z7Mau3PPoP2Fo7/xl4QmhRKdHQ64M9G4
         viYijyft0vX8sjh3cQOFke3VVBzgrCyb9wNBQl9VWOJiTaOnfmn7Osq6TI81nUPhtqVx
         SdYQ==
X-Gm-Message-State: AHQUAuYyXugxOUFz6ZRdhzuhsaV8gzhwyG0eTbAUdH+WUFjLNieDjAne
        3T8ffdutWl1CbXiLbh5EowpjsTw1ZvPXx+p0D/o=
X-Google-Smtp-Source: AHgI3IaUvl0vHvm2sK4y0OZDCteVzglabacER6/sXCtFFISYv5hUfWdEwEhq5AjU80mKtcModU9EB5or2giNX/uFEic=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7979677qtl.343.1550246396406;
 Fri, 15 Feb 2019 07:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20190201191720.20464-1-krzk@kernel.org>
In-Reply-To: <20190201191720.20464-1-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Feb 2019 16:59:40 +0100
Message-ID: <CAK8P3a3rr+==e5iZm_9hscE6ar18rCnmC69NWrV1ZEjxu9H=ew@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] ARM: defconfig: Samsung for v5.1
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 8:17 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-5.1
>
> for you to fetch changes up to 25c390ec22167f896dbf5fb61b869ad05ce273ff:
>
>   ARM: s5pv210_defconfig: Enable cpufreq (2019-01-13 10:31:17 +0100)
>
> ----------------------------------------------------------------
> Samsung defconfig changes for v5.1
>
> Enable more drivers in s5pv210 defconfig for Aries family of mobile
> devices (e.g. Samsung Galaxy S).

Pulled into arm/defconfig, thanks!

     Arnd
