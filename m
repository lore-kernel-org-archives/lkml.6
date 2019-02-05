Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32798C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4195217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549402363;
	bh=1lh4GKKns/P5mxzCXkJkveVV4S+3GHo9sYnOYIUcNSQ=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=iS6WHx3jCMuzkUdfgGCuSVpqfqOvEgHADTGomNP18v6fnCP7Ol/LMcJebwJ72lKuN
	 zjpDUbuVIX3XjdFsHwy2XIv8WqCgPsggokCcrFCQRkLu3haP2nFbUWeRIyVBgZcYkA
	 eoZvc0udDLwWJFA/5jXMlv3IQ7YJc7pmFfgRNr8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfBEVcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:32:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfBEVcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:32:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65325217D6;
        Tue,  5 Feb 2019 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549402361;
        bh=1lh4GKKns/P5mxzCXkJkveVV4S+3GHo9sYnOYIUcNSQ=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=vzu+Ep8PrbvIDLYU0Q1RfqjS+/826fhTVVDk3/o+M/T79pONTfu2qV72TSpUPlSB1
         +LR9IjP/ZmnpF9TbfUcoZ5efhekGhPBD/WKaidANtt96XTCaW9ZEieRpuNcrY8Ilxw
         WUIIKCOvRDRVmtIKTzeEFru/GvK7rboiHQtsMKXA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: ingenic: jz4740: Fix gating of UDC clock
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940236068.169292.6423947318935084728@swboyd.mtv.corp.google.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
References: <20190125153436.13517-1-paul@crapouillou.net>
User-Agent: alot/0.8
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
In-Reply-To: <20190125153436.13517-1-paul@crapouillou.net>
Date:   Tue, 05 Feb 2019 13:32:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-01-25 07:34:36)
> The UDC clock is gated when the bit is cleared, not when it is set.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---

Applied to clk-next

