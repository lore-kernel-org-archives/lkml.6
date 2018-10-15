Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF0C71144
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8351205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eECz1377"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8351205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJPFJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbeJPFJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:09:04 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F5B205F4;
        Mon, 15 Oct 2018 21:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539638524;
        bh=hzgYdSJSoUR9uLuQfnmTAwOh7QaSjFFZoyjV0lzNYcM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=eECz1377SGfZlrsomxiIZonOmWew3/i2gGl7uBEsNUZSLf7GB7OvMP1DoInYSU3TY
         WuWWtn+keb/QTZOIFIHwpUQwrjz6g32W95g+mi8d5hi77EmtZ1yy+7Wku6gQK2/ZGy
         GNN//TigLpSo2yetIbWRldysQOpmzHpE3zxxTDOk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9cf68fe8-73cf-4ee9-6ad4-d6b7ba8f02f8@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
References: <9cf68fe8-73cf-4ee9-6ad4-d6b7ba8f02f8@kernel.org>
Message-ID: <153963852324.5275.14467434252596945402@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [GIT PULL] clk/samsung updates for 4.20-rc1
Date:   Mon, 15 Oct 2018 14:22:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sylwester Nawrocki (2018-10-05 04:49:14)
> Hi Stephen, Mike,
> =

> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343f=
f3:
> =

>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> =

> are available in the git repository at:
> =

>   git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git tags/cl=
k-v4.20-samsung
> =

> for you to fetch changes up to 9dbcfe1ace4e9c57b819df1054eaeceb9bfd34f5:
> =

>   dt-bindings: clock: samsung: Add SPDX license identifiers (2018-10-05 1=
3:36:40 +0200)
> =


Thanks. Pulled into clk-next.
