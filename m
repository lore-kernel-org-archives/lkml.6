Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D345C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153462063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbfAHTqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:46:49 -0500
Received: from mx.demfloro.ru ([185.52.0.75]:35826 "EHLO mx.demfloro.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730692AbfAHTqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:46:45 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 14:46:45 EST
Received: by mx.demfloro.ru (Postfix, from userid 1000)
        id 43Z2dr6ySKz7VMT; Tue,  8 Jan 2019 19:39:44 +0000 (UTC)
From:   Dmitrii Tcvetkov <demfloro@demfloro.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-Id: <43Z2dr6ySKz7VMT@mx.demfloro.ru>
Date:   Tue,  8 Jan 2019 19:39:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

Don't have anything against listed patches, just curious: doesn't upstream commit 
574823bfab82d9d8fa47f422778043fbb4b4f50e 
(Change mincore() to count "mapped" pages rather than "cached" pages) 
need to be backported as a security fix for CVE-2019-5489[1] to stable kernels?

[1] https://www.openwall.com/lists/oss-security/2019/01/07/2
