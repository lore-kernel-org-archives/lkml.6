Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94195C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF66218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbfBRWkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:40:42 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:64509 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfBRWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:40:41 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gvraO-00041R-DK from joseph_myers@mentor.com ; Mon, 18 Feb 2019 14:40:28 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 18 Feb 2019 22:40:25 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gvraK-0000is-Ij; Mon, 18 Feb 2019 22:40:24 +0000
Date:   Mon, 18 Feb 2019 22:40:24 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <y2038@lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yury.norov@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hexagon@vger.kernel.org>,
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        <linux-riscv@lists.infradead.org>, Guan Xuetao <gxt@pku.edu.cn>
Subject: Re: [PATCH 7/8] csky: Use latest system call ABI
In-Reply-To: <20190218210712.3503891-8-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1902182239510.480@digraph.polyomino.org.uk>
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-8-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019, Arnd Bergmann wrote:

> We don't yet have an upstream glibc port for csky, so there is no user

We do.  It's in 2.29.

-- 
Joseph S. Myers
joseph@codesourcery.com
