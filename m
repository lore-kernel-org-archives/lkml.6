Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D304BC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B122083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550786456;
	bh=sNUEgJM6orhFcOo8Z0XQNSqWqvLFL1jmUwyvUTWyxWI=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=FtzU1JJCzKVLAa/3O2jRBTSZzUVYlbxMZLdrVEy8TD0vKedGjKRDZl/jSS2jSjW2D
	 qLGf7I9TPSx0Hz88lkWtPae/ZwsFhawtccb4EinUU030KahwH8voEz04ZoInJ1J7oI
	 cJo+w0XMJmRX+nlVxHTivKaQ1n3d8II/XOTGZNu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfBUWAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBUWAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:00:55 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F3512077B;
        Thu, 21 Feb 2019 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550786454;
        bh=sNUEgJM6orhFcOo8Z0XQNSqWqvLFL1jmUwyvUTWyxWI=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=neuYlRAtn6u+p0sayqNCv/nMM5bMJnT6WrYSFBSxH8Qm5EQIY+GP3d2/qVGkY5jRj
         ZE0FILXlHGGh+QojL1R/GExV+1tvKL6FZd2/Z2nn3lZ4ca49HNaJiglB71YXpBFUik
         PL+/T+fCv/7GkAZ/6hevSudw5iwdV9CaqvGA60H8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] clk: qcom: clk-rpmh: Add IPA clock support
Message-ID: <155078645377.77512.9488949531816849411@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548377220-9039-1-git-send-email-daidavid1@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548377220-9039-1-git-send-email-daidavid1@codeaurora.org>
To:     David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        tdas@codeaurora.org, elder@linaro.org
Date:   Thu, 21 Feb 2019 14:00:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Dai (2019-01-24 16:47:00)
> The clk-rpmh driver only supports on and off RPMh clock resources. Let's
> extend the driver by adding support for clocks that are managed by a
> different type of RPMh resource known as Bus Clock Manager(BCM). The BCM
> is a configurable shared resource aggregator that scales performance
> based on a set of frequency points. The Qualcomm IP Accelerator (IPA)
> clock is an example of a resource that is managed by the BCM and this a
> requirement from the IPA driver in order to scale its core clock.
>=20
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---

Applied to clk-next

