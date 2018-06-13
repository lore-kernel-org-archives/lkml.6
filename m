Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6608FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC567208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ylaNLst3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC567208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934998AbeFMA4p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934717AbeFMA4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:56:43 -0400
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com [209.85.161.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B93208B0;
        Wed, 13 Jun 2018 00:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528851403;
        bh=Qo4IJjhwVkw03kTnlHx9G7W+fkXYjOPFIC7LrGx8BCg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ylaNLst3WXvt/JdhlchDPoUujCcRiV4szasfrGxQOVZInCxAuFosu2Vp3ZaVkh526
         orfm/ebyfBRR9N7Uwfet0FzaQuxnzoWED6JlJrvTcWa9rTUbxyD3iY8nVQqgQCWtBH
         uwCbc8CIlMjmJJNfgcxSsQV8FFa4o+ircc3SzpVA=
Received: by mail-yw0-f174.google.com with SMTP id b125-v6so313010ywe.1;
        Tue, 12 Jun 2018 17:56:43 -0700 (PDT)
X-Gm-Message-State: APt69E2j6L6SwIk4zbXChvXk5hWfD+oo1Ol5uhhirHu5npvyTNbhuRe4
        uBnX9Wh6oQJnW72nHVHJkCEcwSEEpLqu50BMuzQ=
X-Google-Smtp-Source: ADUXVKIvte7dzsjMMkhFWtnJwdbo24ZAUqN9xcy/sHwe9PKZPFq5t+QhhdBefOlBh1WaafCp/TYEXLSlwGvvSCmqQq8=
X-Received: by 2002:a81:3c0d:: with SMTP id j13-v6mr1315326ywa.16.1528851402382;
 Tue, 12 Jun 2018 17:56:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 17:56:01 -0700 (PDT)
In-Reply-To: <1528798243-2029-30-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com> <1528798243-2029-30-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 12 Jun 2018 19:56:01 -0500
X-Gmail-Original-Message-ID: <CANk1AXR9BLpp-iwnwsb3aJsk3NTfquftKP=dNXgxnrACRc=5Tw@mail.gmail.com>
Message-ID: <CANk1AXR9BLpp-iwnwsb3aJsk3NTfquftKP=dNXgxnrACRc=5Tw@mail.gmail.com>
Subject: Re: [PATCH v6 29/29] MAINTAINERS: add entry for FPGA DFL drivers
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:10 AM, Wu Hao <hao.wu@intel.com> wrote:
> Add entry for FPGA Device Feature List (DFL) drivers.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 448957c..98fc5ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5619,6 +5619,14 @@ F:       drivers/fpga/
>  F:     include/linux/fpga/
>  W:     http://www.rocketboards.org
>
> +FPGA DFL DRIVERS
> +M:     Wu Hao <hao.wu@intel.com>
> +L:     linux-fpga@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/fpga/dfl.txt
> +F:     include/uapi/linux/fpga-dfl.h
> +F:     drivers/fpga/dfl*
> +
>  FPU EMULATOR
>  M:     Bill Metzenthen <billm@melbpc.org.au>
>  W:     http://floatingpoint.sourceforge.net/emulator/index.html
> --
> 1.8.3.1
>
