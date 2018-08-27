Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B26C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B367208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B367208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeH0Roy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:44:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbeH0Roy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:44:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9501AED8;
        Mon, 27 Aug 2018 13:58:07 +0000 (UTC)
Message-ID: <1535378286.5079.7.camel@suse.de>
Subject: Re: [PULL REQUEST] i2c for 4.19
From:   Jean Delvare <jdelvare@suse.de>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 27 Aug 2018 15:58:06 +0200
In-Reply-To: <20180824153735.ffqgp6k3utguwpwb@ninjato>
References: <20180824153735.ffqgp6k3utguwpwb@ninjato>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-24 at 17:37 +0200, Wolfram Sang wrote:
> Linus,
> 
> as promised, here is my 2nd pull request for I2C, containing:
> 
> * removal of the attach_adapter callback, converting its last user
> * removal of any __deprecated usage within I2C
> * one email address update
> * some SPDX conversion
> 
> CCing Jean on this one, he will probably be happy to finally see
> attach_adapter be gone for good as well :)

You have no idea :-)

Huge thanks to everyone who made it happen!

-- 
Jean Delvare
SUSE L3 Support
