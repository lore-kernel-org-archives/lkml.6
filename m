Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F42C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BF020843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xcaEn/U2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BF020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeIAG5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 02:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbeIAG5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 02:57:13 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A41620841;
        Sat,  1 Sep 2018 02:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535770015;
        bh=uJvyBvVcdWB5b80VVmO2LOPhef+0oGbkkySSfNHYqTo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=xcaEn/U2aVim4GBo2GuK5eFE8MSD9bzrFEP9OTYRzuQ4n7uyfhYf+cbMHto3+fVUr
         EAeDAoZPfmgLzHdvnPl0YWTE4Z8gxPM8gT9puI8Zi1yoJ30gLmfzEQR5oYMJGmM3b9
         puvVtdIkMgxFt0OEXbX/E4rYtLTcZHtm7O2hMd0Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <a959a032-6817-dcb4-2c5f-b4bd17fc1c8b@linux.vnet.ibm.com>
Cc:     linux-media@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, andrew@aj.id.au, mchehab@kernel.org,
        joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <153573819126.93865.1884182656081956202@swboyd.mtv.corp.google.com>
 <a959a032-6817-dcb4-2c5f-b4bd17fc1c8b@linux.vnet.ibm.com>
Message-ID: <153577001451.19113.16924655760277630355@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/4] media: platform: Add Aspeed Video Engine driver
Date:   Fri, 31 Aug 2018 19:46:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eddie James (2018-08-31 12:30:02)
> =

> =

> On 08/31/2018 12:56 PM, Stephen Boyd wrote:
> > Quoting Eddie James (2018-08-29 14:09:29)
> > Please let me know your merge strategy here. I can ack the clk patches
> > because they look fine from high-level clk driver perspective (maybe
> > Joel can take a closer look) or I can merge the patches into clk-next
> > and get them into next release while the video driver gets reviewed.
> =

> Thanks for taking a look! Probably preferable to get the clk patches =

> into clk-next first (though Joel reviewing would be great). I just put =

> everything in the same set for the sake of explaining the necessity of =

> the clk changes.
> =


Ok. If Joel is able to review then I can easily merge it into clk-next.

