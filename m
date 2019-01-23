Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A68C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC9A21841
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAWLFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:05:02 -0500
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:48934 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727075AbfAWLFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:05:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3DFD1180A8853;
        Wed, 23 Jan 2019 11:05:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wing91_48a9add928d5d
X-Filterd-Recvd-Size: 1166
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 23 Jan 2019 11:04:59 +0000 (UTC)
Message-ID: <b594fea0c643dd940dbbff0476d37e31fb00e504.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Verify SPDX comment style
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 23 Jan 2019 03:04:58 -0800
In-Reply-To: <8b02899853247a2c67669561761f354dd3bd110e.camel@perches.com>
References: <8b02899853247a2c67669561761f354dd3bd110e.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 16:05 -0800, Joe Perches wrote:
> Using SPDX commenting style // or /* is specified for
> various file types in Documentation/process/license-rules.rst
> so add an appropriate test for .[chsS] files because many
> proposed file additions and patches do not use the correct style.

ping?


