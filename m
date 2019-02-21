Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF769C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9290A2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550786712;
	bh=zAwSLPfIKq/ej3wVshazSBQ8ov0FPNCKK7Qq74R6VJ4=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=Hpgbj4vXLSg2L3uhqKlAnLGo1pkk4DgUwCyOp+3yAETkzPK6zdk995ZqfhQh+86Bg
	 xRE4YRbdsrHM8uuQqKGbwF2FnDkE0eKHQtGr02EgCTAc0axRNKgUrLgvm4VhDbmmXS
	 5v/SiswwMvjvXkgF9Ctyrpxhexd0IcVFVS2yNW+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfBUWFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfBUWFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:05:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A3A207E0;
        Thu, 21 Feb 2019 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550786710;
        bh=zAwSLPfIKq/ej3wVshazSBQ8ov0FPNCKK7Qq74R6VJ4=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=nEgZyTN08GzJHmt4SVV5DgSlUl9j8iwfp1rZcW2kwdb/B1PXxE/rZH7uqwRoMLH1y
         EmAsZDKdVRmA9OYjVxD2+iAZsz3udphxLLB8QyO6bW6J81GkdL8Kbl1ZWZcEfEKvIh
         GLJWQ9fYSpecoCIm0mkwVmDI8DZz85nM8tN8s5GI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: clk-gpio: add support for sleeping GPIOs in gpio-gate-clk
Message-ID: <155078670927.77512.17882802117777143214@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190211135818.10518-1-thomas.petazzoni@bootlin.com> <155007806256.115909.10137511038361789251@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <155007806256.115909.10137511038361789251@swboyd.mtv.corp.google.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 21 Feb 2019 14:05:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-02-13 09:14:22)
>=20
> static?
>=20

Ok I marked it static and applied to clk-next.

