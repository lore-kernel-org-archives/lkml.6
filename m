Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	SUBJ_ALL_CAPS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3403DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4AF222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550067215;
	bh=3pIcwDJy+87hJBEW09SCXKst6dnuZy8rBHxoi31BiiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iqIAXr1f5NR1jfp0nwDdZdXlu2KbXvuOpnJL5efxw6oGEzkGjgK71iFIZwVjKKo3C
	 t4lUuZiIac32CKNkziMTLDTr8Ayhlhljm+Qt4beOHJF4fgmh1HWmEupkz4nbw/dO4t
	 2Gys0PibU0tH6BUOUAT5racejTtH3aFJNHsTw0mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391962AbfBMONe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:13:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbfBMONc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:13:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DBB8222B5;
        Wed, 13 Feb 2019 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550067211;
        bh=3pIcwDJy+87hJBEW09SCXKst6dnuZy8rBHxoi31BiiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQxHGr0iNjm0qyovUIwrL65FxTZk0ARN0w92XePcXeS0O5Y+nW/mSKnI09ya5bEoz
         mn+G8KCp3TmgZldZNXhqEn0R5pofNJEl7Y+dOWV3xMUyDC4aH7dJDUOyaKICmiDllb
         OfKpLxOaptmg7/sA1CocxmIEHOpaG5uzPuPOP3n4=
Date:   Wed, 13 Feb 2019 15:13:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PATCHES MERGE MISSING FROM PATCHSET
Message-ID: <20190213141329.GA10202@kroah.com>
References: <VI1PR04MB480016AF3EC4813AA16B366DF3660@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <VI1PR04MB4800E4DAD4729CBA3A146E36F3660@VI1PR04MB4800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4800E4DAD4729CBA3A146E36F3660@VI1PR04MB4800.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:05:13PM +0000, Vabhav Sharma wrote:
> ++ Kernel Mailing list
> 
> From: Vabhav Sharma
> Sent: Wednesday, February 13, 2019 7:30 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Stephen Boyd <sboyd@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>
> Subject: PATCHES MERGE MISSING FROM PATCHSET
> Importance: High
> 
> Hello Maintainers,
> I had sent patch series with subject "arm64: dts: NXP: add basic dts file for LX2160A SoC" in 2018.
> *        This is to update you that all the dts and SoC/Board support patches are merged but below two patches are not yet merged from this patchset series.
> *        clk: qoriq: increase array size of cmux_to_group<https://patchwork.kernel.org/patch/10658885/>
> *        clk: qoriq: Add clockgen support for lx2160a<https://patchwork.kernel.org/patch/10658871/>
> Kindly help to merge the patches.

If patches somehow get dropped, just resend them and be sure to cc: the
proper developers/maintainers/lists as shown by
scripts/get_maintainer.pl.

thanks,

greg k-h
