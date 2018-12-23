Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB49C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 19:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B0217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 19:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbeLWT6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 14:58:19 -0500
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:44383 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725812AbeLWT6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 14:58:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A5723180A844B;
        Sun, 23 Dec 2018 19:58:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: water56_d8ff60577556
X-Filterd-Recvd-Size: 1476
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Dec 2018 19:58:13 +0000 (UTC)
Message-ID: <b80c5fcd621e19255f824acb521984dbf845b9ed.camel@perches.com>
Subject: Re: [PATCH][trivial] fix email address quoting in MODULE_AUTHOR()
From:   Joe Perches <joe@perches.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Trivial patch monkey <trivial@kernel.org>,
        Andrew Morton <akpm@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>, tony@atomide.com,
        daniel.baluta@intel.com, lee.jones@linaro.org, andrew@lunn.ch,
        baolin.wang@linaro.org, rteysseyre@gmail.com,
        javier.martin@vista-silicon.com, sandeep_n@ti.com, dmurphy@ti.com,
        juhosg@openwrt.org, andy.yan@rock-chips.com, robdclark@gmail.com,
        srinivas.kandagatla@linaro.org, steven.eckhoff.opensource@gmail.com
Date:   Sun, 23 Dec 2018 11:58:11 -0800
In-Reply-To: <20181223192719.GA31367@amd>
References: <20181223192719.GA31367@amd>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-23 at 20:27 +0100, Pavel Machek wrote:
>     
> Apparently it is quite easy to forget ">" in quoting of email
> address. This fixes it.

It's good you do this, thanks.

Please use git diff --stat -p when you produce these
or git format-patch so there is an easy to read list
of files modified in this patch.


