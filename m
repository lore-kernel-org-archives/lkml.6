Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9728DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ED3218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548355534;
	bh=48YGJcY5BgRvZBfRNDRL+l2TjPzVe6jkARbwlcsyqr8=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=kfPjdlU9KUW5MRb2/juzJQt+iF0VvqlFMEHSDJGS03bbpPav9+F/yYJU4oN020BbD
	 spjijIA2WDTl0sHjOG0k7Hc5w0CYfSnn7QLZ1/IPRG8rYmqjo9nKkTm0EAWX6YNjvg
	 kT1Y6PuTeJ4mmoOSpDP6exSoC6Lz+W8douAIYKC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfAXSpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfAXSpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:45:32 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9F6F218A2;
        Thu, 24 Jan 2019 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548355531;
        bh=48YGJcY5BgRvZBfRNDRL+l2TjPzVe6jkARbwlcsyqr8=;
        h=Subject:From:To:Cc:Date:From;
        b=dPkP2RvOKJTN1BOdJHJOgUqstl1+bAoopX4AXvhdM+c+wtQqLBiWRuzucKUyGHyFU
         Tk1NPRdqwWxpJ/reUmHRTe2qhY7s3qphyWEOLkIUbnSq8j41o9sCBhCaCLS0hEIMnu
         5W3BTKbOFCX7z9QK+MrJDZpkbuOdVvZeytXntj5I=
Message-ID: <1548355529.7144.4.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.132-rt112
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Thu, 24 Jan 2019 12:45:29 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.132-rt112 stable release.

This release is just an update to the new stable 3.18.132 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: bf9a0c49219adf81c8535351bfc4ae8b0f4e69c6

Or to build 3.18.132-rt112 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.132.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.132-rt112.patch.xz


Enjoy!
   
   Tom
