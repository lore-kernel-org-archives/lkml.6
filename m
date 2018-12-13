Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6017C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4A920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730222;
	bh=7qLupQQAJCyoUyYK7QED4TeWIFQT5zrjJ5/sMGhoj28=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=aoAl8KwtQkv4IQh7msLCfpC0QuZ+ld4bHAeBEfi65yNtnAhClDhTbW61JGGqZNszb
	 zH3Un8BCg6inKlSMTleojhGM/acvwFiWHlYLqqBcvCFK+xLv9oyMOIV7ZyEZeSJsfy
	 AFcibKjFebbK1kNx+k3FVj4XDu0QLHCtzaFL2Inc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4A920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeLMTnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbeLMTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:43:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DEA2086D;
        Thu, 13 Dec 2018 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730219;
        bh=7qLupQQAJCyoUyYK7QED4TeWIFQT5zrjJ5/sMGhoj28=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=XPKyE/DBYJBjTkPc1zSabYw19AeWA/l3Ur9yz1h/yBfmHlsKaPmiR66N1MslQ99hg
         zGFEbq/6tO3fDz76sRx2eFI0Vmd0Ihwf+k8CgngiVlWVv1YdepGhG20fHtkEES6nMI
         ekq9mVzG/3eqoyYnprSZBdY6+D2o2jFNL1q9bkPA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211180250.220623-2-sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: Tag basic clk types with SPDX
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20181211180250.220623-1-sboyd@kernel.org> <20181211180250.220623-2-sboyd@kernel.org>
Message-ID: <154473021904.19322.4396609935844748710@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Thu, 13 Dec 2018 11:43:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-12-11 10:02:50)
> These are all GPL-2.0 files per the existing license text. Replace the
> boiler plate with the tag.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

