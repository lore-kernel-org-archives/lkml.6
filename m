Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDCC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF1924E86
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF1924E86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeGCC6x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:58:53 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:36636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753710AbeGCC6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:58:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 336BB837F242;
        Tue,  3 Jul 2018 02:58:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fifth52_6a3c1b8a50e16
X-Filterd-Recvd-Size: 1871
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Jul 2018 02:58:49 +0000 (UTC)
Message-ID: <8bc89c25b294c9c48aa0c64abbe3e9c5b660e0fe.camel@perches.com>
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
From:   Joe Perches <joe@perches.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, peter.enderborg@sony.com,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Date:   Mon, 02 Jul 2018 19:58:48 -0700
In-Reply-To: <CAHC9VhTRmWnobxqjffSwvUQfjOP0mo-qOVF_CAd5po_8tGpR5A@mail.gmail.com>
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
         <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
         <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
         <CAHC9VhTzV5QKcjaQL0L_mTZECCexUq=FaSuQjC1AZjubD+VdJA@mail.gmail.com>
         <743d2fd7b0b661bc636766e7b569fefa95a462f6.camel@perches.com>
         <CAHC9VhTRmWnobxqjffSwvUQfjOP0mo-qOVF_CAd5po_8tGpR5A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 22:41 -0400, Paul Moore wrote:
> > It still applies today to -next.
> 
> It doesn't apply cleanly to the selinux/next branch, I believe because
> there are other trees which have made changes under security/selinux/*
> (I believe there was some fs related work from David Howells that
> touched some SELinux/LSM code).
> 
> As I said earlier, if you want me to apply your patches to the SELinux
> tree, please base them either against the selinux/next tree or against
> Linus' tree.

Rather than create more conflicts against changes
that are going to be merged soonish, it can wait.
