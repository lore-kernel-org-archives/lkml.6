Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75464C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1680A20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1680A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLDJdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:33:40 -0500
Received: from mail.gnudd.com ([77.43.112.34]:58173 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbeLDJdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:33:40 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2018 04:33:39 EST
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id wB49NlOg027112;
        Tue, 4 Dec 2018 10:23:47 +0100
Received: (from dciminaghi@localhost)
        by mail.gnudd.com (8.14.4/8.14.4/Submit) id wB49NkIb027110;
        Tue, 4 Dec 2018 10:23:46 +0100
Date:   Tue, 4 Dec 2018 10:23:46 +0100
From:   Davide Ciminaghi <ciminaghi@gnudd.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Alessandro Rubini <rubini@gnudd.com>
Subject: Re: [PATCH 12/22] mfd: sta2x11: drop unused MODULE_ tags from non-modular code
Message-ID: <20181204092346.GA26833@mail.gnudd.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com> <1543811009-15112-13-git-send-email-paul.gortmaker@windriver.com> <20181203111442.GK26661@dell> <20181203150756.GA23156@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181203150756.GA23156@windriver.com>
X-Face: #Q;A)@_4.#>0+_%y]7aBr:c"ndLp&#+2?]J;lkse\^)FP^Lr5@O0{)J;'nny4%74.fM'n)M >ISCj.KmsL/HTxz!:Ju'pnj'Gz&.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 10:07:56AM -0500, Paul Gortmaker wrote:
> [Re: [PATCH 12/22] mfd: sta2x11: drop unused MODULE_ tags from non-modular code] On 03/12/2018 (Mon 11:14) Lee Jones wrote:
> 
> > On Sun, 02 Dec 2018, Paul Gortmaker wrote:
> > 
.....
> 
> Looking in git history, I was able to find two e-mail, but one hasn't
> been used in 5+ years, so hopefully it is still active.  I have added
> both to the Cc: of this e-mail and added them to the commit below.
> 
> Alessandro, Davide - you can find additional context regarding why we
> are making these changes in the [00/22] e-mail that can be found here:
> 
Hi,

the patch is OK for me.
I think Alessandro is travelling, he'll reply as soon as he's back to work.


Thanks and regards
Davide
