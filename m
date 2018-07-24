Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035D2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBA220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBA220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeGXSmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:42:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57796 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388403AbeGXSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:42:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41ZlqV2yd1z1qx8t;
        Tue, 24 Jul 2018 19:35:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41ZlqV2X1xz1tLPL;
        Tue, 24 Jul 2018 19:35:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Xho6Ls0XH1BU; Tue, 24 Jul 2018 19:35:01 +0200 (CEST)
X-Auth-Info: gGLywVnJoJk6I6WNLs559Xwf440VvVKFokM3HaTq5t5S3SKsb2rljeHLtTUMmeH4
Received: from igel.home (ppp-188-174-155-150.dynamic.mnet-online.de [188.174.155.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Jul 2018 19:35:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 02E2A2C129B; Tue, 24 Jul 2018 19:35:00 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: m68k allmodconfig build errors
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
        <878t66idai.fsf@igel.home>
        <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org>
X-Yow:  Maybe we could paint GOLDIE HAWN a rich PRUSSIAN BLUE--
Date:   Tue, 24 Jul 2018 19:35:00 +0200
In-Reply-To: <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org> (Randy
        Dunlap's message of "Mon, 23 Jul 2018 18:52:27 -0700")
Message-ID: <87sh48r0zf.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 23 2018, Randy Dunlap <rdunlap@infradead.org> wrote:

> I don't see that all of these string compare fields are null-terminated.

That gcc has converted the strncmp calls to strcmp is a pretty strong
evidence that they are.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
