Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C68C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A25B2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xRR8mflJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A25B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJBEoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeJBEoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:44:20 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CC24208AE;
        Mon,  1 Oct 2018 22:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538431465;
        bh=M4QEb9IYP+zC+lYJRAvAGqQYMArbTPHgExz5fEfwnq8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=xRR8mflJ9iFaqVEtI5e0MYWDHWMhR3g5tUX5YM0UH7xGl6YewUS0i88xLL1fF7aGg
         QZNjVp6/9wbixD2+ukqAuQIk5Q68jmjrUKfnuvajfTi3oiK0g7KSy8OSPtCNuW7M1Z
         ZYMAe9OxDhqf8s27NRVRCHwDEGg4Yjv3QF9Re7Pc=
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
In-Reply-To: <1537747741-6245-5-git-send-email-vabhav.sharma@nxp.com>
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Tang Yuantian <andy.tang@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-5-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153843146463.119890.6551025813220021124@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 4/6] drivers: clk-qoriq: Add clockgen support for lx2160a
Date:   Mon, 01 Oct 2018 15:04:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same subject comment.

Quoting Vabhav Sharma (2018-09-23 17:08:59)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> =

> Add clockgen support for lx2160a.
