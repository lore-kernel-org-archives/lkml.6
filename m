Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C6C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32292145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWi7mFNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32292145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJBEn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeJBEn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:43:56 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18BA8208AE;
        Mon,  1 Oct 2018 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538431441;
        bh=Vl1sBvK27TBP7RfJg4Li2nZ5dYl5tG5P33ssB8QQPU4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=OWi7mFNsPWhZ70kGFk5VpRf237T56p5Cr4ZOryZuUJbMSsHPtm9X7w9lDmnFeSFFi
         hblQ7ZXa2PjZb6g1lXgJVE22FsaspHuCxpLFUEqqgao5S2CbBRbv9hiVeNbUa+X8cs
         7ntuDtkTsEZQnglkZ6BfmyoClaQrd4jx/fj+va7w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vabhav Sharma <vabhav.sharma@nxp.com>, arnd@arndb.de,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mark.rutland@arm.com, mturquette@baylibre.com, oss@buserror.net,
        rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, will.deacon@arm.com,
        yamada.masahiro@socionext.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1537747741-6245-4-git-send-email-vabhav.sharma@nxp.com>
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153843144041.119890.5558230475983572666@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/6] drivers: clk-qoriq: increase array size of cmux_to_group
Date:   Mon, 01 Oct 2018 15:04:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject should be "clk: qoriq: increase array size ..."

