Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E515C5ACCD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189322148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="othPYRTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189322148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJQGha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeJQGha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:37:30 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A34D21471;
        Tue, 16 Oct 2018 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539729895;
        bh=4VMf37uMjdp3mBF5xj0gUz66OpGyptXJbWGuzkeKgYA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=othPYRTUZ+cv9mZRzBCK+b/q8FB3zn37Qy7IlKp+zA80jc/Mdug6agHwCUX8ylkJk
         o15JZeO7XAp59VFPyuNJCjmLn98l8W8TIpNPHTCWPLA/cTktGGOSDJLp7MNkwmftpH
         pr7+10LF7zQjksSVLtJrV7JOLzLW12FD0eRtUqCg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vabhav Sharma <vabhav.sharma@nxp.com>, arnd@arndb.de,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mark.rutland@arm.com,
        mturquette@baylibre.com, oss@buserror.net, rjw@rjwysocki.net,
        robh+dt@kernel.org, shawnguo@kernel.org, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, will.deacon@arm.com,
        yamada.masahiro@socionext.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
Cc:     linux@armlinux.org.uk, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, V.Sethi@nxp.com, udit.kumar@nxp.com,
        pankaj.bansal@nxp.com, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
 <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153972989460.5275.12653601090217013634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 3/6] clk: qoriq: increase array size of cmux_to_group
Date:   Tue, 16 Oct 2018 15:44:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vabhav Sharma (2018-10-14 10:08:00)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> =

> Increase size of cmux_to_group array, to accomdate entry of
> -1 termination.
> =

> Added -1, terminated, entry for 4080_cmux_grpX.
> =

> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

