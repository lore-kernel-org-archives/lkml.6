Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D80AC64EBA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB9F2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="roYvJxjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB9F2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeJCCnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJCCny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:43:54 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB6320652;
        Tue,  2 Oct 2018 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538510333;
        bh=jDp9FeFbS9uwkIBWpJOW4+tFFJRrhi7udjSG/1nrJIg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=roYvJxjHfJbignHM7s5zhVl+Vh9rUML4SuyfvaSmwXNI6VPhzz1bHAqyJE3iKIsiI
         AIHgD0rw2zbp3VxekP3v4qtYORg5Th80jZrD1c8w5aGR/aGA9VGiyt2+0BcwFXVBpc
         cHsRmQl494hdo027q/oEz3s+6zLcX8l4j4oPsEmo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180828005056.27326-1-nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        t-kristo@ti.com, tony@atomide.com, linux-clk@vger.kernel.org,
        Nishanth Menon <nm@ti.com>
References: <20180828005056.27326-1-nm@ti.com>
Message-ID: <153851033263.119890.1832482570043652816@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
Date:   Tue, 02 Oct 2018 12:58:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nishanth Menon (2018-08-27 17:50:56)
> K3_ARCH uses TISCI for clocks as well. Enable the same
> for the driver support.
> =

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Applied to clk-next

