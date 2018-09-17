Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E6BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C7A214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C7A214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeIQF7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:59:54 -0400
Received: from smtpq2.mnd.mail.iss.as9143.net ([212.54.34.165]:49292 "EHLO
        smtpq2.mnd.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbeIQF7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:59:53 -0400
Received: from [212.54.34.117] (helo=smtp9.mnd.mail.iss.as9143.net)
        by smtpq2.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <rene.herman@gmail.com>)
        id 1g1hF2-0006bc-3m; Mon, 17 Sep 2018 02:18:16 +0200
Received: from 52499ff3.cm-4-2c.dynamic.ziggo.nl ([82.73.159.243] helo=localhost.localdomain)
        by smtp9.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <rene.herman@gmail.com>)
        id 1g1hF2-0005ge-0N; Mon, 17 Sep 2018 02:18:16 +0200
From:   Rene Herman <rene.herman@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
Date:   Mon, 17 Sep 2018 02:18:13 +0200
Message-Id: <20180917001813.15290-1-rene.herman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
X-SourceIP: 82.73.159.243
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=TeciSiYh c=1 sm=1 tr=0 a=1WNebpHDdbXTIQ7tA6On8w==:17 a=x7bEGLp0ZPQA:10 a=dgzHxJTjTkEA:10 a=JBFolyDoGHsA:10 a=tclcd6dtLQvEqt9_mmAA:9
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

