Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07050C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A962086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730218;
	bh=82xXUooLCXvKyuTkh9y0Dt/7L4AeqHgJpNcqsRBEUC4=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=YSQCV8QgE8sPVpkvG0l/Nl0ZLIdPensDHBQPncpolE4P3Hkk+8VwOLQizp0Dlx0tT
	 uu0vi9VmPaWQEObLFJ2k9XAIAhJqKBoLBJ8Q/4Nj2QI2N1SRGk4WN5yfUl7YwHeq4n
	 OPHnYd7pALc94U/X9MeTGpAVYYajIYyPujpcphRs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A962086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeLMTni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:43:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeLMTnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:43:37 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11672086D;
        Thu, 13 Dec 2018 19:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730216;
        bh=82xXUooLCXvKyuTkh9y0Dt/7L4AeqHgJpNcqsRBEUC4=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=iH1FkdSBU192eZ4dTPghOrKgXlIHeP+Mw0jH21OjeTZqbfsr3iuhNvbMgUpS3r1So
         yeCNrE5kYTvi2SubpZfsR/v+g1NNVP8xCKBH2AwLbjmZlopYKchEF7lCDo8UOmZjXX
         EB/i/90pGMeb4lRvv/EBrrYsZ843/ZtLGvrQURXw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211180250.220623-1-sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: Tag clk core files with SPDX
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20181211180250.220623-1-sboyd@kernel.org>
Message-ID: <154473021598.19322.10921150003197084961@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Thu, 13 Dec 2018 11:43:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-12-11 10:02:49)
> These are all GPL-2.0 files per the existing license text. Replace the
> boiler plate with the tag.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

