Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661A52183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbfAKTLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:11:05 -0500
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:42097 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733043AbfAKTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:11:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B34B6100E86C0;
        Fri, 11 Jan 2019 19:11:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: eye19_7d8e54bf68530
X-Filterd-Recvd-Size: 1317
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Jan 2019 19:11:02 +0000 (UTC)
Message-ID: <0fd4c9e86bc69c852249c0d1f416d7a1ee9bbebc.camel@perches.com>
Subject: Re: [PATCH] checkpatch: allow reporting C99 style comments
From:   Joe Perches <joe@perches.com>
To:     Vadim Bendebury <vbendeb@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, apw@canonical.com
Date:   Fri, 11 Jan 2019 11:11:01 -0800
In-Reply-To: <CAC3GErFi6Hg-E81wpwDV6gpWD0pxM6Rcbj-J9Q6Rs1FOuZ3fNA@mail.gmail.com>
References: <20190110050117.55349-1-vbendeb@chromium.org>
         <20190110224957.25008-1-vbendeb@chromium.org>
         <2413156a3cd115daa6bee09c4158e0f09efdf1a7.camel@perches.com>
         <CAC3GErFi6Hg-E81wpwDV6gpWD0pxM6Rcbj-J9Q6Rs1FOuZ3fNA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-11 at 10:07 -0800, Vadim Bendebury wrote:
> Joe,
> 
> what are next steps to get this merged

Generally, Andrew Morton will pick it up
and merge it in the next major release.

>  - do I have to do anything,

Be patient.

> is anything still missing?

I think not.


