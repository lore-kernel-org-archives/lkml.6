Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F211EECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC552064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC552064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gherkin.frus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeJYLKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 07:10:15 -0400
Received: from gherkin.frus.com ([192.158.254.49]:32928 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeJYLKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 07:10:15 -0400
Received: by gherkin.frus.com (Postfix, from userid 500)
        id 9C4543D006; Wed, 24 Oct 2018 21:39:32 -0500 (CDT)
Date:   Wed, 24 Oct 2018 21:39:32 -0500
From:   Bob Tracy <rct@gherkin.frus.com>
To:     linux-alpha@vger.kernel.org
Cc:     debian-alpha@lists.debian.org, linux-kernel@vger.kernel.org,
        mcree@orcon.net.nz
Subject: Re: vmlinux ld relocation errors on Alpha
Message-ID: <20181025023932.GA12242@gherkin.frus.com>
References: <20181024144629.GA6338@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024144629.GA6338@gherkin.frus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 09:46:29AM -0500, Bob Tracy wrote:
> Back in January of 2017, a patch set was created for the 4.9.0 kernel and
> *hopefully* sent upstream to address the subject issue.
> (...).
> Am currently attempting a native 4.19.0 build with an up-to-date debian
> "sid" toolchain.  If the build succeeds, than the issue became OBE for
> whatever reason.  Otherwise, it would be nice to know what happened to
> the patch set.  Should know either way as far as the build in a few more
> hours.

Successful build, so I guess "OBE" applies.  If someone reading this
knows, how was this fixed?  My guess would be improvements in the
compiler tool chain, most particularly "bintools".

Sorry for the noise.

--Bob
