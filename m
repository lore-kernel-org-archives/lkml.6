Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A435206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544807787;
	bh=6SQpJE8nklKe57vGAWDSPPh8oQdcfc87nP993k0nR7Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=RC5OaFRNebahGRB455WuBKaI+ewBCCkQROj3vvgl42iweJkx6RT0APFVNyvx+x1mL
	 KDBqL8HHWLAOE2DkhdMAJGjxX1FleJPuJ/yH0072GjTBoIQTD9OyM+iIZc5hs0zlne
	 dPb0O/FINXelc18Xud+s95kHP2v/hW3onmj1iTss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeLNRQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730403AbeLNRQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:16:23 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 746822070B;
        Fri, 14 Dec 2018 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544807784;
        bh=6SQpJE8nklKe57vGAWDSPPh8oQdcfc87nP993k0nR7Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KGyUZ/yihX/tw7UT08Ji7RSgmzrmsgjMmZ0YdnlPIo7eVEMRWzBrj6Li2u2yLrIHO
         K8NHCOQM6eP4fN4ukZbsaRXFZSb0x3k6AYxRrhf9jBg5Mru9MAnk3yZZa0z4+I0Ceh
         DIFqkGuvEFrK/kOmFczXwNNd0wyx+1qkh7l1SPQo=
Message-ID: <1544807781.10497.7.camel@kernel.org>
Subject: Re: [PATCH v8 03/22] tracing: Add hist trigger handler.action
 documentation to README
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Fri, 14 Dec 2018 11:16:21 -0600
In-Reply-To: <20181214221121.6e3d56b7ada3b5fed6124d28@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
         <aed0a478f683ac4a7669c62d72e8a01d975e525b.1544483272.git.tom.zanussi@linux.intel.com>
         <20181214221121.6e3d56b7ada3b5fed6124d28@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, 2018-12-14 at 22:11 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Mon, 10 Dec 2018 18:01:17 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add abbreviated documentation for handlers and actions to README.
> 
> This change itself is good to me, and I would rather like to see this
> in the patch which does actual change, since user (or test code) may
> check this to decide whether the kernel supports this feature or not.
> 
> If we separate this from the change, the test code may fail when
> bisecting.
> 

OK, I'll merge it into '[PATCH v8 01/22] tracing: Refactor hist trigger
action code'.

Thanks,

Tom

