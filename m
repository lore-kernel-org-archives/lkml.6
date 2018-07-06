Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEFFC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1904D22430
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0n0hnHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1904D22430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934706AbeGFSq4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934516AbeGFSqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:46:54 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C51421A5C;
        Fri,  6 Jul 2018 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530902813;
        bh=SP48/zbpGhoZ4d0O+KDX9qYr+CA8BcbookCPDSSvnYU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=p0n0hnHnSD+i5oujX7ks+2RoioIplqzHaunkn9V/bvE8hpljMEDOc2bX1vFFpZkv1
         3fQHEE4aKWyziq+iw9hJnOeCa0I11Ss95mHNR7HEzvoe69p3DtLgiP7U6v+qZlZF37
         HzpwaZ8lKC1oemzofbMwaA4VCOvQCwaxIHfPqWH0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Saravanan Sekar <sravanhome@gmail.com>, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180703092524.1697111-4-sravanhome@gmail.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
References: <20180703092524.1697111-1-sravanhome@gmail.com>
 <20180703092524.1697111-4-sravanhome@gmail.com>
Message-ID: <153090281264.143105.2922773144286373098@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/5] clk: actions: Add REGMAP as dependency
Date:   Fri, 06 Jul 2018 11:46:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravanan Sekar (2018-07-03 02:25:22)
> Add REGMAP as dependency to avoid undefined reference to regmap symbol
> =

> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

Fixes tag? This should come earlier in the series, or even at the
beginning.

