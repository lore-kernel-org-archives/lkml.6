Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25733C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F9520684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F9520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeJAT4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:56:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37442 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbeJAT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:56:38 -0400
Received: by mail-qk1-f196.google.com with SMTP id x8-v6so367132qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 06:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRGB4dav7QSf1qmMkkWNST9N54xSf9XfAWira5Xq398=;
        b=Zw9JzCESZK9ubMw8BJ/N7KQLSOG9lju6TSmQz3YegupAh/4ZZaAUIqyUd13gv6MnOy
         nqlPEYCd+EskotGRrmJjRvViZhAvl/A55TbcZkuqva1wVVPpjJNKnX7HbzSIhFJIJ7PL
         ZcHn7nyxCkEpQpAskdZFRKhp1F4+NjJsaXbsc7g34Nu4gwRg3j3NTzNPfWGDvCMbDAB/
         bHp0edDUCeBvOSsB06qfQNzaMRtFVkutnsaTV/xEG1ORn3DLGFKhK1fjr/hF4eTJF+ep
         NFCMiY9kDL8O4Cocc6z9EIv47yysf/fVytvWeZG2wsji4iwt3AO+Ln5FJtIOtz8mSUo5
         TW0g==
X-Gm-Message-State: ABuFfogg19xfXtI3vmJtTXj0idNEnDEBqB5Rvx/0bvnNWzJD4OeAR/Ol
        yJuei7JiK3nwsXPU6Dc2uobirBc2FiIQQmfJRUV0aw==
X-Google-Smtp-Source: ACcGV62j7BWluF85O4Y3JhrKXceQSC/OL7Y1HjjTffztN69YHINDeSw7TTv7XkoRz2GigvQ45xKjsViF2J7nNBEkPwM=
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr8167002qkc.107.1538399930602;
 Mon, 01 Oct 2018 06:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180929130003.5dc79bed@xhacker.debian>
In-Reply-To: <20180929130003.5dc79bed@xhacker.debian>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 15:18:34 +0200
Message-ID: <CAK8P3a2dPpcV08vhsdtr9CD-+-u5VUhSNRhRptmP8bodfF+DSw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: fix pattern in ARM/Synaptics berlin SoC section
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 7:03 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Berlin SoC files has been moved from marvell dir to synaptics dir, but
> commit bc52497a595d ("MAINTAINERS: update entry for ARM/berlin") didn't
> update the dir accordingly. This patch fixes it.
>
> From another side, new derivative SoCs from Synaptics may not be named
> as berlin*, so let's update the entries accordingly.
>
> Fixes: bc52497a595d ("MAINTAINERS: update entry for ARM/berlin")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Reported-by: Joe Perches <joe@perches.com>


Applied to next/soc, thanks!

       Arnd
