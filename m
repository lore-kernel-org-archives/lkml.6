Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A672146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfBSPRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:17:22 -0500
Received: from verein.lst.de ([213.95.11.211]:52504 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfBSPRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:17:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3FE5568CEC; Tue, 19 Feb 2019 16:17:21 +0100 (CET)
Date:   Tue, 19 Feb 2019 16:17:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] powerpc: drop unused GENERIC_CSUM Kconfig item
Message-ID: <20190219151721.GC4121@lst.de>
References: <3695e169b0367503f3a424d4862cba5a247fabf4.1550226577.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3695e169b0367503f3a424d4862cba5a247fabf4.1550226577.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
