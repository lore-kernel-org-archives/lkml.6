Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A236C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB0020866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB0020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJPQD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:03:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43557 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeJPQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:03:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id k9so21618083otl.10;
        Tue, 16 Oct 2018 01:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PEVoxjyl0mjH4pOVREItLiDsO2ucXuQthFmkulKmqI=;
        b=UuBvtXhwkacIEI0ac8pEknvc3+8M0nJGfUXmPwrXWJOsx++de4gCTCXFqxHm6dx/9t
         Qr2lbs3y7UC7IF8I+JpeVDH2Iu2LSogKWkvSKS0AUvzZZ3nT9iw5fFbd0JnUfE3wsYvV
         6qtEmNACnm02jkKXb+npJIAzh9PYBANZpKSixtQALKZIqOejz6GkYWjcq61SrxnC2aWg
         ZEG0CJIpNFFZlFWUb8JN5DrdFVMdBg/xH/wAGu6yWNzMvsbox3KBJQ3wD3xBHA5XCV/n
         Wewb4InQO/yCjfn5eTUcUGCKynQy58laazXL/gOoPMSMReOjI3sobnIZMN0Xci+DDClA
         4iYA==
X-Gm-Message-State: ABuFfojrN5VI6VfBf11J4sXmHJJqCJaFziVrIud65ZipO2zScxBEKoIg
        JeN2JVyCWbZGsWO6vkv/c5NynvlMq4TuTAanJSXfdQ==
X-Google-Smtp-Source: ACcGV62LDi8Y15STyh+WFighs/oAgSc239eoZ1axVfJa7Bv83zZZDou3tSIniURarm6qE6hH51T3qAkFrU2YFH4f74k=
X-Received: by 2002:a9d:4c90:: with SMTP id m16mr12350826otf.124.1539677681455;
 Tue, 16 Oct 2018 01:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <88f95364-29a8-358e-356e-e62771e52c8e@kernel.org>
In-Reply-To: <88f95364-29a8-358e-356e-e62771e52c8e@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Oct 2018 10:14:30 +0200
Message-ID: <CAJZ5v0jWrmCj=tpi_Eb6Z8vtRHFNdfU1d0_prytMZqK7hJPK-g@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 4.20-rc1
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>, anders.roxell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Mon, Oct 15, 2018 at 9:21 PM Shuah Khan <shuah@kernel.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 4.20-rc1
>
> This cpupower update for Linux 4.20-rc1 consists of fixes for bugs and
> compile warnings from Prarit Bhargava and Anders Roxell.
>
> diff is attached.

Pulled, thanks!
