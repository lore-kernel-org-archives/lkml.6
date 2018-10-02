Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473C6C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0AD2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8D0R45J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0AD2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeJBOAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbeJBOAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:00:07 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E052089A;
        Tue,  2 Oct 2018 07:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538464699;
        bh=KSsVEqcYfFENW6VCAM36i/oqdb6GCEtSX413F/ErMOA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=X8D0R45JcdCp4oW/gbci4s0lSWOi50TyjnIDCxtYQkdpKKjwAQxhqY4ny7wk15DWB
         x0xMzcgwjgO/dNqjPVdci1Aj216+Y3uKeZSQFt4s9cLeQvZIlUoIIgCTs6GWl6zsht
         8RTv2bpDcIxHOhyOI5U01vA0y575QeM5qAv1vZMs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180910112654.42061-4-lkundrak@v3.sk>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Lubomir Rintel <lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
 <20180910112654.42061-4-lkundrak@v3.sk>
Message-ID: <153846469907.119890.12700901744521125166@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/8] dt-bindings: marvell,mmp2: Add clock id for the SP clock
Date:   Tue, 02 Oct 2018 00:18:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2018-09-10 04:26:49)
> This is the clock for the "security processor" core.
> =

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

