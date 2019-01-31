Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C10C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B749520820
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548952505;
	bh=DlXLFBk2H01c6yoQhOJoCLKrirnDzZrY54GcdtAEhPM=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=xV/YblNto3UoYuqlqra8e7jV0bQnCPknZX/InUaBc8HRilbuVOKEeiPLZi13C0kuG
	 /iW8XtY1kVVQAiPvRhiSyYaayv/LtnUHjBNBBF4Lv55BkW3kDJxrExF1e1eSBSKZrp
	 yw53WpwcyqmOnkfUZAw0IFy2SQzySkmn1F32kZ6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbfAaQfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388631AbfAaQfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:35:01 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0906E20863;
        Thu, 31 Jan 2019 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548952501;
        bh=DlXLFBk2H01c6yoQhOJoCLKrirnDzZrY54GcdtAEhPM=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=tRDRRcFEDvYBUpcdG0Oy+uEVLQa3DoNG7/4GpYC8FBVSp4nvMefaRkUUBWuPW1Bo8
         iNFdXUaR6PvjyflcghbWtg+fQgFaFPyaKbwkX30McNVJhm0NIA2YwnQjoIrajAZwMn
         Gy/Hvxt5CKouhZ9MtxA1uUEZvjIO/C7psCnqS1zI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] PM / OPP: Remove unused parameter of _generic_set_opp_clk_only()
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154895250022.169292.11355732570610088435@swboyd.mtv.corp.google.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
References: <e2e83f314120f078f7e24fbd5393decb9940a067.1548923105.git.viresh.kumar@linaro.org>
User-Agent: alot/0.8
To:     Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <e2e83f314120f078f7e24fbd5393decb9940a067.1548923105.git.viresh.kumar@linaro.org>
Date:   Thu, 31 Jan 2019 08:35:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2019-01-31 00:25:13)
> The previous frequency value isn't getting used in the routine
> _generic_set_opp_clk_only(), drop it.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

