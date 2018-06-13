Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D06EAC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCCE208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCCE208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935863AbeFMXtx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:49:53 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:40469 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935682AbeFMXtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:49:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B1780AE840;
        Wed, 13 Jun 2018 23:49:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jump90_72b875c9a7a1f
X-Filterd-Recvd-Size: 1651
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 Jun 2018 23:49:48 +0000 (UTC)
Message-ID: <85d6e86b7829b42e69feab8e8dbe93a30b5fa4f1.camel@perches.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
From:   Joe Perches <joe@perches.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Date:   Wed, 13 Jun 2018 16:49:47 -0700
In-Reply-To: <20180613151921.GA27375@mail.hallyn.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
         <20180613151921.GA27375@mail.hallyn.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 10:19 -0500, Serge E. Hallyn wrote:
> Using octal and not symbolic permissions is preferred by many as more
> > readable.
> > 
> > see: https://lkml.org/lkml/2016/8/2/1945
> 
> Heh, well see also https://lkml.org/lkml/2016/8/2/2062 .

We all love Al.

I did reply then too.

cheers, Joe

