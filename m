Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF50C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF9521582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF9521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbeKPE3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:29:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36269 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPE3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:29:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id r127-v6so17553951oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fbaz3/iTWzL2OTCa0+QnUQnErAXSM41FrUj9+bemy4k=;
        b=NqvfdXL1EUyESsrBHYmOz1padQBVuG7r0eI3vx+Q3fz2k0MOesheFSiXO5dvKrsAoQ
         7qR90d+61bS7vYXCFyxFh2ZeuUALo6a4oWqlrrtAPtITmIUmNdca6LcT7N/b/nJJLAE8
         NNP+qDQ6B2dUn+I9EeYH6WtDYZg6KfRTxldZZZtkthboQtDtJD1IGXFdlSsc3wy/a4i0
         krXQebi90JnMcrERsEp/E/0H/+tNI5e68PIfesE/uWF+0bu1wYquwnXOGFZcNK7b0nmV
         mpJ1vzXfwzYpjK1OJ1VpryG5SkOyIjcppCZTVTVpnbrJuqmsy/3ZOnGEfOADoCMew8VO
         Kc6A==
X-Gm-Message-State: AGRZ1gLZ8HqAi5Wb9cn8yA8WqHe9m8Gm3XMOcaV/TDV020pksBlPSAID
        QePrXVbE/DzHnIVPSqG/YqTCMkQWMGoOqy9k/JqEDg==
X-Google-Smtp-Source: AJdET5dCcNI2Gz2u9Wm25pytx4ad+rHWq8eJbBIMqC5MfqXK4YTeCf72eEjzBAq/ELHf+1A6IwQmwqJijEzTPvwgtF8=
X-Received: by 2002:aca:c41:: with SMTP id i1-v6mr4069142oiy.272.1542306053027;
 Thu, 15 Nov 2018 10:20:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU6P0HdDWGMmsjyArQ746N7RBE3qMVq3aZgkfGjb153yJw@mail.gmail.com>
 <CAHk-=wi1f2tTnHe_DoMBsoj7v38G746Kk=tpouGg0_Y3fUFqKA@mail.gmail.com>
In-Reply-To: <CAHk-=wi1f2tTnHe_DoMBsoj7v38G746Kk=tpouGg0_Y3fUFqKA@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 15 Nov 2018 19:20:41 +0100
Message-ID: <CAHc6FU5vaPLF8kcTAnHGHPkJQMf7GwMOX3YOg=DC=XFHrYPmdg@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2: 4.20 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 at 18:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Nov 15, 2018 at 6:00 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > could you please pull the following gfs2 fixes for 4.20?
>
> No.
>
> I'm not pulling this useless commit message:
>
>   "Merge tag 'v4.20-rc1'"
>
> with absolutely _zero_ explanation for why that merge was done.

Sorry for that.

I guess rebasing the for-next branch onto something more recent to
avoid the back-merge in the first place will be best, resulting in a
cleaner history.

> Guys, stop doing this. Because I will stop pulling them.
>
> If you can't be bothered to explain exactly why you're doing a merge,
> I can't be bothered to pull the result.
>
> Commit messages are important. They explain why something was done.
> Merge commits are to some degree *more* important, because they do odd
> things and the reason is not obvious from the code ("Oh, it's a
> oneliner obvious fix").
>
> So merge commits without  a reason for them are simply not acceptable.

Thanks,
Andreas
