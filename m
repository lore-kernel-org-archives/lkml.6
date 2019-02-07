Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5E3C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980E42147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="lr8Nql0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBGORw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:17:52 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:46730 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBGORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549549070; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDJoJYX2WbwkiGvaAXMcKu9rRPOY1MymgSrLCOWQUTI=;
        b=lr8Nql0iodg/QYDsG2G19apbrl3xrtouFm4H9QeBCnBoRRN49+ZzuZzEDlRiVAj33rqAG5
        ZLEjp44Tuy/zjDEw1wjqRVvsFqGJtkd0Cl8yzDwiT4f1WkOC+hFlMAzPfrtDee3+66LrYY
        bpc/PIsu8aeBHK5lTwiPprXjWzDR7No=
Date:   Thu, 07 Feb 2019 11:17:37 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: sound: Document jz4740-codec bindings
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1549549058.24598.0@crapouillou.net>
In-Reply-To: <20190207140031.GB6190@sirena.org.uk>
References: <20190207133143.5232-1-paul@crapouillou.net>
        <20190207140031.GB6190@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Feb 7, 2019 at 11:00 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 07, 2019 at 10:31:38AM -0300, Paul Cercueil wrote:
>>  Add documentation about how to probe the jz4740-codec driver from
>>  devicetree.
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Well you only applied patch 6/6, didn't you? I only see this one in your
tree.

-Paul


