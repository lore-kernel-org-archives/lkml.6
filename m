Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F556C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A60A20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547059544;
	bh=dw7nPwk5U4peS74yb9SkDlt49Z+n91/be+nZ+DgP6Yo=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=gw0zFKwAXu8E3Z+1jZ886ZNQL1ks7sc+DNB1LEVoRVHvrHAHpcLwFIwfipAHTN5/R
	 CSuVnCB3NGrric4yz7g7nVqatUcMOpOApImwNRXnRXNHbf4y0WeOb0SIn+UrX4X71S
	 YIgdvq49bBfieTAu+UiBejr/wgRUEgc5XfCvAep8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfAISpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfAISpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:45:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6822D20661;
        Wed,  9 Jan 2019 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547059542;
        bh=dw7nPwk5U4peS74yb9SkDlt49Z+n91/be+nZ+DgP6Yo=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=W3LhEw3FgWJdRxZfiOoq7Kyr9DzK09np2E1IBEi0QDXKCFybLdct/JEjpv4EO2shg
         B14uCYXX60+JEV675ou2c3h/4+c/2oMRbQ8zpkVMHClbA0glXWSzJrlLn6g2K/TXWC
         uF2fbg5+eM7ILhrQJ212DWgbKAUoxCCIWCeCpqXg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] clk: sysfs: fix invalid JSON in clk_dump
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20190104220549.24849-1-lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20190104220549.24849-1-lkundrak@v3.sk>
Message-ID: <154705954169.15366.6662624891586662983@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 10:45:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-04 14:05:49)
> Add a missing comma.
>=20
> Fixes: 9fba738a53dd ("clk: add duty cycle support")
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-fixes

