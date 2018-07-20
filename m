Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A076ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E98206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E98206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeGTGtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:49:47 -0400
Received: from nautica.notk.org ([91.121.71.147]:38044 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeGTGtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:49:47 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 959DAC009; Fri, 20 Jul 2018 07:57:20 +0200 (CEST)
Date:   Fri, 20 Jul 2018 07:57:05 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coccinelle: suggest replacing strncpy+truncation by
 strscpy
Message-ID: <20180720055705.GA2810@nautica>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
 <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
 <alpine.DEB.2.20.1807200731240.2349@hadrien>
 <20180720054050.GA32233@nautica>
 <alpine.DEB.2.20.1807200745400.2349@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1807200745400.2349@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall wrote on Fri, Jul 20, 2018:
> On Fri, 20 Jul 2018, Dominique Martinet wrote:
> > I guess there is no value in the script landing first by itself, I'll
> > just remove the script path from the commit messages and resend the
> > first few this weekend.
> 
> It's not that there is no value to the script.  The problem is that I
> don't know if the script is correct - I'm not familiar with these string
> functions.  Once the script is in the kernel, it stays there beyond your
> patches, so I would prefer to know that it is correct up front, rather
> than having to remove it afterwards.

I understand, I didn't say there is no value in the script ("landing
first by itself" doesn't mean it should/can not be taken later)

I'll bump this thread again in a couple of weeks after having resent
most of the other patches

-- 
Dominique Martinet
