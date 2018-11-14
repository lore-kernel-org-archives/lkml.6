Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3279C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BECE2250E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY260j9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BECE2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeKOI01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:26:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbeKOI01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:26:27 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308C22250E;
        Wed, 14 Nov 2018 22:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234084;
        bh=SNSGOGrgL2RZ2wMCrS5LMV8n/u2kZcdbTZR4NK1j0Ns=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=YY260j9UmshDRu8hiNk8h5Fcpkpc8cdZ6Jqrlq19ZNstO0NNJOgHEh8aw9mTR609i
         1s7Ffh49PGzgbvJ5qXVn/MsK3UU/ixcyXqnNe0ILC/+0gdP6stpmwnjNQEIeMcA8NU
         D4NFpl5NIuICPtAAjUxXHqzXZS8a593swvBtFtkM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Janek Kotas <jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <37A652CE-2DB0-4232-8F94-F11A38D2FA76@global.cadence.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <37A652CE-2DB0-4232-8F94-F11A38D2FA76@global.cadence.com>
Message-ID: <154223408357.88331.5555853411586910501@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/2] clk: Add driver and bindings for Fixed MMIO clock
Date:   Wed, 14 Nov 2018 14:21:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janek Kotas (2018-11-14 07:24:17)
> This patchset adds a driver support for Fixed Memory Mapped IO clock.
> =

> The driver reads a clock frequency value from a single 32-bit memory
> mapped register and registers it as a fixed rate clock.
> =

> It can be useful for prototyping Linux on various hardware platforms.

Please fix your mailer (is it git send-email?) to do proper threading of
emails and cover letters. I see these aren't sent as replies to the
cover, and so I get three different mail lines in my inbox which makes
it take more time for me to go through the patches.

