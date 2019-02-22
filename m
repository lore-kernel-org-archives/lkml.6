Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF4EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E831206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550859455;
	bh=JivcoX3NddAkJywbiyRhA+zsDIix0FaT98Z6u3MkQvQ=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=YgEUJhTJnRPvjJnqi6BUB1Yyin4l1iC2z9p/nX4+I5B83Q0mNUXhuCrZU4/hIyjLB
	 m+tO9kwnjE06nt7Ow3scyqSD0tY1UZDTvBjRXCSTOGTnGZOjZ3mzzG4kk+sZvQ5Edj
	 Yv5y2JQXvCLApSUdSDSZOxgJ7tPDRaZowW4B84KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfBVSRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfBVSRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:17:32 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7502070B;
        Fri, 22 Feb 2019 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550859452;
        bh=JivcoX3NddAkJywbiyRhA+zsDIix0FaT98Z6u3MkQvQ=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=DC2S65VL5beEoOuAzWtQqVNLMcRop5ir/t0pGvK7eTJ1Jg01UkmnQU2bsz8rcNZUh
         2fWM2mRUQSvlbvD+3JKaEuudZpMlfRQFE7q4MmXBk2r4OfMNP+BGJIT+XY22/vTs7K
         GWuGOYmPQ3hRhGdD9XWgkcqUHJSbKJq2eh7YFpb4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] clk: ingenic: Fix doc of ingenic_cgu_div_info
Message-ID: <155085945156.77512.11742538801141381836@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190128020921.16309-1-paul@crapouillou.net> <20190128020921.16309-2-paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128020921.16309-2-paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Date:   Fri, 22 Feb 2019 10:17:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-01-27 18:09:21)
> The 'div' field does not represent a number of bits used to divide
> (understand: right-shift) the divider, but a number itself used to
> divide the divider.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> Cc: <stable@vger.kernel.org>
> ---

Applied to clk-next

