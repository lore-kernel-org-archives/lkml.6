Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED76C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37AE20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="XlM//QZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfBFSvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:51 -0500
Received: from onstation.org ([52.200.56.107]:59570 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfBFSvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:46 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 624C216B;
        Wed,  6 Feb 2019 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549479105;
        bh=RpkDEO3b27qtgozvNhutv7q5fp6HbTcE3djQ5jIiPh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlM//QZ0dpFwgdtfVD7hENVWDi6cTdljaFX+Bqbx0RSeSonSUPWQ0Oqm91z7pJaVf
         jXQ4NOrXqDSwR+g5EeMyOyCGapG3aNkyDGd+zT4h2B09da8TpfmSQwnvZdzE56tSib
         oVkzGpnGIXv+hSebKGZ+7JLW+avtSfX0hOavGhy4=
Date:   Wed, 6 Feb 2019 13:51:45 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v4 3/3] ARM: dts: qcom: msm8974-hammerhead: add device
 tree bindings for vibrator
Message-ID: <20190206185145.GA7464@basecamp>
References: <20190206013329.18195-1-masneyb@onstation.org>
 <20190206013329.18195-4-masneyb@onstation.org>
 <20190206181822.GB174258@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206181822.GB174258@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:18:22AM -0800, Dmitry Torokhov wrote:
> On Tue, Feb 05, 2019 at 08:33:29PM -0500, Brian Masney wrote:
> > This patch adds device device tree bindings for the vibrator found on
> > the LG Nexus 5 (hammerhead) phone.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> 
> This should go through Qualcomm tree with the other bindings?

Yes, this will go through Andy's tree.

Brian
