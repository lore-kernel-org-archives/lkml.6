Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F227EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB19420846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJn0LmDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB19420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeGPR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeGPR6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:58:50 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EFF20846;
        Mon, 16 Jul 2018 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531762226;
        bh=Iu8kUdWDNxp2dSbUOI5XO4lzVESG0v1ctvRXOXT5Rgg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=qJn0LmDnM5uR7vrlCUhhhvVAo7VqnjiszY4Cst85ZkxvvdDe6Z7sQivypEiBaJBDJ
         LTlvuy3qYOJddDowIKBs2ejmgmOpc6Os3o2eCfu1WwCiGTkQl/petyW+UNTP69Pru/
         gHWi3kZLDyJOOXCifawAkyQDgahd7eZgBl1ZmWhY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525845367-22185-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1525845367-22185-1-git-send-email-tdas@codeaurora.org>
 <1525845367-22185-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153176222570.48062.14197627616169510732@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [v9] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date:   Mon, 16 Jul 2018 10:30:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-05-08 22:56:07)
> Add the RPMh clock driver to control the RPMh managed clock resources on
> some of the Qualcomm Technologies, Inc. SoCs.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

