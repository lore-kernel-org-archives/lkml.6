Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F12C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CED720660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CED720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeLAIUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:20:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:44007 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAIUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:20:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 13:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="121033755"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by fmsmga001.fm.intel.com with ESMTP; 30 Nov 2018 13:09:34 -0800
Date:   Fri, 30 Nov 2018 13:09:34 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
Message-ID: <20181130210934.GE22338@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
 <CAMuHMdXWi2ARLCTPjwXD27KNHo1ghV9sdEuDzeLZ5ihZfbEB9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXWi2ARLCTPjwXD27KNHo1ghV9sdEuDzeLZ5ihZfbEB9Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:57:09PM +0100, Geert Uytterhoeven wrote:
> As a non-native speaker, I find both replacements difficult to understand.
> While many of the original comments are easy to grasp for +7 year olds
> who were never taught English, but are exposed to modern global ways
> of communication...

So you say that a non-native speaker could drop the f-word by accident?
Like when you go to a grocery store in an English speaking country,
instead of saying hello to the counter lady, you say the f-word by
accident? Does not compute...

/Jarkko
