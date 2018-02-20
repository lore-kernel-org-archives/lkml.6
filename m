Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeBTIhg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:37:36 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51269 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeBTIhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:37:35 -0500
X-Google-Smtp-Source: AH8x225h/YNgssW8CMmtkUWWsjgLzwke2ij2eL1pXujcTCTc1ACjKNUCZ/+FSdyKHvb/6zm4qrH/+A==
Date: Tue, 20 Feb 2018 09:37:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: mingo@elte.hu, tglx@linutronix.de,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH RESEND] x86: consider effective protection attributes in
 W+X check
Message-ID: <20180220083731.kzkctvwvtc4qhrdi@gmail.com>
References: <5A8BDF3602000078001A96CD@prv-mh.provo.novell.com>
 <20180220081042.wgriecqneizg3df7@gmail.com>
 <5A8BE8C602000078001A9729@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8BE8C602000078001A9729@prv-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> I'll see what I can do; it's a pity that the change here, which had
> been sent weeks ago and is a bug fix, hadn't gone in before that
> other change (being more an improvement than a bug fix).

When was it submitted, got a link or Message-ID of the previous submission?

Thanks,

	Ingo
