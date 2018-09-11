Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCFC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DDD20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DDD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeILBHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:07:09 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51695 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeILBHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:07:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fzovN-0001j9-VY; Tue, 11 Sep 2018 21:06:14 +0100
Message-ID: <1536696373.3024.148.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 48/79] ieee802154: at86rf230: use __func__ macro for
 debug messages
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Cc:     stable@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Sep 2018 21:06:13 +0100
In-Reply-To: <20180823074922.245271192@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
         <20180823074922.245271192@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 09:53 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Stefan Schmidt <stefan@datenfreihafen.org>
> 
> [ Upstream commit 8a81388ec27c4c0adbdecd20e67bb5f411ab46b2 ]
> 
> Instead of having the function name hard-coded (it might change and we
> forgot to update them in the debug output) we can use __func__ instead
> and also shorter the line so we do not need to break it. Also fix an
> extra blank line while being here.
> Found by checkpatch.
[...]

This is a perfectly good fix for upstream, but really not important
enough for stable.  Sasha, please retrain your patch selector.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
