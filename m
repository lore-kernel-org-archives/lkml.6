Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A789CC46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7532085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/Cckkp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7532085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeKFImO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725751AbeKFImO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:42:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E582F20825;
        Mon,  5 Nov 2018 23:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541460003;
        bh=kCVPgts7SJzG8s+kv8odv6oi3jr+XF73N3w0KV6qAek=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=B/Cckkp6WOXP1g577l8Y5SdIAZw0oWMkyL45EE8d1fMOzSWUV2ifaNQTvTA17hiOf
         li/fkuuqCAIUzN/9P+k/AGkNCcvOMMGzJ2hIGqDUzvJjAVlKihiuFuknHKZYPLYPWp
         lQjyq86CFJ1Gmi4URL3lSmavMbCAaWPCdQMPKaXw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yuantian Tang <andy.tang@nxp.com>, oss@buserror.net
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181031065736.32719-2-andy.tang@nxp.com>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yuantian Tang <andy.tang@nxp.com>
References: <20181031065736.32719-1-andy.tang@nxp.com>
 <20181031065736.32719-2-andy.tang@nxp.com>
Message-ID: <154146000223.88331.842879133964597851@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2 v3] clk: qoriq: add more compatibles strings
Date:   Mon, 05 Nov 2018 15:20:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yuantian Tang (2018-10-30 23:57:36)
> Add more SoC compatible strings to support more chips.
> =

> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

