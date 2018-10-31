Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F779C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED0F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED0F20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeJaUvF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:51:05 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:43544 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbeJaUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:51:05 -0400
Received: from ipb218edd4.dynamic.kabel-deutschland.de ([178.24.237.212] helo=[10.1.9.221])
        by Chamillionaire.breakpoint.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1gHp3j-0000ic-7O; Wed, 31 Oct 2018 12:53:15 +0100
Date:   Wed, 31 Oct 2018 11:21:59 +0000
In-Reply-To: <20181030205136.GB6236@thunk.org>
References: <20181029223334.GH10011@roeckx.be> <20181030001807.7wailpm37mlinsli@breakpoint.cc> <20181030141544.GE15839@thunk.org> <20181030183723.GI10011@roeckx.be> <20181030205136.GB6236@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to 7.9p1
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Kurt Roeckx <kurt@roeckx.be>
CC:     912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?Bernhard_=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Message-ID: <6BBD7CF1-696B-4B5E-ABD8-A30C2F15E5C5@breakpoint.cc>
X-Breakpoint-Spam-Score: -1.0
X-Breakpoint-Spam-Level: -
X-Breakpoint-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 30, 2018 8:51:36 PM UTC, "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
>
>So it's complicated.  It's not a binary trusted/untrusted sort of
>thing.  

What about RNDRESEEDCRNG? Would it be reasonable to issue it after writing the seed as part of the boot process?

>Cheers,
>
>					- Ted


-- 
Sebastian
