Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19917C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28692083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550786511;
	bh=Flp8ov83dPBhxAhODJJd098kjNfHEoNs5o3ekrg+hbQ=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=LUePF0M/OXu+58QNFsiRCgRt6DOwrb2LLVvzHeixcnkujVLiHJlxqnfIBPfO9tQ8u
	 nsvgqhjh0Nb+0SyXXDbkrhujvdkqzlAUHokRT6ZYG2GL8a9yHiLu+UI9lKLtsck/Sl
	 93RlxWlimQUuKKV5DMvnO/nHPfIrNzhN0tRsBpiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfBUWBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBUWBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:01:49 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F672077B;
        Thu, 21 Feb 2019 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550786508;
        bh=Flp8ov83dPBhxAhODJJd098kjNfHEoNs5o3ekrg+hbQ=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=1yMqRpcf/YEC+L3cBjD6tjWp4n5fsdmJmTgw6mJVNJwYAH0owfcNWgvzEMx4LH7HZ
         wtvPNvVNDITRox/2o+S8yposAvPcY7BTmvMGqEWukekMFnX+Pc8yONfdW5PsfzCW9x
         aIx3p/l7PzVy8RwODqFNM+Ys/8SjVDPvI43xqP8s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: marvell,mmp2: Add clock id for the LCDC clock
Message-ID: <155078650801.77512.6725660289964680903@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190211102050.24422-1-lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190211102050.24422-1-lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Date:   Thu, 21 Feb 2019 14:01:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-02-11 02:20:49)
> The peripheral clock is required for access the the LCDC registers. It
> is in fact separate from the "AXI clock" that is optionally used to gener=
ate
> the pixel clock and as such requires a separate clock id.
>=20
> Link: https://lists.freedesktop.org/archives/dri-devel/2019-January/20397=
5.html
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

It's a resend? I picked up the other one.

