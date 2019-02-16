Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43495C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106B2222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfBPOQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:16:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfBPOQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:16:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49AB27BDC3;
        Sat, 16 Feb 2019 14:16:11 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55AD526FD3;
        Sat, 16 Feb 2019 14:16:05 +0000 (UTC)
Date:   Sat, 16 Feb 2019 22:15:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kirill@shutemov.name Thomas Gleixner" <tglx@linutronix.de>,
        x86@kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/mm: Adjust the padding size for KASLR
Message-ID: <20190216141549.GA2007@MiWiFi-R3L-srv>
References: <20190212013118.28203-1-msys.mizuma@gmail.com>
 <20190214101236.GE14858@MiWiFi-R3L-srv>
 <20190214173945.utbawbfbdjkw7dif@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214173945.utbawbfbdjkw7dif@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 16 Feb 2019 14:16:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/19 at 12:39pm, Masayoshi Mizuma wrote:
> > Another thing is for the 3rd part, I also queued several patches in my
> > local branch, they are code bug fix patches, and several clean up
> > patches suggested by Ingo and Kirill. They can be found here:
> > 
> > https://github.com/baoquan-he/linux/commits/kaslar-mm-bug-fix
> > 
> > In my local patches, Ingo suggested opening code get_padding(), and
> > about the SGI UV bug, he suggested adding another function to calculate
> > the needed size for the direct mapping region. So I am wondering if you
> > can rebase the part 3 on top of it, or you add a new function to
> > calculate the size for the direct mapping region so that I can rebase on
> > top of your patch and reuse it.
> > 
> > What do you think about it?
> 
> OK, I will rebase my patches on top of your patch.
> Could you add CCing me when you post your patches?

The patchset has been sent out and added you in the CC list, please feel
free to check.

Thanks
Baoquan
